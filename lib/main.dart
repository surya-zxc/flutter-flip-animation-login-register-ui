import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginRegisterScreen(),
    );
  }
}

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with SingleTickerProviderStateMixin {
  bool isSignUp = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleCard() {
    if (isSignUp) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Switcher (Log in / Sign up)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: isSignUp ? null : TextDecoration.underline,
                  ),
                ),
                Switch(
                  value: isSignUp,
                  onChanged: (value) {
                    toggleCard();
                  },
                  activeColor: Colors.black,
                ),
                Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: isSignUp ? TextDecoration.underline : null,
                  ),
                ),
              ],
            ),

            // Flip card with 3D animation
            SizedBox(
              width: 300,
              height: 350,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final angle =
                      _controller.value * 3.14159; // Convert to radians
                  final isFrontVisible = angle < 3.14159 / 2;

                  return Stack(
                    children: [
                      if (isFrontVisible)
                        Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle),
                          alignment: Alignment.center,
                          child: _buildLoginCard(context),
                        ),
                      if (!isFrontVisible)
                        Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle + 3.14159),
                          alignment: Alignment.center,
                          child: _buildSignUpCard(context),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Log in",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: _inputDecoration("Email"),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: _inputDecoration("Password"),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: _buttonStyle(),
            child: const Text("Let’s Go!"),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpCard(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: _inputDecoration("Name"),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: _inputDecoration("Email"),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: _inputDecoration("Password"),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: _buttonStyle(),
            child: const Text("Confirm!"),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      minimumSize: const Size(120, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade600,
          offset: const Offset(4, 4),
        ),
      ],
    );
  }
}
