Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C4DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA80208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA80208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeK3BMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:12:51 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61849 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbeK3BMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:12:50 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 435K8l49hKz9vGF4;
        Thu, 29 Nov 2018 15:07:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SpS-bAsIITvC; Thu, 29 Nov 2018 15:07:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 435K8l3hsJz9vGDm;
        Thu, 29 Nov 2018 15:07:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C4FCF8B8A1;
        Thu, 29 Nov 2018 15:07:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id x35CBJUYNZUW; Thu, 29 Nov 2018 15:07:20 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46FB88B899;
        Thu, 29 Nov 2018 15:07:20 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E86FA69AE8; Thu, 29 Nov 2018 14:07:19 +0000 (UTC)
Message-Id: <7f705dc6b125f0f8147258a97fe6a61277702db4.1543499865.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543499860.git.christophe.leroy@c-s.fr>
References: <cover.1543499860.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 17/20] powerpc/8xx: Enable 512k hugepage support with HW
 assistance
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 29 Nov 2018 14:07:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For using 512k pages with hardware assistance, the PTEs have to be spread
every 128 bytes in the L2 table.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h |  4 +++-
 arch/powerpc/mm/hugetlbpage.c      | 10 +++++++++-
 arch/powerpc/mm/tlb_nohash.c       |  3 +++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index dfb8bf236586..62a0ca02ca7d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -74,7 +74,9 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 	unsigned long idx = 0;
 
 	pte_t *dir = hugepd_page(hpd);
-#ifndef CONFIG_PPC_FSL_BOOK3E
+#ifdef CONFIG_PPC_8xx
+	idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
+#elif !defined(CONFIG_PPC_FSL_BOOK3E)
 	idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
 #endif
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bc97874d7c74..5b236621d302 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -65,6 +65,9 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (pshift >= pdshift) {
 		cachep = PGT_CACHE(PTE_T_ORDER);
 		num_hugepd = 1 << (pshift - pdshift);
+	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
+		cachep = PGT_CACHE(PTE_INDEX_SIZE);
+		num_hugepd = 1;
 	} else {
 		cachep = PGT_CACHE(pdshift - pshift);
 		num_hugepd = 1;
@@ -331,6 +334,9 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 
 	if (shift >= pdshift)
 		hugepd_free(tlb, hugepte);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		pgtable_free_tlb(tlb, hugepte,
+				 get_hugepd_cache_index(PTE_INDEX_SIZE));
 	else
 		pgtable_free_tlb(tlb, hugepte,
 				 get_hugepd_cache_index(pdshift - shift));
@@ -700,7 +706,9 @@ static int __init hugetlbpage_init(void)
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
 		 */
-		if (pdshift > shift)
+		if (pdshift > shift && IS_ENABLED(CONFIG_PPC_8xx))
+			pgtable_cache_add(PTE_INDEX_SIZE);
+		else if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 8ad7aab150b7..ae5d568e267f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -97,6 +97,9 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 14,
 	},
 #endif
+	[MMU_PAGE_512K] = {
+		.shift	= 19,
+	},
 	[MMU_PAGE_8M] = {
 		.shift	= 23,
 	},
-- 
2.13.3

