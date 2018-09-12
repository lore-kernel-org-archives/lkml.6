Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96794C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5008120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5008120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeILSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:40:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeILSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:40:38 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g05JH-0001Ap-7o; Wed, 12 Sep 2018 15:35:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to userspace
Date:   Wed, 12 Sep 2018 15:33:53 +0200
Message-Id: <20180912133353.20595-11-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912133353.20595-1-bigeasy@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
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

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/entry/common.c             |  9 +++++++++
 arch/x86/include/asm/fpu/api.h      |  5 +++++
 arch/x86/include/asm/fpu/internal.h | 16 +++++++++------
 arch/x86/kernel/fpu/core.c          | 31 ++++++++++++++++++++++-------
 arch/x86/kernel/process_32.c        |  7 ++++---
 arch/x86/kernel/process_64.c        |  7 ++++---
 arch/x86/kvm/x86.c                  | 10 +++++++---
 arch/x86/mm/pkeys.c                 |  2 +-
 8 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3b2490b819181..180e16a8177d2 100644
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
+	if (unlikely(cached_flags & _TIF_LOAD_FPU)) {
+		clear_thread_flag(TIF_LOAD_FPU);
+		switch_fpu_return();
+	}
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a9caac9d4a729..308e66a7fcd62 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -27,6 +27,11 @@ extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 
+/*
+ * Load the task FPU state before returning to userspace.
+ */
+extern void switch_fpu_return(void);
+
 /*
  * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
  *
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 184d76c6470b1..370686972592e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -472,9 +472,11 @@ static inline void fpregs_activate(struct fpu *fpu)
 /*
  * Load the FPU state for the current task. Call with preemption disabled.
  */
-static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
+static inline void __fpregs_load_activate(void)
 {
-	if (!fpregs_state_valid(fpu, cpu))
+	struct fpu *fpu = &current->thread.fpu;
+
+	if (!fpregs_state_valid(fpu, smp_processor_id()))
 		copy_kernel_to_fpregs(&fpu->state);
 	fpregs_activate(fpu);
 }
@@ -482,11 +484,13 @@ static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
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
@@ -497,8 +501,8 @@ static inline void __fpregs_changes_end(void)
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
@@ -523,7 +527,7 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Set up the userspace FPU context for the new task, if the task
  * has used the FPU.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
+static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
 	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
 		       new_fpu->initialized;
@@ -531,7 +535,7 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	if (!preload)
 		return;
 
-	__fpregs_load_activate(new_fpu, cpu);
+	set_thread_flag(TIF_LOAD_FPU);
 	/* Protection keys need to be in place right at context switch time. */
 	if (boot_cpu_has(X86_FEATURE_OSPKE)) {
 		if (new_fpu->pkru != __read_pkru())
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8564086c217fc..cbbd20515cf46 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,14 +101,14 @@ void __kernel_fpu_begin(void)
 
 	kernel_fpu_disable();
 
-	if (fpu->initialized) {
+	__cpu_invalidate_fpregs_state();
+
+	if (!test_and_set_thread_flag(TIF_LOAD_FPU)) {
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
@@ -117,8 +117,7 @@ void __kernel_fpu_end(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
-	if (fpu->initialized)
-		copy_kernel_to_fpregs(&fpu->state);
+	switch_fpu_finish(fpu);
 
 	kernel_fpu_enable();
 }
@@ -147,7 +146,7 @@ void fpu__save(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	preempt_disable();
+	__fpregs_changes_begin();
 	trace_x86_fpu_before_save(fpu);
 	if (fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(fpu)) {
@@ -155,7 +154,7 @@ void fpu__save(struct fpu *fpu)
 		}
 	}
 	trace_x86_fpu_after_save(fpu);
-	preempt_enable();
+	__fpregs_changes_end();
 }
 EXPORT_SYMBOL_GPL(fpu__save);
 
@@ -403,6 +402,24 @@ void fpu__clear(struct fpu *fpu)
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
+
 /*
  * x87 math exception handling:
  */
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
index 2d8b3c257e769..d9a8c5ec8d6fe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7573,6 +7573,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		wait_lapic_expire(vcpu);
 	guest_enter_irqoff();
 
+	if (test_and_clear_thread_flag(TIF_LOAD_FPU))
+		switch_fpu_return();
+
 	if (unlikely(vcpu->arch.switch_db_regs)) {
 		set_debugreg(0, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
@@ -7832,22 +7835,23 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 /* Swap (qemu) user FPU context for the guest FPU context. */
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	preempt_disable();
+	__fpregs_changes_begin();
 	copy_fpregs_to_fpstate(&vcpu->arch.user_fpu);
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
 	copy_fpregs_to_fpstate(&vcpu->arch.guest_fpu);
 	copy_kernel_to_fpregs(&vcpu->arch.user_fpu.state);
 	preempt_enable();
+	__fpregs_changes_end();
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
 }
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6e91529fe2a30..83835abd526d7 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -28,7 +28,7 @@ void write_pkru(u32 pkru)
 	current->thread.fpu.pkru = pkru;
 
 	__fpregs_changes_begin();
-	__fpregs_load_activate(&current->thread.fpu, smp_processor_id());
+	__fpregs_load_activate();
 	__write_pkru(pkru);
 	__fpregs_changes_end();
 }
-- 
2.19.0

