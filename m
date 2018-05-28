Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933918AbeE1J0N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:26:13 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:23137 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933643AbeE1JZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:25:08 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MIni027506
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
Subject: [PATCH v5 27/31] kcov: test compiler capability in Kconfig and correct dependency
Date: Mon, 28 May 2018 18:22:04 +0900
Message-Id: <1527499328-13213-28-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
be used with care - it forces a lower limit of another symbol, ignoring
the dependency.  Currently, KCOV can select GCC_PLUGINS even if arch
does not select HAVE_GCC_PLUGINS.  This could cause the unmet direct
dependency.

Now that Kconfig can test compiler capability, let's handle this in a
more sophisticated way.

There are two ways to enable KCOV; use the compiler that natively
supports -fsanitize-coverage=trace-pc, or build the SANCOV plugin if
the compiler has ability to build GCC plugins.  Hence, the correct
dependency for KCOV is:

  depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS

You do not need to build the SANCOV plugin if the compiler already
supports -fsanitize-coverage=trace-pc.  Hence, the select should be:

  select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC

With this, GCC_PLUGIN_SANCOV is selected only when necessary, so
scripts/Makefile.gcc-plugins can be cleaner.

I also cleaned up Kconfig and scripts/Makefile.kcov as well.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
  - Replace the previous 'select -> imply' patch with
    a new approach

Changes in v2:
  - Drop depends on GCC_VERSION

 Makefile                     |  2 +-
 lib/Kconfig.debug            | 11 +++++++----
 scripts/Makefile.gcc-plugins |  6 +-----
 scripts/Makefile.kcov        | 10 ++++++----
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 80e0800..4b5a17a 100644
--- a/Makefile
+++ b/Makefile
@@ -626,7 +626,7 @@ all: vmlinux
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage \
 	$(call cc-option,-fno-tree-loop-im) \
 	$(call cc-disable-warning,maybe-uninitialized,)
-export CFLAGS_GCOV CFLAGS_KCOV
+export CFLAGS_GCOV
 
 # The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
 # values of the respective KBUILD_* variables
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b7..b76cab2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -736,12 +736,15 @@ config ARCH_HAS_KCOV
 	  only for x86_64. KCOV requires testing on other archs, and most likely
 	  disabling of instrumentation for some early boot code.
 
+config CC_HAS_SANCOV_TRACE_PC
+	def_bool $(cc-option,-fsanitize-coverage=trace-pc)
+
 config KCOV
 	bool "Code coverage for fuzzing"
 	depends on ARCH_HAS_KCOV
+	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
 	select DEBUG_FS
-	select GCC_PLUGINS if !COMPILE_TEST
-	select GCC_PLUGIN_SANCOV if !COMPILE_TEST
+	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
 	help
 	  KCOV exposes kernel code coverage information in a form suitable
 	  for coverage-guided fuzzing (randomized testing).
@@ -755,7 +758,7 @@ config KCOV
 config KCOV_ENABLE_COMPARISONS
 	bool "Enable comparison operands collection by KCOV"
 	depends on KCOV
-	default n
+	depends on $(cc-option,-fsanitize-coverage=trace-cmp)
 	help
 	  KCOV also exposes operands of every comparison in the instrumented
 	  code along with operand sizes and PCs of the comparison instructions.
@@ -765,7 +768,7 @@ config KCOV_ENABLE_COMPARISONS
 config KCOV_INSTRUMENT_ALL
 	bool "Instrument all code by default"
 	depends on KCOV
-	default y if KCOV
+	default y
 	help
 	  If you are doing generic system call fuzzing (like e.g. syzkaller),
 	  then you will want to instrument the whole kernel and you should
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 7f5c862..0ce3802 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -14,16 +14,12 @@ ifdef CONFIG_GCC_PLUGINS
   endif
 
   ifdef CONFIG_GCC_PLUGIN_SANCOV
-    ifeq ($(strip $(CFLAGS_KCOV)),)
       # It is needed because of the gcc-plugin.sh and gcc version checks.
       gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
 
-      ifneq ($(PLUGINCC),)
-        CFLAGS_KCOV := $(SANCOV_PLUGIN)
-      else
+      ifeq ($(PLUGINCC),)
         $(warning warning: cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler)
       endif
-    endif
   endif
 
   gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
index 5cc7203..d71ba73 100644
--- a/scripts/Makefile.kcov
+++ b/scripts/Makefile.kcov
@@ -1,7 +1,9 @@
 ifdef CONFIG_KCOV
-CFLAGS_KCOV	:= $(call cc-option,-fsanitize-coverage=trace-pc,)
-ifeq ($(CONFIG_KCOV_ENABLE_COMPARISONS),y)
-CFLAGS_KCOV += $(call cc-option,-fsanitize-coverage=trace-cmp,)
-endif
+
+kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)	+= -fsanitize-coverage=trace-pc
+kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)	+= -fsanitize-coverage=trace-cmp
+kcov-flags-$(CONFIG_GCC_PLUGIN_SANKOV)		+= -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
+
+export CFLAGS_KCOV := $(kcov-flags-y)
 
 endif
-- 
2.7.4
