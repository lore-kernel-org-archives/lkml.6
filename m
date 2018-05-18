Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeERExy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 00:53:54 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33678 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeERExu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 00:53:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4I4qbKF013482
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kconfig: refactor Qt package checks for building qconf
Date: Fri, 18 May 2018 13:52:23 +0900
Message-Id: <1526619146-1895-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the necessary package checks for building qconf is
surrounded by ifeq ($(MAKECMDGOALS),xconfig) ... endif.
Then, Make will restart when .tmp_qtcheck is generated.

To simplify the Makefile, move the scripting to a separate file,
and use filechk.  The shell script is executed everytime xconfig
is run, but it is not a costly script.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile     | 73 +++++++++++++++++---------------------------
 scripts/kconfig/qconf-cfg.sh | 25 +++++++++++++++
 2 files changed, 53 insertions(+), 45 deletions(-)
 create mode 100755 scripts/kconfig/qconf-cfg.sh

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5def877..e9a87bf 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -188,8 +188,6 @@ HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
 #         Utilizes ncurses
 # mconf:  Used for the menuconfig target
 #         Utilizes the lxdialog package
-# qconf:  Used for the xconfig target
-#         Based on Qt which needs to be installed to compile it
 # gconf:  Used for the gconfig target
 #         Based on GTK+ which needs to be installed to compile it
 # object files used by all kconfig flavours
@@ -201,14 +199,12 @@ conf-objs	:= conf.o  zconf.tab.o
 mconf-objs     := mconf.o zconf.tab.o $(lxdialog)
 nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
 kxgettext-objs	:= kxgettext.o zconf.tab.o
-qconf-cxxobjs	:= qconf.o
-qconf-objs	:= zconf.tab.o
 gconf-objs	:= gconf.o zconf.tab.o
 
-hostprogs-y := conf nconf mconf kxgettext qconf gconf
+hostprogs-y := conf nconf mconf kxgettext gconf
 
 targets		+= zconf.lex.c
-clean-files	:= qconf.moc .tmp_qtcheck .tmp_gtkcheck
+clean-files	:= .tmp_gtkcheck
 clean-files	+= gconf.glade.h
 clean-files     += config.pot linux.pot
 
@@ -228,9 +224,6 @@ HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTC
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_qconf	= $(KC_QT_LIBS)
-HOSTCXXFLAGS_qconf.o	= $(KC_QT_CFLAGS)
-
 HOSTLOADLIBES_gconf	= `pkg-config --libs gtk+-2.0 gmodule-2.0 libglade-2.0`
 HOSTCFLAGS_gconf.o	= `pkg-config --cflags gtk+-2.0 gmodule-2.0 libglade-2.0` \
                           -Wno-missing-prototypes
@@ -241,34 +234,22 @@ HOSTLOADLIBES_nconf	= $(shell \
 				pkg-config --libs menuw panelw ncursesw 2>/dev/null \
 				|| pkg-config --libs menu panel ncurses 2>/dev/null \
 				|| echo "-lmenu -lpanel -lncurses"  )
-$(obj)/qconf.o: $(obj)/.tmp_qtcheck
-
-ifeq ($(MAKECMDGOALS),xconfig)
-$(obj)/.tmp_qtcheck: $(src)/Makefile
--include $(obj)/.tmp_qtcheck
-
-# Qt needs some extra effort...
-$(obj)/.tmp_qtcheck:
-	@set -e; $(kecho) "  CHECK   qt"; \
-	if pkg-config --exists Qt5Core; then \
-	    cflags="-std=c++11 -fPIC `pkg-config --cflags Qt5Core Qt5Gui Qt5Widgets`"; \
-	    libs=`pkg-config --libs Qt5Core Qt5Gui Qt5Widgets`; \
-	    moc=`pkg-config --variable=host_bins Qt5Core`/moc; \
-	elif pkg-config --exists QtCore; then \
-	    cflags=`pkg-config --cflags QtCore QtGui`; \
-	    libs=`pkg-config --libs QtCore QtGui`; \
-	    moc=`pkg-config --variable=moc_location QtCore`; \
-	else \
-	    echo >&2 "*"; \
-	    echo >&2 "* Could not find Qt via pkg-config."; \
-	    echo >&2 "* Please install either Qt 4.8 or 5.x. and make sure it's in PKG_CONFIG_PATH"; \
-	    echo >&2 "*"; \
-	    exit 1; \
-	fi; \
-	echo "KC_QT_CFLAGS=$$cflags" > $@; \
-	echo "KC_QT_LIBS=$$libs" >> $@; \
-	echo "KC_QT_MOC=$$moc" >> $@
-endif
+
+# qconf: Used for the xconfig target based on Qt
+hostprogs-y	+= qconf
+qconf-cxxobjs	:= qconf.o
+qconf-objs	:= zconf.tab.o
+
+HOSTLOADLIBES_qconf	= $(shell . $(obj)/.qconf-cfg && echo $$libs)
+HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/.qconf-cfg && echo $$cflags)
+
+$(obj)/qconf.o: $(obj)/.qconf-cfg $(obj)/qconf.moc
+
+quiet_cmd_moc = MOC     $@
+      cmd_moc = $(shell . $(obj)/.qconf-cfg && echo $$moc) -i $< -o $@
+
+$(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
+	$(call cmd,moc)
 
 $(obj)/gconf.o: $(obj)/.tmp_gtkcheck
 
@@ -298,15 +279,17 @@ endif
 
 $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
 
-$(obj)/qconf.o: $(obj)/qconf.moc
-
-quiet_cmd_moc = MOC     $@
-      cmd_moc = $(KC_QT_MOC) -i $< -o $@
-
-$(obj)/%.moc: $(src)/%.h $(obj)/.tmp_qtcheck
-	$(call cmd,moc)
-
 # Extract gconf menu items for i18n support
 $(obj)/gconf.glade.h: $(obj)/gconf.glade
 	$(Q)intltool-extract --type=gettext/glade --srcdir=$(srctree) \
 	$(obj)/gconf.glade
+
+# check if necessary packages are available, and configure build flags
+define filechk_conf_cfg
+	$(CONFIG_SHELL) $<
+endef
+
+$(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
+	$(call filechk,conf_cfg)
+
+clean-files += .*conf-cfg
diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
new file mode 100755
index 0000000..0862e15
--- /dev/null
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="Qt5Core Qt5Gui Qt5Widgets"
+PKG2="QtCore QtGui"
+
+if pkg-config --exists $PKG; then
+	echo cflags=\"-std=c++11 -fPIC $(pkg-config --cflags Qt5Core Qt5Gui Qt5Widgets)\"
+	echo libs=\"$(pkg-config --libs $PKG)\"
+	echo moc=\"$(pkg-config --variable=host_bins Qt5Core)/moc\"
+	exit 0
+fi
+
+if pkg-config --exists $PKG2; then
+	echo cflags=\"$(pkg-config --cflags $PKG2)\"
+	echo libs=\"$(pkg-config --libs $PKG2)\"
+	echo moc=\"$(pkg-config --variable=moc_location QtCore)\"
+	exit 0
+fi
+
+echo >&2 "*"
+echo >&2 "* Could not find Qt via pkg-config."
+echo >&2 "* Please install either Qt 4.8 or 5.x. and make sure it's in PKG_CONFIG_PATH"
+echo >&2 "*"
+exit 1
-- 
2.7.4
