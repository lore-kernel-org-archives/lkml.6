Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7CEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38812086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38812086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeICVpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbeICVpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:51 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 350A3D2F;
        Mon,  3 Sep 2018 17:24:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will.deacon@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 110/165] mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE
Date:   Mon,  3 Sep 2018 18:56:36 +0200
Message-Id: <20180903165701.034109344@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit d86564a2f085b79ec046a5cba90188e612352806 upstream.

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

[ Modified to be on top of Nick's cleanups, which simplified this patch
  now that tlb_flush_mmu_tlbonly() really only flushes the TLB - Linus ]

Fixes: 9e52fc2b50de ("x86/mm: Enable RCU based page table freeing (CONFIG_HAVE_RCU_TABLE_FREE=y)")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/Kconfig     |    3 +++
 arch/x86/Kconfig |    1 +
 mm/memory.c      |   18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -336,6 +336,9 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_RCU_TABLE_FREE
 	bool
 
+config HAVE_RCU_TABLE_INVALIDATE
+	bool
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -170,6 +170,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_RCU_TABLE_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -331,6 +331,21 @@ bool __tlb_remove_page_size(struct mmu_g
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
+	tlb_flush_mmu_tlbonly(tlb);
+#endif
+}
+
 static void tlb_remove_table_smp_sync(void *arg)
 {
 	/* Simply deliver the interrupt */
@@ -367,6 +382,7 @@ void tlb_table_flush(struct mmu_gather *
 	struct mmu_table_batch **batch = &tlb->batch;
 
 	if (*batch) {
+		tlb_table_invalidate(tlb);
 		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
 		*batch = NULL;
 	}
@@ -388,11 +404,13 @@ void tlb_remove_table(struct mmu_gather
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


