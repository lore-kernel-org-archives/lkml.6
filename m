Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C446420BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C446420BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeGQKHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:07:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbeGQKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:07:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9Z8er1463425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:35:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Z8h11463422;
        Tue, 17 Jul 2018 02:35:08 -0700
Date:   Tue, 17 Jul 2018 02:35:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        songliubraving@fb.com, dave.hansen@intel.com, tglx@linutronix.de,
        riel@surriel.com, hpa@zytor.com, torvalds@linux-foundation.org,
        mingo@kernel.org
Reply-To: peterz@infradead.org, songliubraving@fb.com,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          hpa@zytor.com, riel@surriel.com, tglx@linutronix.de,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180716190337.26133-5-riel@surriel.com>
References: <20180716190337.26133-5-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
Git-Commit-ID: ac0315896970d8589291e9d8a1569fc65967b7f1
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

Commit-ID:  ac0315896970d8589291e9d8a1569fc65967b7f1
Gitweb:     https://git.kernel.org/tip/ac0315896970d8589291e9d8a1569fc65967b7f1
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Mon, 16 Jul 2018 15:03:34 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:35:33 +0200

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

Unlike the 2016 version of this patch, CPUs with cpu_tlbstate.is_lazy set
are not removed from the mm_cpumask(mm), since that would prevent the TLB
flush IPIs at page table free time from being sent to all the CPUs
that need them.

This patch reduces total CPU use in the system by about 1-2% for a
memcache workload on two socket systems, and by about 1% for a heavily
multi-process netperf between two systems.

Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Link: http://lkml.kernel.org/r/20180716190337.26133-5-riel@surriel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4b73fe835c95..26542cc17043 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/gfp.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -185,6 +186,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -242,17 +244,40 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
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
 
@@ -454,6 +479,9 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * paging-structure cache to avoid speculatively reading
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
+		 *
+		 * This should be rare, with native_flush_tlb_others skipping
+		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
 		return;
@@ -560,6 +588,9 @@ static void flush_tlb_func_remote(void *info)
 void native_flush_tlb_others(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info)
 {
+	cpumask_var_t lazymask;
+	unsigned int cpu;
+
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
@@ -583,8 +614,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
 		cpu = smp_processor_id();
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
@@ -592,8 +621,29 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 					       (void *)info, 1);
 		return;
 	}
-	smp_call_function_many(cpumask, flush_tlb_func_remote,
+
+	/*
+	 * A temporary cpumask is used in order to skip sending IPIs
+	 * to CPUs in lazy TLB state, while keeping them in mm_cpumask(mm).
+	 * If the allocation fails, simply IPI every CPU in mm_cpumask.
+	 */
+	if (!alloc_cpumask_var(&lazymask, GFP_ATOMIC)) {
+		smp_call_function_many(cpumask, flush_tlb_func_remote,
+			       (void *)info, 1);
+		return;
+	}
+
+	cpumask_copy(lazymask, cpumask);
+
+	for_each_cpu(cpu, lazymask) {
+		if (per_cpu(cpu_tlbstate.is_lazy, cpu))
+			cpumask_clear_cpu(cpu, lazymask);
+	}
+
+	smp_call_function_many(lazymask, flush_tlb_func_remote,
 			       (void *)info, 1);
+
+	free_cpumask_var(lazymask);
 }
 
 /*
