Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBAE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Td3IY9wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfBUKiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:38:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63586 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbfBUKiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:38:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444rXT6qs2z9v3pB;
        Thu, 21 Feb 2019 11:38:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Td3IY9wJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OtGvk8QHHNcn; Thu, 21 Feb 2019 11:38:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444rXT5prCz9v3p9;
        Thu, 21 Feb 2019 11:38:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550745481; bh=PflQifAIraZoHsFcRSkbPTHUo33jek0bAeupHuGm5nM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Td3IY9wJPF6E4u8XdmR3Qa5+hjvDZmKOHcnP/GMTpTxxhBqr/hm8nha/fjngSsuck
         4zzvCK3VygkbMejzIVp3G0u9c7lzpSyfSvI2qg3VxyCqIrTxk0ysbSyC8bH1JLYMup
         ccOm9DR8k5eHQ6kCWUO7w26nzeODcS970Sno+wo8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2E148B859;
        Thu, 21 Feb 2019 11:38:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3CSJyyRfmPZm; Thu, 21 Feb 2019 11:38:02 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2F658B852;
        Thu, 21 Feb 2019 11:38:02 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 808166E856; Thu, 21 Feb 2019 10:38:02 +0000 (UTC)
Message-Id: <34d3f85fce395f3d924a2ad1ade1a74de616b83c.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/10] powerpc/603: don't handle PAGE_ACCESSED in TLB miss
 handlers.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 10:38:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_ACCESSED is only needed for CONFIG_SWAP. When CONFIG_SWAP
is not set, just ignore it. If CONFIG_SWAP is set and PAGE_ACCESSED
is not, let's take a minor fault.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 6b5cb7551a72..fdb587c96a80 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -503,7 +503,11 @@ InstructionTLBMiss:
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SPRG_PGDIR
+#ifdef CONFIG_SWAP
+	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
+#else
 	li	r1,_PAGE_PRESENT | _PAGE_EXEC
+#endif
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	bge-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
@@ -517,12 +521,6 @@ InstructionTLBMiss:
 	lwz	r0,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
-	ori	r0,r0,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */
-	/*
-	 * NOTE! We are assuming this is not an SMP system, otherwise
-	 * we would need to update the pte atomically with lwarx/stwcx.
-	 */
-	stw	r0,0(r2)		/* update PTE (accessed bit) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	ori	r1, r1, 0xe05		/* clear out reserved bits */
@@ -571,7 +569,11 @@ DataLoadTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
+#ifdef CONFIG_SWAP
+	li	r1, _PAGE_PRESENT | _PAGE_ACCESSED
+#else
 	li	r1, _PAGE_PRESENT
+#endif
 	bge-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
@@ -583,12 +585,10 @@ DataLoadTLBMiss:
 	lwz	r0,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
-	ori	r0,r0,_PAGE_ACCESSED	/* set _PAGE_ACCESSED in pte */
 	/*
 	 * NOTE! We are assuming this is not an SMP system, otherwise
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
-	stw	r0,0(r2)		/* update PTE (accessed bit) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
 	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
@@ -649,7 +649,11 @@ DataStoreTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
-	li	r1, _PAGE_RW | _PAGE_PRESENT /* access flags */
+#ifdef CONFIG_SWAP
+	li	r1, _PAGE_RW | _PAGE_PRESENT | _PAGE_ACCESSED
+#else
+	li	r1, _PAGE_RW | _PAGE_PRESENT
+#endif
 	bge-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
@@ -661,12 +665,10 @@ DataStoreTLBMiss:
 	lwz	r0,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
-	ori	r0,r0,_PAGE_ACCESSED
 	/*
 	 * NOTE! We are assuming this is not an SMP system, otherwise
 	 * we would need to update the pte atomically with lwarx/stwcx.
 	 */
-	stw	r0,0(r2)		/* update PTE (accessed/dirty bits) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	li	r1,0xe05		/* clear out reserved bits & PP lsb */
-- 
2.13.3

