Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D822F27F91
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D822F27F91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934693AbeF2O3v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:29:51 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34340 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbeF2O3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:29:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fYuOx-0000Zu-QT; Fri, 29 Jun 2018 10:29:31 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, hpa@zytor.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Date:   Fri, 29 Jun 2018 10:29:15 -0400
Message-Id: <20180629142918.26601-5-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629142918.26601-1-riel@surriel.com>
References: <20180629142918.26601-1-riel@surriel.com>
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

Unlike the 2016 version of this patch, CPUs with cpu_tlbstate.is_lazy set
are not removed from the mm_cpumask(mm), since that would prevent the TLB
flush IPIs at page table free time from being sent to all the CPUs
that need them.

This patch reduces total CPU use in the system by about 1-2% for a
memcache workload on two socket systems, and by about 1% for a heavily
multi-process netperf between two systems.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/include/asm/uv/uv.h  |  6 ++--
 arch/x86/mm/tlb.c             | 82 ++++++++++++++++++++++++++++++++++++-------
 arch/x86/platform/uv/tlb_uv.c |  2 +-
 3 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index a80c0673798f..d801afb5fe90 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -17,7 +17,7 @@ extern int is_uv_hubless(void);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
 extern void uv_system_init(void);
-extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
+extern struct cpumask *uv_flush_tlb_others(struct cpumask *cpumask,
 						 const struct flush_tlb_info *info);
 
 #else	/* X86_UV */
@@ -27,8 +27,8 @@ static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubless(void)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
-static inline const struct cpumask *
-uv_flush_tlb_others(const struct cpumask *cpumask,
+static inline struct cpumask *
+uv_flush_tlb_others(struct cpumask *cpumask,
 		    const struct flush_tlb_info *info)
 { return cpumask; }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4b73fe835c95..e59214ec52b1 100644
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
@@ -560,6 +588,22 @@ static void flush_tlb_func_remote(void *info)
 void native_flush_tlb_others(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info)
 {
+	cpumask_t *mask = (struct cpumask *)cpumask;
+	cpumask_var_t varmask;
+	bool can_lazy_flush = false;
+	unsigned int cpu;
+
+	/*
+	 * A temporary cpumask allows the kernel to skip sending IPIs
+	 * to CPUs in lazy TLB state, without also removing them from
+	 * mm_cpumask(mm).
+	 */
+	if (alloc_cpumask_var(&varmask, GFP_ATOMIC)) {
+		cpumask_copy(varmask, cpumask);
+		mask = varmask;
+		can_lazy_flush = true;
+	}
+
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
@@ -583,17 +627,29 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
 		cpu = smp_processor_id();
-		cpumask = uv_flush_tlb_others(cpumask, info);
-		if (cpumask)
-			smp_call_function_many(cpumask, flush_tlb_func_remote,
+		mask = uv_flush_tlb_others(mask, info);
+		if (mask)
+			smp_call_function_many(mask, flush_tlb_func_remote,
 					       (void *)info, 1);
-		return;
+		goto out;
 	}
-	smp_call_function_many(cpumask, flush_tlb_func_remote,
+
+	/*
+	 * There is no need to send IPIs to CPUs in lazy TLB mode. They
+	 * can simply flush the TLB at the next context switch.
+	 */
+	if (can_lazy_flush) {
+		for_each_cpu(cpu, mask) {
+			if (per_cpu(cpu_tlbstate.is_lazy, cpu))
+				cpumask_clear_cpu(cpu, mask);
+		}
+	}
+
+	smp_call_function_many(mask, flush_tlb_func_remote,
 			       (void *)info, 1);
+ out:
+	free_cpumask_var(varmask);
 }
 
 /*
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index ca446da48fd2..84a4c6679da6 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1102,7 +1102,7 @@ static int set_distrib_bits(struct cpumask *flush_mask, struct bau_control *bcp,
  * Returns pointer to cpumask if some remote flushing remains to be
  * done.  The returned pointer is valid till preemption is re-enabled.
  */
-const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
+struct cpumask *uv_flush_tlb_others(struct cpumask *cpumask,
 					  const struct flush_tlb_info *info)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.14.4

