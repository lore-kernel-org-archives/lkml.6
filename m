Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C500ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265152147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTFxFSxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265152147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeIQGMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:12:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42653 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeIQGMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:12:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so6810406pgp.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUOk0eURMaVrGevtRNtoWaQ2AqVBj2VfBwf6zuc4npM=;
        b=vTFxFSxE/SrM5MkfTvcmHSeSFPyOftzzFnQ7jUEcMNrIb/86nig1pe7sNQrwfeTTjB
         Id9JkksKgdedvEl59mmsggULNYama0MIYxPnKcoZQffUYKW+0zP31RcA3N/vRsrLoGIQ
         drVBSEcfkGKkOx3g3JgP1aDL6C4+alpQB8TzbA0kwDqdcsujsS4l20YWje2CTQvPqvBZ
         57DLmmUBt4JynKvHm0c3KOecZHlonPcM6xlVJf35hbnHil6C87ZCqMCd7+ob9GMnMCeg
         DGvWdrbUI3QZ+sK+Yz8QKxfVA5gndK0bQJuaDnC5G2eqJMxKFRl+moIfRbLYmrCCFeQ9
         oyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BUOk0eURMaVrGevtRNtoWaQ2AqVBj2VfBwf6zuc4npM=;
        b=SmtzHIu2k2TpMprWelwFnMISlDzNlm8RBFUI/01eEETW0JtZxwZWtB01IDhjoiYWd3
         iKi2Fh571ZQlAJjs7Tdw+lzR09lBcsJ7YirAPK3bRH1lvMS28zYsw4xljFD/dryx++LK
         v4DH/+GA1AxRlwnappvZTCRM97Tmd3nvrsg3Cot2AOAzQig19Vj4yJsvhuKOct1hmjf4
         2x5qEF/GUUoYHVhQkM9OuzTQWJ4DQAaP+H0tAfUgp7JSDb1PxfFFGnD4ksNTiNMeXzsX
         5o0lhfBSg0TAd7P0mHCWtWLYK/MJoXwWPU9AKiz3eGlBmej1mD2wjxlqjw0ZbvbSGEMQ
         TyTg==
X-Gm-Message-State: APzg51A+ZQzJDv16qsfK325F9ALVkl88XH0bxQsNzoyC1D0reOOfneeT
        ksriHgH7clzBfue9m94pK58=
X-Google-Smtp-Source: ANB0VdZ7S01PIfKyVKXifmLkakjimPZscEDEyp9HxziGzAt1wZ8jvnsW7QtvFB/j2B185tMFn4PZ3Q==
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr21228178pgr.157.1537145229044;
        Sun, 16 Sep 2018 17:47:09 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id w16-v6sm29311503pfi.101.2018.09.16.17.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:47:07 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        miles.chen@mediatek.com, jian-min.lui@mediatek.com,
        juju.sung@mediatek.com, Minchan Kim <minchan@kernel.org>,
        Simon Horman <horms@verge.net.au>
Subject: [PATCH v1 1/3] arm: mm: reordering memory type table
Date:   Mon, 17 Sep 2018 09:44:49 +0900
Message-Id: <20180917004451.174527-2-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917004451.174527-1-minchan@kernel.org>
References: <20180917004451.174527-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use bit 5 in page table as L_PTE_SPECIAL, we need a room for that.
It seems we don't need 4 bits for the memory type with ARMv6+.
If it's true, let's reorder bits to make bit 5 free.

We will use the bit for L_PTE_SPECIAL in next patch.

A note from Catalin
"
> Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> shared device in hardware. Looking through the arm32 code, it seems that
> MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on shmbile).
"

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/include/asm/pgtable-2level.h | 19 +++++++++++++++----
 arch/arm/mm/proc-macros.S             |  4 ++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8a9af0..514b13c27b43 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -164,14 +164,25 @@
 #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
 #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
 #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
+#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
+#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
 #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
 #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
-#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
-#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#if defined(CONFIG_CPU_V7) || defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
+/*
+ * On ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
+ * shared device in hardware.
+ */
+#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_DEV_SHARED
+#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
+#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
+#define L_PTE_MT_MASK		(_AT(pteval_t, 0x07) << 2)
+#else
 #define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
 #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
-#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
-#define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
+#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#define L_PTE_MT_MASK           (_AT(pteval_t, 0x0f) << 2)
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 81d0efb055c6..367a89d5aeca 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -138,7 +138,7 @@
 	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
 	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
 	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
+	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
 	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
 	.long	0x00						@ unused
@@ -148,7 +148,7 @@
 	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
 	.long	0x00						@ unused
 	.long	0x00						@ unused
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
+	.long	0x00						@ unused
 	.endm
 
 	.macro	armv6_set_pte_ext pfx
-- 
2.19.0.397.gdd90340f6a-goog

