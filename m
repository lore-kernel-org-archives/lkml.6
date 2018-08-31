Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4BBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5769E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qeBafyHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5769E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHaNmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:42:54 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:25947 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:42:54 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w7V9Z69d031784;
        Fri, 31 Aug 2018 18:35:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w7V9Z69d031784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535708107;
        bh=4MxuXEdI9XhywhZNAR1bVd8p1o/lMqCnhZzgnSe63ic=;
        h=From:To:Cc:Subject:Date:From;
        b=qeBafyHAhDLgGS3V85Kh5N2L8JQ61nOBy259UzWLGjH8E/3b/DZC/zRICI1Vb//C7
         KrZxFxVeizswbnAZZmdVyxWTPkM1QERoFd4L7OaPDqbb7ayJFHtGaEqd54XRH7NI9H
         N9ZCCJCqPo3HxhiUr5AwqeMp81VSuNz6VXcEjLXrehamFKuBGXe04pYiryBdVZu7ql
         tqQUgFgGdaNR01C4FyFfSujvdQNgUEnMiHjfr3ZgnXENGmzWokyQCp9tSet6R9Uynk
         NqwInexNfWspLhwMYGhhdpEFjSjhJy9VpS8bh3msNzP+uIuS9qkDRvdihvXGy8LwwL
         H3fS5DQW/z5vA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Meelis Roos <mroos@linux.ee>, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] kconfig: do not require pkg-config on make {menu,n}config
Date:   Fri, 31 Aug 2018 18:34:55 +0900
Message-Id: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos reported a {menu,n}config regression:

 "I have libncurses devel package installed in the default system
  location (as do 99%+ on actual developers probably) and in this
  case, pkg-config is useless.  pkg-config is needed only when
  libraries and headers are installed in non-default locations but
  it is bad to require installation of pkg-config on all the machines
  where make menuconfig would be possibly run."

For {menu,n}config, do not use pkg-config if it is not installed.
For {g,x}config, keep checking pkg-config since we really rely on it
for finding the installation paths of the required packages.

Fixes: 4ab3b80159d4 ("kconfig: check for pkg-config on make {menu,n,g,x}config")
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/process/changes.rst  |  2 +-
 scripts/kconfig/Makefile           |  1 -
 scripts/kconfig/check-pkgconfig.sh |  8 --------
 scripts/kconfig/gconf-cfg.sh       |  7 +++++++
 scripts/kconfig/mconf-cfg.sh       | 25 ++++++++++++++-----------
 scripts/kconfig/nconf-cfg.sh       | 25 ++++++++++++++-----------
 scripts/kconfig/qconf-cfg.sh       |  7 +++++++
 7 files changed, 43 insertions(+), 32 deletions(-)
 delete mode 100644 scripts/kconfig/check-pkgconfig.sh

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 61f918b..d1bf143 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -86,7 +86,7 @@ pkg-config
 
 The build system, as of 4.18, requires pkg-config to check for installed
 kconfig tools and to determine flags settings for use in
-'make {menu,n,g,x}config'.  Previously pkg-config was being used but not
+'make {g,x}config'.  Previously pkg-config was being used but not
 verified or documented.
 
 Flex
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 4a7bd21..67ed9f6 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -221,7 +221,6 @@ $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
 
 # check if necessary packages are available, and configure build flags
 define filechk_conf_cfg
-	$(CONFIG_SHELL) $(srctree)/scripts/kconfig/check-pkgconfig.sh; \
 	$(CONFIG_SHELL) $<
 endef
 
diff --git a/scripts/kconfig/check-pkgconfig.sh b/scripts/kconfig/check-pkgconfig.sh
deleted file mode 100644
index 7a1c40b..0000000
--- a/scripts/kconfig/check-pkgconfig.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Check for pkg-config presence
-
-if [ -z $(command -v pkg-config) ]; then
-	echo "'make *config' requires 'pkg-config'. Please install it." 1>&2
-	exit 1
-fi
diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
index 533b3d8..480ecd8 100755
--- a/scripts/kconfig/gconf-cfg.sh
+++ b/scripts/kconfig/gconf-cfg.sh
@@ -3,6 +3,13 @@
 
 PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
 
+if [ -z "$(command -v pkg-config)" ]; then
+	echo >&2 "*"
+	echo >&2 "* 'make gconfig' requires 'pkg-config'. Please install it."
+	echo >&2 "*"
+	exit 1
+fi
+
 if ! pkg-config --exists $PKG; then
 	echo >&2 "*"
 	echo >&2 "* Unable to find the GTK+ installation. Please make sure that"
diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
index e6f9fac..c812872d 100755
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -4,20 +4,23 @@
 PKG="ncursesw"
 PKG2="ncurses"
 
-if pkg-config --exists $PKG; then
-	echo cflags=\"$(pkg-config --cflags $PKG)\"
-	echo libs=\"$(pkg-config --libs $PKG)\"
-	exit 0
-fi
+if [ -n "$(command -v pkg-config)" ]; then
+	if pkg-config --exists $PKG; then
+		echo cflags=\"$(pkg-config --cflags $PKG)\"
+		echo libs=\"$(pkg-config --libs $PKG)\"
+		exit 0
+	fi
 
-if pkg-config --exists $PKG2; then
-	echo cflags=\"$(pkg-config --cflags $PKG2)\"
-	echo libs=\"$(pkg-config --libs $PKG2)\"
-	exit 0
+	if pkg-config --exists $PKG2; then
+		echo cflags=\"$(pkg-config --cflags $PKG2)\"
+		echo libs=\"$(pkg-config --libs $PKG2)\"
+		exit 0
+	fi
 fi
 
-# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
-# by pkg-config.
+# Check the default paths in case pkg-config is not installed.
+# (Even if it is installed, some distributions such as openSUSE cannot
+# find ncurses by pkg-config.)
 if [ -f /usr/include/ncursesw/ncurses.h ]; then
 	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
 	echo libs=\"-lncursesw\"
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
index 42f5ac7..001559e 100644
--- a/scripts/kconfig/nconf-cfg.sh
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -4,20 +4,23 @@
 PKG="ncursesw menuw panelw"
 PKG2="ncurses menu panel"
 
-if pkg-config --exists $PKG; then
-	echo cflags=\"$(pkg-config --cflags $PKG)\"
-	echo libs=\"$(pkg-config --libs $PKG)\"
-	exit 0
-fi
+if [ -n "$(command -v pkg-config)" ]; then
+	if pkg-config --exists $PKG; then
+		echo cflags=\"$(pkg-config --cflags $PKG)\"
+		echo libs=\"$(pkg-config --libs $PKG)\"
+		exit 0
+	fi
 
-if pkg-config --exists $PKG2; then
-	echo cflags=\"$(pkg-config --cflags $PKG2)\"
-	echo libs=\"$(pkg-config --libs $PKG2)\"
-	exit 0
+	if pkg-config --exists $PKG2; then
+		echo cflags=\"$(pkg-config --cflags $PKG2)\"
+		echo libs=\"$(pkg-config --libs $PKG2)\"
+		exit 0
+	fi
 fi
 
-# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
-# by pkg-config.
+# Check the default paths in case pkg-config is not installed.
+# (Even if it is installed, some distributions such as openSUSE cannot
+# find ncurses by pkg-config.)
 if [ -f /usr/include/ncursesw/ncurses.h ]; then
 	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
 	echo libs=\"-lncursesw -lmenuw -lpanelw\"
diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
index 0862e15..02ccc0a 100755
--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -4,6 +4,13 @@
 PKG="Qt5Core Qt5Gui Qt5Widgets"
 PKG2="QtCore QtGui"
 
+if [ -z "$(command -v pkg-config)" ]; then
+	echo >&2 "*"
+	echo >&2 "* 'make xconfig' requires 'pkg-config'. Please install it."
+	echo >&2 "*"
+	exit 1
+fi
+
 if pkg-config --exists $PKG; then
 	echo cflags=\"-std=c++11 -fPIC $(pkg-config --cflags Qt5Core Qt5Gui Qt5Widgets)\"
 	echo libs=\"$(pkg-config --libs $PKG)\"
-- 
2.7.4

