Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9DC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECD1223C6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECD1223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbeKVGyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbeKVGyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:11 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYx3-0000IL-FP; Wed, 21 Nov 2018 21:18:21 +0100
Message-Id: <20181121201723.948990148@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 17/24] x86/speculation: Move IBPB control out of switch_mm()
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-speculation--Move-IBPB-control-out-of-switch_mm--.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBPB control is currently in switch_mm() to avoid issuing IBPB when
switching between tasks of the same process.

But that's not covering the case of sandboxed tasks which get the
TIF_SPEC_IB flag set via seccomp. There the barrier is required when the
potentially malicious task is switched out because the task which is
switched in might have it not set and would still be attackable.

For tasks which mark themself with TIF_SPEC_IB via the prctl, the barrier
needs to be when the tasks switches in because the previous one might be an
attacker.

Move the code out of switch_mm() and evaluate the TIF bit in
switch_to(). Make it an inline function so it can be used both in 32bit and
64bit code.

This loses the optimization of switching back to the same process, but
that's wrong in the context of seccomp anyway as it does not protect tasks
of the same process against each other.

This could be optimized by keeping track of the last user task per cpu and
avoiding the barrier when the task is immediately scheduled back and the
thread inbetween was a kernel thread. It's dubious whether that'd be worth
the extra load/store and conditional operations. Keep it optimized for the
common case where the TIF bit is not set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/nospec-branch.h |    2 +
 arch/x86/include/asm/spec-ctrl.h     |   46 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tlbflush.h      |    2 -
 arch/x86/kernel/cpu/bugs.c           |   16 +++++++++++-
 arch/x86/kernel/process_32.c         |   11 ++++++--
 arch/x86/kernel/process_64.c         |   11 ++++++--
 arch/x86/mm/tlb.c                    |   39 -----------------------------
 7 files changed, 81 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -312,6 +312,8 @@ do {									\
 } while (0)
 
 DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+DECLARE_STATIC_KEY_FALSE(switch_to_cond_ibpb);
+DECLARE_STATIC_KEY_FALSE(switch_to_always_ibpb);
 
 #endif /* __ASSEMBLY__ */
 
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -76,6 +76,52 @@ static inline u64 ssbd_tif_to_amd_ls_cfg
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
+/**
+ * switch_to_ibpb - Issue IBPB on task switch
+ * @next:	Pointer to the next task
+ * @prev_tif:	Threadinfo flags of the previous task
+ * @next_tif:	Threadinfo flags of the next task
+ *
+ * IBPB flushes the branch predictor, which stops Spectre-v2 attacks
+ * between user space tasks. Depending on the mode the flush is made
+ * conditional.
+ */
+static inline void switch_to_ibpb(struct task_struct *next,
+				  unsigned long prev_tif,
+				  unsigned long next_tif)
+{
+	if (static_branch_unlikely(&switch_to_always_ibpb)) {
+		/* Only flush when switching to a user task. */
+		if (next->mm)
+			indirect_branch_prediction_barrier();
+	}
+
+	if (static_branch_unlikely(&switch_to_cond_ibpb)) {
+		/*
+		 * Both tasks' threadinfo flags are checked for TIF_SPEC_IB.
+		 *
+		 * For an outgoing sandboxed task which has TIF_SPEC_IB set
+		 * via seccomp this is needed because it might be malicious
+		 * and the next user task switching in might not have it
+		 * set.
+		 *
+		 * For an incoming task which has set TIF_SPEC_IB itself
+		 * via prctl() this is needed because the previous user
+		 * task might be malicious and have the flag unset.
+		 *
+		 * This could be optimized by keeping track of the last
+		 * user task per cpu and avoiding the barrier when the task
+		 * is immediately scheduled back and the thread inbetween
+		 * was a kernel thread. It's dubious whether that'd be
+		 * worth the extra load/store and conditional operations.
+		 * Keep it optimized for the common case where the TIF bit
+		 * is not set.
+		 */
+		if ((prev_tif | next_tif) & _TIF_SPEC_IB)
+			indirect_branch_prediction_barrier();
+	}
+}
+
 #ifdef CONFIG_SMP
 extern void speculative_store_bypass_ht_init(void);
 #else
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -171,8 +171,6 @@ struct tlb_state {
 
 	u16 loaded_mm_asid;
 	u16 next_asid;
-	/* last user mm's ctx id */
-	u64 last_ctx_id;
 
 	/*
 	 * We can be in one of several states:
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,6 +56,10 @@ u64 __ro_after_init x86_amd_ls_cfg_ssbd_
 
 /* Control conditional STIPB in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
+/* Control conditional IBPB in switch_to() */
+DEFINE_STATIC_KEY_FALSE(switch_to_cond_ibpb);
+/* Control unconditional IBPB in switch_to() */
+DEFINE_STATIC_KEY_FALSE(switch_to_always_ibpb);
 
 void __init check_bugs(void)
 {
@@ -331,7 +335,17 @@ spectre_v2_app2app_select_mitigation(enu
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
+
+		switch (mode) {
+		case SPECTRE_V2_APP2APP_STRICT:
+			static_branch_enable(&switch_to_always_ibpb);
+			break;
+		default:
+			break;
+		}
+
+		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
+			mode == SPECTRE_V2_APP2APP_STRICT ? "forced" : "conditional");
 	}
 
 	/* If enhanced IBRS is enabled no STIPB required */
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -58,6 +58,7 @@
 #include <asm/vm86.h>
 #include <asm/intel_rdt_sched.h>
 #include <asm/proto.h>
+#include <asm/spec-ctrl.h>
 
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
@@ -231,6 +232,7 @@ EXPORT_SYMBOL_GPL(start_thread);
 			     *next = &next_p->thread;
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
+	unsigned long prev_tif, next_tif;
 	int cpu = smp_processor_id();
 	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
@@ -264,11 +266,16 @@ EXPORT_SYMBOL_GPL(start_thread);
 	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
 		set_iopl_mask(next->iopl);
 
+	prev_tif = task_thread_info(prev_p)->flags;
+	next_tif = task_thread_info(next_p)->flags;
+	/* Indirect branch prediction barrier control */
+	switch_to_ibpb(next_p, prev_tif, next_tif);
+
 	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
-	if (unlikely(task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV ||
-		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
+	if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
+		     prev_tif & _TIF_WORK_CTXSW_PREV))
 		__switch_to_xtra(prev_p, next_p, tss);
 
 	/*
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -55,6 +55,7 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
+#include <asm/spec-ctrl.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -552,6 +553,7 @@ void compat_start_thread(struct pt_regs
 	struct thread_struct *next = &next_p->thread;
 	struct fpu *prev_fpu = &prev->fpu;
 	struct fpu *next_fpu = &next->fpu;
+	unsigned long prev_tif, next_tif;
 	int cpu = smp_processor_id();
 	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
 
@@ -617,11 +619,16 @@ void compat_start_thread(struct pt_regs
 	/* Reload sp0. */
 	update_task_stack(next_p);
 
+	prev_tif = task_thread_info(prev_p)->flags;
+	next_tif = task_thread_info(next_p)->flags;
+	/* Indirect branch prediction barrier control */
+	switch_to_ibpb(next_p, prev_tif, next_tif);
+
 	/*
 	 * Now maybe reload the debug registers and handle I/O bitmaps
 	 */
-	if (unlikely(task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT ||
-		     task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV))
+	if (unlikely(next_tif & _TIF_WORK_CTXSW_NEXT ||
+		     prev_tif & _TIF_WORK_CTXSW_PREV))
 		__switch_to_xtra(prev_p, next_p, tss);
 
 #ifdef CONFIG_XEN_PV
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -181,19 +181,6 @@ static void sync_current_stack_to_mm(str
 	}
 }
 
-static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
-{
-	/*
-	 * Check if the current (previous) task has access to the memory
-	 * of the @tsk (next) task. If access is denied, make sure to
-	 * issue a IBPB to stop user->user Spectre-v2 attacks.
-	 *
-	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
-	 */
-	return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
-		ptrace_may_access_sched(tsk, PTRACE_MODE_SPEC_IBPB));
-}
-
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -292,23 +279,6 @@ void switch_mm_irqs_off(struct mm_struct
 		new_asid = prev_asid;
 		need_flush = true;
 	} else {
-		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
-
-		/*
-		 * Avoid user/user BTB poisoning by flushing the branch
-		 * predictor when switching between processes. This stops
-		 * one process from doing Spectre-v2 attacks on another.
-		 *
-		 * As an optimization, flush indirect branches only when
-		 * switching into a processes that can't be ptrace by the
-		 * current one (as in such case, attacker has much more
-		 * convenient way how to tamper with the next process than
-		 * branch buffer poisoning).
-		 */
-		if (static_cpu_has(X86_FEATURE_USE_IBPB) &&
-				ibpb_needed(tsk, last_ctx_id))
-			indirect_branch_prediction_barrier();
-
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
 			 * If our current stack is in vmalloc space and isn't
@@ -365,14 +335,6 @@ void switch_mm_irqs_off(struct mm_struct
 		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
-	/*
-	 * Record last user mm's context id, so we can avoid
-	 * flushing branch buffer with IBPB if we switch back
-	 * to the same user.
-	 */
-	if (next != &init_mm)
-		this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
-
 	/* Make sure we write CR3 before loaded_mm. */
 	barrier();
 
@@ -441,7 +403,6 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);


