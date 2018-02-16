Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227HuXSSyu7zpvWMnx1Mueot2BCBj1P7Zl+TGtHcOgrjwkIgfAKtay4yluoWhM8Ns8pRl2e3
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=wnrR/AXCUwDGfxfSvCIiLDeYWXFNiTq6N9VswZXfnrhdsRYMME2f8lOVgsrK0tfpNR
         zv7zayapg+CjnAEXhekaqfd3Fg3zKlZm6Exb38sbxwSFy4Gsu6q4SGYQ2676rbq3fNg8
         Gaq9imalli3cGrHM196dctl0h054MWFYQ8AXfmTGk3VLLEsZjCya/H3XzY8QqOlj3bWb
         qD3kb8HG5FFcmMjDPqGGn2fwmPDQDK1QPyaSlNQ69945BRMhp+lQ7ExU8DfucbWpO9vE
         hnyt7dfq2fzgZF4a2TwcanTFHCl85RuPaOxJykUBnrakKQx+K+F1sc+kc1O8AA7GXS+F
         m5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=BPc6z7jaBi5hs6EsHJx7v6rdWK5aF1kXWi0zXb2tz0w=;
        b=t2+u9kHhYe2RYkn5FAhXT6/JUZXQIH70xkK67bFK83S3BM4L+bFWPtkiy66xQ36Ym9
         K0IO7eV8vxM8+h8p3HwZ6fCiGSLrPXt6gXENVcVO1BPbRSUxj5raGPZohNZjTGGFjWyj
         Qd2YjdUeD0VWkVb/thgEe17WbMdV/TL3byLBnz/VwfjTm4MwcT3UKTf64UpwvaouuxhL
         FTlXGDp3OMX4SqE9uxdlkyObfYv6DV28yFiSTPGta9JEd+I8+qUnSAh2e8vL1OpbGhWl
         2ck7zWaZqCHx+AiUcflplIhWZ79dQxOcZ/XZEXdbRkD0t3knPE/IEZUN9/EUcve1cxdk
         YdzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QiTU1ykl;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QiTU1ykl;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTN013418
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
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH 20/23] gcc-plugins: always build plugins with C++
Date: Sat, 17 Feb 2018 03:38:48 +0900
Message-Id: <1518806331-7101-21-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935376722462?=
X-GMAIL-MSGID: =?utf-8?q?1592583935376722462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the target compiler is GCC 4.8 or newer, plugins are compiled with
HOSTCXX.  Otherwise, gcc-plugin.sh will select HOSTCC or HOSTCXX.

To simpily things, let's decide GCC 4.8 is the requirement for GCC
pulgins.  With this, plugins are always built with HOSTCXX.  This is a
feature of advanced users, so this requirement whould not be not a big
issue.

Add 'depends on GCC_VERSION >= 40800' to GCC_PLUGINS, and remove the
code that was needed to build plugins with HOSTCC.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/Kconfig                 |  1 +
 scripts/Makefile.gcc-plugins | 11 +++--------
 scripts/gcc-plugin.sh        | 38 +++-----------------------------------
 scripts/gcc-plugins/Makefile | 15 ++++-----------
 4 files changed, 11 insertions(+), 54 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9b7a628..9bd4e1f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -410,6 +410,7 @@ config HAVE_GCC_PLUGINS
 menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
+	depends on GCC_VERSION >= 40800
 	depends on !COMPILE_TEST
 	help
 	  GCC plugins are loadable modules that provide extra features to the
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b2a95af..b0f9108 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifdef CONFIG_GCC_PLUGINS
-  __PLUGINCC := $(call cc-ifversion, -ge, 0408, $(HOSTCXX), $(HOSTCC))
-  PLUGINCC := $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-plugin.sh "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)")
+  PLUGINCC := $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-plugin.sh $(HOSTCXX) $(CC))
 
   SANCOV_PLUGIN := -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
 
@@ -65,12 +64,8 @@ ifdef CONFIG_GCC_PLUGINS
 	  @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1
         endif
       endif
-      ifeq ($(call cc-ifversion, -ge, 0405, y), y)
-	$(Q)$(srctree)/scripts/gcc-plugin.sh --show-error "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)" || true
-	@echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
-      else
-	@echo "Cannot use CONFIG_GCC_PLUGINS: your gcc version does not support plugins, you should upgrade it to at least gcc 4.5" >&2 && exit 1
-      endif
+      $(Q)$(srctree)/scripts/gcc-plugin.sh --show-error $(HOSTCXX) $(CC) || true
+      @echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
     endif
   endif
 endif
diff --git a/scripts/gcc-plugin.sh b/scripts/gcc-plugin.sh
index d3caefe..0edbdae 100755
--- a/scripts/gcc-plugin.sh
+++ b/scripts/gcc-plugin.sh
@@ -8,42 +8,10 @@ if [ "$1" = "--show-error" ] ; then
 	shift || true
 fi
 
-gccplugins_dir=$($3 -print-file-name=plugin)
-plugincc=$($1 -E -x c++ - -o /dev/null -I"${srctree}"/gcc-plugins -I"${gccplugins_dir}"/include 2>&1 <<EOF
-#include "gcc-common.h"
-#if BUILDING_GCC_VERSION >= 4008 || defined(ENABLE_BUILD_WITH_CXX)
-#warning $2 CXX
-#else
-#warning $1 CC
-#endif
-EOF
-)
-
-if [ $? -ne 0 ]
-then
-	if [ -n "$SHOW_ERROR" ] ; then
-		echo "${plugincc}" >&2
-	fi
-	exit 1
-fi
-
-case "$plugincc" in
-	*"$1 CC"*)
-		echo "$1"
-		exit 0
-		;;
-
-	*"$2 CXX"*)
-		# the c++ compiler needs another test, see below
-		;;
-
-	*)
-		exit 1
-		;;
-esac
+gccplugins_dir=$($2 -print-file-name=plugin)
 
 # we need a c++ compiler that supports the designated initializer GNU extension
-plugincc=$($2 -c -x c++ -std=gnu++98 - -fsyntax-only -I"${srctree}"/gcc-plugins -I"${gccplugins_dir}"/include 2>&1 <<EOF
+plugincc=$($1 -c -x c++ -std=gnu++98 - -fsyntax-only -I"${srctree}"/gcc-plugins -I"${gccplugins_dir}"/include 2>&1 <<EOF
 #include "gcc-common.h"
 class test {
 public:
@@ -56,7 +24,7 @@ EOF
 
 if [ $? -eq 0 ]
 then
-	echo "$2"
+	echo "$1"
 	exit 0
 fi
 
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index e2ff425..47d5f69 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -1,17 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 GCC_PLUGINS_DIR := $(shell $(CC) -print-file-name=plugin)
 
-ifeq ($(PLUGINCC),$(HOSTCC))
-  HOSTLIBS := hostlibs
-  HOST_EXTRACFLAGS += -I$(GCC_PLUGINS_DIR)/include -I$(src) -std=gnu99 -ggdb
-  export HOST_EXTRACFLAGS
-else
-  HOSTLIBS := hostcxxlibs
-  HOST_EXTRACXXFLAGS += -I$(GCC_PLUGINS_DIR)/include -I$(src) -std=gnu++98 -fno-rtti
-  HOST_EXTRACXXFLAGS += -fno-exceptions -fasynchronous-unwind-tables -ggdb
-  HOST_EXTRACXXFLAGS += -Wno-narrowing -Wno-unused-variable
-  export HOST_EXTRACXXFLAGS
-endif
+HOSTLIBS := hostcxxlibs
+HOST_EXTRACXXFLAGS += -I$(GCC_PLUGINS_DIR)/include -I$(src) -std=gnu++98 -fno-rtti
+HOST_EXTRACXXFLAGS += -fno-exceptions -fasynchronous-unwind-tables -ggdb
+HOST_EXTRACXXFLAGS += -Wno-narrowing -Wno-unused-variable
 
 ifneq ($(CFLAGS_KCOV), $(SANCOV_PLUGIN))
   GCC_PLUGIN := $(filter-out $(SANCOV_PLUGIN), $(GCC_PLUGIN))
-- 
2.7.4
