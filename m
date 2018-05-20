Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeETITD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:19:03 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:22132 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeETISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:18:45 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w4K8H4h5004008
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] kconfig: refactor ncurses package checks for building nconf
Date: Sun, 20 May 2018 17:16:53 +0900
Message-Id: <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building nconf requires ncurses, but its presence is not checked.
Check and configure necessary packages by a shell script like the
other GUI frontends.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add fallback code in case distributions cannot find
    ncurses by pkg-config.

 scripts/kconfig/Makefile     | 16 ++++++++--------
 scripts/kconfig/nconf-cfg.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)
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
index 0000000..8eb7948
--- /dev/null
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="ncursesw menuw panelw"
+PKG2="ncurses menu panel"
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
+# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
+# by pkg-config.
+if [ -f /usr/include/ncursesw/ncurses.h ]; then
+	echo libs=\"-lncursesw -lmenuw -lpanelw\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses.h ]; then
+	echo libs=\"-lncurses -lmenu -lpanel\"
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
