Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeDMFMH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:12:07 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54557 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeDMFIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgF029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/30] stack-protector: test compiler capability in Kconfig and drop AUTO mode
Date: Fri, 13 Apr 2018 14:06:30 +0900
Message-Id: <1523595999-27433-22-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the test for -fstack-protector(-strong) option to Kconfig.

If the compiler does not support the option, the corresponding menu
is automatically hidden.  If STRONG is not supported, it will fall
back to REGULAR.  If REGULAR is not supported, it will be disabled.
This means, AUTO is implicitly handled by the dependency solver of
Kconfig, hence removed.

I also turned the 'choice' into only two boolean symbols.  The use of
'choice' is not a good idea here, because all of all{yes,mod,no}config
would choose the first visible value, while we want allnoconfig to
disable as many features as possible.

X86 has additional shell scripts in case the compiler supports those
options, but generates broken code.  I added CC_HAS_SANE_STACKPROTECTOR
to test this.  I had to add -m32 to gcc-x86_32-has-stack-protector.sh
to make it work correctly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 Makefile                                  | 93 ++-----------------------------
 arch/Kconfig                              | 32 ++++-------
 arch/x86/Kconfig                          | 11 +++-
 scripts/gcc-x86_32-has-stack-protector.sh |  7 +--
 scripts/gcc-x86_64-has-stack-protector.sh |  5 --
 5 files changed, 28 insertions(+), 120 deletions(-)

diff --git a/Makefile b/Makefile
index 4b36329..889d002 100644
--- a/Makefile
+++ b/Makefile
@@ -672,55 +672,11 @@ ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
 
-# This selects the stack protector compiler flag. Testing it is delayed
-# until after .config has been reprocessed, in the prepare-compiler-check
-# target.
-ifdef CONFIG_CC_STACKPROTECTOR_AUTO
-  stackp-flag := $(call cc-option,-fstack-protector-strong,$(call cc-option,-fstack-protector))
-  stackp-name := AUTO
-else
-ifdef CONFIG_CC_STACKPROTECTOR_REGULAR
-  stackp-flag := -fstack-protector
-  stackp-name := REGULAR
-else
-ifdef CONFIG_CC_STACKPROTECTOR_STRONG
-  stackp-flag := -fstack-protector-strong
-  stackp-name := STRONG
-else
-  # If either there is no stack protector for this architecture or
-  # CONFIG_CC_STACKPROTECTOR_NONE is selected, we're done, and $(stackp-name)
-  # is empty, skipping all remaining stack protector tests.
-  #
-  # Force off for distro compilers that enable stack protector by default.
-  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
-endif
-endif
-endif
-# Find arch-specific stack protector compiler sanity-checking script.
-ifdef stackp-name
-ifneq ($(stackp-flag),)
-  stackp-path := $(srctree)/scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh
-  stackp-check := $(wildcard $(stackp-path))
-  # If the wildcard test matches a test script, run it to check functionality.
-  ifdef stackp-check
-    ifneq ($(shell $(CONFIG_SHELL) $(stackp-check) $(CC) $(KBUILD_CPPFLAGS) $(biarch)),y)
-      stackp-broken := y
-    endif
-  endif
-  ifndef stackp-broken
-    # If the stack protector is functional, enable code that depends on it.
-    KBUILD_CPPFLAGS += -DCONFIG_CC_STACKPROTECTOR
-    # Either we've already detected the flag (for AUTO) or we'll fail the
-    # build in the prepare-compiler-check rule (for specific flag).
-    KBUILD_CFLAGS += $(stackp-flag)
-  else
-    # We have to make sure stack protector is unconditionally disabled if
-    # the compiler is broken (in case we're going to continue the build in
-    # AUTO mode).
-    KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
-  endif
-endif
-endif
+stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
+stackp-flags-$(CONFIG_CC_STACKPROTECTOR)          := -fstack-protector
+stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)   := -fstack-protector-strong
+
+KBUILD_CFLAGS += $(stackp-flags-y)
 
 ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
@@ -1096,7 +1052,7 @@ endif
 # prepare2 creates a makefile if using a separate output directory.
 # From this point forward, .config has been reprocessed, so any rules
 # that need to depend on updated CONFIG_* values can be checked here.
-prepare2: prepare3 prepare-compiler-check outputmakefile asm-generic
+prepare2: prepare3 outputmakefile asm-generic
 
 prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
                    include/config/auto.conf
@@ -1122,43 +1078,6 @@ uapi-asm-generic:
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
 
-# Check for CONFIG flags that require compiler support. Abort the build
-# after .config has been processed, but before the kernel build starts.
-#
-# For security-sensitive CONFIG options, we don't want to fallback and/or
-# silently change which compiler flags will be used, since that leads to
-# producing kernels with different security feature characteristics
-# depending on the compiler used. (For example, "But I selected
-# CC_STACKPROTECTOR_STRONG! Why did it build with _REGULAR?!")
-PHONY += prepare-compiler-check
-prepare-compiler-check: FORCE
-# Make sure compiler supports requested stack protector flag.
-ifdef stackp-name
-  # Warn about CONFIG_CC_STACKPROTECTOR_AUTO having found no option.
-  ifeq ($(stackp-flag),)
-	@echo CONFIG_CC_STACKPROTECTOR_$(stackp-name): \
-		  Compiler does not support any known stack-protector >&2
-  else
-  # Fail if specifically requested stack protector is missing.
-  ifeq ($(call cc-option, $(stackp-flag)),)
-	@echo Cannot use CONFIG_CC_STACKPROTECTOR_$(stackp-name): \
-		  $(stackp-flag) not supported by compiler >&2 && exit 1
-  endif
-  endif
-endif
-# Make sure compiler does not have buggy stack-protector support. If a
-# specific stack-protector was requested, fail the build, otherwise warn.
-ifdef stackp-broken
-  ifeq ($(stackp-name),AUTO)
-	@echo CONFIG_CC_STACKPROTECTOR_$(stackp-name): \
-                  $(stackp-flag) available but compiler is broken: disabling >&2
-  else
-	@echo Cannot use CONFIG_CC_STACKPROTECTOR_$(stackp-name): \
-                  $(stackp-flag) available but compiler is broken >&2 && exit 1
-  endif
-endif
-	@:
-
 # Generate some files
 # ---------------------------------------------------------------------------
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665..b0582f2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -535,13 +535,16 @@ config HAVE_CC_STACKPROTECTOR
 	bool
 	help
 	  An arch should select this symbol if:
-	  - its compiler supports the -fstack-protector option
 	  - it has implemented a stack canary (e.g. __stack_chk_guard)
 
-choice
-	prompt "Stack Protector buffer overflow detection"
+config CC_HAS_STACKPROTECTOR_NONE
+	def_bool $(cc-option -fno-stack-protector)
+
+config CC_STACKPROTECTOR
+	bool "Stack Protector buffer overflow detection"
 	depends on HAVE_CC_STACKPROTECTOR
-	default CC_STACKPROTECTOR_AUTO
+	depends on $(cc-option -fstack-protector)
+	default y
 	help
 	  This option turns on the "stack-protector" GCC feature. This
 	  feature puts, at the beginning of functions, a canary value on
@@ -551,14 +554,6 @@ choice
 	  overwrite the canary, which gets detected and the attack is then
 	  neutralized via a kernel panic.
 
-config CC_STACKPROTECTOR_NONE
-	bool "None"
-	help
-	  Disable "stack-protector" GCC feature.
-
-config CC_STACKPROTECTOR_REGULAR
-	bool "Regular"
-	help
 	  Functions will have the stack-protector canary logic added if they
 	  have an 8-byte or larger character array on the stack.
 
@@ -570,7 +565,10 @@ config CC_STACKPROTECTOR_REGULAR
 	  by about 0.3%.
 
 config CC_STACKPROTECTOR_STRONG
-	bool "Strong"
+	bool "Strong Stack Protector"
+	depends on CC_STACKPROTECTOR
+	depends on $(cc-option -fstack-protector-strong)
+	default y
 	help
 	  Functions will have the stack-protector canary logic added in any
 	  of the following conditions:
@@ -588,14 +586,6 @@ config CC_STACKPROTECTOR_STRONG
 	  about 20% of all kernel functions, which increases the kernel code
 	  size by about 2%.
 
-config CC_STACKPROTECTOR_AUTO
-	bool "Automatic"
-	help
-	  If the compiler supports it, the best available stack-protector
-	  option will be chosen.
-
-endchoice
-
 config LD_DEAD_CODE_DATA_ELIMINATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 72350d5..6f65146 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,7 +124,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
-	select HAVE_CC_STACKPROTECTOR
+	select HAVE_CC_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
@@ -340,6 +340,15 @@ config PGTABLE_LEVELS
 	default 2
 
 source "init/Kconfig"
+
+config CC_HAS_SANE_STACKPROTECTOR
+	bool
+	default $(success $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
+	default $(success $(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
+	help
+	   We have to make sure stack protector is unconditionally disabled if
+	   the compiler produces broken code.
+
 source "kernel/Kconfig.freezer"
 
 menu "Processor type and features"
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index 6b2aeef..f5c1194 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -1,9 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-if [ "$?" -eq "0" ] ; then
-	echo y
-else
-	echo n
-fi
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
index 4a48bdc..3755af0 100755
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ b/scripts/gcc-x86_64-has-stack-protector.sh
@@ -2,8 +2,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
 echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-if [ "$?" -eq "0" ] ; then
-	echo y
-else
-	echo n
-fi
-- 
2.7.4
