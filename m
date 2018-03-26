Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeCZPz3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:55:29 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:43700 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeCZPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:55:27 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2QFrv8B007902
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2,10/10] kbuild: mark $(targets) as .SECONDARY and remove .PRECIOUS markers
Date: Tue, 27 Mar 2018 00:53:54 +0900
Message-Id: <1522079634-5947-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU Make automatically deletes intermediate files that are updated
in a chain of pattern rules.

Example 1) %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
Example 2) %.o <- %.c <- %.c_shipped

A couple of makefiles mark such targets as .PRECIOUS to prevent Make
from deleting them, but the correct way is to use .SECONDARY.

  .SECONDARY
    Prerequisites of this special target are treated as intermediate
    files but are never automatically deleted.

  .PRECIOUS
    When make is interrupted during execution, it may delete the target
    file it is updating if the file was modified since make started.
    If you mark the file as precious, make will never delete the file
    if interrupted.

Both can avoid deletion of intermediate files, but the difference is
the behavior when Make is interrupted; .SECONDARY deletes the target,
but .PRECIOUS does not.

The use of .PRECIOUS is relatively rare since we do not want to keep
partially constructed (possibly corrupted) targets.

Another difference is that .PRECIOUS works with pattern rules whereas
.SECONDARY does not.

  .PRECIOUS: $(obj)/%.lex.c

works, but

  .SECONDARY: $(obj)/%.lex.c

has no effect.  However, for the reason above, I do not want to use
.PRECIOUS which could cause obscure build breakage.

The targets specified as .SECONDARY must be explicit.  $(targets)
contains all targets that need to include .*.cmd files.  So, the
intermediates you want to keep are mostly in there.  Therefore, mark
$(targets) as .SECONDARY.  It means primary targets are also marked
as .SECONDARY, but I do not see any drawback for this.

I replaced some .SECONDARY / .PRECIOUS markers with 'targets'.  This
will make Kbuild search for non-existing .*.cmd files, but this is
not a noticeable performance issue.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Frank Rowand <frowand.list@gmail.com>
---
 arch/arc/boot/dts/Makefile        |  2 --
 arch/arm/crypto/Makefile          |  2 +-
 arch/arm64/crypto/Makefile        |  2 +-
 arch/metag/boot/dts/Makefile      |  2 --
 arch/sparc/vdso/Makefile          |  4 +---
 arch/x86/entry/vdso/Makefile      |  4 +---
 drivers/of/unittest-data/Makefile |  4 ----
 scripts/Makefile.build            | 10 +++++++---
 scripts/Makefile.lib              |  3 ---
 9 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index 22a4c5d..a83c4f5 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -9,8 +9,6 @@ endif
 obj-y   += $(builtindtb-y).dtb.o
 dtb-y := $(builtindtb-y).dtb
 
-.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
-
 # for CONFIG_OF_ALL_DTBS test
 dtstree	:= $(srctree)/$(src)
 dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 30ef8e2..b69ea35 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -63,4 +63,4 @@ $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
 	$(call cmd,perl)
 
-.PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
+targets += sha256-core.S sha512-core.S
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index cee9b8d9..036eb23 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -76,4 +76,4 @@ $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
 $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
 
-.PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
+targets += sha256-core.S sha512-core.S
diff --git a/arch/metag/boot/dts/Makefile b/arch/metag/boot/dts/Makefile
index f0a180f..16505aa 100644
--- a/arch/metag/boot/dts/Makefile
+++ b/arch/metag/boot/dts/Makefile
@@ -12,5 +12,3 @@ endif
 
 dtb-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb
 obj-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb.o
-
-.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index a6615d8..dd0b5a9 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -29,9 +29,7 @@ vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
 vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
 obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
-targets += $(vdso_img_sodbg)
-.SECONDARY: $(vdso_img-y:%=$(obj)/vdso-image-%.c) \
-	$(vdso_img-y:%=$(obj)/vdso%.so)
+targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
 export CPPFLAGS_vdso.lds += -P -C
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 1943aeb..d998a48 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -42,9 +42,7 @@ vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
 vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
 obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
-targets += $(vdso_img_sodbg)
-.SECONDARY: $(vdso_img-y:%=$(obj)/vdso-image-%.c) \
-	$(vdso_img-y:%=$(obj)/vdso%.so)
+targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
 export CPPFLAGS_vdso.lds += -P -C
 
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 87a65ca..013d85e 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -30,7 +30,3 @@ DTC_FLAGS_testcases += -@
 
 # suppress warnings about intentional errors
 DTC_FLAGS_testcases += -Wno-interrupts_property
-
-.PRECIOUS: \
-	$(obj)/%.dtb.S \
-	$(obj)/%.dtb
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ee004f5..67fda60 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -434,8 +434,6 @@ quiet_cmd_asn1_compiler = ASN.1   $@
       cmd_asn1_compiler = $(objtree)/scripts/asn1_compiler $< \
 				$(subst .h,.c,$@) $(subst .c,.h,$@)
 
-.PRECIOUS: $(objtree)/$(obj)/%.asn1.c $(objtree)/$(obj)/%.asn1.h
-
 $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 	$(call cmd,asn1_compiler)
 
@@ -573,10 +571,12 @@ targets := $(filter-out $(PHONY), $(targets))
 intermediate_targets = $(foreach sfx, $(2), \
 				$(patsubst %$(strip $(1)),%$(sfx), \
 					$(filter %$(strip $(1)), $(targets))))
+# %.asn1.o <- %.asn1.[ch] <- %.asn1
 # %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
 # %.lex.o <- %.lex.c <- %.l
 # %.tab.o <- %.tab.[ch] <- %.y
-targets += $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
+targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
+	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
 	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
 
@@ -616,6 +616,10 @@ $(shell mkdir -p $(obj-dirs))
 endif
 endif
 
+# Some files contained in $(targets) are intermediate artifacts.
+# We never want them to be removed automatically.
+.SECONDARY: $(targets)
+
 # Declare the contents of the .PHONY variable as phony.  We keep that
 # information in a variable se we can use it in if_changed and friends.
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2882e19..173d198 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -191,7 +191,6 @@ endef
 quiet_cmd_flex = LEX     $@
       cmd_flex = $(LEX) -o$@ -L $<
 
-.PRECIOUS: $(obj)/%.lex.c
 $(obj)/%.lex.c: $(src)/%.l FORCE
 	$(call if_changed,flex)
 
@@ -200,14 +199,12 @@ $(obj)/%.lex.c: $(src)/%.l FORCE
 quiet_cmd_bison = YACC    $@
       cmd_bison = $(YACC) -o$@ -t -l $<
 
-.PRECIOUS: $(obj)/%.tab.c
 $(obj)/%.tab.c: $(src)/%.y FORCE
 	$(call if_changed,bison)
 
 quiet_cmd_bison_h = YACC    $@
       cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
 
-.PRECIOUS: $(obj)/%.tab.h
 $(obj)/%.tab.h: $(src)/%.y FORCE
 	$(call if_changed,bison_h)
 
-- 
2.7.4
