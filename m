Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZoREhfcorOxP1J9eJ7Ditt0eCiTJoLkda22FPomjGEzaAmKokROj397FxPYQhd4/08aA1T7
ARC-Seal: i=1; a=rsa-sha256; t=1526619186; cv=none;
        d=google.com; s=arc-20160816;
        b=qD0OG+oPLQdFQghAZC7kiR/hA2nU0pUChBqM05KbvrE20wXLFQaBgFOJR5qQJypXEv
         YQb+YAL5ukQV37UkhSMM2/boA/cBpjShKDxi4YAMpqaF1nYNsGjEK6NPubJ6oTyWOomC
         Pe6ZAb8wBTEEatt317kSox3XI7gEyco0uk4AdOFZxtHFm/0ruq/HNI54UihcTZk9HG8i
         JIC56UTLriDSwz3EjuAELGE4Jnk2ozb/mILFDDcB/P0VaACD/vNlUrAuUNrQG/kaN1kA
         ffvF9oIKv+Lr1x1DADwkxpGtFnT1LnQwcs27kUtorr+rr1607vOSeG55yhfLKJwh6Is0
         /s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=2sGr2fqfNPJUmiBhzE6pSuGCearjfItYeHO3XBDRUAc=;
        b=I8znrcK2rDuPj+HuvCSebBAIP8UP1jsjwcIrB4X+4jaemwnUmdb6fa1jlhmRNJXeDI
         WtzWvfrre6EBb3A5CgoEUGfK+7IMFkA10Qh1kVlLxoXT4A/k+L9G5rajS+AHDQHXHN8N
         ZAKl2w1vQfFrLQAOH6IxF0pEhljTCB5O6DnVuWz6M5C7M+mLv0PsnK+N8+bz5QaSbIjL
         lk+6/149DeDzf8NxjPVoZytyBgwAwx0EZh2qwe549cK5OC12sl5Kgud8F3V5yzKVwjkS
         hUah1ncNAY/a42aENSTInutIgw+8T6ofVy7r57043PgS5ae4rovAEx6fBWueEvXUX+gy
         5TAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=N7CSX9VV;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=N7CSX9VV;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4I4qbKH013482
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Subject: [PATCH 4/5] kconfig: refactor ncurses package checks for building mconf
Date: Fri, 18 May 2018 13:52:25 +0900
Message-Id: <1526619146-1895-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600776240586808874?=
X-GMAIL-MSGID: =?utf-8?q?1600776240586808874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
check-lxdialog.sh has additional checks in case pkg-config is not
available.  However, qconf and gconf already rely on pkg-config to
check necessary packages.  For simplification, drop the fallback
code from check-lxdialog.sh and move/rename to mconf-cfg.sh to
make it work in the same way as the other GUI frontends.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile                   | 44 +++++---------
 scripts/kconfig/lxdialog/check-lxdialog.sh | 93 ------------------------------
 scripts/kconfig/lxdialog/dialog.h          |  2 +-
 scripts/kconfig/mconf-cfg.sh               | 24 ++++++++
 4 files changed, 41 insertions(+), 122 deletions(-)
 delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
 create mode 100755 scripts/kconfig/mconf-cfg.sh

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index c222745..25a3d25 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -173,60 +173,48 @@ help:
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
 # nconf:  Used for the nconfig target.
 #         Utilizes ncurses
-# mconf:  Used for the menuconfig target
-#         Utilizes the lxdialog package
 # object files used by all kconfig flavours
 
-lxdialog := lxdialog/checklist.o lxdialog/util.o lxdialog/inputbox.o
-lxdialog += lxdialog/textbox.o lxdialog/yesno.o lxdialog/menubox.o
-
 conf-objs	:= conf.o  zconf.tab.o
-mconf-objs     := mconf.o zconf.tab.o $(lxdialog)
 nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
 kxgettext-objs	:= kxgettext.o zconf.tab.o
 
-hostprogs-y := conf nconf mconf kxgettext
+hostprogs-y := conf nconf kxgettext
 
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
-
 HOSTLOADLIBES_nconf	= $(shell \
 				pkg-config --libs menuw panelw ncursesw 2>/dev/null \
 				|| pkg-config --libs menu panel ncurses 2>/dev/null \
 				|| echo "-lmenu -lpanel -lncurses"  )
 
+# mconf: Used for the menuconfig target based on lxdialog
+hostprogs-y	+= mconf
+lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
+mconf-objs	:= mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))
+
+HOSTLOADLIBES_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
+$(foreach f, mconf.o $(lxdialog), \
+  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
+
+$(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/.mconf-cfg
+
 # qconf: Used for the xconfig target based on Qt
 hostprogs-y	+= qconf
 qconf-cxxobjs	:= qconf.o
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
index 0000000..7d5a4b2
--- /dev/null
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -0,0 +1,24 @@
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
+echo >&2 "*"
+echo >&2 "* Unable to find the ncurses."
+echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
+echo >&2 "* depending on your distribution)"
+echo >&2 "*"
+exit 1
-- 
2.7.4
