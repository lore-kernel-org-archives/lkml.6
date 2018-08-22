Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B59C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3052A21525
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LihpBYe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3052A21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbeHVTL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:11:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHVTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zUKxfxjpgWzZcjbYNf+Wl4oxw1QTfZ/a5hMhTBA6A2c=; b=LihpBYe80MmgqB361ej9IoCREs
        /vL0G5e1PRqx3qNsuISx1zrXxTXiwALJu3yr//2iVpu6gFCuZk0FVc5JqI/LLGa0AnyCNUDhaLQT3
        VkkNNdswlRc8kYqTusppEvH8gakOYOTvLrxneAyZVTu5X8U5hicLVNSp6ElFMGr6Mmtls06D+ybiy
        K2Fd6Y9uFC2CpTlckZzCAtAZUZXkodQz/hQLG3ZaJfvgpgP7QCaGi6ijjI9l9wj3Op5XZHFZVQ1/P
        S1k9FIfD/VLv6KZSJZ8bANA4+yQ3V4DYguO8M/Cv+kgBe5Xd0O5/v2CqEFbFcZnfX9QoVDAB28b+G
        fk0zJHHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsVKM-0004RB-E1; Wed, 22 Aug 2018 15:45:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C2A5C2024D725; Wed, 22 Aug 2018 17:45:44 +0200 (CEST)
Message-ID: <20180822154046.823850812@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Aug 2018 17:30:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
References: <20180822153012.173508681@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann reported that x86 was missing required TLB invalidates when he
hit the !*batch slow path in tlb_remove_table().

This is indeed the case; RCU_TABLE_FREE does not provide TLB (cache)
invalidates, the PowerPC-hash where this code originated and the
Sparc-hash where this was subsequently used did not need that. ARM
which later used this put an explicit TLB invalidate in their
__p*_free_tlb() functions, and PowerPC-radix followed that example.

But when we hooked up x86 we failed to consider this. Fix this by
(optionally) hooking tlb_remove_table() into the TLB invalidate code.

NOTE: s390 was also needing something like this and might now
      be able to use the generic code again.

Cc: stable@kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 9e52fc2b50de ("x86/mm: Enable RCU based page table freeing (CONFIG_HAVE_RCU_TABLE_FREE=y)")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig     |    3 +++
 arch/x86/Kconfig |    1 +
 mm/memory.c      |   27 +++++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -362,6 +362,9 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_RCU_TABLE_FREE
 	bool
 
+config HAVE_RCU_TABLE_INVALIDATE
+	bool
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -180,6 +180,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_RCU_TABLE_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -238,17 +238,22 @@ void arch_tlb_gather_mmu(struct mmu_gath
 	__tlb_reset_range(tlb);
 }
 
-static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
+static void __tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
 	if (!tlb->end)
 		return;
 
 	tlb_flush(tlb);
 	mmu_notifier_invalidate_range(tlb->mm, tlb->start, tlb->end);
+	__tlb_reset_range(tlb);
+}
+
+static void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
+{
+	__tlb_flush_mmu_tlbonly(tlb);
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
-	__tlb_reset_range(tlb);
 }
 
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
@@ -330,6 +335,21 @@ bool __tlb_remove_page_size(struct mmu_g
  * See the comment near struct mmu_table_batch.
  */
 
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
+	__tlb_flush_mmu_tlbonly(tlb);
+#endif
+}
+
 static void tlb_remove_table_smp_sync(void *arg)
 {
 	/* Simply deliver the interrupt */
@@ -366,6 +386,7 @@ void tlb_table_flush(struct mmu_gather *
 	struct mmu_table_batch **batch = &tlb->batch;
 
 	if (*batch) {
+		tlb_table_invalidate(tlb);
 		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
 		*batch = NULL;
 	}
@@ -378,11 +399,13 @@ void tlb_remove_table(struct mmu_gather
 	if (*batch == NULL) {
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		if (*batch == NULL) {
+			tlb_table_invalidate(tlb);
 			tlb_remove_table_one(table);
 			return;
 		}
 		(*batch)->nr = 0;
 	}
+
 	(*batch)->tables[(*batch)->nr++] = table;
 	if ((*batch)->nr == MAX_TABLE_BATCH)
 		tlb_table_flush(tlb);


