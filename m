Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbeCWNGL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:06:11 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:52680 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbeCWNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:06:00 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2ND4mgY011418
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 02/10] kbuild: clean up *.lex.c and *.tab.[ch] patterns from top-level Makefile
Date: Fri, 23 Mar 2018 22:04:31 +0900
Message-Id: <1521810279-6282-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files suffixed by .lex.c, .tab.[ch] are generated lexers, parsers,
respectively.  Clean them up globally from the top Makefile.

Some of the final host programs they are linked into are needed for
building external modules, but those intermediates are unneeded.
They can be cleaned away by 'make clean' instead of 'make mrproper'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                  | 1 +
 scripts/dtc/Makefile      | 6 ++----
 scripts/genksyms/Makefile | 2 --
 scripts/kconfig/Makefile  | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 493e267..168432e 100644
--- a/Makefile
+++ b/Makefile
@@ -1613,6 +1613,7 @@ clean: $(clean-dirs)
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su'  \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
+		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
 		-o -name modules.builtin -o -name '.tmp_*.o.*' \
 		-o -name .cache.mk \
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index a88b8c9..d17ba64 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -28,7 +28,5 @@ HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
 # dependencies on generated files need to be listed explicitly
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
 
-# generated files need to include *.cmd and be cleaned explicitly
-generated-files	:= dtc-lexer.lex.c dtc-parser.tab.c dtc-parser.tab.h
-targets		:= $(generated-files)
-clean-files	:= $(generated-files)
+# generated files need to include *.cmd
+targets := dtc-lexer.lex.c dtc-parser.tab.c dtc-parser.tab.h
diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
index 34d6ab1..0ccac51 100644
--- a/scripts/genksyms/Makefile
+++ b/scripts/genksyms/Makefile
@@ -11,5 +11,3 @@ HOSTCFLAGS_lex.lex.o := -I$(src)
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/lex.lex.o: $(obj)/parse.tab.h
-
-clean-files	:= lex.lex.c parse.tab.c parse.tab.h
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index f9bdd02..1dcd797 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -209,7 +209,7 @@ hostprogs-y := conf nconf mconf kxgettext qconf gconf
 
 targets		+= zconf.tab.c zconf.lex.c
 clean-files	:= qconf.moc .tmp_qtcheck .tmp_gtkcheck
-clean-files	+= zconf.tab.c zconf.lex.c gconf.glade.h
+clean-files	+= gconf.glade.h
 clean-files     += config.pot linux.pot
 
 # Check that we have the required ncurses stuff installed for lxdialog (menuconfig)
-- 
2.7.4
