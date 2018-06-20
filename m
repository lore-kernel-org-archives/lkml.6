Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64635C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB102083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB102083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeFTT5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:57:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52072 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754824AbeFTT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:57:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVjDr-0002g7-Ci; Wed, 20 Jun 2018 15:56:55 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Date:   Wed, 20 Jun 2018 15:56:49 -0400
Message-Id: <20180620195652.27251-5-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620195652.27251-1-riel@surriel.com>
References: <20180620195652.27251-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lazy TLB mode can result in an idle CPU being woken up by a TLB flush,
when all it really needs to do is reload %CR3 at the next context switch,
assuming no page table pages got freed.

This patch deals with that issue by introducing a third TLB state,
TLBSTATE_FLUSH, which causes %CR3 to be reloaded at the next context
switch.

Atomic compare and exchange is used to close races between the TLB
shootdown code and the context switch code. Keying off just the
tlb_gen is likely to not be enough, since that would not give
lazy_clb_can_skip_flush() information on when it is facing a race
and has to send the IPI to a CPU in the middle of a LAZY -> OK switch.

Unlike the 2016 version of this patch, CPUs in TLBSTATE_LAZY are not
removed from the mm_cpumask(mm), since that would prevent the TLB
flush IPIs at page table free time from being sent to all the CPUs
that need them.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/include/asm/tlbflush.h |   5 ++
 arch/x86/include/asm/uv/uv.h    |   6 +--
 arch/x86/mm/tlb.c               | 108 ++++++++++++++++++++++++++++++++++++----
 arch/x86/platform/uv/tlb_uv.c   |   2 +-
 4 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 88a4d6b87ff7..0a8bdd6084de 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -171,6 +171,7 @@ struct tlb_context {
 
 #define TLBSTATE_OK	0
 #define TLBSTATE_LAZY	1
+#define TLBSTATE_FLUSH	2
 
 struct tlb_state {
 	/*
@@ -199,6 +200,10 @@ struct tlb_state {
 	 *    We're heuristically guessing that the CR3 load we
 	 *    skipped more than makes up for the overhead added by
 	 *    lazy mode.
+	 *
+	 *  - Lazily using a real mm, which has seen a TLB invalidation on
+	 *    other CPUs. TLB needs to be flushed at context switch time,
+	 *    state == TLBSTATE_FLUSH.
 	 */
 	int state;
 
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
index e063e623e52c..4b27d8469848 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/gfp.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -227,8 +228,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
-
 	/*
 	 * The membarrier system call requires a full memory barrier and
 	 * core serialization before returning to user-space, after
@@ -236,8 +235,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * memory barrier and core serializing instruction.
 	 */
 	if (real_prev == next) {
+		int *tlbstate = this_cpu_ptr(&cpu_tlbstate.state);
+		int oldstate = *tlbstate;
+
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
-			   next->context.ctx_id);
+				next->context.ctx_id);
 
 		/*
 		 * We don't currently support having a real mm loaded without
@@ -250,6 +252,26 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
+		/*
+		 * In lazy TLB mode. The atomic exchange makes sure there was
+		 * no TLB shootdown all the way to this context switch.
+		 */
+		if (oldstate == TLBSTATE_LAZY)
+			oldstate = cmpxchg(tlbstate, oldstate, TLBSTATE_OK);
+
+		/*
+		 * There was a TLB invalidation while this CPU was idle.
+		 * The code in choose_new_asid will figure out what kind
+		 * of flush is needed.
+		 */
+		if (oldstate == TLBSTATE_FLUSH)
+			goto reload_cr3;
+
+		/*
+		 * Nothing to do. Either we are switching between two
+		 * threads in the same process, or we were in TLBSTATE_LAZY
+		 * without any TLB invalidations happening.
+		 */
 		return;
 	} else {
 		u16 new_asid;
@@ -294,6 +316,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * Start remote flushes and then read tlb_gen.
 		 */
 		cpumask_set_cpu(cpu, mm_cpumask(next));
+ reload_cr3:
+		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
@@ -454,6 +478,9 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * paging-structure cache to avoid speculatively reading
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
+		 *
+		 * This should be rare, with native_flush_tlb_others skipping
+		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
 		return;
@@ -557,9 +584,57 @@ static void flush_tlb_func_remote(void *info)
 	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
 }
 
+/*
+ * Determine whether a CPU's TLB needs to be flushed now, or whether the
+ * flush can be delayed until the next context switch, by changing the
+ * tlbstate from TLBSTATE_LAZY to TLBSTATE_FLUSH.
+ */
+static bool lazy_tlb_can_skip_flush(int cpu)
+{
+	int *tlbstate = &per_cpu(cpu_tlbstate.state, cpu);
+	int old;
+
+	switch (*tlbstate) {
+	case TLBSTATE_FLUSH:
+		/* The TLB will be flushed on the next context switch. */
+		return true;
+	case TLBSTATE_LAZY:
+		/*
+		 * The CPU is in TLBSTATE_LAZY, which could context switch back
+		 * to TLBSTATE_OK, re-using the old TLB state without a flush.
+		 * if that happened, send a TLB flush IPI.
+		 *
+		 * Otherwise, the state is now TLBSTATE_FLUSH, and TLB will
+		 * be flushed at the next context switch. Skip the IPI.
+		 */
+		old = cmpxchg(tlbstate, TLBSTATE_LAZY, TLBSTATE_FLUSH);
+		return old != TLBSTATE_OK;
+	case TLBSTATE_OK:
+	default:
+		/* A task on the CPU is actively using the mm. Flush the TLB. */
+		return false;
+	}
+}
+
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
@@ -583,17 +658,30 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
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
+	}
+
+	/*
+	 * Instead of sending IPIs to CPUs in lazy TLB mode, move that
+	 * CPU's TLB state to TLBSTATE_FLUSH, causing the TLB to be flushed
+	 * at the next context switch, or at page table free time.
+	 */
+	if (can_lazy_flush) {
+		for_each_cpu(cpu, mask) {
+			if (lazy_tlb_can_skip_flush(cpu))
+				cpumask_clear_cpu(cpu, mask);
+		}
 	}
-	smp_call_function_many(cpumask, flush_tlb_func_remote,
+
+	smp_call_function_many(mask, flush_tlb_func_remote,
 			       (void *)info, 1);
+ out:
+	free_cpumask_var(varmask);
 }
 
 /*
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index b36caae0fb2f..42730acec8b7 100644
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

