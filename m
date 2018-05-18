Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeERExw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 00:53:52 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33676 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeERExu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 00:53:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4I4qbKI013482
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] kconfig: refactor ncurses package checks for building nconf
Date: Fri, 18 May 2018 13:52:26 +0900
Message-Id: <1526619146-1895-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building nconf requires ncurses, but its presence is not checked.
Check and configure necessary packages as in the other GUI frontends.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile     | 16 ++++++++--------
 scripts/kconfig/nconf-cfg.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)
 create mode 100644 scripts/kconfig/nconf-cfg.sh

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 25a3d25..b90e801 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -176,15 +176,12 @@ help:
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
 # conf:	  Used for defconfig, oldconfig and related targets
-# nconf:  Used for the nconfig target.
-#         Utilizes ncurses
 # object files used by all kconfig flavours
 
 conf-objs	:= conf.o  zconf.tab.o
-nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
 kxgettext-objs	:= kxgettext.o zconf.tab.o
 
-hostprogs-y := conf nconf kxgettext
+hostprogs-y := conf kxgettext
 
 targets		+= zconf.lex.c
 clean-files	+= gconf.glade.h
@@ -199,10 +196,13 @@ HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTC
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_nconf	= $(shell \
-				pkg-config --libs menuw panelw ncursesw 2>/dev/null \
-				|| pkg-config --libs menu panel ncurses 2>/dev/null \
-				|| echo "-lmenu -lpanel -lncurses"  )
+# nconf: Used for the nconfig target based on ncurses
+hostprogs-y	+= nconf
+nconf-objs	:= nconf.o zconf.tab.o nconf.gui.o
+
+HOSTLOADLIBES_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
+
+$(obj)/nconf.o: $(obj)/.nconf-cfg
 
 # mconf: Used for the menuconfig target based on lxdialog
 hostprogs-y	+= mconf
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
new file mode 100644
index 0000000..9def36f
--- /dev/null
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="menuw panelw ncursesw"
+PKG2="menu panel ncurses"
+
+if pkg-config --exists $PKG; then
+	echo libs=\"$(pkg-config --libs $PKG)\"
+	exit 0
+fi
+
+if pkg-config --exists $PKG2; then
+	echo libs=\"$(pkg-config --libs $PKG2)\"
+	exit 0
+fi
+
+echo >&2 "*"
+echo >&2 "* Unable to find the ncurses."
+echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
+echo >&2 "* depending on your distribution)"
+echo >&2 "*"
+exit 1
-- 
2.7.4
