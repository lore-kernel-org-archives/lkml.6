Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeE1JYe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:24:34 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:22008 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeE1JY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:29 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInb027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 20/31] kconfig: test: add Kconfig macro language tests
Date: Mon, 28 May 2018 18:21:57 +0900
Message-Id: <1527499328-13213-21-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the test cases I used for developing the text expansion
feature.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5:
  - Add SPDX License Identifier to test files
  - Update tests according to the simplification of grammar
  - Add more escape sequence tricks

Changes in v4:
  - Adjust for the change in function call syntax.
  - Remove unnecessarily tricky tests.

Changes in v3:
  - newly added

Changes in v2: None

 .../kconfig/tests/preprocess/builtin_func/Kconfig  | 27 +++++++++++
 .../tests/preprocess/builtin_func/__init__.py      |  9 ++++
 .../tests/preprocess/builtin_func/expected_stderr  |  5 ++
 .../tests/preprocess/builtin_func/expected_stdout  |  1 +
 .../tests/preprocess/circular_expansion/Kconfig    |  5 ++
 .../preprocess/circular_expansion/__init__.py      | 11 +++++
 .../preprocess/circular_expansion/expected_stderr  |  1 +
 scripts/kconfig/tests/preprocess/escape/Kconfig    | 44 ++++++++++++++++++
 .../kconfig/tests/preprocess/escape/__init__.py    |  8 ++++
 .../tests/preprocess/escape/expected_stderr        | 10 ++++
 scripts/kconfig/tests/preprocess/variable/Kconfig  | 53 ++++++++++++++++++++++
 .../kconfig/tests/preprocess/variable/__init__.py  |  8 ++++
 .../tests/preprocess/variable/expected_stderr      |  9 ++++
 13 files changed, 191 insertions(+)
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
index 0000000..baa3288
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# 'info' prints the argument to stdout.
+$(info,hello world 0)
+
+# 'warning-if', if the first argument is y, sends the second argument to stderr,
+# and the message is prefixed with the current file name and line number.
+$(warning-if,y,hello world 1)
+
+# 'error-if' is similar, but it terminates the parsing immediately.
+# The following is just no-op since the first argument is not y.
+$(error-if,n,this should not be printed)
+
+# Shorthand
+warning = $(warning-if,y,$(1))
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
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/__init__.py b/scripts/kconfig/tests/preprocess/builtin_func/__init__.py
new file mode 100644
index 0000000..2e53ba0
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/__init__.py
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
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
index 0000000..33ea9ca
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
@@ -0,0 +1,5 @@
+Kconfig:8: hello world 1
+Kconfig:18: hello world 3
+Kconfig:22: hello world  4
+Kconfig:26: filename=Kconfig
+Kconfig:27: lineno=27
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
new file mode 100644
index 0000000..82de3a7
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
@@ -0,0 +1 @@
+hello world 0
diff --git a/scripts/kconfig/tests/preprocess/circular_expansion/Kconfig b/scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
new file mode 100644
index 0000000..6838997
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+X = $(Y)
+Y = $(X)
+$(info $(X))
diff --git a/scripts/kconfig/tests/preprocess/circular_expansion/__init__.py b/scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
new file mode 100644
index 0000000..419bda3
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
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
index 0000000..cde68fa
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr
@@ -0,0 +1 @@
+Kconfig:5: Recursive variable 'X' references itself (eventually)
diff --git a/scripts/kconfig/tests/preprocess/escape/Kconfig b/scripts/kconfig/tests/preprocess/escape/Kconfig
new file mode 100644
index 0000000..4e3f444
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/Kconfig
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Shorthand
+warning = $(warning-if,y,$(1))
+
+# You can not pass commas directly to a function since they are treated as
+# delimiters. You can use the following trick to do so.
+comma   := ,
+$(warning,hello$(comma) world)
+
+# Like Make, single quotes, double quotes, spaces are treated verbatim.
+# The following prints the text as-is.
+$(warning,  ' " '"   ' ''' "'")
+
+# Unlike Make, '$' has special meaning only when it is followed by '('.
+# No need to escape '$' itself.
+$(warning,$)
+$(warning,$$)
+$ := 1
+$(warning,$($))
+
+# You need a trick to escape '$' followed by '('
+# The following should print "$(X)". It should not be expanded further.
+dollar := $
+$(warning,$(dollar)(X))
+
+# You need a trick to treat unbalanced parentheses.
+# The following should print "(".
+left_paren := (
+$(warning,$(left_paren))
+
+# A simple expanded should not be expanded multiple times.
+# The following should print "$(X)". It should not be expanded further.
+Y := $(dollar)(X)
+$(warning,$(Y))
+
+# The following should print "$(X)" as well.
+Y = $(dollar)(X)
+$(warning,$(Y))
+
+# The following should print "$(".
+# It should not be emit "unterminated reference" error.
+unterminated := $(dollar)(
+$(warning,$(unterminated))
diff --git a/scripts/kconfig/tests/preprocess/escape/__init__.py b/scripts/kconfig/tests/preprocess/escape/__init__.py
new file mode 100644
index 0000000..7ee8e74
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/__init__.py
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Escape sequence tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/escape/expected_stderr b/scripts/kconfig/tests/preprocess/escape/expected_stderr
new file mode 100644
index 0000000..1c00957
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/escape/expected_stderr
@@ -0,0 +1,10 @@
+Kconfig:9: hello, world
+Kconfig:13:   ' " '"   ' ''' "'"
+Kconfig:17: $
+Kconfig:18: $$
+Kconfig:20: 1
+Kconfig:25: $(X)
+Kconfig:30: (
+Kconfig:35: $(X)
+Kconfig:39: $(X)
+Kconfig:44: $(
diff --git a/scripts/kconfig/tests/preprocess/variable/Kconfig b/scripts/kconfig/tests/preprocess/variable/Kconfig
new file mode 100644
index 0000000..9ce2f95
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/Kconfig
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Shorthand
+warning = $(warning-if,y,$(1))
+
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
index 0000000..e88b170
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/__init__.py
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Variable and user-defined function tests.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() == 0
+    assert conf.stderr_matches('expected_stderr')
diff --git a/scripts/kconfig/tests/preprocess/variable/expected_stderr b/scripts/kconfig/tests/preprocess/variable/expected_stderr
new file mode 100644
index 0000000..a4841c3
--- /dev/null
+++ b/scripts/kconfig/tests/preprocess/variable/expected_stderr
@@ -0,0 +1,9 @@
+Kconfig:10: SIMPLE = 1
+Kconfig:16: RECURSIVE = 2
+Kconfig:22: SIMPLE = 1 3
+Kconfig:28: RECURSIVE = 2 4
+Kconfig:35: UNDEFINED_VARIABLE = 4
+Kconfig:41: AB = 5
+Kconfig:45: Hello, my name is John.
+Kconfig:50: Hello, my name is .
+Kconfig:53: Hello, my name is John.
-- 
2.7.4
