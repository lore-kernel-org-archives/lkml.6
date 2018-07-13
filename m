Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A583AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84A208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E84A208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeGMSFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:05:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48351 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeGMSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:05:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fe2CI-0004gb-8V; Fri, 13 Jul 2018 19:49:38 +0200
Date:   Fri, 13 Jul 2018 19:49:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711093346.782af07a@gandalf.local.home>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
code disables BH and expects that it is not preemptible. On -RT the
task remains preemptible but remains the same CPU. This may corrupt the
content of the SIMD registers if the task is preempted during
saving/restoring those registers.
Add a locallock around this process. This avoids that the any function
within the locallock block is invoked more than once on the same CPU.

The kernel_neon_begin() can't be kept preemptible. If the task-switch notices
TIF_FOREIGN_FPSTATE then it would restore task's SIMD state and we lose the
state of registers used for in-kernel-work. We would require additional storage
for the in-kernel copy of the registers. But then the NEON-crypto checks for
the need-resched flag so it shouldn't that bad.
The preempt_disable() avoids the context switch while the kernel uses the SIMD
registers. Unfortunately we have to balance out the migrate_disable() counter
because local_lock_bh() is invoked in different context compared to its unlock
counterpart.

__efi_fpsimd_begin() should not use kernel_fpu_begin() due to its
preempt_disable() context and instead save the registers always in its
extra spot on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This seems to make work (crypto chacha20-neon + cyclictest). I have no
EFI so I have no clue if saving SIMD while calling to EFI works.

 arch/arm64/kernel/fpsimd.c |   47 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -38,6 +38,7 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/locallock.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
@@ -235,7 +236,7 @@ static void sve_user_enable(void)
  *    whether TIF_SVE is clear or set, since these are not vector length
  *    dependent.
  */
-
+static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
 /*
  * Update current's FPSIMD/SVE registers from thread_struct.
  *
@@ -594,7 +595,7 @@ int sve_set_vector_length(struct task_st
 	 * non-SVE thread.
 	 */
 	if (task == current) {
-		local_bh_disable();
+		local_lock_bh(fpsimd_lock);
 
 		task_fpsimd_save();
 		set_thread_flag(TIF_FOREIGN_FPSTATE);
@@ -605,7 +606,7 @@ int sve_set_vector_length(struct task_st
 		sve_to_fpsimd(task);
 
 	if (task == current)
-		local_bh_enable();
+		local_unlock_bh(fpsimd_lock);
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -837,7 +838,7 @@ asmlinkage void do_sve_acc(unsigned int
 
 	sve_alloc(current);
 
-	local_bh_disable();
+	local_lock_bh(fpsimd_lock);
 
 	task_fpsimd_save();
 	fpsimd_to_sve(current);
@@ -849,7 +850,7 @@ asmlinkage void do_sve_acc(unsigned int
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
-	local_bh_enable();
+	local_unlock_bh(fpsimd_lock);
 }
 
 /*
@@ -925,7 +926,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	local_lock_bh(fpsimd_lock);
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_flush_task_state(current);
@@ -967,7 +968,7 @@ void fpsimd_flush_thread(void)
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	local_unlock_bh(fpsimd_lock);
 }
 
 /*
@@ -979,9 +980,9 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	local_lock_bh(fpsimd_lock);
 	task_fpsimd_save();
-	local_bh_enable();
+	local_unlock_bh(fpsimd_lock);
 }
 
 /*
@@ -1021,14 +1022,14 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	local_lock_bh(fpsimd_lock);
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_to_cpu();
 	}
 
-	local_bh_enable();
+	local_unlock_bh(fpsimd_lock);
 }
 
 /*
@@ -1041,7 +1042,7 @@ void fpsimd_update_current_state(struct
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	local_lock_bh(fpsimd_lock);
 
 	current->thread.fpsimd_state.user_fpsimd = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1052,7 +1053,7 @@ void fpsimd_update_current_state(struct
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_bind_to_cpu();
 
-	local_bh_enable();
+	local_unlock_bh(fpsimd_lock);
 }
 
 /*
@@ -1115,7 +1116,7 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
-	local_bh_disable();
+	local_lock_bh(fpsimd_lock);
 
 	__this_cpu_write(kernel_neon_busy, true);
 
@@ -1129,8 +1130,14 @@ void kernel_neon_begin(void)
 	fpsimd_flush_cpu_state();
 
 	preempt_disable();
-
-	local_bh_enable();
+	/*
+	 * ballance atomic vs !atomic context of migrate_disable().
+	 * local_lock_bh = get_local_var() + spin_lock_bh (2x migrate_disable)
+	 */
+	migrate_disable();
+	migrate_disable();
+	migrate_disable();
+	local_unlock_bh(fpsimd_lock);
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
@@ -1154,6 +1161,10 @@ void kernel_neon_end(void)
 	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
 
 	preempt_enable();
+	/* balance migrate_disable(). See kernel_neon_begin() */
+	migrate_enable();
+	migrate_enable();
+	migrate_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
@@ -1185,9 +1196,7 @@ void __efi_fpsimd_begin(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	WARN_ON(preemptible());
-
-	if (may_use_simd()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
 		kernel_neon_begin();
 	} else {
 		/*
