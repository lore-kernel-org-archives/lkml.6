Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756126AbeEIHYs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:24:48 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50568 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeEIHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:24:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36G028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] depmod.sh: remove symbol prefix support
Date: Wed,  9 May 2018 16:23:48 +0900
Message-Id: <1525850632-10921-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.

No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX,
hence the last argument of scripts/depmod.sh can be removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile          |  2 +-
 scripts/depmod.sh | 21 +--------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 4cb8531..52ea534 100644
--- a/Makefile
+++ b/Makefile
@@ -1760,7 +1760,7 @@ quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files))
 # Run depmod only if we have System.map and depmod is executable
 quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
       cmd_depmod = $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPMOD) \
-                   $(KERNELRELEASE) "$(patsubst y,_,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))"
+                   $(KERNELRELEASE)
 
 # Create temporary dir for module support files
 # clean it up only when building all modules
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 9831cca..421d1aa 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -9,30 +9,11 @@ if test $# -ne 3; then
 fi
 DEPMOD=$1
 KERNELRELEASE=$2
-SYMBOL_PREFIX=$3
 
 if ! test -r System.map -a -x "$DEPMOD"; then
 	exit 0
 fi
 
-# older versions of depmod don't support -P <symbol-prefix>
-# support was added in module-init-tools 3.13
-if test -n "$SYMBOL_PREFIX"; then
-	release=$("$DEPMOD" --version)
-	package=$(echo "$release" | cut -d' ' -f 1)
-	if test "$package" = "module-init-tools"; then
-		version=$(echo "$release" | cut -d' ' -f 2)
-		later=$(printf '%s\n' "$version" "3.13" | sort -V | tail -n 1)
-		if test "$later" != "$version"; then
-			# module-init-tools < 3.13, drop the symbol prefix
-			SYMBOL_PREFIX=""
-		fi
-	fi
-	if test -n "$SYMBOL_PREFIX"; then
-		SYMBOL_PREFIX="-P $SYMBOL_PREFIX"
-	fi
-fi
-
 # older versions of depmod require the version string to start with three
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true
@@ -55,7 +36,7 @@ set -- -ae -F System.map
 if test -n "$INSTALL_MOD_PATH"; then
 	set -- "$@" -b "$INSTALL_MOD_PATH"
 fi
-"$DEPMOD" "$@" "$KERNELRELEASE" $SYMBOL_PREFIX
+"$DEPMOD" "$@" "$KERNELRELEASE"
 ret=$?
 
 if $depmod_hack_needed; then
-- 
2.7.4
