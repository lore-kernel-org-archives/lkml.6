Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13385C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF35821722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zk9aKQ0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF35821722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeH0GxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:53:11 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:58404 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeH0GxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:53:11 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w7R37dt8005354;
        Mon, 27 Aug 2018 12:07:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w7R37dt8005354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535339259;
        bh=B8xkQBFo4yxnOb4Y3sjXVbGiKUL+hoOmtpDnugZP2zE=;
        h=From:To:Cc:Subject:Date:From;
        b=Zk9aKQ0s3PA35RbBGxHz7szuudocpUrzmHfhZDcoRxLCm0YmhQ3hwYOHYFNEO16tv
         ztv3bTajEhvYVM7Fy08ev6PgFKC7d2L+doW/11e93a/wUJqYI3HdX7mcnQl7ONHADY
         A7uFqc3bLyB/MnGuY4euHMOruHf3MQiwRjvpnyScXuTnKeCzVz3ckCz0P9kbU5PSY/
         Ghz4bUP+flujLzVBJLogVGdp8D+k6rVaU8qqtcuI2zADQF4lkGLrqESMUL+RYEfzhr
         LhH41w8pzMxo/OVWfHmyEx3xdIahknt6Bbksx+hioS33uQ7xnnVMlXyRZxymlqVFh1
         HBz+A1UlnkiHA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arc: remove redundant GCC version checks
Date:   Mon, 27 Aug 2018 12:07:37 +0900
Message-Id: <1535339257-17620-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

With GCC >= 4.6 assumed, 'upto_gcc44' is empty, 'atleast_gcc44' is y.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arc/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index fb02619..99cce77 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -43,10 +43,7 @@ ifdef CONFIG_ARC_CURR_IN_REG
 LINUXINCLUDE	+=  -include ${src}/arch/arc/include/asm/current.h
 endif
 
-upto_gcc44    :=  $(call cc-ifversion, -le, 0404, y)
-atleast_gcc44 :=  $(call cc-ifversion, -ge, 0404, y)
-
-cflags-$(atleast_gcc44)			+= -fsection-anchors
+cflags-y				+= -fsection-anchors
 
 cflags-$(CONFIG_ARC_HAS_LLSC)		+= -mlock
 cflags-$(CONFIG_ARC_HAS_SWAPE)		+= -mswape
@@ -82,11 +79,6 @@ cflags-$(disable_small_data)		+= -mno-sdata -fcall-used-gp
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -mbig-endian
 ldflags-$(CONFIG_CPU_BIG_ENDIAN)	+= -EB
 
-# STAR 9000518362: (fixed with binutils shipping with gcc 4.8)
-# arc-linux-uclibc-ld (buildroot) or arceb-elf32-ld (EZChip) don't accept
-# --build-id w/o "-marclinux". Default arc-elf32-ld is OK
-ldflags-$(upto_gcc44)			+= -marclinux
-
 LIBGCC	:= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
 
 # Modules with short calls might break for calls into builtin-kernel
-- 
2.7.4

