Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF90AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8386820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8386820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeKJDO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:14:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61296 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJDO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:14:57 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42s6gc3V0cz9v0XS;
        Fri,  9 Nov 2018 18:33:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nIG8Q7boi-mB; Fri,  9 Nov 2018 18:33:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42s6gc2rDdz9v0XL;
        Fri,  9 Nov 2018 18:33:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FA8A8B899;
        Fri,  9 Nov 2018 18:33:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AFLDbTZemEiJ; Fri,  9 Nov 2018 18:33:22 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DFD78B887;
        Fri,  9 Nov 2018 18:33:22 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0F9A769A2A; Fri,  9 Nov 2018 17:33:22 +0000 (UTC)
Message-Id: <d011001c94681a20a0c836ae3a9bf5e4f4d7a38e.1541784640.git.christophe.leroy@c-s.fr>
In-Reply-To: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
References: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/9] powerpc/book3s/32: Use MMU_FTR_HPTE_TABLE in head_32.S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  9 Nov 2018 17:33:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually patching a blr at hash_page() entry in
MMU_init_hw(), this patch adds a features section in head_32.S

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S |  4 ++++
 arch/powerpc/mm/ppc_mmu_32.c  | 12 +-----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 61ca27929355..068c1656c758 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -393,7 +393,9 @@ DataAccess:
 	bne	1f			/* if not, try to put a PTE */
 	mfspr	r4,SPRN_DAR		/* into the hash table */
 	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
+BEGIN_MMU_FTR_SECTION
 	bl	hash_page
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 1:	lwz	r5,_DSISR(r11)		/* get DSISR value */
 	mfspr	r4,SPRN_DAR
 	EXC_XFER_LITE(0x300, handle_page_fault)
@@ -408,7 +410,9 @@ InstructionAccess:
 	beq	1f			/* if so, try to put a PTE */
 	li	r3,0			/* into the hash table */
 	mr	r4,r12			/* SRR0 is fault address */
+BEGIN_MMU_FTR_SECTION
 	bl	hash_page
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 1:	mr	r4,r12
 	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
 	EXC_XFER_LITE(0x400, handle_page_fault)
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f6f575bae3bc..3c7c73defcb6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -184,20 +184,10 @@ void __init MMU_init_hw(void)
 
 	extern unsigned int hash_page_patch_A[];
 	extern unsigned int hash_page_patch_B[], hash_page_patch_C[];
-	extern unsigned int hash_page[];
 	extern unsigned int flush_hash_patch_A[], flush_hash_patch_B[];
 
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
-		/*
-		 * Put a blr (procedure return) instruction at the
-		 * start of hash_page, since we can still get DSI
-		 * exceptions on a 603.
-		 */
-		hash_page[0] = 0x4e800020;
-		flush_icache_range((unsigned long) &hash_page[0],
-				   (unsigned long) &hash_page[1]);
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
 		return;
-	}
 
 	if ( ppc_md.progress ) ppc_md.progress("hash:enter", 0x105);
 
-- 
2.13.3

