Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3637FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0455220880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PChYG3uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfBUKiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:38:15 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30004 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfBUKiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:38:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444rXS65TLz9v3pC;
        Thu, 21 Feb 2019 11:38:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PChYG3uV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 42vO8L3iKy91; Thu, 21 Feb 2019 11:38:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444rXS54B5z9v3p9;
        Thu, 21 Feb 2019 11:38:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550745480; bh=vto19QmGp+esAtJoRSg+SmW1fpzZW/xknQU3Ddxjfgg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=PChYG3uV031YS9QO9wCoYvUifYVb8HfUk19li9mqESdo2vBeDYtovRt3fKT5PxrL4
         k3oZTebw3l/N/5GomD0l8zqQycJ0JCCHv4iP+6L5ONxQ+Myh6vbpUNVKbdSGblM8SX
         EoLXd6ocM8g91XYRZWGLPEg+n9lO7jNDVq4mQLKw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D702E8B859;
        Thu, 21 Feb 2019 11:38:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KWcBEim3jbxY; Thu, 21 Feb 2019 11:38:01 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABABD8B852;
        Thu, 21 Feb 2019 11:38:01 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 7ADE86E856; Thu, 21 Feb 2019 10:38:01 +0000 (UTC)
Message-Id: <376b3b491bfe86c1728063f541911ac3fe982565.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/10] powerpc/603: Don't worry about _PAGE_USER in TLB
 miss handlers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 10:38:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PP bits take user access into account, so no need to check _PAGE_USER
here. A DSI or ISI will be generated if needed.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index b071f328b4b0..6b5cb7551a72 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -503,11 +503,9 @@ InstructionTLBMiss:
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SPRG_PGDIR
-	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
+	li	r1,_PAGE_PRESENT | _PAGE_EXEC
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	bge-	112f
-	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 #endif
@@ -573,10 +571,8 @@ DataLoadTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
-	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
+	li	r1, _PAGE_PRESENT
 	bge-	112f
-	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
@@ -653,10 +649,8 @@ DataStoreTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_PGDIR
-	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
+	li	r1, _PAGE_RW | _PAGE_PRESENT /* access flags */
 	bge-	112f
-	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
-- 
2.13.3

