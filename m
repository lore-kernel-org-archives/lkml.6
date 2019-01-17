Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F297C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4192720657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mBWnQHCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfAQKDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:03:47 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:49394 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfAQKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:03:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0HA38Gt009525;
        Thu, 17 Jan 2019 19:03:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0HA38Gt009525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547719392;
        bh=soy1QAAm9zjbqbxh/eF8P8dx1NBX+Q5/ESX1favG7s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBWnQHCAno0hRXrIv1/BWp+TQ5HNg+bXOXxeN5tR6N3jv5qp1fAVoZBew1H5n6ozx
         QRQRI5blUfNFwwWK9rUq0marR1jhoMMPZu29xlFC64nSUWWwnjVTGP4TnFWAETPauN
         Z/vFjK58juF7ef9ZevE8/mgfD06WgbTgOykrRiCxJ8opuWY2F39HfEOsQALuSI9FDE
         bpATk77Z7TEoy64DlbXSQRTvU/yG6+nKC2iZMgdPw4+RhPTu7r6fqgxbHIF6Bu5MFV
         mT+jDJCcw1g+kr2krr1zc4XvK+O7vl4dbjUBx3hzzYASTRyv+Vc2a3tR5xsuqWyJ6I
         jApeHHrJRm3GA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] kbuild: remove unnecessary in-subshell execution
Date:   Thu, 17 Jan 2019 19:02:44 +0900
Message-Id: <1547719364-18849-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commands surrounded by ( ) are executed in a subshell, but in
most cases, we do not need to spawn an extra subshell.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Makefile.build |  4 ++--
 scripts/Makefile.lib   | 21 ++++++++++-----------
 scripts/mkcompile_h    |  4 ++--
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9800178..f8e2794 100644
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
index c6fc295..c0abd9a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -271,7 +271,7 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtb= DTB     $@
 cmd_dt_S_dtb=						\
-(							\
+{							\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
@@ -281,7 +281,7 @@ cmd_dt_S_dtb=						\
 	echo '__dtb_$(subst -,_,$(*F))_end:';		\
 	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
-) > $@
+} > $@
 
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 	$(call if_changed,dt_S_dtb)
@@ -335,20 +335,20 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-      cmd_bzip2 = (cat $(real-prereqs) | bzip2 -9 && $(size_append)) > $@
+      cmd_bzip2 = { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-      cmd_lzma = (cat $(real-prereqs) | lzma -9 && $(size_append)) > $@
+      cmd_lzma = { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@
 
 quiet_cmd_lzo = LZO     $@
-      cmd_lzo = (cat $(real-prereqs) | lzop -9 && $(size_append)) > $@
+      cmd_lzo = { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@
 
 quiet_cmd_lz4 = LZ4     $@
-      cmd_lz4 = (cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
-                  $(size_append)) > $@
+      cmd_lz4 = { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
+                  $(size_append); } > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -390,12 +390,11 @@ quiet_cmd_uimage = UIMAGE  $@
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-      cmd_xzkern = (cat $(real-prereqs) | \
-	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
+      cmd_xzkern = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh && \
+                     $(size_append); } > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
-      cmd_xzmisc = (cat $(real-prereqs) | \
-	xz --check=crc32 --lzma2=dict=1MiB) > $@
+      cmd_xzmisc = cat $(real-prereqs) | xz --check=crc32 --lzma2=dict=1MiB > $@
 
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

