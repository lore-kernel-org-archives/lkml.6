Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4/14H4akDGPHe/5YHB6pIcimystjAIT5NiSjk0KLlfqfhujXbmnLGZjrhk8PbTdjrLW+VqK
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=HIcJJI6vXCL7mGWcesjGSjmFlMkzBLyNILZFxcfV9Hg5n9+DJ/5VXtSx7ikmbQlFtN
         rC4pwcruGypIUEdsJu+BaVjLjUEbp/pZIcgTGanPyjhAKIEc7N58KGYgFM5gWrCkThAQ
         nNTOqkWq0N6xF4GwhvWuZHrg3dR0FSMpSdwerKwKQFZrz6lY68RqA0liSdHM1zoSvUOI
         dvNUhA0RjKlwoHzNAlx4UzulbLtDwG0Y4K9AGwMreNwiEHmNjv7J2eHs8UfirTFeRQRv
         6s/kSmRh/O1d1NUdRGKg1QP+mGwnuFu484v1tMAV30jf6tDLDWgGDj//alhuOCCIoCRE
         u/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=SmnoR5uX+QdJc5jR+e3JIIYITKB70ECICvL3cl8cDVA=;
        b=EtbkmVkG1Irgu5B+HcKy3QQSu7PdW4g7yu5w7vykUYHINLz9NMbYJII+OSv1fMh3CA
         9q1Ygty9tJzeJf/TwHposhXuNwl0LousMm0AcKShMs+o4hSofd+koSN05IRxBdlFwLU7
         W41VrCFp+bKo0MIQWPrnERgoRZn0KuSxUAYjHM3Kb/6o8fMqJJQ2/3vECkdTW7octY3U
         e5EMnQw3lrs7ED/t2sKJxsy5EKljJIh2myqAMdoHgw/tsxSPmwAL373ryTIP2VR9X8I0
         UrkKCl7KcKrS9MY++p12U+ZKGH1lmEeAsb1TXlNoibGAA9zSBtZCPFj1HANq2Z4AKGsl
         CKdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=teTvD2yn;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=teTvD2yn;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM2011947
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
Subject: [PATCH v2 17/21] gcc-plugins: always build plugins with C++
Date: Tue, 27 Mar 2018 14:29:31 +0900
Message-Id: <1522128575-5326-18-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545463713502?=
X-GMAIL-MSGID: =?utf-8?q?1596067545463713502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the target compiler is GCC 4.8 or newer, plugins are compiled with
HOSTCXX.  Otherwise, gcc-plugin.sh will select HOSTCC or HOSTCXX.

To simplify things, drop the HOSTCC support for plugins.  If you use
GCC plugins, the requirement for the target compiler is GCC 4.8 (or
older compiler with necessary features backported).  This is a feature
for advanced users, so this requirement would not be a big deal.
Currently, building plugins requires GCC 4.5, so this is not a big jump.

Remove the code that was needed to build plugins with HOSTCC as a
preparation for Kconfig migration.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Makefile.gcc-plugins | 11 +++--------
 scripts/gcc-plugin.sh        | 38 +++-----------------------------------
 scripts/gcc-plugins/Makefile | 15 ++++-----------
 3 files changed, 10 insertions(+), 54 deletions(-)

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
