Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeDMFMJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:12:09 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54534 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeDMFIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgL029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] gcc-plugins: test plugin support in Kconfig and clean up Makefile
Date: Fri, 13 Apr 2018 14:06:36 +0900
Message-Id: <1523595999-27433-28-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run scripts/gcc-plugin.sh from Kconfig so that users can enable
GCC_PLUGINS only when the compiler supports building plugins.

Kconfig defines a new symbol, PLUGIN_HOSTCC.  This will contain
the compiler (g++ or gcc) used for building plugins, or empty
if the plugin can not be supported at all.

This allows us to remove all ugly testing in Makefile.gcc-plugins.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Respin to keep scripts/gcc-plugin.sh as-is.

Changes in v2: None

 arch/Kconfig                 | 10 ++++++
 scripts/Kconfig.include      |  3 ++
 scripts/Makefile.gcc-plugins | 79 ++++++++++++--------------------------------
 scripts/gcc-plugins/Makefile |  1 +
 4 files changed, 36 insertions(+), 57 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b0582f2..9166157 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -401,6 +401,15 @@ config SECCOMP_FILTER
 
 	  See Documentation/prctl/seccomp_filter.txt for details.
 
+preferred-plugin-hostcc := $(shell [ $(gcc-version) -ge 40800 ] && echo $(HOSTCXX) || echo $(HOSTCC))
+
+config PLUGIN_HOSTCC
+	string
+	default "$(shell $(srctree)/scripts/gcc-plugin.sh $(preferred-plugin-hostcc) $(HOSTCXX) $(CC))"
+	help
+	  Host compiler used to build GCC plugins.  This can be $(HOSTCXX),
+	  $(HOSTCC), or a null string if GCC plugin is unsupported.
+
 config HAVE_GCC_PLUGINS
 	bool
 	help
@@ -410,6 +419,7 @@ config HAVE_GCC_PLUGINS
 menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
+	depends on PLUGIN_HOSTCC != ""
 	depends on !COMPILE_TEST
 	help
 	  GCC plugins are loadable modules that provide extra features to the
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index cac7a81..0864a19 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -15,3 +15,6 @@ cc-option = $(success $(CC) -Werror $(1) -c -x c /dev/null -o /dev/null)
 
 # y if the given linker flag is supported, n otherwise
 ld-option = $(success $(LD) -v $(1))
+
+# gcc version including patch level
+gcc-version := $(shell $(srctree)/scripts/gcc-version.sh -p $(CC) | sed 's/^0*//')
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 1e92353..da5d38d 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -1,72 +1,37 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_GCC_PLUGINS
-  __PLUGINCC := $(call cc-ifversion, -ge, 0408, $(HOSTCXX), $(HOSTCC))
-  PLUGINCC := $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-plugin.sh "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)")
-
-  SANCOV_PLUGIN := -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
-
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY)	+= cyc_complexity_plugin.so
+gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY)	+= cyc_complexity_plugin.so
 
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= -DLATENT_ENTROPY_PLUGIN
-  ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
+gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= -DLATENT_ENTROPY_PLUGIN
+ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
     DISABLE_LATENT_ENTROPY_PLUGIN			+= -fplugin-arg-latent_entropy_plugin-disable
-  endif
-
-  ifdef CONFIG_GCC_PLUGIN_SANCOV
-      # It is needed because of the gcc-plugin.sh and gcc version checks.
-      gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
-
-      ifeq ($(PLUGINCC),)
-        $(warning warning: cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler)
-      endif
-  endif
-
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)	+= -fplugin-arg-structleak_plugin-verbose
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	+= -fplugin-arg-structleak_plugin-byref-all
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= -DSTRUCTLEAK_PLUGIN
+endif
 
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= -DRANDSTRUCT_PLUGIN
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	+= -fplugin-arg-randomize_layout_plugin-performance-mode
+gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)		+= sancov_plugin.so
+gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)	+= -fplugin-arg-structleak_plugin-verbose
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	+= -fplugin-arg-structleak_plugin-byref-all
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= -DSTRUCTLEAK_PLUGIN
 
-  GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
+gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= -DRANDSTRUCT_PLUGIN
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	+= -fplugin-arg-randomize_layout_plugin-performance-mode
 
-  export PLUGINCC GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
-  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN
+GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
 
-  ifneq ($(PLUGINCC),)
-    # SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.
-    GCC_PLUGINS_CFLAGS := $(filter-out $(SANCOV_PLUGIN), $(GCC_PLUGINS_CFLAGS))
-  endif
+export GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
+export DISABLE_LATENT_ENTROPY_PLUGIN
 
-  KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
-  GCC_PLUGIN := $(gcc-plugin-y)
-  GCC_PLUGIN_SUBDIR := $(gcc-plugin-subdir-y)
-endif
+# SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.
+GCC_PLUGINS_CFLAGS := $(filter-out %/sancov_plugin.so, $(GCC_PLUGINS_CFLAGS))
 
-# If plugins aren't supported, abort the build before hard-to-read compiler
-# errors start getting spewed by the main build.
-PHONY += gcc-plugins-check
-gcc-plugins-check: FORCE
-ifdef CONFIG_GCC_PLUGINS
-  ifeq ($(PLUGINCC),)
-    ifneq ($(GCC_PLUGINS_CFLAGS),)
-      ifeq ($(call cc-ifversion, -ge, 0405, y), y)
-	$(Q)$(srctree)/scripts/gcc-plugin.sh --show-error "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)" || true
-	@echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
-      else
-	@echo "Cannot use CONFIG_GCC_PLUGINS: your gcc version does not support plugins, you should upgrade it to at least gcc 4.5" >&2 && exit 1
-      endif
-    endif
-  endif
-endif
-	@:
+KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
+GCC_PLUGIN := $(gcc-plugin-y)
+GCC_PLUGIN_SUBDIR := $(gcc-plugin-subdir-y)
 
 # Actually do the build, if requested.
 PHONY += gcc-plugins
-gcc-plugins: scripts_basic gcc-plugins-check
+gcc-plugins: scripts_basic
 ifdef CONFIG_GCC_PLUGINS
 	$(Q)$(MAKE) $(build)=scripts/gcc-plugins
 endif
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index e2ff425..c47198c 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+PLUGINCC := $(CONFIG_PLUGIN_HOSTCC:"%"=%)
 GCC_PLUGINS_DIR := $(shell $(CC) -print-file-name=plugin)
 
 ifeq ($(PLUGINCC),$(HOSTCC))
-- 
2.7.4
