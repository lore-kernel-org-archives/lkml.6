Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E2CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259B0214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259B0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeIRWbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:31:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40298 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbeIRWa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42F8LM5r2wz9ttRc;
        Tue, 18 Sep 2018 18:57:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FvMhvnGGkfUK; Tue, 18 Sep 2018 18:57:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42F8LM5K5Bz9ttRb;
        Tue, 18 Sep 2018 18:57:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A94E8B80B;
        Tue, 18 Sep 2018 18:57:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2TI3EpiwCcyp; Tue, 18 Sep 2018 18:57:31 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42CAE8B7F9;
        Tue, 18 Sep 2018 18:57:31 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E0CD07192E; Tue, 18 Sep 2018 16:57:30 +0000 (UTC)
Message-Id: <5c81cd04d83063ab603f5925db1859c2c9254ca7.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 14/20] powerpc/mm: Move pte_fragment_alloc() to a common
 location
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Sep 2018 16:57:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of next patch which generalises the use of
pte_fragment_alloc() for all, this patch moves the related functions
in a place that is common to all subarches.

The 8xx will need that for supporting 16k pages, as in that mode
page tables still have a size of 4k.

Since pte_fragment with only once fragment is not different
from what is done in the general case, we can easily migrate all
subarchs to pte fragments.

For the time being, it is only code move. We enclose it inside

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile               |   4 +-
 arch/powerpc/mm/mmu_context.c          |   1 -
 arch/powerpc/mm/mmu_context_book3s64.c |  67 -------------
 arch/powerpc/mm/pgtable-book3s64.c     |  85 -----------------
 arch/powerpc/mm/pgtable-frag.c         | 167 +++++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+), 154 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable-frag.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c844bdd16c4..bd43b3ee52cb 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -15,7 +15,9 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o \
+				   $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o \
+				   pgtable-frag.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index f84e14f23e50..b89e7dcc14cc 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -96,4 +96,3 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	switch_mmu_context(prev, next, tsk);
 }
-
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index dbd8f762140b..417b0cb67584 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -155,50 +155,6 @@ static void destroy_contexts(mm_context_t *ctx)
 	}
 }
 
-static void pte_frag_destroy(void *pte_frag)
-{
-	int count;
-	struct page *page;
-
-	page = virt_to_page(pte_frag);
-	/* drop all the pending references */
-	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
-	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_page_dtor(page);
-		__free_page(page);
-	}
-}
-
-static void pmd_frag_destroy(void *pmd_frag)
-{
-	int count;
-	struct page *page;
-
-	page = virt_to_page(pmd_frag);
-	/* drop all the pending references */
-	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
-	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
-		pgtable_pmd_page_dtor(page);
-		__free_page(page);
-	}
-}
-
-static void destroy_pagetable_cache(struct mm_struct *mm)
-{
-	void *frag;
-
-	frag = mm->context.pte_frag;
-	if (frag)
-		pte_frag_destroy(frag);
-
-	frag = mm->context.pmd_frag;
-	if (frag)
-		pmd_frag_destroy(frag);
-	return;
-}
-
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
@@ -212,29 +168,6 @@ void destroy_context(struct mm_struct *mm)
 	mm->context.id = MMU_NO_CONTEXT;
 }
 
-void arch_exit_mmap(struct mm_struct *mm)
-{
-	destroy_pagetable_cache(mm);
-
-	if (radix_enabled()) {
-		/*
-		 * Radix doesn't have a valid bit in the process table
-		 * entries. However we know that at least P9 implementation
-		 * will avoid caching an entry with an invalid RTS field,
-		 * and 0 is invalid. So this will do.
-		 *
-		 * This runs before the "fullmm" tlb flush in exit_mmap,
-		 * which does a RIC=2 tlbie to clear the process table
-		 * entry. See the "fullmm" comments in tlb-radix.c.
-		 *
-		 * No barrier required here after the store because
-		 * this process will do the invalidate, which starts with
-		 * ptesync.
-		 */
-		process_tb[mm->context.id].prtb0 = 0;
-	}
-}
-
 #ifdef CONFIG_PPC_RADIX_MMU
 void radix__switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 01d7c0f7c4f0..723cd324fa34 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -317,91 +317,6 @@ void pmd_fragment_free(unsigned long *pmd)
 	}
 }
 
-static pte_t *get_pte_from_cache(struct mm_struct *mm)
-{
-	void *pte_frag, *ret;
-
-	spin_lock(&mm->page_table_lock);
-	ret = mm->context.pte_frag;
-	if (ret) {
-		pte_frag = ret + PTE_FRAG_SIZE;
-		/*
-		 * If we have taken up all the fragments mark PTE page NULL
-		 */
-		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
-			pte_frag = NULL;
-		mm->context.pte_frag = pte_frag;
-	}
-	spin_unlock(&mm->page_table_lock);
-	return (pte_t *)ret;
-}
-
-static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
-{
-	void *ret = NULL;
-	struct page *page;
-
-	if (!kernel) {
-		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
-		if (!page)
-			return NULL;
-		if (!pgtable_page_ctor(page)) {
-			__free_page(page);
-			return NULL;
-		}
-	} else {
-		page = alloc_page(PGALLOC_GFP);
-		if (!page)
-			return NULL;
-	}
-
-	atomic_set(&page->pt_frag_refcount, 1);
-
-	ret = page_address(page);
-	/*
-	 * if we support only one fragment just return the
-	 * allocated page.
-	 */
-	if (PTE_FRAG_NR == 1)
-		return ret;
-	spin_lock(&mm->page_table_lock);
-	/*
-	 * If we find pgtable_page set, we return
-	 * the allocated page with single fragement
-	 * count.
-	 */
-	if (likely(!mm->context.pte_frag)) {
-		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
-		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
-	}
-	spin_unlock(&mm->page_table_lock);
-
-	return (pte_t *)ret;
-}
-
-pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
-{
-	pte_t *pte;
-
-	pte = get_pte_from_cache(mm);
-	if (pte)
-		return pte;
-
-	return __alloc_for_ptecache(mm, kernel);
-}
-
-void pte_fragment_free(unsigned long *table, int kernel)
-{
-	struct page *page = virt_to_page(table);
-
-	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
-	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
-		if (!kernel)
-			pgtable_page_dtor(page);
-		__free_page(page);
-	}
-}
-
 static inline void pgtable_free(void *table, int index)
 {
 	switch (index) {
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
new file mode 100644
index 000000000000..bc924822dcd6
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  Handling Page Tables through page fragments
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <linux/hugetlb.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+
+static void pte_frag_destroy(void *pte_frag)
+{
+	int count;
+	struct page *page;
+
+	page = virt_to_page(pte_frag);
+	/* drop all the pending references */
+	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
+	/* We allow PTE_FRAG_NR fragments from a PTE page */
+	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
+		pgtable_page_dtor(page);
+		__free_page(page);
+	}
+}
+
+static void pmd_frag_destroy(void *pmd_frag)
+{
+	int count;
+	struct page *page;
+
+	page = virt_to_page(pmd_frag);
+	/* drop all the pending references */
+	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
+	/* We allow PTE_FRAG_NR fragments from a PTE page */
+	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
+		pgtable_pmd_page_dtor(page);
+		__free_page(page);
+	}
+}
+
+static void destroy_pagetable_cache(struct mm_struct *mm)
+{
+	void *frag;
+
+	frag = mm->context.pte_frag;
+	if (frag)
+		pte_frag_destroy(frag);
+
+	frag = mm->context.pmd_frag;
+	if (frag)
+		pmd_frag_destroy(frag);
+}
+
+void arch_exit_mmap(struct mm_struct *mm)
+{
+	destroy_pagetable_cache(mm);
+
+	if (radix_enabled()) {
+		/*
+		 * Radix doesn't have a valid bit in the process table
+		 * entries. However we know that at least P9 implementation
+		 * will avoid caching an entry with an invalid RTS field,
+		 * and 0 is invalid. So this will do.
+		 *
+		 * This runs before the "fullmm" tlb flush in exit_mmap,
+		 * which does a RIC=2 tlbie to clear the process table
+		 * entry. See the "fullmm" comments in tlb-radix.c.
+		 *
+		 * No barrier required here after the store because
+		 * this process will do the invalidate, which starts with
+		 * ptesync.
+		 */
+		process_tb[mm->context.id].prtb0 = 0;
+	}
+}
+
+static pte_t *get_pte_from_cache(struct mm_struct *mm)
+{
+	void *pte_frag, *ret;
+
+	spin_lock(&mm->page_table_lock);
+	ret = mm->context.pte_frag;
+	if (ret) {
+		pte_frag = ret + PTE_FRAG_SIZE;
+		/*
+		 * If we have taken up all the fragments mark PTE page NULL
+		 */
+		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
+			pte_frag = NULL;
+		mm->context.pte_frag = pte_frag;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return (pte_t *)ret;
+}
+
+static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
+{
+	void *ret = NULL;
+	struct page *page;
+
+	if (!kernel) {
+		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
+		if (!page)
+			return NULL;
+		if (!pgtable_page_ctor(page)) {
+			__free_page(page);
+			return NULL;
+		}
+	} else {
+		page = alloc_page(PGALLOC_GFP);
+		if (!page)
+			return NULL;
+	}
+
+	atomic_set(&page->pt_frag_refcount, 1);
+
+	ret = page_address(page);
+	/*
+	 * if we support only one fragment just return the
+	 * allocated page.
+	 */
+	if (PTE_FRAG_NR == 1)
+		return ret;
+	spin_lock(&mm->page_table_lock);
+	/*
+	 * If we find pgtable_page set, we return
+	 * the allocated page with single fragement
+	 * count.
+	 */
+	if (likely(!mm->context.pte_frag)) {
+		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
+		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
+	}
+	spin_unlock(&mm->page_table_lock);
+
+	return (pte_t *)ret;
+}
+
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
+{
+	pte_t *pte;
+
+	pte = get_pte_from_cache(mm);
+	if (pte)
+		return pte;
+
+	return __alloc_for_ptecache(mm, kernel);
+}
+
+void pte_fragment_free(unsigned long *table, int kernel)
+{
+	struct page *page = virt_to_page(table);
+
+	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
+		if (!kernel)
+			pgtable_page_dtor(page);
+		__free_page(page);
+	}
+}
-- 
2.13.3

