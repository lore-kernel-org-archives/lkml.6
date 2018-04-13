Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeDMFOp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:14:45 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54470 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgC029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/30] kconfig: test: test text expansion
Date: Fri, 13 Apr 2018 14:06:27 +0900
Message-Id: <1523595999-27433-19-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the test cases I used for developing the text expansion
feature.

I implemented a similar language as you see in Make.  The implementation
is different (the source code in GNU Make is much longer, so I did not
want to pull it in), but the behavior is hopefully almost the same.

I intentionally changed some behavior and syntax, but I tried to stick
to the make-like behavior where possible.

It might be interesting to compare the behavior between Make and
Kconfig.

[1] Variable test

You can directly run scripts/kconfig/tests/preprocess/variable/Kconfig
by make.

Make and Kconfig produce the exactly the same output for the variable
test.  The output from Make:

  $ cd scripts/kconfig/tests/preprocess/variable && make -f Kconfig
  Kconfig:5: SIMPLE = 1
  Kconfig:11: RECURSIVE = 2
  Kconfig:17: SIMPLE = 1 3
  Kconfig:23: RECURSIVE = 2 4
  Kconfig:30: UNDEFINED_VARIABLE = 4
  Kconfig:36: AB = 5
  Kconfig:39: X = A
  make: *** No targets.  Stop.

[2] Built-in function test

The output from Make:

  $ cd scripts/kconfig/tests/preprocess/builtin_func && make -f Kconfig
  hello,world 0
  Kconfig:7: hello,world 1
  Kconfig:11: hello,  world 2
  Kconfig:15: hello,world 3
  Kconfig:19: hello, world  4
  make: *** No targets.  Stop.

The output from "$(warning   hello,  world 2)" is different.
"Kconfig:11: hello,  world 2" vs "Kconfig:11:   hello,  world 2"

Make strips all leading spaces from the first argument, but does not
touch the other arguments.  I thought this was inconsistent.  So, I
changed the behavior to not touch any arguments at all.

[3] User-defined function test

I changed the syntax for calling a user-defined function.  In
Make, it is invoked by using the 'call' built-in function as in
$(call greeting,Hello,John) but in Kconfig it is invoked without
'call' as in $(greeting Hello,John).  Except the syntax difference,
the test case works exactly in the same way for Make and Kconfig.

[4] Escape sequence test

Except the syntax of user-defined function, Make and Kconfig work
in the same way.  The behavior of a standalone '$' is different
among Make versions.

By fixing the user-defined function syntax, Make 4.1 or older
works like this:

  Kconfig:5: arg0= arg1=
  Kconfig:9: arg0=, arg1=,
  Kconfig:13: ' " '"   ' ''' "'"
  Kconfig:16: $
  Kconfig:20: $X
  Kconfig:26: nasty
  Kconfig:32: super_nasty
  Kconfig:41:
  Kconfig:46: X
  Kconfig:49:
  make: *** No targets.  Stop.

Make 4.2 or newer is like this:

  Kconfig:5: arg0= arg1=
  Kconfig:9: arg0=, arg1=,
  Kconfig:13: ' " '"   ' ''' "'"
  Kconfig:16: $
  Kconfig:20: $X
  Kconfig:26: nasty
  Kconfig:32: super_nasty
  Kconfig:41: $
  Kconfig:46: $X
  Kconfig:49: nasty
  make: *** No targets.  Stop.

The last three lines are different.  I adopted the behavior of the
newer Make versions.  Of course, you should not write such code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 .../kconfig/tests/preprocess/builtin_func/Kconfig  | 19 +++++++++
 .../tests/preprocess/builtin_func/__init__.py      |  8 ++++
 .../tests/preprocess/builtin_func/expected_stderr  |  4 ++
 .../tests/preprocess/builtin_func/expected_stdout  |  1 +
 scripts/kconfig/tests/preprocess/escape/Kconfig    | 49 ++++++++++++++++++++++
 .../kconfig/tests/preprocess/escape/__init__.py    |  9 ++++
 .../tests/preprocess/escape/expected_stderr        | 10 +++++
 scripts/kconfig/tests/preprocess/user_func/Kconfig | 19 +++++++++
 .../kconfig/tests/preprocess/user_func/__init__.py |  7 ++++
 .../tests/preprocess/user_func/expected_stderr     |  5 +++
 scripts/kconfig/tests/preprocess/variable/Kconfig  | 39 +++++++++++++++++
 .../kconfig/tests/preprocess/variable/__init__.py  |  7 ++++
 .../tests/preprocess/variable/expected_stderr      |  7 ++++
 13 files changed, 184 insertions(+)
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
 create mode 100644 scripts/kconfig/tests/preprocess/escape/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/escape/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/escape/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/user_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/user_func/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/user_func/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/variable/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/variable/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/variable/expected_stderr

diff --git a/scripts/kconfig/tests/preprocess/builtin_func/Kconfig b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
new file mode 100644
index 0000000..5dc454e
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
@@ -0,0 +1,19 @@
+# 'info' prints the argument to stdout.
+# commas are treated verbatim instead of as argument separaters.
+$(info hello,world 0)
+
+# 'warning' is similar, but it sends its argument to stderr,
+# and the message is prefixed with the current file name and line number.
+$(warning hello,world 1)
+
+# leading spaces of the first argument are preserved except
+# the one right after the function name. (This is different from Make)
+$(warning   hello,  world 2)
+
+# 'shell' executes a command, and returns its stdout.
+# commas are treated verbatim instead of as argument separaters.
+$(warning $(shell echo hello,world 3))
+
+# Every newline in the output is replaced with a space,
+# but any trailing newlines are deleted.
+$(warning $(shell printf 'hello,\nworld\n\n4\n\n\n'))
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/__init__.py b/scripts/kconfig/tests/preprocess/builtin_func/__init__.py
new file mode 100644
index 0000000..ec7c3e2
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/__init__.py
@@ -0,0 +1,8 @@
+"""
+Built-in function tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stdout_contains('expected_stdout')
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/expected_stderr b/scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
new file mode 100644
index 0000000..b6c046e
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
@@ -0,0 +1,4 @@
+Kconfig:7: hello,world 1
+Kconfig:11:   hello,  world 2
+Kconfig:15: hello,world 3
+Kconfig:19: hello, world  4
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
new file mode 100644
index 0000000..036c34a
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
@@ -0,0 +1 @@
+hello,world 0
diff --git a/scripts/kconfig/tests/preprocess/escape/Kconfig b/scripts/kconfig/tests/preprocess/escape/Kconfig
new file mode 100644
index 0000000..b99dfa2
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/Kconfig
@@ -0,0 +1,49 @@
+foo = arg0=$1 arg1=$2
+
+# You can not pass a comma directly as a argument since it is treated as an
+# argument separator. In the following, $1 and $2 will be given a null string.
+$(warning $(foo ,))
+
+# Assign ',' to a variable, then use it if you want to pass in commas
+comma   := ,
+$(warning $(foo $(comma),$(comma)))
+
+# Like Make, single quotes, double quotes, spaces are treated verbatim.
+# The following prints the text as-is.
+$(warning ' " '"   ' ''' "'")
+
+# You can use '$$' to escape '$' itself
+$(warning $$)
+
+# The escaped '$' loses its special meaning. The following should print '$X'.
+# Do not expand '$X' even further.
+$(warning $$X)
+
+# In Make, a variable name can contain almost any characters.  The only
+# disallowed characters are : # and =
+# '$' can be used as a variable name in Kconfig, although it is nasty
+$$ = nasty
+$(warning $($$))
+
+# Even a space can be a variable name by using the following trick.
+empty   :=
+space   := $(empty) $(empty)
+$(space) = super_nasty
+$(warning $($(space)))
+
+# The behavior of a standalone '$' at the end of a token is undefined.
+# It is evaluated to an empty string in Make 4.1 or older, while
+# to '$' as-is in Make 4.2 or newer.  Kconfig follows the behavior of
+# the newer Make version, but it is not important.
+
+# In the implementation of Kconfig, a standalone '$' at the end of a token
+# is treated as-is.  So, the following also prints '$'
+$(warning $)
+
+# Likewise, a standalone '$' before a comma loses its special meaning.
+# The following prints '$X'.  Do not expand '$X' even further.
+bar = $1$2
+$(warning $(bar $,X))
+
+# The following prints the value of the variable '$'.
+$(warning $($))
diff --git a/scripts/kconfig/tests/preprocess/escape/__init__.py b/scripts/kconfig/tests/preprocess/escape/__init__.py
new file mode 100644
index 0000000..841a754
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/__init__.py
@@ -0,0 +1,9 @@
+"""
+Escape sequence tests.
+
+Test tricky cases related to escaping.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/escape/expected_stderr b/scripts/kconfig/tests/preprocess/escape/expected_stderr
new file mode 100644
index 0000000..81df7e5
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/expected_stderr
@@ -0,0 +1,10 @@
+Kconfig:5: arg0= arg1=
+Kconfig:9: arg0=, arg1=,
+Kconfig:13: ' " '"   ' ''' "'"
+Kconfig:16: $
+Kconfig:20: $X
+Kconfig:26: nasty
+Kconfig:32: super_nasty
+Kconfig:41: $
+Kconfig:46: $X
+Kconfig:49: nasty
diff --git a/scripts/kconfig/tests/preprocess/user_func/Kconfig b/scripts/kconfig/tests/preprocess/user_func/Kconfig
new file mode 100644
index 0000000..9d248ca
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/user_func/Kconfig
@@ -0,0 +1,19 @@
+greeting = $(1), my name is $(2).
+$(warning $(greeting Hello,John))
+
+# It is allowed to pass more arguments than referenced.
+# Unreferenced parameters are just ignored.
+$(warning $(greeting Hello,John,ignored,ignored))
+
+# It is also allowed to give fewer arguments. $(2) will be blank in this case.
+$(warning $(greeting Hello))
+
+# Passing zero argument is OK.  In fact, a user-defined function
+# is handle in the same way as a recursively expanded variable
+$(warning $(greeting))
+
+# However, if 1, 2 are defined as a global scope variable,
+# user-defined function will use them where arguments are missing
+1 = Hi
+2 = Tom
+$(warning $(greeting))
diff --git a/scripts/kconfig/tests/preprocess/user_func/__init__.py b/scripts/kconfig/tests/preprocess/user_func/__init__.py
new file mode 100644
index 0000000..8da60f6
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/user_func/__init__.py
@@ -0,0 +1,7 @@
+"""
+User-defined function tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/user_func/expected_stderr b/scripts/kconfig/tests/preprocess/user_func/expected_stderr
new file mode 100644
index 0000000..1dd6684
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/user_func/expected_stderr
@@ -0,0 +1,5 @@
+Kconfig:2: Hello, my name is John.
+Kconfig:6: Hello, my name is John.
+Kconfig:9: Hello, my name is .
+Kconfig:13: , my name is .
+Kconfig:19: Hi, my name is Tom.
diff --git a/scripts/kconfig/tests/preprocess/variable/Kconfig b/scripts/kconfig/tests/preprocess/variable/Kconfig
new file mode 100644
index 0000000..df4446b
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/Kconfig
@@ -0,0 +1,39 @@
+# Simply expanded variable.
+X := 1
+SIMPLE := $(X)
+X := 2
+$(warning SIMPLE = $(SIMPLE))
+
+# Recursively expanded variable.
+X := 1
+RECURSIVE = $(X)
+X := 2
+$(warning RECURSIVE = $(RECURSIVE))
+
+# Append something to a simply expanded variable.
+Y := 3
+SIMPLE += $(Y)
+Y := 4
+$(warning SIMPLE = $(SIMPLE))
+
+# Append something to a recursively expanded variable.
+Y := 3
+RECURSIVE += $(Y)
+Y := 4
+$(warning RECURSIVE = $(RECURSIVE))
+
+# Use += operator to an undefined variable.
+# This works as a recursively expanded variable.
+Y := 3
+UNDEFINED_VARIABLE += $(Y)
+Y := 4
+$(warning UNDEFINED_VARIABLE = $(UNDEFINED_VARIABLE))
+
+# You can use variable references for the lefthand side of assignment statement.
+X := A
+Y := B
+$(X)$(Y) := 5
+$(warning AB = $(AB))
+
+# By the way, you can omit the parentheses for a single-letter variable
+$(warning X = $X)
diff --git a/scripts/kconfig/tests/preprocess/variable/__init__.py b/scripts/kconfig/tests/preprocess/variable/__init__.py
new file mode 100644
index 0000000..e087698
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/__init__.py
@@ -0,0 +1,7 @@
+"""
+Variable tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/variable/expected_stderr b/scripts/kconfig/tests/preprocess/variable/expected_stderr
new file mode 100644
index 0000000..61b06e1
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/expected_stderr
@@ -0,0 +1,7 @@
+Kconfig:5: SIMPLE = 1
+Kconfig:11: RECURSIVE = 2
+Kconfig:17: SIMPLE = 1 3
+Kconfig:23: RECURSIVE = 2 4
+Kconfig:30: UNDEFINED_VARIABLE = 4
+Kconfig:36: AB = 5
+Kconfig:39: X = A
-- 
2.7.4
