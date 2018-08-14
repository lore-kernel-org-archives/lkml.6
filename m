Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA05AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CB221653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CB221653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeHNRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:42:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33949 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbeHNRmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:42:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41qbGr5Xtlz9tvSs;
        Tue, 14 Aug 2018 16:54:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NeEeSHCU7eDR; Tue, 14 Aug 2018 16:54:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41qbGr4zMlz9tvSn;
        Tue, 14 Aug 2018 16:54:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B0468B7D6;
        Tue, 14 Aug 2018 16:54:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0WQH0ms2gBKR; Tue, 14 Aug 2018 16:54:44 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C1F0E8B7D4;
        Tue, 14 Aug 2018 16:54:44 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A304D71288; Tue, 14 Aug 2018 14:54:44 +0000 (UTC)
Message-Id: <7cebab88809de00ed42086512ae790c0d3e4e2f1.1534258290.git.christophe.leroy@c-s.fr>
In-Reply-To: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/4] powerpc/mm: replace hugetlb_cache by
 PGT_CACHE(PTE_T_ORDER)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Aug 2018 14:54:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of opencoding cache handling for the special case
of hugepage tables having a single pte_t element, this
patch makes use of the common pgtable_cache helpers

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h |  2 --
 arch/powerpc/mm/hugetlbpage.c      | 26 +++++++-------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 2d00cc530083..e13843556414 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -6,8 +6,6 @@
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
 
-extern struct kmem_cache *hugepte_cache;
-
 #ifdef CONFIG_PPC_BOOK3S_64
 
 #include <asm/book3s/64/hugetlb.h>
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7296a42eb62e..53b7a605c3a8 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -43,6 +43,8 @@ EXPORT_SYMBOL(HPAGE_SHIFT);
 
 #define hugepd_none(hpd)	(hpd_val(hpd) == 0)
 
+#define PTE_T_ORDER	(__builtin_ffs(sizeof(pte_t)) - __builtin_ffs(sizeof(void *)))
+
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
 	/*
@@ -62,7 +64,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	int num_hugepd;
 
 	if (pshift >= pdshift) {
-		cachep = hugepte_cache;
+		cachep = PGT_CACHE(PTE_T_ORDER);
 		num_hugepd = 1 << (pshift - pdshift);
 	} else {
 		cachep = PGT_CACHE(pdshift - pshift);
@@ -265,7 +267,7 @@ static void hugepd_free_rcu_callback(struct rcu_head *head)
 	unsigned int i;
 
 	for (i = 0; i < batch->index; i++)
-		kmem_cache_free(hugepte_cache, batch->ptes[i]);
+		kmem_cache_free(PGT_CACHE(PTE_T_ORDER), batch->ptes[i]);
 
 	free_page((unsigned long)batch);
 }
@@ -278,7 +280,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
 	    mm_is_thread_local(tlb->mm)) {
-		kmem_cache_free(hugepte_cache, hugepte);
+		kmem_cache_free(PGT_CACHE(PTE_T_ORDER), hugepte);
 		put_cpu_var(hugepd_freelist_cur);
 		return;
 	}
@@ -653,7 +655,6 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
-struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
 	int psize;
@@ -703,21 +704,8 @@ static int __init hugetlbpage_init(void)
 		if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift, NULL);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-		else if (!hugepte_cache) {
-			/*
-			 * Create a kmem cache for hugeptes.  The bottom bits in
-			 * the pte have size information encoded in them, so
-			 * align them to allow this
-			 */
-			hugepte_cache = kmem_cache_create("hugepte-cache",
-							  sizeof(pte_t),
-							  HUGEPD_SHIFT_MASK + 1,
-							  0, NULL);
-			if (hugepte_cache == NULL)
-				panic("%s: Unable to create kmem cache "
-				      "for hugeptes\n", __func__);
-
-		}
+		else
+			pgtable_cache_add(PTE_T_ORDER, NULL);
 #endif
 	}
 
-- 
2.13.3

