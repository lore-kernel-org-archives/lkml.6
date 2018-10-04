Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB2EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701082147D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701082147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJDU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36339 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:40 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GW-0002ic-3i; Thu, 04 Oct 2018 16:06:08 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/11] x86/fpu: defer FPU state load until return to userspace
Date:   Thu,  4 Oct 2018 16:05:47 +0200
Message-Id: <20181004140547.13014-12-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

Defer loading of FPU state until return to userspace. This gives
the kernel the potential to skip loading FPU state for tasks that
stay in kernel mode, or for tasks that end up with repeated
invocations of kernel_fpu_begin.

It also increases the chances that a task's FPU state will remain
valid in the FPU registers until it is scheduled back in, allowing
us to skip restoring that task's FPU state altogether.

The __fpregs_changes_{begin|end}() section ensures that the register
remain unchanged. Otherwise a context switch or a BH could save the
registers to its FPU context and processor's FPU register would remain
random.
fpu__restore() has one user so I pulled that preempt_disable() part into
fpu__restore(). While the function did *load* the registers, it now just
makes sure that they are loaded on return to userland.

KVM swaps the host/guest register on enry/exit path. I kept the flow as
is. First it ensures that the registers are loaded and then saves the
current (host) state before it loads the guest's register. Before
entring the guest, it ensures that the register are still loaded.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/entry/common.c             |   9 +++
 arch/x86/include/asm/fpu/api.h      |  11 +++
 arch/x86/include/asm/fpu/internal.h |  25 ++++---
 arch/x86/include/asm/trace/fpu.h    |   5 +-
 arch/x86/kernel/fpu/core.c          | 108 ++++++++++++++++++++--------
 arch/x86/kernel/fpu/signal.c        |   3 -
 arch/x86/kernel/process.c           |   2 +-
 arch/x86/kernel/process_32.c        |   7 +-
 arch/x86/kernel/process_64.c        |   7 +-
 arch/x86/kvm/x86.c                  |  18 +++--
 10 files changed, 143 insertions(+), 52 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b819181..3dad5c3b335eb 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -31,6 +31,7 @@
 #include <asm/vdso.h>
 #include <linux/uaccess.h>
 #include <asm/cpufeature.h>
+#include <asm/fpu/api.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -196,6 +197,14 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
 		exit_to_usermode_loop(regs, cached_flags);
 
+	/* Reload ti->flags; we may have rescheduled above. */
+	cached_flags = READ_ONCE(ti->flags);
+
+	if (unlikely(cached_flags & _TIF_LOAD_FPU))
+		switch_fpu_return();
+	else
+		fpregs_is_state_consistent();
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a9caac9d4a729..e3077860f7333 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -27,6 +27,17 @@ extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+extern void fpregs_is_state_consistent(void);
+#else
+static inline void fpregs_is_state_consistent(void) { }
+#endif
+
+/*
+ * Load the task FPU state before returning to userspace.
+ */
+extern void switch_fpu_return(void);
+
 /*
  * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
  *
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index df8816be3efdd..346f8057ecd7b 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -32,7 +32,7 @@ extern void fpu__save(struct fpu *fpu);
 extern void fpu__restore(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu);
+extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
@@ -473,21 +473,30 @@ static inline void fpregs_activate(struct fpu *fpu)
 /*
  * Load the FPU state for the current task. Call with preemption disabled.
  */
-static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
+static inline void __fpregs_load_activate(void)
 {
+	struct fpu *fpu = &current->thread.fpu;
+	int cpu = smp_processor_id();
+
 	if (!fpregs_state_valid(fpu, cpu))
 		copy_kernel_to_fpregs(&fpu->state);
 	fpregs_activate(fpu);
+	fpu->last_cpu = cpu;
+	clear_thread_flag(TIF_LOAD_FPU);
 }
 
+void fpregs_load_activate(void);
+
 static inline void __fpregs_changes_begin(void)
 {
 	preempt_disable();
+	local_bh_disable();
 }
 
 static inline void __fpregs_changes_end(void)
 {
 	preempt_enable();
+	local_bh_enable();
 }
 
 /*
@@ -498,8 +507,8 @@ static inline void __fpregs_changes_end(void)
  *  - switch_fpu_prepare() saves the old state.
  *    This is done within the context of the old process.
  *
- *  - switch_fpu_finish() restores the new state as
- *    necessary.
+ *  - switch_fpu_finish() sets TIF_LOAD_FPU; the floating point state
+ *    will get loaded on return to userspace, or when the kernel needs it.
  */
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)
@@ -521,10 +530,10 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 
 /*
- * Set up the userspace FPU context for the new task, if the task
- * has used the FPU.
+ * Load PKRU from the FPU context if available. Delay loading the loading of the
+ * complete FPU state until the return to userland.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
+static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
 	bool load_fpu;
 
@@ -545,7 +554,7 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 #endif
 	if (!load_fpu)
 		return;
-	__fpregs_load_activate(new_fpu, cpu);
+	set_thread_flag(TIF_LOAD_FPU);
 }
 
 /*
diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 069c04be15076..ec3be1c9da7ec 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -14,6 +14,7 @@ DECLARE_EVENT_CLASS(x86_fpu,
 	TP_STRUCT__entry(
 		__field(struct fpu *, fpu)
 		__field(bool, initialized)
+		__field(bool, load_fpu)
 		__field(u64, xfeatures)
 		__field(u64, xcomp_bv)
 		),
@@ -21,14 +22,16 @@ DECLARE_EVENT_CLASS(x86_fpu,
 	TP_fast_assign(
 		__entry->fpu		= fpu;
 		__entry->initialized	= fpu->initialized;
+		__entry->load_fpu	= test_thread_flag(TIF_LOAD_FPU);
 		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
 			__entry->xfeatures = fpu->state.xsave.header.xfeatures;
 			__entry->xcomp_bv  = fpu->state.xsave.header.xcomp_bv;
 		}
 	),
-	TP_printk("x86/fpu: %p initialized: %d xfeatures: %llx xcomp_bv: %llx",
+	TP_printk("x86/fpu: %p initialized: %d load: %d xfeatures: %llx xcomp_bv: %llx",
 			__entry->fpu,
 			__entry->initialized,
+			__entry->load_fpu,
 			__entry->xfeatures,
 			__entry->xcomp_bv
 	)
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 72cd2e2a07194..c757fd1a8440d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,14 +101,15 @@ void __kernel_fpu_begin(void)
 
 	kernel_fpu_disable();
 
-	if (fpu->initialized) {
+	__cpu_invalidate_fpregs_state();
+
+	if (!test_thread_flag(TIF_LOAD_FPU)) {
+		set_thread_flag(TIF_LOAD_FPU);
 		/*
 		 * Ignore return value -- we don't care if reg state
 		 * is clobbered.
 		 */
 		copy_fpregs_to_fpstate(fpu);
-	} else {
-		__cpu_invalidate_fpregs_state();
 	}
 }
 EXPORT_SYMBOL(__kernel_fpu_begin);
@@ -117,8 +118,7 @@ void __kernel_fpu_end(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
-	if (fpu->initialized)
-		copy_kernel_to_fpregs(&fpu->state);
+	switch_fpu_finish(fpu);
 
 	kernel_fpu_enable();
 }
@@ -147,15 +147,15 @@ void fpu__save(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	preempt_disable();
+	__fpregs_changes_begin();
 	trace_x86_fpu_before_save(fpu);
-	if (fpu->initialized) {
+	if (fpu->initialized && !test_thread_flag(TIF_LOAD_FPU)) {
 		if (!copy_fpregs_to_fpstate(fpu)) {
 			copy_kernel_to_fpregs(&fpu->state);
 		}
 	}
 	trace_x86_fpu_after_save(fpu);
-	preempt_enable();
+	__fpregs_changes_end();
 }
 EXPORT_SYMBOL_GPL(fpu__save);
 
@@ -188,8 +188,11 @@ void fpstate_init(union fpregs_state *state)
 }
 EXPORT_SYMBOL_GPL(fpstate_init);
 
-int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
+int fpu__copy(struct task_struct *dst, struct task_struct *src)
 {
+	struct fpu *dst_fpu = &dst->thread.fpu;
+	struct fpu *src_fpu = &src->thread.fpu;
+
 	dst_fpu->last_cpu = -1;
 
 	if (!src_fpu->initialized || !static_cpu_has(X86_FEATURE_FPU))
@@ -204,16 +207,23 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
 
 	/*
-	 * Save current FPU registers directly into the child
+	 * If the FPU registers are not loaded just memcpy() the state.
+	 * Otherwise save current FPU registers directly into the child
 	 * FPU context, without any memory-to-memory copying.
 	 *
 	 * ( The function 'fails' in the FNSAVE case, which destroys
-	 *   register contents so we have to copy them back. )
+	 *   register contents so we have to load them back. )
 	 */
-	if (!copy_fpregs_to_fpstate(dst_fpu)) {
-		memcpy(&src_fpu->state, &dst_fpu->state, fpu_kernel_xstate_size);
-		copy_kernel_to_fpregs(&src_fpu->state);
-	}
+	__fpregs_changes_begin();
+	if (test_thread_flag(TIF_LOAD_FPU))
+		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
+
+	else if (!copy_fpregs_to_fpstate(dst_fpu))
+		copy_kernel_to_fpregs(&dst_fpu->state);
+
+	__fpregs_changes_end();
+
+	set_tsk_thread_flag(dst, TIF_LOAD_FPU);
 
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
@@ -236,6 +246,7 @@ void fpu__initialize(struct fpu *fpu)
 		trace_x86_fpu_activate_state(fpu);
 		/* Safe to do for the current task: */
 		fpu->initialized = 1;
+		set_thread_flag(TIF_LOAD_FPU);
 	}
 }
 EXPORT_SYMBOL_GPL(fpu__initialize);
@@ -306,26 +317,18 @@ void fpu__prepare_write(struct fpu *fpu)
 }
 
 /*
- * 'fpu__restore()' is called to copy FPU registers from
- * the FPU fpstate to the live hw registers and to activate
- * access to the hardware registers, so that FPU instructions
- * can be used afterwards.
- *
- * Must be called with kernel preemption disabled (for example
- * with local interrupts disabled, as it is in the case of
- * do_device_not_available()).
+ * 'fpu__restore()' is called to ensure that the FPU registers in fpstate
+ * are loaded on return to userspace.
  */
 void fpu__restore(struct fpu *fpu)
 {
-	fpu__initialize(fpu);
+	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	/* Avoid __kernel_fpu_begin() right after fpregs_activate() */
-	kernel_fpu_disable();
 	trace_x86_fpu_before_restore(fpu);
-	fpregs_activate(fpu);
-	copy_kernel_to_fpregs(&fpu->state);
+	__fpu_invalidate_fpregs_state(fpu);
+	fpu->initialized = 1;
+	set_thread_flag(TIF_LOAD_FPU);
 	trace_x86_fpu_after_restore(fpu);
-	kernel_fpu_enable();
 }
 EXPORT_SYMBOL_GPL(fpu__restore);
 
@@ -400,6 +403,53 @@ void fpu__clear(struct fpu *fpu)
 	}
 }
 
+/*
+ * Load FPU context before returning to userspace.
+ */
+void switch_fpu_return(void)
+{
+	if (!static_cpu_has(X86_FEATURE_FPU))
+		return;
+
+	/*
+	 * We should never return to user space without the task's
+	 * own FPU contents loaded into the registers. That makes it
+	 * a bug to not have the task's FPU state set up.
+	 */
+	WARN_ON_FPU(!current->thread.fpu.initialized);
+
+	__fpregs_load_activate();
+}
+EXPORT_SYMBOL_GPL(switch_fpu_return);
+
+#ifdef CONFIG_X86_DEBUG_FPU
+/*
+ * If current FPU state according to its tracking (loaded FPU ctx on this CPU)
+ * is not valid then we must have TIF_LOAD_FPU set so the context is loaded on
+ * return to userland.
+ */
+void fpregs_is_state_consistent(void)
+{
+       struct fpu *fpu = &current->thread.fpu;
+
+       if (!fpu->initialized)
+               return;
+       if (test_thread_flag(TIF_LOAD_FPU))
+               return;
+       WARN_ON_FPU(!fpregs_state_valid(fpu, smp_processor_id()));
+}
+EXPORT_SYMBOL_GPL(fpregs_is_state_consistent);
+#endif
+
+void fpregs_load_activate(void)
+{
+	if (test_thread_flag(TIF_LOAD_FPU))
+		__fpregs_load_activate();
+	else
+		fpregs_is_state_consistent();
+}
+EXPORT_SYMBOL_GPL(fpregs_load_activate);
+
 /*
  * x87 math exception handling:
  */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 979dcd1ed82e0..45d2f165b47ac 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -325,10 +325,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
-		fpu->initialized = 1;
-		preempt_disable();
 		fpu__restore(fpu);
-		preempt_enable();
 
 		return err;
 	} else {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfdf16734..cd7105fb92bfc 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,7 +96,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.vm86 = NULL;
 #endif
 
-	return fpu__copy(&dst->thread.fpu, &src->thread.fpu);
+	return fpu__copy(dst, src);
 }
 
 /*
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5046a3c9dec2f..a65f8ce36379b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -236,7 +236,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	switch_fpu_prepare(prev_fpu, cpu);
+	if (prev_fpu->initialized && !test_thread_flag(TIF_LOAD_FPU))
+		switch_fpu_prepare(prev_fpu, cpu);
 
 	/*
 	 * Save away %gs. No need to save %fs, as it was saved on the
@@ -297,10 +298,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		lazy_load_gs(next->gs);
 
-	switch_fpu_finish(next_fpu, cpu);
-
 	this_cpu_write(current_task, next_p);
 
+	switch_fpu_finish(next_fpu);
+
 	/* Load the Intel cache allocation PQR MSR. */
 	intel_rdt_sched_in();
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ea5ea850348da..66b763f3da6a0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -427,7 +427,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(irq_count) != -1);
 
-	switch_fpu_prepare(prev_fpu, cpu);
+	if (prev_fpu->initialized && !test_thread_flag(TIF_LOAD_FPU))
+		switch_fpu_prepare(prev_fpu, cpu);
 
 	/* We must save %fs and %gs before load_TLS() because
 	 * %fs and %gs may be cleared by load_TLS().
@@ -478,8 +479,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	load_seg_legacy(prev->gsindex, prev->gsbase,
 			next->gsindex, next->gsbase, GS);
 
-	switch_fpu_finish(next_fpu, cpu);
-
 	/*
 	 * Switch the PDA and FPU contexts.
 	 */
@@ -489,6 +488,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Reload sp0. */
 	update_task_stack(next_p);
 
+	switch_fpu_finish(next_fpu);
+
 	/*
 	 * Now maybe reload the debug registers and handle I/O bitmaps
 	 */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index edbf00ec56b34..2a9f35e8bb81e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7592,6 +7592,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		wait_lapic_expire(vcpu);
 	guest_enter_irqoff();
 
+	if (test_thread_flag(TIF_LOAD_FPU))
+		switch_fpu_return();
+	else
+		fpregs_is_state_consistent();
+
 	if (unlikely(vcpu->arch.switch_db_regs)) {
 		set_debugreg(0, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
@@ -7851,22 +7856,27 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 /* Swap (qemu) user FPU context for the guest FPU context. */
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	preempt_disable();
+	__fpregs_changes_begin();
+	fpregs_load_activate();
+
 	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
+
 	/* PKRU is separately restored in kvm_x86_ops->run.  */
 	__copy_kernel_to_fpregs(&vcpu->arch.guest_fpu.state,
 				~XFEATURE_MASK_PKRU);
-	preempt_enable();
+	__fpregs_changes_end();
 	trace_kvm_fpu(1);
 }
 
 /* When vcpu_run ends, restore user space FPU context. */
 static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	preempt_disable();
+	__fpregs_changes_begin();
+	fpregs_load_activate();
+
 	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
 	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
-	preempt_enable();
+	__fpregs_changes_end();
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
 }
-- 
2.19.0

