Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944ECC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD9214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2DnjqfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDD9214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeIZSHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeIZSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+pldmGqd3JjO/U8GcilPsAczLWXeONB6ja/7zhAvKSU=; b=Y2DnjqfMTbp9shgseYYmzfFKUc
        JOxDUcVKeeDmUkBtPNcNEOp5ex2rzz1BhXLBNgjbZPc4DKoQEqY1itSR8a8JmCrnG6SSrj/ImAjYM
        jdSHDN9zx9tBQEJC0fzexTubhryRSoUHg/tuu+STAipkqbh9Wk4xQckyXhbFzyGpmgwL+A9xSypZx
        peqZxaWhMXuycKSnEFp84/MEhexrd1lQT88tkqETKrOgJhCAG+SO4ve7Z+rRTWGx7qbMbY6XJ1bvS
        Fx3rkA4Cy5oebDhYzMk6/1gvSSRdwxvS/XVR6k1On+8FBQbF51En9R8PLR73r31pzvshPPNxphkep
        1R4+kamA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Og-00062J-R9; Wed, 26 Sep 2018 11:54:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD924206F181E; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.260918352@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 14/18] s390/tlb: convert to generic mmu_gather
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Cc: npiggin@gmail.com
Cc: heiko.carstens@de.ibm.com
Cc: will.deacon@arm.com
Cc: aneesh.kumar@linux.vnet.ibm.com
Cc: akpm@linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux@armlinux.org.uk
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180918125151.31744-3-schwidefsky@de.ibm.com
---
 arch/s390/Kconfig           |    2 
 arch/s390/include/asm/tlb.h |  128 +++++++++++++-------------------------------
 arch/s390/mm/pgalloc.c      |   63 ---------------------
 3 files changed, 42 insertions(+), 151 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -157,10 +157,12 @@ config S390
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
+	select HAVE_MMU_GATHER_NO_GATHER
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
+	select HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -22,98 +22,39 @@
  * Pages used for the page tables is a different story. FIXME: more
  */
 
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/swap.h>
-#include <asm/processor.h>
-#include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-
-struct mmu_gather {
-	struct mm_struct *mm;
-	struct mmu_table_batch *batch;
-	unsigned int fullmm;
-	unsigned long start, end;
-};
-
-struct mmu_table_batch {
-	struct rcu_head		rcu;
-	unsigned int		nr;
-	void			*tables[0];
-};
-
-#define MAX_TABLE_BATCH		\
-	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
-
-extern void tlb_table_flush(struct mmu_gather *tlb);
-extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
-
-static inline void
-arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			unsigned long start, unsigned long end)
-{
-	tlb->mm = mm;
-	tlb->start = start;
-	tlb->end = end;
-	tlb->fullmm = !(start | (end+1));
-	tlb->batch = NULL;
-}
-
-static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
-{
-	__tlb_flush_mm_lazy(tlb->mm);
-}
-
-static inline void tlb_flush_mmu_free(struct mmu_gather *tlb)
-{
-	tlb_table_flush(tlb);
-}
-
+void __tlb_remove_table(void *_table);
+static inline void tlb_flush(struct mmu_gather *tlb);
+static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
+					  struct page *page, int page_size);
 
-static inline void tlb_flush_mmu(struct mmu_gather *tlb)
-{
-	tlb_flush_mmu_tlbonly(tlb);
-	tlb_flush_mmu_free(tlb);
-}
+#define tlb_start_vma(tlb, vma)			do { } while (0)
+#define tlb_end_vma(tlb, vma)			do { } while (0)
 
-static inline void
-arch_tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end, bool force)
-{
-	if (force) {
-		tlb->start = start;
-		tlb->end = end;
-	}
+#define tlb_flush tlb_flush
+#define pte_free_tlb pte_free_tlb
+#define pmd_free_tlb pmd_free_tlb
+#define p4d_free_tlb p4d_free_tlb
+#define pud_free_tlb pud_free_tlb
 
-	tlb_flush_mmu(tlb);
-}
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm-generic/tlb.h>
 
 /*
  * Release the page cache reference for a pte removed by
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
  * has already been freed, so just do free_page_and_swap_cache.
  */
-static inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	free_page_and_swap_cache(page);
-	return false; /* avoid calling tlb_flush_mmu */
-}
-
-static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	free_page_and_swap_cache(page);
-}
-
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 					  struct page *page, int page_size)
 {
-	return __tlb_remove_page(tlb, page);
+	free_page_and_swap_cache(page);
+	return false;
 }
 
-static inline void tlb_remove_page_size(struct mmu_gather *tlb,
-					struct page *page, int page_size)
+static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	return tlb_remove_page(tlb, page);
+	__tlb_flush_mm_lazy(tlb->mm);
 }
 
 /*
@@ -121,8 +62,17 @@ static inline void tlb_remove_page_size(
  * page table from the tlb.
  */
 static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
-				unsigned long address)
+                                unsigned long address)
 {
+	__tlb_adjust_range(tlb, address, PAGE_SIZE);
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb->cleared_ptes = 1;
+	/*
+	 * page_table_free_rcu takes care of the allocation bit masks
+	 * of the 2K table fragments in the 4K page table page,
+	 * then calls tlb_remove_table.
+	 */
 	page_table_free_rcu(tlb, (unsigned long *) pte, address);
 }
 
@@ -139,6 +89,10 @@ static inline void pmd_free_tlb(struct m
 	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
 		return;
 	pgtable_pmd_page_dtor(virt_to_page(pmd));
+	__tlb_adjust_range(tlb, address, PAGE_SIZE);
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb->cleared_puds = 1;
 	tlb_remove_table(tlb, pmd);
 }
 
@@ -154,6 +108,10 @@ static inline void p4d_free_tlb(struct m
 {
 	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
 		return;
+	__tlb_adjust_range(tlb, address, PAGE_SIZE);
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb->cleared_p4ds = 1;
 	tlb_remove_table(tlb, p4d);
 }
 
@@ -169,19 +127,11 @@ static inline void pud_free_tlb(struct m
 {
 	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
 		return;
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb->cleared_puds = 1;
 	tlb_remove_table(tlb, pud);
 }
 
-#define tlb_start_vma(tlb, vma)			do { } while (0)
-#define tlb_end_vma(tlb, vma)			do { } while (0)
-#define tlb_remove_tlb_entry(tlb, ptep, addr)	do { } while (0)
-#define tlb_remove_pmd_tlb_entry(tlb, pmdp, addr)	do { } while (0)
-#define tlb_migrate_finish(mm)			do { } while (0)
-#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
-	tlb_remove_tlb_entry(tlb, ptep, address)
-
-static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
-{
-}
 
 #endif /* _S390_TLB_H */
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -288,7 +288,7 @@ void page_table_free_rcu(struct mmu_gath
 	tlb_remove_table(tlb, table);
 }
 
-static void __tlb_remove_table(void *_table)
+void __tlb_remove_table(void *_table)
 {
 	unsigned int mask = (unsigned long) _table & 3;
 	void *table = (void *)((unsigned long) _table ^ mask);
@@ -314,67 +314,6 @@ static void __tlb_remove_table(void *_ta
 	}
 }
 
-static void tlb_remove_table_smp_sync(void *arg)
-{
-	/* Simply deliver the interrupt */
-}
-
-static void tlb_remove_table_one(void *table)
-{
-	/*
-	 * This isn't an RCU grace period and hence the page-tables cannot be
-	 * assumed to be actually RCU-freed.
-	 *
-	 * It is however sufficient for software page-table walkers that rely
-	 * on IRQ disabling. See the comment near struct mmu_table_batch.
-	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
-	__tlb_remove_table(table);
-}
-
-static void tlb_remove_table_rcu(struct rcu_head *head)
-{
-	struct mmu_table_batch *batch;
-	int i;
-
-	batch = container_of(head, struct mmu_table_batch, rcu);
-
-	for (i = 0; i < batch->nr; i++)
-		__tlb_remove_table(batch->tables[i]);
-
-	free_page((unsigned long)batch);
-}
-
-void tlb_table_flush(struct mmu_gather *tlb)
-{
-	struct mmu_table_batch **batch = &tlb->batch;
-
-	if (*batch) {
-		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
-		*batch = NULL;
-	}
-}
-
-void tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct mmu_table_batch **batch = &tlb->batch;
-
-	tlb->mm->context.flush_mm = 1;
-	if (*batch == NULL) {
-		*batch = (struct mmu_table_batch *)
-			__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-		if (*batch == NULL) {
-			__tlb_flush_mm_lazy(tlb->mm);
-			tlb_remove_table_one(table);
-			return;
-		}
-		(*batch)->nr = 0;
-	}
-	(*batch)->tables[(*batch)->nr++] = table;
-	if ((*batch)->nr == MAX_TABLE_BATCH)
-		tlb_flush_mmu(tlb);
-}
-
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.


