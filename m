Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeDMFOG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:14:06 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54466 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgB029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/30] Documentation: kconfig: document a new Kconfig macro language
Date: Fri, 13 Apr 2018 14:06:26 +0900
Message-Id: <1523595999-27433-18-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a document for the macro language introduced to Kconfig.

The motivation of this work is to move the compiler option tests to
Kconfig from Makefile.  A number of kernel features require the
compiler support.  Enabling such features blindly in Kconfig ends up
with a lot of nasty build-time testing in Makefiles.  If a chosen
feature turns out unsupported by the compiler, what the build system
can do is either to disable it (silently!) or to forcibly break the
build, despite Kconfig has let the user to enable it.

This change was strongly prompted by Linus Torvalds.  You can find
his suggestions [1] [2] in ML.  The original idea was to add a new
'option', but I found generalized text expansion would make Kconfig
more powerful and lovely.  While polishing up the implementation, I
noticed sort of similarity between Make and Kconfig.  This might be
too immature to be called 'language', but anyway here it is.  All
ideas are from Make (you can even say it is addicted), so people
will easily understand how it works.

[1]: https://lkml.org/lkml/2016/12/9/577
[2]: https://lkml.org/lkml/2018/2/7/527

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 Documentation/kbuild/kconfig-macro-language.txt | 179 ++++++++++++++++++++++++
 MAINTAINERS                                     |   2 +-
 2 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/kbuild/kconfig-macro-language.txt

diff --git a/Documentation/kbuild/kconfig-macro-language.txt b/Documentation/kbuild/kconfig-macro-language.txt
new file mode 100644
index 0000000..1f6281b
--- /dev/null
+++ b/Documentation/kbuild/kconfig-macro-language.txt
@@ -0,0 +1,179 @@
+Concept
+-------
+
+The basic idea was inspired by Make. When we look at Make, we notice sort of
+two languages in one. One language describes dependency graphs consisting of
+targets and prerequisites. The other is a macro language for performing textual
+substitution.
+
+There is clear distinction between the two language stages. For example, you
+can write a makefile like follows:
+
+    APP := foo
+    SRC := foo.c
+    CC := gcc
+
+    $(APP): $(SRC)
+            $(CC) -o $(APP) $(SRC)
+
+The macro language replaces the variable references with their expanded form,
+and handles as if the source file were input like follows:
+
+    foo: foo.c
+            gcc -o foo foo.c
+
+Then, Make analyzes the dependency graph and determines the targets to be
+updated.
+
+The idea is quite similar in Kconfig - it is possible to describe a Kconfig
+file like this:
+
+    CC := gcc
+
+    config CC_HAS_FOO
+            def_bool $(shell $(srctree)/scripts/gcc-check-foo.sh $(CC))
+
+The macro language in Kconfig processes the source file into the following
+intermediate:
+
+    config CC_HAS_FOO
+            def_bool y
+
+Then, Kconfig moves onto the evaluation stage to resolve inter-symbol
+dependency, which is explained in kconfig-language.txt.
+
+
+Variables
+---------
+
+Like in Make, a variable in Kconfig works as a macro variable.  A macro
+variable is expanded "in place" to yield a text string that may then expanded
+further. To get the value of a variable, enclose the variable name in $( ).
+As a special case, single-letter variable names can omit the parentheses and is
+simply referenced like $X. Unlike Make, Kconfig does not support curly braces
+as in ${CC}.
+
+There are two types of variables: simply expanded variables and recursively
+expanded variables.
+
+A simply expanded variable is defined using the := assignment operator. Its
+righthand side is expanded immediately upon reading the line from the Kconfig
+file.
+
+A recursively expanded variable is defined using the = assignment operator.
+Its righthand side is simply stored as the value of the variable without
+expanding it in any way. Instead, the expansion is performed when the variable
+is used.
+
+There is another type of assignment operator; += is used to append text to a
+variable. The righthand side of += is expanded immediately if the lefthand
+side was originally defined as a simple variable. Otherwise, its evaluation is
+deferred.
+
+
+Functions
+---------
+
+Like Make, Kconfig supports both built-in and user-defined functions. A
+function invocation looks much like a variable reference, but includes one or
+more parameters separated by commas:
+
+  $(function-name arg1, arg2, arg3)
+
+Some functions are implemented as a built-in function. Currently, Kconfig
+supports the following:
+
+ - $(shell command)
+
+  The 'shell' function accepts a single argument that is expanded and passed
+  to a subshell for execution. The standard output of the command is then read
+  and returned as the value of the function. Every newline in the output is
+  replaced with a space. Any trailing newlines are deleted. The standard error
+  is not returned, nor is any program exit status.
+
+ - $(warning text)
+
+  The 'warning' function prints its arguments to stderr. The output is prefixed
+  with the name of the current Kconfig file, the current line number. It
+  evaluates to an empty string.
+
+ - $(info text)
+
+  The 'info' function is similar to 'warning' except that it sends its argument
+  to stdout without any Kconfig name or line number.
+
+A user-defined function is defined by using the = operator. The parameters are
+referenced within the body definition with $1, $2, etc. (or $(1), $(2), etc.)
+In fact, a user-defined function is internally treated as a recursive variable.
+
+A user-defined function is referenced in the same way as a built-in function:
+
+    $(my_func, arg0, arg1, arg2)
+
+Note 1:
+There is a slight difference in the whitespace handling of the function call
+between Make and Kconfig. In Make, leading whitespaces are trimmed from the
+first argument. So, $(info    FOO) is equivalent to $(info FOO). Kconfig keeps
+any leading whitespaces except the one right after the function name, which
+works as a separator. So, $(info    FOO) prints "   FOO" to the stdout.
+
+Note 2:
+In Make, a user-defined function is referenced by using a built-in function,
+'call', like this:
+
+    $(call my_func, arg0, arg1, arg2)
+
+However, Kconfig did not adopt this form just for the purpose of shortening the
+syntax.
+
+
+Caveats
+-------
+
+A variable (or function) can not be expanded across tokens. So, you can not use
+a variable as a shorthand for an expression that consists of multiple tokens.
+The following works:
+
+    RANGE_MIN := 1
+    RANGE_MAX := 3
+
+    config FOO
+            int "foo"
+            range $(RANGE_MIN) $(RANGE_MAX)
+
+But, the following does not work:
+
+    RANGES := 1 3
+
+    config FOO
+            int "foo"
+            range $(RANGES)
+
+A variable can not be expanded to any keyword in Kconfig.  The following does
+not work:
+
+    MY_TYPE := tristate
+
+    config FOO
+            $(MY_TYPE) "foo"
+            default y
+
+Obviously from the design, $(shell command) is expanded in the textual
+substitution phase.  You can not pass symbols to the 'shell' function.
+The following does not work as expected.
+
+    config ENDIAN_OPTION
+            string
+            default "-mbig-endian" if CPU_BIG_ENDIAN
+            default "-mlittle-endian" if CPU_LITTLE_ENDIAN
+
+    config CC_HAS_ENDIAN_OPTION
+            def_bool $(shell $(srctree)/scripts/gcc-check-option ENDIAN_OPTION)
+
+Instead, you can do like follows so that any function call is statically
+expanded.
+
+    config CC_HAS_ENDIAN_OPTION
+            bool
+	    default $(shell $(srctree)/scripts/gcc-check-option -mbig-endian) if CPU_BIG_ENDIAN
+	    default $(shell $(srctree)/scripts/gcc-check-option -mlittle-endian) if CPU_LITTLE_ENDIAN
diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d..b9dab38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7622,7 +7622,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig
 L:	linux-kbuild@vger.kernel.org
 S:	Maintained
-F:	Documentation/kbuild/kconfig-language.txt
+F:	Documentation/kbuild/kconfig*
 F:	scripts/kconfig/
 
 KDUMP
-- 
2.7.4
