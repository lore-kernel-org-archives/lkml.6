Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04CB208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeK3BM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:12:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23796 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbeK3BM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:12:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 435K8s5nJSz9vGDx;
        Thu, 29 Nov 2018 15:07:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id feqpjw5bviaR; Thu, 29 Nov 2018 15:07:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 435K8s5GSTz9vGDm;
        Thu, 29 Nov 2018 15:07:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C4D1E8B89E;
        Thu, 29 Nov 2018 15:07:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RL2qu4EkOaxd; Thu, 29 Nov 2018 15:07:26 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7578B8B899;
        Thu, 29 Nov 2018 15:07:26 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0EB9F69AE8; Thu, 29 Nov 2018 14:07:26 +0000 (UTC)
Message-Id: <c1ee119fe530ed5f23f4253703bfd0b7ab8dfe30.1543499865.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543499860.git.christophe.leroy@c-s.fr>
References: <cover.1543499860.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 20/20] powerpc/8xx: regroup TLB handler routines
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 29 Nov 2018 14:07:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this is running with MMU off, the CPU only does speculative
fetch for code in the same page.

Following the significant size reduction of TLB handler routines,
the side handlers can be brought back close to the main part,
ie in the same page.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 112 ++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 0a4f8a9c85ff..b171b7c0a0e7 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -399,6 +399,23 @@ InstructionTLBMiss:
 	rfi
 #endif
 
+#ifndef CONFIG_PIN_TLB_TEXT
+ITLBMissLinear:
+	mtcr	r11
+	/* Set 8M byte page and mark it valid */
+	li	r11, MI_PS8MEG | MI_SVALID
+	mtspr	SPRN_MI_TWC, r11
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
+			  _PAGE_PRESENT
+	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
+
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+	patch_site	0b, patch__itlbmiss_exit_2
+#endif
+
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
@@ -484,6 +501,43 @@ DataStoreTLBMiss:
 	rfi
 #endif
 
+DTLBMissIMMR:
+	mtcr	r11
+	/* Set 512k byte guarded page and mark it valid */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
+	mtspr	SPRN_MD_TWC, r10
+	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
+	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
+			  _PAGE_PRESENT | _PAGE_NO_CACHE
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+	patch_site	0b, patch__dtlbmiss_exit_2
+
+DTLBMissLinear:
+	mtcr	r11
+	/* Set 8M byte page and mark it valid */
+	li	r11, MD_PS8MEG | MD_SVALID
+	mtspr	SPRN_MD_TWC, r11
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
+			  _PAGE_PRESENT
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+
+0:	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+	patch_site	0b, patch__dtlbmiss_exit_3
+
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -583,64 +637,6 @@ InstructionBreakpoint:
 
 	. = 0x2000
 
-/*
- * Bottom part of DataStoreTLBMiss handlers for IMMR area and linear RAM.
- * not enough space in the DataStoreTLBMiss area.
- */
-DTLBMissIMMR:
-	mtcr	r11
-	/* Set 512k byte guarded page and mark it valid */
-	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
-	mtspr	SPRN_MD_TWC, r10
-	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
-	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
-			  _PAGE_PRESENT | _PAGE_NO_CACHE
-	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
-	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-	patch_site	0b, patch__dtlbmiss_exit_2
-
-DTLBMissLinear:
-	mtcr	r11
-	/* Set 8M byte page and mark it valid */
-	li	r11, MD_PS8MEG | MD_SVALID
-	mtspr	SPRN_MD_TWC, r11
-	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
-			  _PAGE_PRESENT
-	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-
-	li	r11, RPN_PATTERN
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-	patch_site	0b, patch__dtlbmiss_exit_3
-
-#ifndef CONFIG_PIN_TLB_TEXT
-ITLBMissLinear:
-	mtcr	r11
-	/* Set 8M byte page and mark it valid */
-	li	r11, MI_PS8MEG | MI_SVALID
-	mtspr	SPRN_MI_TWC, r11
-	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
-			  _PAGE_PRESENT
-	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
-
-0:	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
-	rfi
-	patch_site	0b, patch__itlbmiss_exit_2
-#endif
-
 /* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
  * by decoding the registers used by the dcbx instruction and adding them.
  * DAR is set to the calculated address.
-- 
2.13.3

