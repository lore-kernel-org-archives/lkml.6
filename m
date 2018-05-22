Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeEVHYV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:24:21 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:46282 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeEVHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:24:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4M7MRAh030337
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Subject: [PATCH v3 4/4] kconfig: refactor ncurses package checks for building mconf and nconf
Date: Tue, 22 May 2018 16:22:21 +0900
Message-Id: <1526973741-664-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mconf (or its infrastructure, lxdiaglog) depends on the ncurses.
Move and rename check-lxdialog.sh to mconf-cfg.sh to make it work in
the same way as for qconf and gconf.

This commit fixes some more weirdnesses.

The nconf also needs ncurses packages.  HOSTLOADLIBES_nconf is set
to the libraries needed for nconf, but the cflags is not explicitly
set.  Actually, nconf relies on the check-lxdialog.sh for the proper
cflags:

HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
                    -DLOCALE

The code above passes the ncurses flags to all objects, even for conf,
qconf, gconf.  Let's pass the ncurses flags only to mconf and nconf.

Currently, the presence of ncurses is not checked for nconf.  Let's
show a prompt like the mconf case.

According to Randy's report, the shell scripts still need to carry
the fallback code in case the pkg-config fails to find the ncurses
packages.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Squash two patches into one to not lose bisectability

Changes in v2:
  - Restore fallback detection for openSUSE etc.

 scripts/kconfig/Makefile                   | 58 ++++++++-----------
 scripts/kconfig/lxdialog/check-lxdialog.sh | 93 ------------------------------
 scripts/kconfig/lxdialog/dialog.h          |  2 +-
 scripts/kconfig/mconf-cfg.sh               | 44 ++++++++++++++
 scripts/kconfig/nconf-cfg.sh               | 43 ++++++++++++++
 5 files changed, 112 insertions(+), 128 deletions(-)
 delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
 create mode 100755 scripts/kconfig/mconf-cfg.sh
 create mode 100644 scripts/kconfig/nconf-cfg.sh

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 8cee14b..e4ac102 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -173,59 +173,49 @@ help:
 	@echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
 	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
 
-# lxdialog stuff
-check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
-
-# Use recursively expanded variables so we do not call gcc unless
-# we really need to do so. (Do not call gcc as part of make mrproper)
-HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
-                    -DLOCALE
-
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
 # conf:	  Used for defconfig, oldconfig and related targets
-# nconf:  Used for the nconfig target.
-#         Utilizes ncurses
-# mconf:  Used for the menuconfig target
-#         Utilizes the lxdialog package
 # object files used by all kconfig flavours
 
-lxdialog := lxdialog/checklist.o lxdialog/util.o lxdialog/inputbox.o
-lxdialog += lxdialog/textbox.o lxdialog/yesno.o lxdialog/menubox.o
-
 conf-objs	:= conf.o  zconf.tab.o
-mconf-objs     := mconf.o zconf.tab.o $(lxdialog)
-nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
 kxgettext-objs	:= kxgettext.o zconf.tab.o
 
-hostprogs-y := conf nconf mconf kxgettext
+hostprogs-y := conf kxgettext
 
 targets		+= zconf.lex.c
 clean-files	+= gconf.glade.h
 clean-files     += config.pot linux.pot
 
-# Check that we have the required ncurses stuff installed for lxdialog (menuconfig)
-PHONY += $(obj)/dochecklxdialog
-$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/dochecklxdialog
-$(obj)/dochecklxdialog:
-	$(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_EXTRACFLAGS) $(HOSTLOADLIBES_mconf)
-
-always := dochecklxdialog
-
 # Add environment specific flags
-HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS))
-HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS))
-
+HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS)) \
+		    -DLOCALE
+HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS)) \
+		    -DLOCALE
 # generated files seem to need this to find local include files
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_mconf   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
+# nconf: Used for the nconfig target based on ncurses
+hostprogs-y	+= nconf
+nconf-objs	:= nconf.o zconf.tab.o nconf.gui.o
+
+HOSTLOADLIBES_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
+HOSTCFLAGS_nconf.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
+HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
+
+$(obj)/nconf.o: $(obj)/.nconf-cfg
+
+# mconf: Used for the menuconfig target based on lxdialog
+hostprogs-y	+= mconf
+lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
+mconf-objs	:= mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))
+
+HOSTLOADLIBES_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
+$(foreach f, mconf.o $(lxdialog), \
+  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
 
-HOSTLOADLIBES_nconf	= $(shell \
-				pkg-config --libs menuw panelw ncursesw 2>/dev/null \
-				|| pkg-config --libs menu panel ncurses 2>/dev/null \
-				|| echo "-lmenu -lpanel -lncurses"  )
+$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/.mconf-cfg
 
 # qconf: Used for the xconfig target based on Qt
 hostprogs-y	+= qconf
diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
deleted file mode 100755
index 6c0bcd9..0000000
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Check ncurses compatibility
-
-# What library to link
-ldflags()
-{
-	pkg-config --libs ncursesw 2>/dev/null && exit
-	pkg-config --libs ncurses 2>/dev/null && exit
-	for ext in so a dll.a dylib ; do
-		for lib in ncursesw ncurses curses ; do
-			$cc -print-file-name=lib${lib}.${ext} | grep -q /
-			if [ $? -eq 0 ]; then
-				echo "-l${lib}"
-				exit
-			fi
-		done
-	done
-	exit 1
-}
-
-# Where is ncurses.h?
-ccflags()
-{
-	if pkg-config --cflags ncursesw 2>/dev/null; then
-		echo '-DCURSES_LOC="<ncurses.h>" -DNCURSES_WIDECHAR=1'
-	elif pkg-config --cflags ncurses 2>/dev/null; then
-		echo '-DCURSES_LOC="<ncurses.h>"'
-	elif [ -f /usr/include/ncursesw/curses.h ]; then
-		echo '-I/usr/include/ncursesw -DCURSES_LOC="<curses.h>"'
-		echo ' -DNCURSES_WIDECHAR=1'
-	elif [ -f /usr/include/ncurses/ncurses.h ]; then
-		echo '-I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"'
-	elif [ -f /usr/include/ncurses/curses.h ]; then
-		echo '-I/usr/include/ncurses -DCURSES_LOC="<curses.h>"'
-	elif [ -f /usr/include/ncurses.h ]; then
-		echo '-DCURSES_LOC="<ncurses.h>"'
-	else
-		echo '-DCURSES_LOC="<curses.h>"'
-	fi
-}
-
-# Temp file, try to clean up after us
-tmp=.lxdialog.tmp
-trap "rm -f $tmp" 0 1 2 3 15
-
-# Check if we can link to ncurses
-check() {
-        $cc -x c - -o $tmp 2>/dev/null <<'EOF'
-#include CURSES_LOC
-main() {}
-EOF
-	if [ $? != 0 ]; then
-	    echo " *** Unable to find the ncurses libraries or the"       1>&2
-	    echo " *** required header files."                            1>&2
-	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
-	    echo " *** "                                                  1>&2
-	    echo " *** Install ncurses (ncurses-devel or libncurses-dev " 1>&2
-	    echo " *** depending on your distribution) and try again."    1>&2
-	    echo " *** "                                                  1>&2
-	    exit 1
-	fi
-}
-
-usage() {
-	printf "Usage: $0 [-check compiler options|-ccflags|-ldflags compiler options]\n"
-}
-
-if [ $# -eq 0 ]; then
-	usage
-	exit 1
-fi
-
-cc=""
-case "$1" in
-	"-check")
-		shift
-		cc="$@"
-		check
-		;;
-	"-ccflags")
-		ccflags
-		;;
-	"-ldflags")
-		shift
-		cc="$@"
-		ldflags
-		;;
-	"*")
-		usage
-		exit 1
-		;;
-esac
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index fcffd5b..52e30a0 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -35,7 +35,7 @@
 #ifdef __sun__
 #define CURS_MACROS
 #endif
-#include CURSES_LOC
+#include <ncurses.h>
 
 /*
  * Colors in ncurses 1.9.9e do not work properly since foreground and
diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
new file mode 100755
index 0000000..1c2fe90
--- /dev/null
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="ncursesw"
+PKG2="ncurses"
+
+if pkg-config --exists $PKG; then
+	echo cflags=\"-DNCURSES_WIDECHAR=1 $(pkg-config --cflags $PKG)\"
+	echo libs=\"$(pkg-config --libs $PKG)\"
+	exit 0
+fi
+
+if pkg-config --exists $PKG2; then
+	echo cflags=\"$(pkg-config --cflags $PKG2)\"
+	echo libs=\"$(pkg-config --libs $PKG2)\"
+	exit 0
+fi
+
+# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
+# by pkg-config.
+if [ -f /usr/include/ncursesw/ncurses.h ]; then
+	echo cflags=\"-DNCURSES_WIDECHAR=1 -I/usr/include/ncursesw\"
+	echo libs=\"-lncursesw\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses/ncurses.h ]; then
+	echo cflags=\"-I/usr/include/ncurses\"
+	echo libs=\"-lncurses\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses.h ]; then
+	echo cflags=\"\"
+	echo libs=\"-lncurses\"
+	exit 0
+fi
+
+echo >&2 "*"
+echo >&2 "* Unable to find the ncurses package."
+echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
+echo >&2 "* depending on your distribution)."
+echo >&2 "*"
+exit 1
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
new file mode 100644
index 0000000..4c95b4e
--- /dev/null
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+PKG="ncursesw menuw panelw"
+PKG2="ncurses menu panel"
+
+if pkg-config --exists $PKG; then
+	echo cflags=\"-DNCURSES_WIDECHAR=1 $(pkg-config --cflags $PKG)\"
+	echo libs=\"$(pkg-config --libs $PKG)\"
+	exit 0
+fi
+
+if pkg-config --exists $PKG2; then
+	echo cflags=\"$(pkg-config --cflags $PKG2)\"
+	echo libs=\"$(pkg-config --libs $PKG2)\"
+	exit 0
+fi
+
+# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
+# by pkg-config.
+if [ -f /usr/include/ncursesw/ncurses.h ]; then
+	echo cflags=\"-DNCURSES_WIDECHAR=1 -I/usr/include/ncursesw\"
+	echo libs=\"-lncursesw -lmenuw -lpanelw\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses/ncurses.h ]; then
+	echo cflags=\"-I/usr/include/ncurses\"
+	echo libs=\"-lncurses -lmenu -lpanel\"
+	exit 0
+fi
+
+if [ -f /usr/include/ncurses.h ]; then
+	echo libs=\"-lncurses -lmenu -lpanel\"
+	exit 0
+fi
+
+echo >&2 "*"
+echo >&2 "* Unable to find the ncurses package."
+echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
+echo >&2 "* depending on your distribution)."
+echo >&2 "*"
+exit 1
-- 
2.7.4
