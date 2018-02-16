Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227po2wtU9fAKoag/j8CUg2V8znMqhf81cqxTlHk10SI+7lSjEtZaG0R5tv4SeM1GB3By38F
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=Ppbd3rwTrzEahU3y9M0YW4++QaDe45ePxZjCPu3EhOTpDwt5xZ5QyHPUBZnrXJyHWD
         3dLMBfcwYhN/azVIBLsINSlARMdz5x1m+kI1xmTNdMpDdPTGeehb8dM7ty8w7V27jhje
         SSs6rLg4HivUs4ZFTdACNa1L91kH3XdK8L+DlK0Qir+8X4vTgEIagHc8lvWBOoU4V912
         nByxtdEJCpYCpRZgjbiNWK+W//1kg8tGNPpjNI4iTc2zoQGiuU80E9KFi2CWfOvNL+pw
         IASlisZLuobAv7Uvly8SGXZiQutafYzLPa9qUPsEj/KG9jSCo1mUX/0am9i7wBKYrTx7
         S31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=YofhUX8RoPoVMr1fDLpFqcWzGOIs9n0RgRDX86OQxhA=;
        b=rE3Vb2EWa3GQf09E3Q3B8hl6bTST8oPnXKAk2xo+OZgl5ID1yh5q7/zm39XczzMKcV
         W7ssiS9yvqkbY2rFrDpGblsp2Eso1gmB04qHfB1gzNmjmW+P/Rfn3qD08LCUNR3LZT6q
         /DFN7+M9lPf4ZtMxkxa5R0VLbV2sMPHkKxP8vm8xAbbP5MsQ88boOSmWvavp4n6rU038
         LUD6vMQsyHLoY9CirkmBmvY3QSS80S0XcRcpbHIpGsf4/Jjdob0gGq2rAWf87hXeSbVC
         Nxwz1FDyFKzf73w0ExBJ3tYyTYbg0L42whXCqTCYHpcDvr3GPl7B4p7fIBzaUs9K67cE
         v+Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RwzKdsEr;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=RwzKdsEr;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTD013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 10/23] stack-protector: test compiler capability in Kconfig and drop AUTO mode
Date: Sat, 17 Feb 2018 03:38:38 +0900
Message-Id: <1518806331-7101-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935061592992?=
X-GMAIL-MSGID: =?utf-8?q?1592583935061592992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add CC_HAS_STACKPROTECTOR(_STRONG) to test if the compiler supports
-fstack-protector(-strong) option.

X86 has additional shell scripts in case the compiler supports the
option, but generates broken code.  I added CC_HAS_SANE_STACKPROTECTOR
to test this.  I had to add -m32 to gcc-x86_32-has-stack-protector.sh
to make it work correctly.

If the compiler does not support the option, the menu is automatically
hidden.  If _STRONG is not supported, it will fall back to _REGULAR.
This means, _AUTO is implicitly supported in the dependency solver of
Kconfig, hence removed.

I also turned the 'choice' into only two boolean symbols.  The use of
'choice' is not a good idea here, because all of all{yes,mod,no}config
would choose the first visible value, while we want allnoconfig to
disable as many features as possible.

I did not add CC_HAS_STACKPROTECTOR_NONE in the hope that GCC versions
we support will recognize -fno-stack-protector.

If this turns out to be a problem, it will be possible to do this:

stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
stackp-flags-$(CONFIG_CC_STACKPROTECTOR)          := -fstack-protector
stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)   := -fstack-protector-strong

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                                  | 93 ++-----------------------------
 arch/Kconfig                              | 37 ++++++------
 arch/x86/Kconfig                          |  8 ++-
 scripts/gcc-x86_32-has-stack-protector.sh |  7 +--
 scripts/gcc-x86_64-has-stack-protector.sh |  5 --
 5 files changed, 30 insertions(+), 120 deletions(-)

diff --git a/Makefile b/Makefile
index 9a8c689..e9fc7c9 100644
--- a/Makefile
+++ b/Makefile
@@ -675,55 +675,11 @@ ifneq ($(CONFIG_FRAME_WARN),0)
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
+stackp-flags-y					:= -fno-stack-protector
+stackp-flags-$(CONFIG_CC_STACKPROTECTOR)	:= -fstack-protector
+stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)	:= -fstack-protector-strong
+
+KBUILD_CFLAGS += $(stackp-flags-y)
 
 ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
@@ -1079,7 +1035,7 @@ endif
 # prepare2 creates a makefile if using a separate output directory.
 # From this point forward, .config has been reprocessed, so any rules
 # that need to depend on updated CONFIG_* values can be checked here.
-prepare2: prepare3 prepare-compiler-check outputmakefile asm-generic
+prepare2: prepare3 outputmakefile asm-generic
 
 prepare1: prepare2 $(version_h) include/generated/utsrelease.h \
                    include/config/auto.conf
@@ -1105,43 +1061,6 @@ uapi-asm-generic:
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
index 76c0b54..9b7a628 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -535,13 +535,21 @@ config HAVE_CC_STACKPROTECTOR
 	bool
 	help
 	  An arch should select this symbol if:
-	  - its compiler supports the -fstack-protector option
 	  - it has implemented a stack canary (e.g. __stack_chk_guard)
 
-choice
-	prompt "Stack Protector buffer overflow detection"
+config CC_HAS_STACKPROTECTOR
+	bool
+	default $(cc-option -fstack-protector)
+
+config CC_HAS_STACKPROTECTOR_STRONG
+	bool
+	default $(cc-option -fstack-protector-strong)
+
+config CC_STACKPROTECTOR
+	bool "Stack Protector buffer overflow detection"
 	depends on HAVE_CC_STACKPROTECTOR
-	default CC_STACKPROTECTOR_AUTO
+	depends on CC_HAS_STACKPROTECTOR
+	default y
 	help
 	  This option turns on the "stack-protector" GCC feature. This
 	  feature puts, at the beginning of functions, a canary value on
@@ -551,14 +559,6 @@ choice
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
 
@@ -570,7 +570,10 @@ config CC_STACKPROTECTOR_REGULAR
 	  by about 0.3%.
 
 config CC_STACKPROTECTOR_STRONG
-	bool "Strong"
+	bool "Strong Stack Protector"
+	depends on CC_HAS_STACKPROTECTOR_STRONG
+	depends on CC_STACKPROTECTOR
+	default y
 	help
 	  Functions will have the stack-protector canary logic added in any
 	  of the following conditions:
@@ -588,14 +591,6 @@ config CC_STACKPROTECTOR_STRONG
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
 config THIN_ARCHIVES
 	def_bool y
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 54d943a..498694d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,7 +124,6 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
-	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
@@ -340,6 +339,13 @@ config PGTABLE_LEVELS
 	default 2
 
 source "init/Kconfig"
+
+config CC_HAS_SANE_STACKPROTECTOR
+	bool
+	default $(shell $srctree/scripts/gcc-x86_64-has-stack-protector.sh $CC) if 64BIT
+	default $(shell $srctree/scripts/gcc-x86_32-has-stack-protector.sh $CC)
+	select HAVE_CC_STACKPROTECTOR
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
