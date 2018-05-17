Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEQGUJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:20:09 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26525 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeEQGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:20:06 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUI002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 20/31] kconfig: test: add Kconfig macro language tests
Date: Thu, 17 May 2018 15:16:59 +0900
Message-Id: <1526537830-22606-21-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the test cases I used for developing the text expansion
feature.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - Adjust for the change in function call syntax.
  - Remove unnecessarily tricky tests.

Changes in v3:
  - newly added

Changes in v2: None

 .../kconfig/tests/preprocess/builtin_func/Kconfig  | 29 +++++++++++++
 .../tests/preprocess/builtin_func/__init__.py      |  8 ++++
 .../tests/preprocess/builtin_func/expected_stderr  |  7 ++++
 .../tests/preprocess/builtin_func/expected_stdout  |  1 +
 .../tests/preprocess/circular_expansion/Kconfig    |  3 ++
 .../preprocess/circular_expansion/__init__.py      | 10 +++++
 .../preprocess/circular_expansion/expected_stderr  |  1 +
 scripts/kconfig/tests/preprocess/escape/Kconfig    | 21 ++++++++++
 .../kconfig/tests/preprocess/escape/__init__.py    |  7 ++++
 .../tests/preprocess/escape/expected_stderr        |  5 +++
 scripts/kconfig/tests/preprocess/variable/Kconfig  | 48 ++++++++++++++++++++++
 .../kconfig/tests/preprocess/variable/__init__.py  |  7 ++++
 .../tests/preprocess/variable/expected_stderr      |  9 ++++
 13 files changed, 156 insertions(+)
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/escape/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/escape/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/escape/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/variable/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/variable/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/variable/expected_stderr

diff --git a/scripts/kconfig/tests/preprocess/builtin_func/Kconfig b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
new file mode 100644
index 0000000..5f51135
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
@@ -0,0 +1,29 @@
+# 'info' prints the argument to stdout.
+$(info,hello world 0)
+
+# 'warning' is similar, but it sends its argument to stderr,
+# and the message is prefixed with the current file name and line number.
+$(warning,hello world 1)
+
+# 'shell' executes a command, and returns its stdout.
+$(warning,$(shell,echo hello world 3))
+
+# Every newline in the output is replaced with a space,
+# but any trailing newlines are deleted.
+$(warning,$(shell,printf 'hello\nworld\n\n4\n\n\n'))
+
+# 'filename' is expanded to the currently parsed file name,
+# 'lineno' to the line number.
+$(warning,filename=$(filename))
+$(warning,lineno=$(lineno))
+
+# 'if' selects which argument to expand
+# depending on the condition part.
+cond := 1
+$(warning,$(if,$(cond),y,n))
+cond :=
+$(warning,$(if,$(cond),y,n))
+
+# 'if' delays the expansion of arguments.
+# In the following, the 'error' function should not be evaluated.
+$(if,,$(error,this should not be expanded))
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
index 0000000..a4f27a6
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
@@ -0,0 +1,7 @@
+Kconfig:6: hello world 1
+Kconfig:9: hello world 3
+Kconfig:13: hello world  4
+Kconfig:17: filename=Kconfig
+Kconfig:18: lineno=18
+Kconfig:23: y
+Kconfig:25: n
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
new file mode 100644
index 0000000..82de3a7
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
@@ -0,0 +1 @@
+hello world 0
diff --git a/scripts/kconfig/tests/preprocess/circular_expansion/Kconfig b/scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
new file mode 100644
index 0000000..54debf1
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
@@ -0,0 +1,3 @@
+X = $(Y)
+Y = $(X)
+$(info $(X))
diff --git a/scripts/kconfig/tests/preprocess/circular_expansion/__init__.py b/scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
new file mode 100644
index 0000000..21413d9
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
@@ -0,0 +1,10 @@
+"""
+Detect circular variable expansion.
+
+If a recursively expanded variable references itself (eventually),
+it should fail with an error message.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() != 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr b/scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr
new file mode 100644
index 0000000..c638a8c
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr
@@ -0,0 +1 @@
+Kconfig:3: Recursive variable 'X' references itself (eventually)
diff --git a/scripts/kconfig/tests/preprocess/escape/Kconfig b/scripts/kconfig/tests/preprocess/escape/Kconfig
new file mode 100644
index 0000000..b38c897
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/Kconfig
@@ -0,0 +1,21 @@
+# You can not pass commas directly to a function since they are treated as
+# delimiters. You can use the following trick to do so.
+comma   := ,
+$(warning,hello$(comma) world)
+
+# Like Make, single quotes, double quotes, spaces are treated verbatim.
+# The following prints the text as-is.
+$(warning,' " '"   ' ''' "'")
+
+# You can use '$$' to escape '$' itself
+$(warning,$$)
+
+# The escaped '$' loses its special meaning. The following should print '$(X)'.
+# Do not expand '$(X)' even further.
+$(warning,$$(X))
+
+# In Make, a variable name can contain almost any characters.  The only
+# disallowed characters are : # and =
+# '$' can be used as a variable name in Kconfig, although it is nasty
+$$ = nasty
+$(warning,$($$))
diff --git a/scripts/kconfig/tests/preprocess/escape/__init__.py b/scripts/kconfig/tests/preprocess/escape/__init__.py
new file mode 100644
index 0000000..602861e
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/__init__.py
@@ -0,0 +1,7 @@
+"""
+Escape sequence tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/escape/expected_stderr b/scripts/kconfig/tests/preprocess/escape/expected_stderr
new file mode 100644
index 0000000..6a80134
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/expected_stderr
@@ -0,0 +1,5 @@
+Kconfig:4: hello, world
+Kconfig:8: ' " '"   ' ''' "'"
+Kconfig:11: $
+Kconfig:15: $(X)
+Kconfig:21: nasty
diff --git a/scripts/kconfig/tests/preprocess/variable/Kconfig b/scripts/kconfig/tests/preprocess/variable/Kconfig
new file mode 100644
index 0000000..271834e
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/Kconfig
@@ -0,0 +1,48 @@
+# Simply expanded variable.
+X := 1
+SIMPLE := $(X)
+X := 2
+$(warning,SIMPLE = $(SIMPLE))
+
+# Recursively expanded variable.
+X := 1
+RECURSIVE = $(X)
+X := 2
+$(warning,RECURSIVE = $(RECURSIVE))
+
+# Append something to a simply expanded variable.
+Y := 3
+SIMPLE += $(Y)
+Y := 4
+$(warning,SIMPLE = $(SIMPLE))
+
+# Append something to a recursively expanded variable.
+Y := 3
+RECURSIVE += $(Y)
+Y := 4
+$(warning,RECURSIVE = $(RECURSIVE))
+
+# Use += operator to an undefined variable.
+# This works as a recursively expanded variable.
+Y := 3
+UNDEFINED_VARIABLE += $(Y)
+Y := 4
+$(warning,UNDEFINED_VARIABLE = $(UNDEFINED_VARIABLE))
+
+# You can use variable references for the lefthand side of assignment statement.
+X := A
+Y := B
+$(X)$(Y) := 5
+$(warning,AB = $(AB))
+
+# User-defined function.
+greeting = $(1), my name is $(2).
+$(warning,$(greeting,Hello,John))
+
+# The number of arguments is not checked for user-defined functions.
+# If some arguments are optional, it is useful to pass fewer parameters.
+# $(2) will be blank in this case.
+$(warning,$(greeting,Hello))
+
+# Unreferenced parameters are just ignored.
+$(warning,$(greeting,Hello,John,ignored,ignored))
diff --git a/scripts/kconfig/tests/preprocess/variable/__init__.py b/scripts/kconfig/tests/preprocess/variable/__init__.py
new file mode 100644
index 0000000..5b2c1be
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/__init__.py
@@ -0,0 +1,7 @@
+"""
+Variable and user-defined function tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/variable/expected_stderr b/scripts/kconfig/tests/preprocess/variable/expected_stderr
new file mode 100644
index 0000000..bddfa3b
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/expected_stderr
@@ -0,0 +1,9 @@
+Kconfig:5: SIMPLE = 1
+Kconfig:11: RECURSIVE = 2
+Kconfig:17: SIMPLE = 1 3
+Kconfig:23: RECURSIVE = 2 4
+Kconfig:30: UNDEFINED_VARIABLE = 4
+Kconfig:36: AB = 5
+Kconfig:40: Hello, my name is John.
+Kconfig:45: Hello, my name is .
+Kconfig:48: Hello, my name is John.
-- 
2.7.4
