Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE35C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2899B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/t6hoHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2899B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIZSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeIZSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l4TwOLypeLrg8jwGO2V6hg9OgwsYg7tBLQ3YZNFkico=; b=m/t6hoHEMC6O0KYP1dcigJOIsF
        oyucecRXnOqF9JqyNXklAc+6DaDhz0W31iCBRhFFEkOjmgD+Ctw37rKNqj3OslcPdy6wr6bJQ+wuL
        IzQtpJtd7xgqn7H825vqN5g9WUkWwwL27xl8tzlWvW+wFLwucQHkLShQeI4/5SvSiioEoKliIlCuq
        q/FKyT/VguQjPuQuQfF2o02uNhpdIDyuAUcmqOviITIoYhGOQmCcVj9YMmtxV5hmJrRlsWXFBT/Su
        I46YKHv2qBYnFEJWFEP3vj4nvsrMsztzOeMtTURdFPazgF/kbIn4TQ36bcTGr/Lenz/eJfrGfc87B
        bTMnsXFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Og-00062I-Qa; Wed, 26 Sep 2018 11:54:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A9271206F1818; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.199256189@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 13/18] asm-generic/tlb: Introduce HAVE_MMU_GATHER_NO_GATHER
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

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


