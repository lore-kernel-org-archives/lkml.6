Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAAF20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t11hqDFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfBSKdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfBSKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TN5RXNcFDEGbWABVLmVNC8x3PmXlqXdoY5MjcRf6CAs=; b=t11hqDFfI3p46LQLOtEQH0lKGJ
        Az8qsd9R/MlPa/LVrdrqS+luhzuoWMwl68zDGBHhk5LgiACyb0ZdmpIp/qnKl366z0AEwGQH/k0mU
        ae9qdVDBIraTosQQygH0fcmqOTTPVFYrMJuNu877r+SCcaF34MlxVgonw0183nh/AHUphvx+xKuUV
        34jKs9SARhwr1VvLMhO6OPJtNvSL+eA7LE7DY1qUBgZb71aVz9U7+Rt1aWU0iOTC5K7Dx4hfpOVHG
        vE/dalC3yfqpMquFb+46RuPcPD7o3kgGhDigLB6/UmO9y1LncQZhQsDIR1cNl0NY+J7xY/txVLOBs
        P+SKR3Yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2ho-0006ZV-MH; Tue, 19 Feb 2019 10:32:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7233C285205A0; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.633310832@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:32:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH v6 13/18] asm-generic/tlb: Introduce HAVE_MMU_GATHER_NO_GATHER
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kconfig option HAVE_MMU_GATHER_NO_GATHER to the generic
mmu_gather code. If the option is set the mmu_gather will not
track individual pages for delayed page free anymore. A platform
that enables the option needs to provide its own implementation
of the __tlb_remove_page_size function to free pages.

Cc: npiggin@gmail.com
Cc: heiko.carstens@de.ibm.com
Cc: will.deacon@arm.com
Cc: aneesh.kumar@linux.vnet.ibm.com
Cc: akpm@linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux@armlinux.org.uk
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180918125151.31744-2-schwidefsky@de.ibm.com
---
 arch/Kconfig              |    3 +
 include/asm-generic/tlb.h |    9 +++
 mm/mmu_gather.c           |  107 +++++++++++++++++++++++++---------------------
 3 files changed, 70 insertions(+), 49 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -368,6 +368,9 @@ config HAVE_RCU_TABLE_NO_INVALIDATE
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool
 
+config HAVE_MMU_GATHER_NO_GATHER
+	bool
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -184,6 +184,7 @@ extern void tlb_remove_table(struct mmu_
 
 #endif
 
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 /*
  * If we can't allocate a page to make a big batch of page pointers
  * to work on, then just handle a few from the on-stack structure.
@@ -208,6 +209,10 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
+extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+				   int page_size);
+#endif
+
 /*
  * struct mmu_gather is an opaque type used by the mm code for passing around
  * any data needed by arch specific code for tlb_remove_page.
@@ -254,6 +259,7 @@ struct mmu_gather {
 
 	unsigned int		batch_count;
 
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
@@ -261,6 +267,7 @@ struct mmu_gather {
 #ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
+#endif
 };
 
 void arch_tlb_gather_mmu(struct mmu_gather *tlb,
@@ -269,8 +276,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 void arch_tlb_finish_mmu(struct mmu_gather *tlb,
 			 unsigned long start, unsigned long end, bool force);
 void tlb_flush_mmu_free(struct mmu_gather *tlb);
-extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
-				   int page_size);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address,
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -13,6 +13,8 @@
 
 #ifdef HAVE_GENERIC_MMU_GATHER
 
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+
 static bool tlb_next_batch(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
@@ -41,6 +43,56 @@ static bool tlb_next_batch(struct mmu_ga
 	return true;
 }
 
+static void tlb_batch_pages_flush(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch;
+
+	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
+		free_pages_and_swap_cache(batch->pages, batch->nr);
+		batch->nr = 0;
+	}
+	tlb->active = &tlb->local;
+}
+
+static void tlb_batch_list_free(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch, *next;
+
+	for (batch = tlb->local.next; batch; batch = next) {
+		next = batch->next;
+		free_pages((unsigned long)batch, 0);
+	}
+	tlb->local.next = NULL;
+}
+
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
+{
+	struct mmu_gather_batch *batch;
+
+	VM_BUG_ON(!tlb->end);
+
+#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+	VM_WARN_ON(tlb->page_size != page_size);
+#endif
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
+#endif /* HAVE_MMU_GATHER_NO_GATHER */
+
 void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 				unsigned long start, unsigned long end)
 {
@@ -48,12 +100,15 @@ void arch_tlb_gather_mmu(struct mmu_gath
 
 	/* Is it from 0 to ~0? */
 	tlb->fullmm     = !(start | (end+1));
+
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all = 0;
 	tlb->local.next = NULL;
 	tlb->local.nr   = 0;
 	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
+#endif
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb->batch = NULL;
@@ -67,16 +122,12 @@ void arch_tlb_gather_mmu(struct mmu_gath
 
 void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
-	struct mmu_gather_batch *batch;
-
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
-	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		free_pages_and_swap_cache(batch->pages, batch->nr);
-		batch->nr = 0;
-	}
-	tlb->active = &tlb->local;
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+	tlb_batch_pages_flush(tlb);
+#endif
 }
 
 void tlb_flush_mmu(struct mmu_gather *tlb)
@@ -92,8 +143,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 void arch_tlb_finish_mmu(struct mmu_gather *tlb,
 		unsigned long start, unsigned long end, bool force)
 {
-	struct mmu_gather_batch *batch, *next;
-
 	if (force) {
 		__tlb_reset_range(tlb);
 		__tlb_adjust_range(tlb, start, end - start);
@@ -103,45 +152,9 @@ void arch_tlb_finish_mmu(struct mmu_gath
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
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
-
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
-	VM_WARN_ON(tlb->page_size != page_size);
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+	tlb_batch_list_free(tlb);
 #endif
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
 }
 
 #endif /* HAVE_GENERIC_MMU_GATHER */


