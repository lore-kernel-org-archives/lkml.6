Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F144D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LhO2fkib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeLaIZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:25:21 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:32523 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeLaIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:25:20 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBV8OIjr008355;
        Mon, 31 Dec 2018 17:24:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBV8OIjr008355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546244661;
        bh=sZ34wNp5QOxinAjl4K6AZ3e+ex4n5qiP88Og+S/xRdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhO2fkibHG0FbyiWN0CR3zSH0HNvA4ivSsZKhRXuN0jTrXl0UNuqdGptrudomZ0gV
         omLT7uZdDUiCCzvn/LxYGrzvGVa2RG3DPbLVlghoErSwGfslnhH6+/qNN0zJ0p/7fi
         CdQVmbnDNdtH7opfaaPhrfu17MaJXf8mUtMFXqrsn3KcywGJfonBCSl6/b23eUbHQI
         QhuX4OwuJLgdTGMgHTQ1rUST4Ugv8L0CVgBU8pY6F/jNdZtquDWbQwrLoRS9JA8Azo
         PKipYbzzIAR9oEO1iNKOkKtDyfD7fY2eHym8Cu1Y9liMV5vyhE2qwfFc2h8lFi9Re7
         Um0wuwju6wS6A==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] kbuild: remove unnecessary in-subshell execution
Date:   Mon, 31 Dec 2018 17:24:10 +0900
Message-Id: <1546244651-10447-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commands surrounded by ( ) are executed in a subshell, but in
most cases, we do not need to spawn an extra subshell.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/Makefile |  4 ++--
 scripts/Makefile.build            |  4 ++--
 scripts/Makefile.lib              | 28 ++++++++++++++--------------
 scripts/mkcompile_h               |  4 ++--
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 6114ae6..6fe29c4 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -169,8 +169,8 @@ $(obj)/bswapsdi2.S: $(srctree)/arch/$(SRCARCH)/lib/bswapsdi2.S
 check_for_bad_syms = \
 bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
 [ -z "$$bad_syms" ] || \
-  ( echo "following symbols must have non local/private scope:" >&2; \
-    echo "$$bad_syms" >&2; false )
+  { echo "following symbols must have non local/private scope:" >&2; \
+    echo "$$bad_syms" >&2; false; }
 
 check_for_multiple_zreladdr = \
 if [ $(words $(ZRELADDR)) -gt 1 -a "$(CONFIG_AUTO_ZRELADDR)" = "" ]; then \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60..0a44863 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -312,11 +312,11 @@ $(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 #
 # These mirror gensymtypes_c and co above, keep them in synch.
 cmd_gensymtypes_S =                                                         \
-    (echo "\#include <linux/kernel.h>" ;                                    \
+    {echo "\#include <linux/kernel.h>" ;                                    \
      echo "\#include <asm/asm-prototypes.h>" ;                              \
     $(CPP) $(a_flags) $< |                                                  \
      grep "\<___EXPORT_SYMBOL\>" |                                          \
-     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ) | \
+     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/'; } | \
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

