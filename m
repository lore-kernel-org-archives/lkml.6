Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECBECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0885E214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0sErcDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0885E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeIZSHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbeIZSHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ULS8xakk5PjFAR+8tJXFiitZhxMy7nnK13h1c+fJV4=; b=q0sErcDEJDK+u+Ku5DIDNK3SEs
        WsjoR0HSlVdufw8byMr4LzGTmCpO8hXsMhrVvvnQvzGjIbGXpfrj39OcWhWWOaD6Fb4O/zVCeEs0N
        DNg2h5adaU4nm/Org0E2lpQtXIUGtUUnBsRcaN4P5CjDWxyZDKpAF3n1atbPNe0k2uKs2u/2AOhH7
        Y044Vl9WXefdTfjF/daNYD2PTKpVQpC/nEen9aeXuMZ3yju3gLL41mz4Ie7qX+qcmGkQzcibzM1FA
        5jnNt24XmNhldoGRmZAo8LQT7bsv/RwQj/UFMGXpCk4rSE70Gvl9r1ixDnCbZzgjQ+eEknqXtwUgo
        lGXQn1IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oy-0007Un-0e; Wed, 26 Sep 2018 11:55:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B2BCC206F1820; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.314124744@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 15/18] asm-generic/tlb: Remove arch_tlb*_mmu()
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all architectures are converted to the generic code, remove
the arch hooks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/mmu_gather.c |   93 +++++++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 51 deletions(-)

--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -93,33 +93,6 @@ bool __tlb_remove_page_size(struct mmu_g
 
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
 
-void arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-				unsigned long start, unsigned long end)
-{
-	tlb->mm = mm;
-
-	/* Is it from 0 to ~0? */
-	tlb->fullmm     = !(start | (end+1));
-
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
-	tlb->need_flush_all = 0;
-	tlb->local.next = NULL;
-	tlb->local.nr   = 0;
-	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
-	tlb->active     = &tlb->local;
-	tlb->batch_count = 0;
-#endif
-
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb->batch = NULL;
-#endif
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
-	tlb->page_size = 0;
-#endif
-
-	__tlb_reset_range(tlb);
-}
-
 void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
@@ -136,27 +109,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb_flush_mmu_free(tlb);
 }
 
-/* tlb_finish_mmu
- *	Called at the end of the shootdown operation to free up any resources
- *	that were required.
- */
-void arch_tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end, bool force)
-{
-	if (force) {
-		__tlb_reset_range(tlb);
-		__tlb_adjust_range(tlb, start, end - start);
-	}
-
-	tlb_flush_mmu(tlb);
-
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
-	tlb_batch_list_free(tlb);
-#endif
-}
-
 #endif /* HAVE_GENERIC_MMU_GATHER */
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
@@ -258,10 +210,40 @@ void tlb_remove_table(struct mmu_gather
 void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			unsigned long start, unsigned long end)
 {
-	arch_tlb_gather_mmu(tlb, mm, start, end);
+	tlb->mm = mm;
+
+	/* Is it from 0 to ~0? */
+	tlb->fullmm     = !(start | (end+1));
+
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+	tlb->need_flush_all = 0;
+	tlb->local.next = NULL;
+	tlb->local.nr   = 0;
+	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
+	tlb->active     = &tlb->local;
+	tlb->batch_count = 0;
+#endif
+
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb->batch = NULL;
+#endif
+#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+	tlb->page_size = 0;
+#endif
+
+	__tlb_reset_range(tlb);
 	inc_tlb_flush_pending(tlb->mm);
 }
 
+/**
+ * tlb_finish_mmu - finish an mmu_gather structure
+ * @tlb: the mmu_gather structure to finish
+ * @start: start of the region that will be removed from the page-table
+ * @end: end of the region that will be removed from the page-table
+ *
+ * Called at the end of the shootdown operation to free up any resources that
+ * were required.
+ */
 void tlb_finish_mmu(struct mmu_gather *tlb,
 		unsigned long start, unsigned long end)
 {
@@ -272,8 +254,17 @@ void tlb_finish_mmu(struct mmu_gather *t
 	 * the TLB by observing pte_none|!pte_dirty, for example so flush TLB
 	 * forcefully if we detect parallel PTE batching threads.
 	 */
-	bool force = mm_tlb_flush_nested(tlb->mm);
+	if (mm_tlb_flush_nested(tlb->mm)) {
+		__tlb_reset_range(tlb);
+		__tlb_adjust_range(tlb, start, end - start);
+	}
 
-	arch_tlb_finish_mmu(tlb, start, end, force);
+	tlb_flush_mmu(tlb);
+
+	/* keep the page table cache within bounds */
+	check_pgt_cache();
+#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+	tlb_batch_list_free(tlb);
+#endif
 	dec_tlb_flush_pending(tlb->mm);
 }


