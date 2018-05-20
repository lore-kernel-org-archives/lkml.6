Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZpi6k3nuQ2ecvTzYD5KuNniS0yPI7n2wY5QoJBfLSY+7/lRnNYVU5z3pGWky6PpJJXHqeF9
ARC-Seal: i=1; a=rsa-sha256; t=1526804260; cv=none;
        d=google.com; s=arc-20160816;
        b=prZx+o7205iwZRNepVZ2/fWaIxKNk2C1XUs4ULSuISMpRVQKmGCLtW8AJD2KJ77KYZ
         uXNQsbW3LgJJkg4FQwm9/LSrDm+owGL69NhMLMLTayHDcJkXdQUFX3haFdU48DdqXbXg
         nhAG9XNMv82g4pPhbRxnpUqYfp5N0UR0+0vkzuLtsFZuY6J99iA/KkPs8jaBEhvv7Yjd
         UlyyBLsEsuENCcsTIqEuGaEHDaU4YOMhI9yj74Ls3Mz3TLq+KHSAmRmyDvlnSHwgxxaI
         IbOKowebKDB4TE8OQXnNdKDHgvEsR4/2vPwNoJLYo/Sd6XZumRmd29cCWTpeCndYiSPr
         cvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=7Zs6fZ01yIJSDMmCl+VFb0qiFM0Vky72s4Dsl0tcHb0=;
        b=Q2OOEA1n+9KJKOd4RS8FI148VypKnavnIzB4vSFLOv61AP2MyCiGj4Jg7MimKWx8Rf
         zsSEoSeAPy4sYognbd6PAiV0GnO27grVnBAw5sDdvdEygQqSLQgpQIf321oD+xJMtkQ2
         ep0CssAoU0zBETQQ6j3isZ0GpoSg5zpVCEwP4DGi47nGf9NuM1+SvKFDjJOnMMQdAKNk
         VCoD4HBLX8f7Okcz7pUzGiRT+eUttc+uLcGJePmNj+LfBYvflhTZ1feKH/wNLX11ipby
         KV4a5Ll92oM4ybXaI2Dn6viKNBQVwr2soDp5miqIw6mkOe5a3JkECh1bnapJ638JoH+5
         ZKUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=BBa8pr/o;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=BBa8pr/o;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w4K8H4h4004008
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Subject: [PATCH v2 4/5] kconfig: refactor ncurses package checks for building mconf
Date: Sun, 20 May 2018 17:16:52 +0900
Message-Id: <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600970303979180771?=
X-GMAIL-MSGID: =?utf-8?q?1600970303979180771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
Move and rename check-lxdialog.sh to mconf-cfg.sh to make it work in
the same way as for qconf and gconf.

According to Randy's report, we still need to carry the fallback code
in case the pkg-config fails to find ncurses.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Restore fallback detection for openSUSE etc.

 scripts/kconfig/Makefile                   | 44 +++++---------
 scripts/kconfig/lxdialog/check-lxdialog.sh | 93 ------------------------------
 scripts/kconfig/lxdialog/dialog.h          |  2 +-
 scripts/kconfig/mconf-cfg.sh               | 38 ++++++++++++
 4 files changed, 55 insertions(+), 122 deletions(-)
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
index 0000000..f5fe183
--- /dev/null
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -0,0 +1,38 @@
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
+if [ -f /usr/include/ncurses.h ]; then
+	echo cflags=\"\"
+	echo libs=\"-lncurses\"
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
