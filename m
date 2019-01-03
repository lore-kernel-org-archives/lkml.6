Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC24C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435A520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gLA0fahL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfACBdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:33:03 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:54038 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfACBdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:33:03 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x031WiFN010645;
        Thu, 3 Jan 2019 10:32:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x031WiFN010645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546479164;
        bh=I9fjGBUiO+eOH5I5SOSB7cXRy50jjhhn8kKQaYD8uhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gLA0fahLvxbyFxzwRAcc9SfzNqXhoo6wLnk71jatgi3THfn99gwH9oa6AyS0/wPR4
         PdpzesKnK4dnHK4MKb27FQ2wkjEiSeYD/57T4ycZUS38Gb495yt5bVMI1Q1ca9NHMS
         utwyEcUI7xDFjD3TiwItCOiaLHSUzXBgZ3RiGM5AhTYjSByjBr+NySNOc7jzk1cDkc
         LuPA32KCTvpY1umRm+LoHpm1sVrHx4JGaluw0qe5XaLsy4mKX9H1RutsiFn/jtY6HL
         DU2T2xQBSLdgcbxUv8whq2uYlGzfFERCTjNmuk9K+xV+ywInx4wjb5QY+0KLHAeRuY
         d/sxMXs/JXMLw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: remove unnecessary in-subshell execution
Date:   Thu,  3 Jan 2019 10:32:38 +0900
Message-Id: <1546479159-7611-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commands surrounded by ( ) are executed in a subshell, but in
most cases, we do not need to spawn an extra subshell.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - fix build error of CONFIG_MODVERSIONS

 scripts/Makefile.build |  4 ++--
 scripts/Makefile.lib   | 28 ++++++++++++++--------------
 scripts/mkcompile_h    |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60..778e4fb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -312,11 +312,11 @@ $(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
 cmd_gensymtypes_S =                                                         \
-    (echo "\#include <linux/kernel.h>" ;                                    \
+   { echo "\#include <linux/kernel.h>" ;                                    \
      echo "\#include <asm/asm-prototypes.h>" ;                              \
     $(CPP) $(a_flags) $< |                                                  \
      grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ) | \
+     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 12b88d0..b44ae6c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -270,7 +270,7 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTB     $@
 cmd_dt_S_dtb=						\
-(							\
+{							\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
@@ -280,7 +280,7 @@ cmd_dt_S_dtb=						\
 	echo '__dtb_$(subst -,_,$(*F))_end:';		\
 	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
-) > $@
+} > $@
 
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 	$(call if_changed,dt_S_dtb)
@@ -334,23 +334,23 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
-	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_bzip2 = cat $(filter-out FORCE,$^) | \
+	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^)) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (cat $(filter-out FORCE,$^) | \
-	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_lzma = cat $(filter-out FORCE,$^) | \
+	lzma -9 && $(call size_append, $(filter-out FORCE,$^)) > $@
 
 quiet_cmd_lzo = LZO     $@
-cmd_lzo = (cat $(filter-out FORCE,$^) | \
-	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_lzo = cat $(filter-out FORCE,$^) | \
+	lzop -9 && $(call size_append, $(filter-out FORCE,$^)) > $@
 
 quiet_cmd_lz4 = LZ4     $@
-cmd_lz4 = (cat $(filter-out FORCE,$^) | \
-	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_lz4 = cat $(filter-out FORCE,$^) | \
+	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^)) > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -392,13 +392,13 @@ quiet_cmd_uimage = UIMAGE  $@
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-cmd_xzkern = (cat $(filter-out FORCE,$^) | \
+      cmd_xzkern = cat $(filter-out FORCE,$^) | \
 	sh $(srctree)/scripts/xz_wrap.sh && \
-	$(call size_append, $(filter-out FORCE,$^))) > $@
+	$(call size_append, $(filter-out FORCE,$^)) > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
-cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
-	xz --check=crc32 --lzma2=dict=1MiB) > $@
+      cmd_xzmisc = cat $(filter-out FORCE,$^) | \
+	xz --check=crc32 --lzma2=dict=1MiB > $@
 
 # ASM offsets
 # ---------------------------------------------------------------------------
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 87f1fc9..2339f86 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -62,7 +62,7 @@ UTS_TRUNCATE="cut -b -$UTS_LEN"
 
 # Generate a temporary compile.h
 
-( echo /\* This file is auto generated, version $VERSION \*/
+{ echo /\* This file is auto generated, version $VERSION \*/
   if [ -n "$CONFIG_FLAGS" ] ; then echo "/* $CONFIG_FLAGS */"; fi
 
   echo \#define UTS_MACHINE \"$ARCH\"
@@ -73,7 +73,7 @@ UTS_TRUNCATE="cut -b -$UTS_LEN"
   echo \#define LINUX_COMPILE_HOST \"`echo $LINUX_COMPILE_HOST | $UTS_TRUNCATE`\"
 
   echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | grep ' version ' | sed 's/[[:space:]]*$//'`\"
-) > .tmpcompile
+} > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
 # in order to preserve the timestamp and avoid unnecessary
-- 
2.7.4

