Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092A0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B0C2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AS1zxnah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B0C2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHXQs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:48:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeHXQs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BISzN8qF6q6ecYFFE0rTZ+FS5kn7ncRn9MMvPp12g8s=; b=AS1zxnahi3CwX0IHQtMcvwIJU
        4HH/k3AOZcgfwORacGAX2Fr/vEjVlz5Wp5hbmC0MurJD1t8PtnlkV9UDvepUVGhEvniGJYY1e+vWs
        /HQvyyARK3iR6oqbmn600ExR0ZkXXc/oddUaPb9BYXOSy8NflKSz3ifT6xQwGklpiERVxaXAuFv5p
        dC8k9W7D2ijFrYUAURo17u8veoHOBk+wo5J2VDO2BWQnQoBH8qzjOjC9+Vum/63ZQDp6gyekkXO7X
        mCoYfICUvnXzhJGHdrZg3z+EItLAmvcp8/1mt9bRLbR+URNsfJd2gFdXmvG/VV07aY5yiXqsNfImk
        0S1IautmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftBuD-0001Bh-6z; Fri, 24 Aug 2018 13:13:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A09FF2024C922; Fri, 24 Aug 2018 15:13:32 +0200 (CEST)
Date:   Fri, 24 Aug 2018 15:13:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180824131332.GM24142@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <20180824083556.GI24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824083556.GI24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:35:56AM +0200, Peter Zijlstra wrote:

> Anyway, its sorted now; although I'd like to write me a fairly big
> comment in asm-generic/tlb.h about things, before I forget again.

How's something like so? There's a little page_size thingy in this;
mostly because I couldn't be arsed to split it for now.

Will has opinions on the page_size thing; I'll let him explain.

---

 arch/Kconfig                   |   3 +
 arch/arm/include/asm/tlb.h     |   3 +-
 arch/ia64/include/asm/tlb.h    |   3 +-
 arch/powerpc/Kconfig           |   1 +
 arch/powerpc/include/asm/tlb.h |  17 ------
 arch/s390/include/asm/tlb.h    |   4 +-
 arch/sh/include/asm/tlb.h      |   4 +-
 arch/um/include/asm/tlb.h      |   4 +-
 include/asm-generic/tlb.h      | 130 ++++++++++++++++++++++++++++++++++++-----
 mm/huge_memory.c               |   4 +-
 mm/hugetlb.c                   |   2 +-
 mm/madvise.c                   |   2 +-
 mm/memory.c                    |   9 ++-
 13 files changed, 137 insertions(+), 49 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..053c44703539 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -365,6 +365,9 @@ config HAVE_RCU_TABLE_FREE
 config HAVE_RCU_TABLE_INVALIDATE
 	bool
 
+config HAVE_MMU_GATHER_PAGE_SIZE
+	bool
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index f854148c8d7c..d644c3c7c6f3 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -286,8 +286,7 @@ tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr
 
 #define tlb_migrate_finish(mm)		do { } while (0)
 
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
+static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
 }
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 516355a774bf..bf8985f5f876 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -282,8 +282,7 @@ do {							\
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	tlb_remove_tlb_entry(tlb, ptep, address)
 
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
+static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
 }
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db0b6eebbfa5..4db1072868f7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -217,6 +217,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE		if SMP
+	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index f0e571b2dc7c..b29a67137acf 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -27,7 +27,6 @@
 #define tlb_start_vma(tlb, vma)	do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
 #define __tlb_remove_tlb_entry	__tlb_remove_tlb_entry
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
 
 extern void tlb_flush(struct mmu_gather *tlb);
 
@@ -46,22 +45,6 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 #endif
 }
 
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
-						     unsigned int page_size)
-{
-	if (!tlb->page_size)
-		tlb->page_size = page_size;
-	else if (tlb->page_size != page_size) {
-		if (!tlb->fullmm)
-			tlb_flush_mmu(tlb);
-		/*
-		 * update the page size after flush for the new
-		 * mmu_gather.
-		 */
-		tlb->page_size = page_size;
-	}
-}
-
 #ifdef CONFIG_SMP
 static inline int mm_is_core_local(struct mm_struct *mm)
 {
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 457b7ba0fbb6..cf3d64313740 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -180,9 +180,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	tlb_remove_tlb_entry(tlb, ptep, address)
 
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
-						     unsigned int page_size)
+static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
 {
 }
 
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 77abe192fb43..af7c9d891cf8 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -127,9 +127,7 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 	return tlb_remove_page(tlb, page);
 }
 
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
-						     unsigned int page_size)
+static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
 {
 }
 
diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
index dce6db147f24..6463f3ab1767 100644
--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -146,9 +146,7 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	tlb_remove_tlb_entry(tlb, ptep, address)
 
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
-						     unsigned int page_size)
+static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
 {
 }
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b3353e21f3b3..d3573ba10068 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -20,6 +20,108 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+/*
+ * Generic MMU-gather implementation.
+ *
+ * The mmu_gather data structure is used by the mm code to implement the
+ * correct and efficient ordering of freeing pages and TLB invalidations.
+ *
+ * This correct ordering is:
+ *
+ *  1) unhook page
+ *  2) TLB invalidate page
+ *  3) free page
+ *
+ * That is, we must never free a page before we have ensured there are no live
+ * translations left to it. Otherwise it might be possible to observe (or
+ * worse, change) the page content after it has been reused.
+ *
+ * The mmu_gather API consists of:
+ *
+ *  - tlb_gather_mmu() / tlb_finish_mmu(); start and finish a mmu_gather
+ *
+ *    Finish in particular will issue a (final) TLB invalidate and free
+ *    all (remaining) queued pages.
+ *
+ *  - tlb_start_vma() / tlb_end_vma(); marks the start / end of a VMA
+ *
+ *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
+ *    there's large holes between the VMAs.
+ *
+ *  - tlb_remove_page() / __tlb_remove_page()
+ *  - tlb_remove_page_size() / __tlb_remove_page_size()
+ *
+ *    __tlb_remove_page_size() is the basic primitive that queues a page for
+ *    freeing. __tlb_remove_page() assumes PAGE_SIZE. Both will return a
+ *    boolean indicating if the queue is (now) full and a call to
+ *    tlb_flush_mmu() is required.
+ *
+ *    tlb_remove_page() and tlb_remove_page_size() imply the call to
+ *    tlb_flush_mmu() when required and has no return value.
+ *
+ *  - tlb_change_page_size()
+ *
+ *    call before __tlb_remove_page*() to set the current page-size; implies a
+ *    possible tlb_flush_mmu() call.
+ *
+ *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly() / tlb_flush_mmu_free()
+ *
+ *    tlb_flush_mmu_tlbonly() - does the TLB invalidate (and resets
+ *                              related state, like the range)
+ *
+ *    tlb_flush_mmu_free() - frees the queued pages; make absolutely
+ *			     sure no additional tlb_remove_page()
+ *			     calls happen between _tlbonly() and this.
+ *
+ *    tlb_flush_mmu() - the above two calls.
+ *
+ *  - mmu_gather::fullmm
+ *
+ *    A flag set by tlb_gather_mmu() to indicate we're going to free
+ *    the entire mm; this allows a number of optimizations.
+ *
+ *    XXX list optimizations
+ *
+ *  - mmu_gather::need_flush_all
+ *
+ *    A flag that can be set by the arch code if it wants to force
+ *    flush the entire TLB irrespective of the range. For instance
+ *    x86-PAE needs this when changing top-level entries.
+ *
+ * And requires the architecture to provide and implement tlb_flush().
+ *
+ * tlb_flush() may, in addition to the above mentioned mmu_gather fields, make
+ * use of:
+ *
+ *  - mmu_gather::start / mmu_gather::end
+ *
+ *    which (when !need_flush_all; fullmm will have start = end = ~0UL) provides
+ *    the range that needs to be flushed to cover the pages to be freed.
+ *
+ * Additionally there are a few opt-in features:
+ *
+ *  HAVE_MMU_GATHER_PAGE_SIZE
+ *
+ *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
+ *  changes the size and provides mmu_gather::page_size to tlb_flush().
+ *
+ *  HAVE_RCU_TABLE_FREE
+ *
+ *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
+ *  for page directores (__p*_free_tlb()). This provides separate freeing of
+ *  the page-table pages themselves in a semi-RCU fashion (see comment below).
+ *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
+ *  and therefore doesn't naturally serialize with software page-table walkers.
+ *
+ *  HAVE_RCU_TABLE_INVALIDATE
+ *
+ *  This makes HAVE_RCU_TABLE_FREE call tlb_flush_mmu_tlbonly() before freeing
+ *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
+ *  architecture uses the Linux page-tables natively.
+ *
+ */
+#define HAVE_GENERIC_MMU_GATHER
+
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 /*
  * Semi RCU freeing of the page directories.
@@ -87,14 +189,17 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
-/* struct mmu_gather is an opaque type used by the mm code for passing around
+/*
+ * struct mmu_gather is an opaque type used by the mm code for passing around
  * any data needed by arch specific code for tlb_remove_page.
  */
 struct mmu_gather {
 	struct mm_struct	*mm;
+
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
+
 	unsigned long		start;
 	unsigned long		end;
 	/* we are in the middle of an operation to clear
@@ -103,15 +208,17 @@ struct mmu_gather {
 	/* we have performed an operation which
 	 * requires a complete flush of the tlb */
 				need_flush_all : 1;
+#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+	unsigned int page_size;
+#endif
 
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
 	unsigned int		batch_count;
-	int page_size;
+
 };
 
-#define HAVE_GENERIC_MMU_GATHER
 
 void arch_tlb_gather_mmu(struct mmu_gather *tlb,
 	struct mm_struct *mm, unsigned long start, unsigned long end);
@@ -170,21 +277,18 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
-#ifndef tlb_remove_check_page_size_change
-#define tlb_remove_check_page_size_change tlb_remove_check_page_size_change
-static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
+static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-	/*
-	 * We don't care about page size change, just update
-	 * mmu_gather page size here so that debug checks
-	 * doesn't throw false warning.
-	 */
-#ifdef CONFIG_DEBUG_VM
+#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+	if (tlb->page_size && tlb->page_size != page_size) {
+		if (!tlb->fullmm)
+			tlb_flush_mmu(tlb);
+	}
+
 	tlb->page_size = page_size;
 #endif
 }
-#endif
 
 /*
  * In the case of tlb vma handling, we can optimise these away in the
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08b544383d74..786758670ba1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1617,7 +1617,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct mm_struct *mm = tlb->mm;
 	bool ret = false;
 
-	tlb_remove_check_page_size_change(tlb, HPAGE_PMD_SIZE);
+	tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
@@ -1693,7 +1693,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	pmd_t orig_pmd;
 	spinlock_t *ptl;
 
-	tlb_remove_check_page_size_change(tlb, HPAGE_PMD_SIZE);
+	tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3c21775f196b..8af346b53a79 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3337,7 +3337,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * This is a hugetlb vma, all the pte entries should point
 	 * to huge page.
 	 */
-	tlb_remove_check_page_size_change(tlb, sz);
+	tlb_change_page_size(tlb, sz);
 	tlb_start_vma(tlb, vma);
 	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
 	address = start;
diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922ea1a1..2a9073c652d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -328,7 +328,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	tlb_remove_check_page_size_change(tlb, PAGE_SIZE);
+	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
diff --git a/mm/memory.c b/mm/memory.c
index 83aef222f11b..2818e00d1aae 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -233,7 +233,9 @@ void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb->batch = NULL;
 #endif
+#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
+#endif
 
 	__tlb_reset_range(tlb);
 }
@@ -294,7 +296,10 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 	struct mmu_gather_batch *batch;
 
 	VM_BUG_ON(!tlb->end);
+
+#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size != page_size);
+#endif
 
 	batch = tlb->active;
 	/*
@@ -602,7 +607,7 @@ void free_pgd_range(struct mmu_gather *tlb,
 	 * We add page table cache pages with PAGE_SIZE,
 	 * (see pte_free_tlb()), flush the tlb if we need
 	 */
-	tlb_remove_check_page_size_change(tlb, PAGE_SIZE);
+	tlb_change_page_size(tlb, PAGE_SIZE);
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
@@ -1293,7 +1298,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *pte;
 	swp_entry_t entry;
 
-	tlb_remove_check_page_size_change(tlb, PAGE_SIZE);
+	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
 	init_rss_vec(rss);
 	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
