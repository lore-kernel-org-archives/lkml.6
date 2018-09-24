Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A765C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFDC2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFDC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeIYAlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:41:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36342 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbeIYAlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:41:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VkD-0002qj-W7; Mon, 24 Sep 2018 14:38:06 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/7] x86/mm/tlb: Make lazy TLB mode lazier
Date:   Mon, 24 Sep 2018 14:37:59 -0400
Message-Id: <20180924183759.23955-8-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
References: <20180924183759.23955-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lazy TLB mode can result in an idle CPU being woken up by a TLB flush,
when all it really needs to do is reload %CR3 at the next context switch,
assuming no page table pages got freed.

Memory ordering is used to prevent race conditions between switch_mm_irqs_off,
which checks whether .tlb_gen changed, and the TLB invalidation code, which
increments .tlb_gen whenever page table entries get invalidated.

The atomic increment in inc_mm_tlb_gen is its own barrier; the context
switch code adds an explicit barrier between reading tlbstate.is_lazy and
next->context.tlb_gen.

CPUs in lazy TLB mode remain part of the mm_cpumask(mm), both because
that allows TLB flush IPIs to be sent at page table freeing time, and
because the cache line bouncing on the mm_cpumask(mm) was responsible
for about half the CPU use in switch_mm_irqs_off().

Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5d73bde0e4c8..280b4cc4c28c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -156,6 +156,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -207,17 +208,40 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			   next->context.ctx_id);
 
 		/*
-		 * We don't currently support having a real mm loaded without
-		 * our cpu set in mm_cpumask().  We have all the bookkeeping
-		 * in place to figure out whether we would need to flush
-		 * if our cpu were cleared in mm_cpumask(), but we don't
-		 * currently use it.
+		 * Even in lazy TLB mode, the CPU should stay set in the
+		 * mm_cpumask. The TLB shootdown code can figure out from
+		 * from cpu_tlbstate.is_lazy whether or not to send an IPI.
 		 */
 		if (WARN_ON_ONCE(real_prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
-		return;
+		/*
+		 * If the CPU is not in lazy TLB mode, we are just switching
+		 * from one thread in a process to another thread in the same
+		 * process. No TLB flush required.
+		 */
+		if (!was_lazy)
+			return;
+
+		/*
+		 * Read the tlb_gen to check whether a flush is needed.
+		 * If the TLB is up to date, just use it.
+		 * The barrier synchronizes with the tlb_gen increment in
+		 * the TLB shootdown code.
+		 */
+		smp_mb();
+		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
+				next_tlb_gen)
+			return;
+
+		/*
+		 * TLB contents went out of date while we were in lazy
+		 * mode. Fall through to the TLB switching code below.
+		 */
+		new_asid = prev_asid;
+		need_flush = true;
 	} else {
 		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
 
@@ -308,8 +332,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
-	load_mm_cr4(next);
-	switch_ldt(real_prev, next);
+	if (next != real_prev) {
+		load_mm_cr4(next);
+		switch_ldt(real_prev, next);
+	}
 }
 
 /*
@@ -416,6 +442,9 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * paging-structure cache to avoid speculatively reading
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
+		 *
+		 * This should be rare, with native_flush_tlb_others skipping
+		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
 		return;
@@ -519,6 +548,11 @@ static void flush_tlb_func_remote(void *info)
 	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
 }
 
+static bool tlb_is_not_lazy(int cpu, void *data)
+{
+	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
+}
+
 void native_flush_tlb_others(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info)
 {
@@ -554,8 +588,23 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 					       (void *)info, 1);
 		return;
 	}
-	smp_call_function_many(cpumask, flush_tlb_func_remote,
+
+	/*
+	 * If no page tables were freed, we can skip sending IPIs to
+	 * CPUs in lazy TLB mode. They will flush the CPU themselves
+	 * at the next context switch.
+	 *
+	 * However, if page tables are getting freed, we need to send the
+	 * IPI everywhere, to prevent CPUs in lazy TLB mode from tripping
+	 * up on the new contents of what used to be page tables, while
+	 * doing a speculative memory access.
+	 */
+	if (info->freed_tables)
+		smp_call_function_many(cpumask, flush_tlb_func_remote,
 			       (void *)info, 1);
+	else
+		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
+				(void *)info, 1, GFP_ATOMIC, cpumask);
 }
 
 /*
-- 
2.17.1

