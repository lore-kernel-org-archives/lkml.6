Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64EFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636B621479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636B621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJIWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:19:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:19:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F1Two1081637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:01:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F1TZs1081634;
        Tue, 9 Oct 2018 08:01:29 -0700
Date:   Tue, 9 Oct 2018 08:01:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-145f573b89a62bf53cfc0144fa9b1c56b0f70b45@git.kernel.org>
Cc:     songliubraving@fb.com, mingo@kernel.org, riel@surriel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          riel@surriel.com, mingo@kernel.org, songliubraving@fb.com,
          peterz@infradead.org
In-Reply-To: <20180926035844.1420-8-riel@surriel.com>
References: <20180926035844.1420-8-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
Git-Commit-ID: 145f573b89a62bf53cfc0144fa9b1c56b0f70b45
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  145f573b89a62bf53cfc0144fa9b1c56b0f70b45
Gitweb:     https://git.kernel.org/tip/145f573b89a62bf53cfc0144fa9b1c56b0f70b45
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Tue, 25 Sep 2018 23:58:44 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:12 +0200

x86/mm/tlb: Make lazy TLB mode lazier

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

We can change native_flush_tlb_others() without touching other
(paravirt) implementations of flush_tlb_others() because we'll be
flushing less. The existing implementations flush more and are
therefore still correct.

Cc: npiggin@gmail.com
Cc: mingo@kernel.org
Cc: will.deacon@arm.com
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180926035844.1420-8-riel@surriel.com
---
 arch/x86/mm/tlb.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 92e46f4c058c..7d68489cfdb1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -185,6 +185,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -242,17 +243,40 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
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
 
@@ -346,8 +370,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
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
@@ -455,6 +481,9 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * paging-structure cache to avoid speculatively reading
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
+		 *
+		 * This should be rare, with native_flush_tlb_others skipping
+		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
 		return;
@@ -557,6 +586,11 @@ static void flush_tlb_func_remote(void *info)
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
@@ -592,8 +626,23 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
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
