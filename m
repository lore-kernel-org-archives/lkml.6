Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B141C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1402083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOgOX+7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1402083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeHaORT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:17:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHaORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hssCKZg/lInvd+EjCMMDJ+XFKTtvDerdy9WjPWusgY8=; b=bOgOX+7qXshRD/EZj2DVZVf39
        3U6GPQrFz3LB/5W64sm5ffRWQwzclBddBVibO8SmoZE0k0rrEif9/6Ug3sdkez1Aj/CYvagIeYlW+
        n9TEYuk+1mGz8ac4sL3ROpAzlys6rM+aHO2qIskqlfSZBilrSiDG9MR1ZHiMXatmFsR60Wpmveanc
        CujSw4jZ9nufHMPHa9mXS+PCdllV0bBa8czdV8Qt2KE4UsLu7fv4u0PkBFYWpbs/+DgXHu0BFfWDH
        KK1juGoAOlfNmmFP5o6h4rRHlbz/cqpRBTfiycQSdRSC1Nv0z4ksFR4eRQrAu6iZg4agCVc1bTBSe
        2OgIHdPzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvgNd-0000sv-4r; Fri, 31 Aug 2018 10:10:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A49732024D730; Fri, 31 Aug 2018 12:10:14 +0200 (CEST)
Date:   Fri, 31 Aug 2018 12:10:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831101014.GG24124@hirez.programming.kicks-ass.net>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
 <20180831095417.GF13166@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831095417.GF13166@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:54:18AM +0100, Will Deacon wrote:

> Proposal below (omitted Linus because that seems to be the pattern elsewhere
> in the file and he's not going to shout at himself when things break :)
> Anybody I've missed?
> 
> Will
> 
> --->8
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..7224b5618883 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9681,6 +9681,15 @@ S:	Maintained
>  F:	arch/arm/boot/dts/mmp*
>  F:	arch/arm/mach-mmp/
>  
> +MMU GATHER AND TLB INVALIDATION
> +M:	Will Deacon <will.deacon@arm.com>
> +M:	Nick Piggin <npiggin@gmail.com>
> +M:	Peter Zijlstra <peterz@infradead.org>
> +L:	linux-arch@vger.kernel.org
> +S:	Maintained
> +F:	include/asm-generic/tlb.h
> +F:	arch/*/include/asm/tlb.h
> +
>  MN88472 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
>  L:	linux-media@vger.kernel.org

If we're going to do that (and I'm not opposed); it might make sense to
do something like the below and add:

 F:  mm/mmu_gather.c

---
 b/mm/mmu_gather.c         |  250 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/tlb.h |    2 
 mm/Makefile               |    2 
 mm/memory.c               |  247 ---------------------------------------------
 4 files changed, 253 insertions(+), 248 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -149,6 +149,8 @@ static inline void tlb_flush_mmu_tlbonly
 	__tlb_reset_range(tlb);
 }
 
+extern void tlb_flush_mmu_free(struct mmu_gather *tlb);
+
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -22,7 +22,7 @@ KCOV_INSTRUMENT_mmzone.o := n
 KCOV_INSTRUMENT_vmstat.o := n
 
 mmu-y			:= nommu.o
-mmu-$(CONFIG_MMU)	:= gup.o highmem.o memory.o mincore.o \
+mmu-$(CONFIG_MMU)	:= gup.o highmem.o memory.o mmu_gather.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o \
 			   page_vma_mapped.o pagewalk.o pgtable-generic.o \
 			   rmap.o vmalloc.o
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -186,253 +186,6 @@ static void check_sync_rss_stat(struct t
 
 #endif /* SPLIT_RSS_COUNTING */
 
-#ifdef HAVE_GENERIC_MMU_GATHER
-
-static bool tlb_next_batch(struct mmu_gather *tlb)
-{
-	struct mmu_gather_batch *batch;
-
-	batch = tlb->active;
-	if (batch->next) {
-		tlb->active = batch->next;
-		return true;
-	}
-
-	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
-		return false;
-
-	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
-	if (!batch)
-		return false;
-
-	tlb->batch_count++;
-	batch->next = NULL;
-	batch->nr   = 0;
-	batch->max  = MAX_GATHER_BATCH;
-
-	tlb->active->next = batch;
-	tlb->active = batch;
-
-	return true;
-}
-
-void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-				unsigned long start, unsigned long end)
-{
-	tlb->mm = mm;
-
-	/* Is it from 0 to ~0? */
-	tlb->fullmm     = !(start | (end+1));
-	tlb->need_flush_all = 0;
-	tlb->local.next = NULL;
-	tlb->local.nr   = 0;
-	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
-	tlb->active     = &tlb->local;
-	tlb->batch_count = 0;
-
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb->batch = NULL;
-#endif
-	tlb->page_size = 0;
-
-	__tlb_reset_range(tlb);
-}
-
-static void tlb_flush_mmu_free(struct mmu_gather *tlb)
-{
-	struct mmu_gather_batch *batch;
-
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
-#endif
-	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		free_pages_and_swap_cache(batch->pages, batch->nr);
-		batch->nr = 0;
-	}
-	tlb->active = &tlb->local;
-}
-
-void tlb_flush_mmu(struct mmu_gather *tlb)
-{
-	tlb_flush_mmu_tlbonly(tlb);
-	tlb_flush_mmu_free(tlb);
-}
-
-/* tlb_finish_mmu
- *	Called at the end of the shootdown operation to free up any resources
- *	that were required.
- */
-void arch_tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end, bool force)
-{
-	struct mmu_gather_batch *batch, *next;
-
-	if (force)
-		__tlb_adjust_range(tlb, start, end - start);
-
-	tlb_flush_mmu(tlb);
-
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
-
-	for (batch = tlb->local.next; batch; batch = next) {
-		next = batch->next;
-		free_pages((unsigned long)batch, 0);
-	}
-	tlb->local.next = NULL;
-}
-
-/* __tlb_remove_page
- *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
- *	handling the additional races in SMP caused by other CPUs caching valid
- *	mappings in their TLBs. Returns the number of free page slots left.
- *	When out of page slots we must call tlb_flush_mmu().
- *returns true if the caller should flush.
- */
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
-{
-	struct mmu_gather_batch *batch;
-
-	VM_BUG_ON(!tlb->end);
-	VM_WARN_ON(tlb->page_size != page_size);
-
-	batch = tlb->active;
-	/*
-	 * Add the page and check if we are full. If so
-	 * force a flush.
-	 */
-	batch->pages[batch->nr++] = page;
-	if (batch->nr == batch->max) {
-		if (!tlb_next_batch(tlb))
-			return true;
-		batch = tlb->active;
-	}
-	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
-
-	return false;
-}
-
-#endif /* HAVE_GENERIC_MMU_GATHER */
-
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-
-/*
- * See the comment near struct mmu_table_batch.
- */
-
-/*
- * If we want tlb_remove_table() to imply TLB invalidates.
- */
-static inline void tlb_table_invalidate(struct mmu_gather *tlb)
-{
-#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
-	/*
-	 * Invalidate page-table caches used by hardware walkers. Then we still
-	 * need to RCU-sched wait while freeing the pages because software
-	 * walkers can still be in-flight.
-	 */
-	tlb_flush_mmu_tlbonly(tlb);
-#endif
-}
-
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
-	 * It is however sufficient for software page-table walkers that rely on
-	 * IRQ disabling. See the comment near struct mmu_table_batch.
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
-		tlb_table_invalidate(tlb);
-		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
-		*batch = NULL;
-	}
-}
-
-void tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct mmu_table_batch **batch = &tlb->batch;
-
-	if (*batch == NULL) {
-		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-		if (*batch == NULL) {
-			tlb_table_invalidate(tlb);
-			tlb_remove_table_one(table);
-			return;
-		}
-		(*batch)->nr = 0;
-	}
-
-	(*batch)->tables[(*batch)->nr++] = table;
-	if ((*batch)->nr == MAX_TABLE_BATCH)
-		tlb_table_flush(tlb);
-}
-
-#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
-
-/**
- * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
- * @tlb: the mmu_gather structure to initialize
- * @mm: the mm_struct of the target address space
- * @start: start of the region that will be removed from the page-table
- * @end: end of the region that will be removed from the page-table
- *
- * Called to initialize an (on-stack) mmu_gather structure for page-table
- * tear-down from @mm. The @start and @end are set to 0 and -1
- * respectively when @mm is without users and we're going to destroy
- * the full address space (exit/execve).
- */
-void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-			unsigned long start, unsigned long end)
-{
-	arch_tlb_gather_mmu(tlb, mm, start, end);
-	inc_tlb_flush_pending(tlb->mm);
-}
-
-void tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end)
-{
-	/*
-	 * If there are parallel threads are doing PTE changes on same range
-	 * under non-exclusive lock(e.g., mmap_sem read-side) but defer TLB
-	 * flush by batching, a thread has stable TLB entry can fail to flush
-	 * the TLB by observing pte_none|!pte_dirty, for example so flush TLB
-	 * forcefully if we detect parallel PTE batching threads.
-	 */
-	bool force = mm_tlb_flush_nested(tlb->mm);
-
-	arch_tlb_finish_mmu(tlb, start, end, force);
-	dec_tlb_flush_pending(tlb->mm);
-}
-
 /*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
--- /dev/null
+++ b/mm/mmu_gather.c
@@ -0,0 +1,250 @@
+#include <linux/smp.h>
+#include "asm/tlb.h"
+
+#ifdef HAVE_GENERIC_MMU_GATHER
+
+static bool tlb_next_batch(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch;
+
+	batch = tlb->active;
+	if (batch->next) {
+		tlb->active = batch->next;
+		return true;
+	}
+
+	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
+		return false;
+
+	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
+	if (!batch)
+		return false;
+
+	tlb->batch_count++;
+	batch->next = NULL;
+	batch->nr   = 0;
+	batch->max  = MAX_GATHER_BATCH;
+
+	tlb->active->next = batch;
+	tlb->active = batch;
+
+	return true;
+}
+
+void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+				unsigned long start, unsigned long end)
+{
+	tlb->mm = mm;
+
+	/* Is it from 0 to ~0? */
+	tlb->fullmm     = !(start | (end+1));
+	tlb->need_flush_all = 0;
+	tlb->local.next = NULL;
+	tlb->local.nr   = 0;
+	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
+	tlb->active     = &tlb->local;
+	tlb->batch_count = 0;
+
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb->batch = NULL;
+#endif
+	tlb->page_size = 0;
+
+	__tlb_reset_range(tlb);
+}
+
+void tlb_flush_mmu_free(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch;
+
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb_table_flush(tlb);
+#endif
+	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
+		free_pages_and_swap_cache(batch->pages, batch->nr);
+		batch->nr = 0;
+	}
+	tlb->active = &tlb->local;
+}
+
+void tlb_flush_mmu(struct mmu_gather *tlb)
+{
+	tlb_flush_mmu_tlbonly(tlb);
+	tlb_flush_mmu_free(tlb);
+}
+
+/* tlb_finish_mmu
+ *	Called at the end of the shootdown operation to free up any resources
+ *	that were required.
+ */
+void arch_tlb_finish_mmu(struct mmu_gather *tlb,
+		unsigned long start, unsigned long end, bool force)
+{
+	struct mmu_gather_batch *batch, *next;
+
+	if (force)
+		__tlb_adjust_range(tlb, start, end - start);
+
+	tlb_flush_mmu(tlb);
+
+	/* keep the page table cache within bounds */
+	check_pgt_cache();
+
+	for (batch = tlb->local.next; batch; batch = next) {
+		next = batch->next;
+		free_pages((unsigned long)batch, 0);
+	}
+	tlb->local.next = NULL;
+}
+
+/* __tlb_remove_page
+ *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
+ *	handling the additional races in SMP caused by other CPUs caching valid
+ *	mappings in their TLBs. Returns the number of free page slots left.
+ *	When out of page slots we must call tlb_flush_mmu().
+ *returns true if the caller should flush.
+ */
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
+{
+	struct mmu_gather_batch *batch;
+
+	VM_BUG_ON(!tlb->end);
+	VM_WARN_ON(tlb->page_size != page_size);
+
+	batch = tlb->active;
+	/*
+	 * Add the page and check if we are full. If so
+	 * force a flush.
+	 */
+	batch->pages[batch->nr++] = page;
+	if (batch->nr == batch->max) {
+		if (!tlb_next_batch(tlb))
+			return true;
+		batch = tlb->active;
+	}
+	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
+
+	return false;
+}
+
+#endif /* HAVE_GENERIC_MMU_GATHER */
+
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+
+/*
+ * See the comment near struct mmu_table_batch.
+ */
+
+/*
+ * If we want tlb_remove_table() to imply TLB invalidates.
+ */
+static inline void tlb_table_invalidate(struct mmu_gather *tlb)
+{
+#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
+	/*
+	 * Invalidate page-table caches used by hardware walkers. Then we still
+	 * need to RCU-sched wait while freeing the pages because software
+	 * walkers can still be in-flight.
+	 */
+	tlb_flush_mmu_tlbonly(tlb);
+#endif
+}
+
+static void tlb_remove_table_smp_sync(void *arg)
+{
+	/* Simply deliver the interrupt */
+}
+
+static void tlb_remove_table_one(void *table)
+{
+	/*
+	 * This isn't an RCU grace period and hence the page-tables cannot be
+	 * assumed to be actually RCU-freed.
+	 *
+	 * It is however sufficient for software page-table walkers that rely on
+	 * IRQ disabling. See the comment near struct mmu_table_batch.
+	 */
+	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	__tlb_remove_table(table);
+}
+
+static void tlb_remove_table_rcu(struct rcu_head *head)
+{
+	struct mmu_table_batch *batch;
+	int i;
+
+	batch = container_of(head, struct mmu_table_batch, rcu);
+
+	for (i = 0; i < batch->nr; i++)
+		__tlb_remove_table(batch->tables[i]);
+
+	free_page((unsigned long)batch);
+}
+
+void tlb_table_flush(struct mmu_gather *tlb)
+{
+	struct mmu_table_batch **batch = &tlb->batch;
+
+	if (*batch) {
+		tlb_table_invalidate(tlb);
+		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
+		*batch = NULL;
+	}
+}
+
+void tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	struct mmu_table_batch **batch = &tlb->batch;
+
+	if (*batch == NULL) {
+		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+		if (*batch == NULL) {
+			tlb_table_invalidate(tlb);
+			tlb_remove_table_one(table);
+			return;
+		}
+		(*batch)->nr = 0;
+	}
+
+	(*batch)->tables[(*batch)->nr++] = table;
+	if ((*batch)->nr == MAX_TABLE_BATCH)
+		tlb_table_flush(tlb);
+}
+
+#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+
+/**
+ * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
+ * @tlb: the mmu_gather structure to initialize
+ * @mm: the mm_struct of the target address space
+ * @start: start of the region that will be removed from the page-table
+ * @end: end of the region that will be removed from the page-table
+ *
+ * Called to initialize an (on-stack) mmu_gather structure for page-table
+ * tear-down from @mm. The @start and @end are set to 0 and -1
+ * respectively when @mm is without users and we're going to destroy
+ * the full address space (exit/execve).
+ */
+void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+	arch_tlb_gather_mmu(tlb, mm, start, end);
+	inc_tlb_flush_pending(tlb->mm);
+}
+
+void tlb_finish_mmu(struct mmu_gather *tlb,
+		unsigned long start, unsigned long end)
+{
+	/*
+	 * If there are parallel threads are doing PTE changes on same range
+	 * under non-exclusive lock(e.g., mmap_sem read-side) but defer TLB
+	 * flush by batching, a thread has stable TLB entry can fail to flush
+	 * the TLB by observing pte_none|!pte_dirty, for example so flush TLB
+	 * forcefully if we detect parallel PTE batching threads.
+	 */
+	bool force = mm_tlb_flush_nested(tlb->mm);
+
+	arch_tlb_finish_mmu(tlb, start, end, force);
+	dec_tlb_flush_pending(tlb->mm);
+}
+
