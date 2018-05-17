Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeEQMkM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:40:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeEQMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:40:10 -0400
Date: Thu, 17 May 2018 14:40:06 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
code disables BH and expects that it is not preemptible. On -RT the
task remains preemptible but remains the same CPU. This may corrupt the
content of the SIMD registers if the task is preempted during
saving/restoring those registers.
Add a locallock around next to the local_bh_disable(). This fulfill the
requirement that the code is not invoked again in different context on
the same CPU while it remains preemptible.

The preempt_disable() + local_bh_enable() combo in kernel_neon_begin()
is not working on -RT. We don't use NEON in kernel mode on RT right now
but this still should be addressed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/kernel/fpsimd.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e7226c4c7493..3a5cd1908874 100644
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
@@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 * non-SVE thread.
 	 */
 	if (task == current) {
+		local_lock(fpsimd_lock);
 		local_bh_disable();
 
 		task_fpsimd_save();
@@ -604,8 +606,10 @@ int sve_set_vector_length(struct task_struct *task,
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
-	if (task == current)
+	if (task == current) {
+		local_unlock(fpsimd_lock);
 		local_bh_enable();
+	}
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -838,6 +842,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	sve_alloc(current);
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	task_fpsimd_save();
 	fpsimd_to_sve(current);
@@ -849,6 +854,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -926,6 +932,7 @@ void fpsimd_flush_thread(void)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_flush_task_state(current);
@@ -967,6 +974,7 @@ void fpsimd_flush_thread(void)
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -980,7 +988,9 @@ void fpsimd_preserve_current_state(void)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 	task_fpsimd_save();
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -1022,12 +1032,14 @@ void fpsimd_restore_current_state(void)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_to_cpu();
 	}
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -1042,6 +1054,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	current->thread.fpsimd_state.user_fpsimd = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1052,6 +1065,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_bind_to_cpu();
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -1116,6 +1130,7 @@ void kernel_neon_begin(void)
 	BUG_ON(!may_use_simd());
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	__this_cpu_write(kernel_neon_busy, true);
 
@@ -1128,6 +1143,7 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
 
+	local_unlock(fpsimd_lock);
 	preempt_disable();
 
 	local_bh_enable();
-- 
2.17.0
