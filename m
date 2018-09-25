Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D47C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C100C2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C100C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeIYW7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:59:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63218 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbeIYW7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:59:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KRsP0Wfhz9ttCS;
        Tue, 25 Sep 2018 18:50:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gDQ6P5vdnUf9; Tue, 25 Sep 2018 18:50:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KRsP02qLz9ttCN;
        Tue, 25 Sep 2018 18:50:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BDB38B7E5;
        Tue, 25 Sep 2018 18:50:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fEDUTEU5jcfq; Tue, 25 Sep 2018 18:50:48 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AEAEF8B7C8;
        Tue, 25 Sep 2018 18:50:48 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8193F70AFE; Tue, 25 Sep 2018 16:50:48 +0000 (UTC)
Message-Id: <60c0f3b871bba32a4e3ddb4c93b3543fd6a7973c.1537892498.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 05/22] powerpc/8xx: Move SW perf counters in first 32kb of
 memory
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Sep 2018 16:50:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simplify time critical exceptions handling 8xx
specific SW perf counters, this patch moves the counters into
the beginning of memory. This is possible because .text is readable
and the counters are never modified outside of the handlers.

By doing this, we avoid having to set a second register with
the upper part of the address of the counters.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 58 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3b67b9533c82..c203defe49a4 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -106,6 +106,23 @@ turn_on_mmu:
 	mtspr	SPRN_SRR0,r0
 	rfi				/* enables MMU */
 
+
+#ifdef CONFIG_PERF_EVENTS
+	.align	4
+
+	.globl	itlb_miss_counter
+itlb_miss_counter:
+	.space	4
+
+	.globl	dtlb_miss_counter
+dtlb_miss_counter:
+	.space	4
+
+	.globl	instruction_counter
+instruction_counter:
+	.space	4
+#endif
+
 /*
  * Exception entry code.  This code runs with address translation
  * turned off, i.e. using physical addresses.
@@ -384,17 +401,16 @@ InstructionTLBMiss:
 
 #ifdef CONFIG_PERF_EVENTS
 	patch_site	0f, patch__itlbmiss_perf
-0:	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
+0:	lwz	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
+#endif
 
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
@@ -509,15 +525,14 @@ DataStoreTLBMiss:
 
 #ifdef CONFIG_PERF_EVENTS
 	patch_site	0f, patch__dtlbmiss_perf
-0:	lis	r10, (dtlb_miss_counter - PAGE_OFFSET)@ha
-	lwz	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, 1
-	stw	r11, (dtlb_miss_counter - PAGE_OFFSET)@l(r10)
-#endif
+0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
+#endif
 
 #ifdef CONFIG_HUGETLB_PAGE
 10:	/* 8M pages */
@@ -625,16 +640,13 @@ DataBreakpoint:
 	. = 0x1d00
 InstructionBreakpoint:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-	lis	r10, (instruction_counter - PAGE_OFFSET)@ha
-	lwz	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
-	addi	r11, r11, -1
-	stw	r11, (instruction_counter - PAGE_OFFSET)@l(r10)
+	lwz	r10, (instruction_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, -1
+	stw	r10, (instruction_counter - PAGE_OFFSET)@l(0)
 	lis	r10, 0xffff
 	ori	r10, r10, 0x01
 	mtspr	SPRN_COUNTA, r10
 	mfspr	r10, SPRN_SPRG_SCRATCH0
-	mfspr	r11, SPRN_SPRG_SCRATCH1
 	rfi
 #else
 	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
@@ -1065,17 +1077,3 @@ swapper_pg_dir:
  */
 abatron_pteptrs:
 	.space	8
-
-#ifdef CONFIG_PERF_EVENTS
-	.globl	itlb_miss_counter
-itlb_miss_counter:
-	.space	4
-
-	.globl	dtlb_miss_counter
-dtlb_miss_counter:
-	.space	4
-
-	.globl	instruction_counter
-instruction_counter:
-	.space	4
-#endif
-- 
2.13.3

