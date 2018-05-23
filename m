Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeEWCMt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:12:49 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:20217 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeEWCMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:12:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4N2BaOW029812
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fixup! kconfig: refactor ncurses package checks for building mconf and nconf
Date: Wed, 23 May 2018 11:11:31 +0900
Message-Id: <1527041491-12647-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is redundant to pass -DNCURSES_WIDECHAR=1 explicitly; when we use
'pkg-config --cflags', it takes care of appropriate flags.

Actually, 'pkg-config --cflags' will add -D_GNU_SOURCE, which will
define _XOPEN_SOURCE_EXTENDED, and NCURSES_WIDECHAR=1, anyway.

I added -D_GNU_SOURCE to follow the suggestion of pkg-config
for cases where pkg-config is not useful.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The v3 (https://patchwork.kernel.org/patch/10417413/) was
reviewed and tested.

I'd like to squash this into it.


 scripts/kconfig/mconf-cfg.sh | 8 ++++----
 scripts/kconfig/nconf-cfg.sh | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
index 1c2fe90..e6f9fac 100755
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -5,7 +5,7 @@ PKG="ncursesw"
 PKG2="ncurses"
 
 if pkg-config --exists $PKG; then
-	echo cflags=\"-DNCURSES_WIDECHAR=1 $(pkg-config --cflags $PKG)\"
+	echo cflags=\"$(pkg-config --cflags $PKG)\"
 	echo libs=\"$(pkg-config --libs $PKG)\"
 	exit 0
 fi
@@ -19,19 +19,19 @@ fi
 # Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
 # by pkg-config.
 if [ -f /usr/include/ncursesw/ncurses.h ]; then
-	echo cflags=\"-DNCURSES_WIDECHAR=1 -I/usr/include/ncursesw\"
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
 	echo libs=\"-lncursesw\"
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses/ncurses.h ]; then
-	echo cflags=\"-I/usr/include/ncurses\"
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncurses\"
 	echo libs=\"-lncurses\"
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses.h ]; then
-	echo cflags=\"\"
+	echo cflags=\"-D_GNU_SOURCE\"
 	echo libs=\"-lncurses\"
 	exit 0
 fi
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
index 4c95b4e..42f5ac7 100644
--- a/scripts/kconfig/nconf-cfg.sh
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -5,7 +5,7 @@ PKG="ncursesw menuw panelw"
 PKG2="ncurses menu panel"
 
 if pkg-config --exists $PKG; then
-	echo cflags=\"-DNCURSES_WIDECHAR=1 $(pkg-config --cflags $PKG)\"
+	echo cflags=\"$(pkg-config --cflags $PKG)\"
 	echo libs=\"$(pkg-config --libs $PKG)\"
 	exit 0
 fi
@@ -19,18 +19,19 @@ fi
 # Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
 # by pkg-config.
 if [ -f /usr/include/ncursesw/ncurses.h ]; then
-	echo cflags=\"-DNCURSES_WIDECHAR=1 -I/usr/include/ncursesw\"
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
 	echo libs=\"-lncursesw -lmenuw -lpanelw\"
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses/ncurses.h ]; then
-	echo cflags=\"-I/usr/include/ncurses\"
+	echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncurses\"
 	echo libs=\"-lncurses -lmenu -lpanel\"
 	exit 0
 fi
 
 if [ -f /usr/include/ncurses.h ]; then
+	echo cflags=\"-D_GNU_SOURCE\"
 	echo libs=\"-lncurses -lmenu -lpanel\"
 	exit 0
 fi
-- 
2.7.4
