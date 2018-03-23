Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeCWNGK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:06:10 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:52876 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbeCWNGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:06:07 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2ND4mgb011418
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
Subject: [PATCH 05/10] kbuild: add %.dtb.S and %.dtb to 'targets' automatically
Date: Fri, 23 Mar 2018 22:04:34 +0900
Message-Id: <1521810279-6282-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521810279-6282-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another common pattern that consists of chained commands is to compile
a DTB as binary data into the kernel image or a module.  It is used in
several places in the source tree.  Let's support it in the build core.

$(call if_changed,dt_S_dtb) is more suitable than $(call cmd,dt_S_dtb)
in case cmd_dt_S_dtb is changed in the future.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/of/unittest-data/Makefile | 2 --
 scripts/Makefile.build            | 4 +++-
 scripts/Makefile.lib              | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index df69797..333bc4c 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -7,8 +7,6 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
 
-targets += $(foreach suffix, dtb dtb.S, $(patsubst %.dtb.o,%.$(suffix),$(obj-y)))
-
 # enable creation of __symbols__ node
 DTC_FLAGS_overlay := -@
 DTC_FLAGS_overlay_bad_phandle := -@
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 36f7990..15b3bbb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -544,9 +544,11 @@ targets := $(filter-out $(PHONY), $(targets))
 intermediate_targets = $(foreach sfx, $(2), \
 				$(patsubst %$(strip $(1)),%$(sfx), \
 					$(filter %$(strip $(1)), $(targets))))
+# %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
 # %.lex.o <- %.lex.c <- %.l
 # %.tab.o <- %.tab.[ch] <- %.y
-targets += $(call intermediate_targets, .lex.o, .lex.c) \
+targets += $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
+	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
 
 # Descending
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b7d2c97..7a1fa92 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -278,8 +278,8 @@ cmd_dt_S_dtb=						\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
 ) > $@
 
-$(obj)/%.dtb.S: $(obj)/%.dtb
-	$(call cmd,dt_S_dtb)
+$(obj)/%.dtb.S: $(obj)/%.dtb FORCE
+	$(call if_changed,dt_S_dtb)
 
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
-- 
2.7.4
