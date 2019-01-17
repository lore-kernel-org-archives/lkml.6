Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC5220851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kqnlTzrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfAQELF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:11:05 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:22827 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbfAQELF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:11:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0H4AYQb007102;
        Thu, 17 Jan 2019 13:10:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0H4AYQb007102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547698234;
        bh=DeGTimLs2LDTF0UV0F/cvayXY2TZfd8t27YTASSPmfM=;
        h=From:To:Cc:Subject:Date:From;
        b=kqnlTzrlMSwg8JjpaxTOmqJktov4P0X058ZiUE096VHgLi9LZzzPw6LPYlcK3g++h
         cwKwXKhggYQHafV6PdmuA6ioUH1/4d42JFXk+lmMgo1zfeA1nYsoMJxCy+JHF1OepO
         o9ASRpIjF8dK1tpukxJh/s1m/tokzuLSGcM72rUY/Jp9ZAm8nS0lnIr1CJV/v9tHkD
         crVk9bSjvvMxUUIZw9k+SdDsQSEREYDC9Vw1+4dnsvjfkCdQxRNY368qt7QhzJbGpv
         qMKvH6C+zOD9mp9jEqgVzU0e8NHBToYg3jGLAPiW3vBm2EqzEksEQK4R2VO11izuzP
         zQ5yksCSP8QPw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: simplify rules of data compression with size appending
Date:   Thu, 17 Jan 2019 13:10:29 +0900
Message-Id: <1547698231-20985-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers of size_append pass $(filter-out FORCE,$^).
Move $(filter-out FORCE,$^) to the definition of size_append.

This makes the callers cleaner because $(call ...) can be omitted
to expand a macro with no argument.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ecad15b..ebaa348 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -321,7 +321,7 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 # append the size as a 32-bit littleendian number as gzip does.
 size_append = printf $(shell						\
 dec_size=0;								\
-for F in $1; do								\
+for F in $(filter-out FORCE,$^); do					\
 	fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);	\
 	dec_size=$$(expr $$dec_size + $$fsize);				\
 done;									\
@@ -335,23 +335,20 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
-	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (cat $(filter-out FORCE,$^) | \
-	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
 
 quiet_cmd_lzo = LZO     $@
-cmd_lzo = (cat $(filter-out FORCE,$^) | \
-	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
 
 quiet_cmd_lz4 = LZ4     $@
-cmd_lz4 = (cat $(filter-out FORCE,$^) | \
-	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
+      cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
+                  $(size_append)) > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -394,8 +391,7 @@ quiet_cmd_uimage = UIMAGE  $@
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
 cmd_xzkern = (cat $(filter-out FORCE,$^) | \
-	sh $(srctree)/scripts/xz_wrap.sh && \
-	$(call size_append, $(filter-out FORCE,$^))) > $@
+	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
 cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
-- 
2.7.4

