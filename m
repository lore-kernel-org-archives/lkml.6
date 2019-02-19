Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17D921902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550557333;
	bh=fjGeysTJlj78uDXJhltvIZoPs/XLrIzLrV5xCAnChLE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=smQVbfsa76/sc35M63VNbdf8iQmymq7uLpJO2iHlBLQ9n/mwVCc0ZRImvtlgqTHUQ
	 ouGkfZI1J0X2BwV6+eIxj+i/RBj54GWYM5Hno1k1HoVdTFeMrfq24SCdzOyt5HUr8y
	 EOTBhJGwtIH3t/Y3wy7JUOJmMqjRQhjXJd4tgJuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfBSGWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSGWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:22:11 -0500
Received: from localhost.localdomain (unknown [122.234.57.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8574217D7;
        Tue, 19 Feb 2019 06:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550557331;
        bh=fjGeysTJlj78uDXJhltvIZoPs/XLrIzLrV5xCAnChLE=;
        h=From:To:Cc:Subject:Date:From;
        b=jyqkwgNui0FWez0OYxijt95Xlr9ZEfxxtwoCYePcJxLxJWGxJJLvYeK7j4Zzm4RFP
         ltdxjHpaNz4rB4dWr7gRKrIL74lAE1Mad4g3Puwu8F1NDSqZpjm9Yt9pzdIu4yCfl+
         xLGMXaO9C58UpWKB9tzjxWRNV7GtHqAtvHYPOKno=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Subject: [PATCH] csky: Fixup vdsp&fpu issues in kernel
Date:   Tue, 19 Feb 2019 14:22:04 +0800
Message-Id: <1550557324-6354-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

This fixup is continue to commit 35ff802af1c4 (csky: fixup remove
vdsp implement for kernel.) and in that patch I didn't finish the
job. We must forbid gcc to generate any vdsp & fpu instructions
and remove vdsp asm in memmove.S.

eg: For GCC it's -mcpu=ck860 and For AS it's -Wa,-mcpu=ck860fv

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Makefile        | 2 +-
 arch/csky/abiv2/memmove.S | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 3607a6e..6b87f6c 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -36,7 +36,7 @@ endif
 
 ifneq ($(CSKYABI),)
 MCPU_STR = $(CPUTYPE)$(FPUEXT)$(VDSPEXT)$(TEEEXT)
-KBUILD_CFLAGS += -mcpu=$(MCPU_STR)
+KBUILD_CFLAGS += -mcpu=$(CPUTYPE) -Wa,-mcpu=$(MCPU_STR)
 KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(MCPU_STR)\"
 KBUILD_CFLAGS += -msoft-float -mdiv
 KBUILD_CFLAGS += -fno-tree-vectorize
diff --git a/arch/csky/abiv2/memmove.S b/arch/csky/abiv2/memmove.S
index b0c42ec..5721e73 100644
--- a/arch/csky/abiv2/memmove.S
+++ b/arch/csky/abiv2/memmove.S
@@ -35,11 +35,7 @@ ENTRY(memmove)
 .L_len_larger_16bytes:
 	subi	r1, 16
 	subi	r0, 16
-#if defined(__CSKY_VDSPV2__)
-	vldx.8	vr0, (r1), r19
-	PRE_BNEZAD (r18)
-	vstx.8	vr0, (r0), r19
-#elif defined(__CK860__)
+#if defined(__CK860__)
 	ldw	r3, (r1, 12)
 	stw	r3, (r0, 12)
 	ldw	r3, (r1, 8)
-- 
2.7.4

