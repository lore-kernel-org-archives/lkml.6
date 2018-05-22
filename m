Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEVHXw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:23:52 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45387 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:23:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4M7MRAg030337
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] kconfig: refactor GTK+ package checks for building gconf
Date: Tue, 22 May 2018 16:22:20 +0900
Message-Id: <1526973741-664-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the package checks for gconf in the same way as for qconf.

Also, convert the build rule of gconf.glade.h to Kbuild style.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---

Changes in v3:
  - Use kbuild short log for building gconf.glade.h too

Changes in v2: None

 scripts/kconfig/Makefile     | 49 ++++++++++++--------------------------------
 scripts/kconfig/gconf-cfg.sh | 23 +++++++++++++++++++++
 2 files changed, 36 insertions(+), 36 deletions(-)
 create mode 100755 scripts/kconfig/gconf-cfg.sh

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index e9a87bf..8cee14b 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -188,8 +188,6 @@ HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
 #         Utilizes ncurses
 # mconf:  Used for the menuconfig target
 #         Utilizes the lxdialog package
-# gconf:  Used for the gconfig target
-#         Based on GTK+ which needs to be installed to compile it
 # object files used by all kconfig flavours
 
 lxdialog := lxdialog/checklist.o lxdialog/util.o lxdialog/inputbox.o
@@ -199,12 +197,10 @@ conf-objs	:= conf.o  zconf.tab.o
 mconf-objs     := mconf.o zconf.tab.o $(lxdialog)
 nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
 kxgettext-objs	:= kxgettext.o zconf.tab.o
-gconf-objs	:= gconf.o zconf.tab.o
 
-hostprogs-y := conf nconf mconf kxgettext gconf
+hostprogs-y := conf nconf mconf kxgettext
 
 targets		+= zconf.lex.c
-clean-files	:= .tmp_gtkcheck
 clean-files	+= gconf.glade.h
 clean-files     += config.pot linux.pot
 
@@ -224,10 +220,6 @@ HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTC
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_gconf	= `pkg-config --libs gtk+-2.0 gmodule-2.0 libglade-2.0`
-HOSTCFLAGS_gconf.o	= `pkg-config --cflags gtk+-2.0 gmodule-2.0 libglade-2.0` \
-                          -Wno-missing-prototypes
-
 HOSTLOADLIBES_mconf   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
 
 HOSTLOADLIBES_nconf	= $(shell \
@@ -251,38 +243,23 @@ quiet_cmd_moc = MOC     $@
 $(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
 	$(call cmd,moc)
 
-$(obj)/gconf.o: $(obj)/.tmp_gtkcheck
-
-ifeq ($(MAKECMDGOALS),gconfig)
--include $(obj)/.tmp_gtkcheck
-
-# GTK+ needs some extra effort, too...
-$(obj)/.tmp_gtkcheck:
-	@if `pkg-config --exists gtk+-2.0 gmodule-2.0 libglade-2.0`; then		\
-		if `pkg-config --atleast-version=2.0.0 gtk+-2.0`; then			\
-			touch $@;								\
-		else									\
-			echo >&2 "*"; 							\
-			echo >&2 "* GTK+ is present but version >= 2.0.0 is required.";	\
-			echo >&2 "*";							\
-			false;								\
-		fi									\
-	else										\
-		echo >&2 "*"; 								\
-		echo >&2 "* Unable to find the GTK+ installation. Please make sure that"; 	\
-		echo >&2 "* the GTK+ 2.0 development package is correctly installed..."; 	\
-		echo >&2 "* You need gtk+-2.0, glib-2.0 and libglade-2.0."; 		\
-		echo >&2 "*"; 								\
-		false;									\
-	fi
-endif
+# gconf: Used for the gconfig target based on GTK+
+hostprogs-y	+= gconf
+gconf-objs	:= gconf.o zconf.tab.o
+
+HOSTLOADLIBES_gconf = $(shell . $(obj)/.gconf-cfg && echo $$libs)
+HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
+
+$(obj)/gconf.o: $(obj)/.gconf-cfg
 
 $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
 
 # Extract gconf menu items for i18n support
+quiet_cmd_intl = INTL    $@
+      cmd_intl = intltool-extract --type=gettext/glade --srcdir=$(srctree) $<
+
 $(obj)/gconf.glade.h: $(obj)/gconf.glade
-	$(Q)intltool-extract --type=gettext/glade --srcdir=$(srctree) \
-	$(obj)/gconf.glade
+	$(call cmd,intl)
 
 # check if necessary packages are available, and configure build flags
 define filechk_conf_cfg
diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
new file mode 100755
index 0000000..533b3d8
--- /dev/null
+++ b/scripts/kconfig/gconf-cfg.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
+
+if ! pkg-config --exists $PKG; then
+	echo >&2 "*"
+	echo >&2 "* Unable to find the GTK+ installation. Please make sure that"
+	echo >&2 "* the GTK+ 2.0 development package is correctly installed."
+	echo >&2 "* You need $PKG"
+	echo >&2 "*"
+	exit 1
+fi
+
+if ! pkg-config --atleast-version=2.0.0 gtk+-2.0; then
+	echo >&2 "*"
+	echo >&2 "* GTK+ is present but version >= 2.0.0 is required."
+	echo >&2 "*"
+	exit 1
+fi
+
+echo cflags=\"$(pkg-config --cflags $PKG)\"
+echo libs=\"$(pkg-config --libs $PKG)\"
-- 
2.7.4
