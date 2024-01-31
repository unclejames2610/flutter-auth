import 'package:auth_app/components/my_button.dart';
import 'package:auth_app/components/my_text_field.dart';
import 'package:auth_app/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  // sign user up
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // try creating user
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // Navigator.pop(context);
        showErrorMsg("Passwords don't match!");
      }
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMsg(e.code);
    }
  }

  // void wrongCredentialsMsg() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           title: Text("Wrong Credentials"),
  //         );
  //       });
  // }

  // void loginFailed() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           title: Text("Login Failed"),
  //         );
  //       });
  // }

  void showErrorMsg(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  Text(
                    "Let's create an account for you!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  MyButton(
                    onTap: signUserUp,
                    text: "Sign Up",
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // google and apple sign in btns
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google
                      SquareTile(
                        imagePath: "lib/images/googleLogo.png",
                      ),

                      SizedBox(
                        width: 25,
                      ),
                      // apple
                      SquareTile(
                        imagePath: "lib/images/appleLogo.png",
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login now",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
