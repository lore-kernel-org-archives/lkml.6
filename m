Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D804C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142EE2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142EE2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbeGZQXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:23:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbeGZQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:23:54 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fihqc-0000uH-KX; Thu, 26 Jul 2018 17:06:34 +0200
Date:   Thu, 26 Jul 2018 17:06:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
Message-ID: <20180726150634.cl3wccqur6qhle6p@linutronix.de>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724094623.37430032@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
code disables BH and expects that it is not preemptible. On -RT the
task remains preemptible but remains the same CPU. This may corrupt the
content of the SIMD registers if the task is preempted during
saving/restoring those registers.

Add preempt_disable()/enable() to enfore the required semantic on -RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
This should work. Compiling currently gcc-6 on the box to see what
happens. Since the crypto disables preemption "frequently" and I don't
expect or see anything to worry about.

 arch/arm64/kernel/fpsimd.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -157,6 +157,15 @@ static void sve_free(struct task_struct
 	__sve_free(task);
 }
 
+static void *sve_free_atomic(struct task_struct *task)
+{
+	void *sve_state = task->thread.sve_state;
+
+	WARN_ON(test_tsk_thread_flag(task, TIF_SVE));
+
+	task->thread.sve_state = NULL;
+	return sve_state;
+}
 
 /* Offset of FFR in the SVE register dump */
 static size_t sve_ffr_offset(int vl)
@@ -594,6 +603,7 @@ int sve_set_vector_length(struct task_st
 	 * non-SVE thread.
 	 */
 	if (task == current) {
+		preempt_disable();
 		local_bh_disable();
 
 		task_fpsimd_save();
@@ -604,8 +614,10 @@ int sve_set_vector_length(struct task_st
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
-	if (task == current)
+	if (task == current) {
 		local_bh_enable();
+		preempt_enable();
+	}
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -837,6 +849,7 @@ asmlinkage void do_sve_acc(unsigned int
 
 	sve_alloc(current);
 
+	preempt_disable();
 	local_bh_disable();
 
 	task_fpsimd_save();
@@ -850,6 +863,7 @@ asmlinkage void do_sve_acc(unsigned int
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -921,10 +935,12 @@ void fpsimd_thread_switch(struct task_st
 void fpsimd_flush_thread(void)
 {
 	int vl, supported_vl;
+	void *mem = NULL;
 
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
@@ -932,7 +948,7 @@ void fpsimd_flush_thread(void)
 
 	if (system_supports_sve()) {
 		clear_thread_flag(TIF_SVE);
-		sve_free(current);
+		mem = sve_free_atomic(current);
 
 		/*
 		 * Reset the task vector length as required.
@@ -968,6 +984,8 @@ void fpsimd_flush_thread(void)
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
 	local_bh_enable();
+	preempt_enable();
+	kfree(mem);
 }
 
 /*
@@ -979,9 +997,11 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 	task_fpsimd_save();
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -1021,6 +1041,7 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -1029,6 +1050,7 @@ void fpsimd_restore_current_state(void)
 	}
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -1041,6 +1063,7 @@ void fpsimd_update_current_state(struct
 	if (!system_supports_fpsimd())
 		return;
 
+	preempt_disable();
 	local_bh_disable();
 
 	current->thread.fpsimd_state.user_fpsimd = *state;
@@ -1053,6 +1076,7 @@ void fpsimd_update_current_state(struct
 		fpsimd_bind_to_cpu();
 
 	local_bh_enable();
+	preempt_enable();
 }
 
 /*
@@ -1115,6 +1139,7 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
+	preempt_disable();
 	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
@@ -1131,6 +1156,7 @@ void kernel_neon_begin(void)
 	preempt_disable();
 
 	local_bh_enable();
+	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
