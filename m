Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49Xm9DjfKoORz73yUP+YeNsUbngFCaT9OmQw46B1PdB4louqn+z5l7lfHfeG4D+I8PLJ5RK
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=ydeB/F3o3VRArioIPvn4bXr3zPzcpW1/4jCkZoy6Ey/1/kKS5CV1+BDqca//AMUzma
         4jEoonXdbTbcH2qAVOcvl6bz/7W7vKAQy5Rk1UKtaomSgKMWh70uHF72SYckqeegq+17
         pYWS+CIDCiGMuXOWaYlStdaf+biwZ6yobvkar3+Ngs45Y9OEUh0xGoyCjrtH0qTryjv8
         +j2KEWNtgUmEYAigMKn6x03qbhF0O26VvVj2J9YYsR/BQKgQmC+yeJVaCm9UhIBg5nan
         ZtQIn+6nAHoy+cplEx0j9CQ9yk6QEyl9F/twVk2oN6mZ1eMKxageijfHzYrMxfIvHWSC
         Aqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=J5s1k4WDxvrC/cEZRKsOAIhyqGKMiPt0AQZWKjK7RxU=;
        b=VVyvkBjaHjoKnMb3zw8enYOy4FEARklx9+wC1gi+w9dyakzRNJdAzqvGZdq7jeNmey
         kvmjqp1IU23P3CorE6G/XapQdSJhmRl2Q3Ko++B/hNB7+5ulZS55HKNshnquzp7sGmkz
         ieO+du9n4d/InbLQ6Y/d73yKW/SLXOUMVVR2BFgUK6uMIIv4iW7OOi6MLGHK2uVXkCK5
         AF5YBxpUkhzhcqRYAVBqZTlBTb371uosrUltmrwF31e3ea36d18nEh1+5fdGJFbUPbdr
         K1zdcZjOqF84wRu0/5SpUbRwyRwSpvSHX5mblZt/wgcWJn6bkxcqVzXRW/W7v3WGihif
         +7tw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=GNX1TWYc;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=GNX1TWYc;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM4011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH v2 19/21] gcc-plugins: test GCC plugin support in Kconfig
Date: Tue, 27 Mar 2018 14:29:33 +0900
Message-Id: <1522128575-5326-20-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545439308966?=
X-GMAIL-MSGID: =?utf-8?q?1596067545439308966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Run scripts/gcc-plugin.sh from Kconfig.  Users can enable GCC_PLUGINS
only when it is supported.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/Kconfig                 |  4 +++
 scripts/Makefile.gcc-plugins | 82 ++++++++++++++++----------------------------
 scripts/gcc-plugin.sh        |  1 -
 3 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b42378d..88cc925 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -407,9 +407,13 @@ config HAVE_GCC_PLUGINS
 	  An arch should select this symbol if it supports building with
 	  GCC plugins.
 
+config CC_HAS_GCC_PLUGINS
+	bool
+
 menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
+	depends on $(success $srctree/scripts/gcc-plugin.sh $HOSTCXX $CC)
 	depends on !COMPILE_TEST
 	help
 	  GCC plugins are loadable modules that provide extra features to the
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 25da4c0..19d0d5b 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -1,71 +1,47 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_GCC_PLUGINS
-  PLUGINCC := $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-plugin.sh $(HOSTCXX) $(CC))
-
-  SANCOV_PLUGIN := -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
+SANCOV_PLUGIN := -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
 
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY)	+= cyc_complexity_plugin.so
+gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY)	+= cyc_complexity_plugin.so
 
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= -DLATENT_ENTROPY_PLUGIN
-  ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
-    DISABLE_LATENT_ENTROPY_PLUGIN			+= -fplugin-arg-latent_entropy_plugin-disable
-  endif
+gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= -DLATENT_ENTROPY_PLUGIN
+ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
+  DISABLE_LATENT_ENTROPY_PLUGIN			+= -fplugin-arg-latent_entropy_plugin-disable
+endif
 
-  ifdef CONFIG_GCC_PLUGIN_SANCOV
-    ifeq ($(CFLAGS_KCOV),)
-      # It is needed because of the gcc-plugin.sh and gcc version checks.
-      gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
+ifdef CONFIG_GCC_PLUGIN_SANCOV
+  ifeq ($(CFLAGS_KCOV),)
+    # It is needed because of the gcc-plugin.sh and gcc version checks.
+    gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
 
-      ifneq ($(PLUGINCC),)
-        CFLAGS_KCOV := $(SANCOV_PLUGIN)
-      else
-        $(warning warning: cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler)
-      endif
-    endif
+    CFLAGS_KCOV := $(SANCOV_PLUGIN)
   endif
+endif
 
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)	+= -fplugin-arg-structleak_plugin-verbose
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	+= -fplugin-arg-structleak_plugin-byref-all
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= -DSTRUCTLEAK_PLUGIN
-
-  gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= -DRANDSTRUCT_PLUGIN
-  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	+= -fplugin-arg-randomize_layout_plugin-performance-mode
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
+export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN
 
-  KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
-  GCC_PLUGIN := $(gcc-plugin-y)
-  GCC_PLUGIN_SUBDIR := $(gcc-plugin-subdir-y)
-endif
+# SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.
+GCC_PLUGINS_CFLAGS := $(filter-out $(SANCOV_PLUGIN), $(GCC_PLUGINS_CFLAGS))
 
-# If plugins aren't supported, abort the build before hard-to-read compiler
-# errors start getting spewed by the main build.
-PHONY += gcc-plugins-check
-gcc-plugins-check: FORCE
-ifdef CONFIG_GCC_PLUGINS
-  ifeq ($(PLUGINCC),)
-    ifneq ($(GCC_PLUGINS_CFLAGS),)
-      $(Q)$(srctree)/scripts/gcc-plugin.sh --show-error $(HOSTCXX) $(CC) || true
-      @echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
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
diff --git a/scripts/gcc-plugin.sh b/scripts/gcc-plugin.sh
index 0edbdae..b18c69c 100755
--- a/scripts/gcc-plugin.sh
+++ b/scripts/gcc-plugin.sh
@@ -24,7 +24,6 @@ EOF
 
 if [ $? -eq 0 ]
 then
-	echo "$1"
 	exit 0
 fi
 
-- 
2.7.4
