Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeFALZN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:25:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50318 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeFALZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:07 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 09/19] arm64: convert syscall trace logic to C
Date: Fri,  1 Jun 2018 12:24:31 +0100
Message-Id: <20180601112441.37810-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently syscall tracing is a tricky assembly state machine, which can
be rather difficult to follow, and even harder to modify. Before we
start fiddling with it for pt_regs syscalls, let's convert it to C.

This is not intended to have any functional change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S   | 53 ++---------------------------------------
 arch/arm64/kernel/syscall.c | 58 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 46543f34b9dc..05b9f03f3e00 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -896,24 +896,6 @@ el0_error_naked:
 	b	ret_to_user
 ENDPROC(el0_error)
 
-
-/*
- * This is the fast syscall return path.  We do as little as possible here,
- * and this includes saving x0 back into the kernel stack.
- */
-ret_fast_syscall:
-	disable_daif
-	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
-	and	x2, x1, #_TIF_SYSCALL_WORK
-	cbnz	x2, ret_fast_syscall_trace
-	and	x2, x1, #_TIF_WORK_MASK
-	cbnz	x2, work_pending
-	enable_step_tsk x1, x2
-	kernel_exit 0
-ret_fast_syscall_trace:
-	enable_daif
-	b	__sys_trace_return_skipped	// we already saved x0
-
 /*
  * Ok, we need to do extra processing, enter the slow path.
  */
@@ -969,44 +951,13 @@ alternative_else_nop_endif
 #endif
 
 el0_svc_naked:					// compat entry point
-	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
-	enable_daif
-	ct_user_exit 1
-
-	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
-	b.ne	__sys_trace
 	mov	x0, sp
 	mov	w1, wscno
 	mov	w2, wsc_nr
 	mov	x3, stbl
-	bl	invoke_syscall
-	b	ret_fast_syscall
-ENDPROC(el0_svc)
-
-	/*
-	 * This is the really slow path.  We're going to be doing context
-	 * switches, and waiting for our parent to respond.
-	 */
-__sys_trace:
-	cmp     wscno, #NO_SYSCALL		// user-issued syscall(-1)?
-	b.ne	1f
-	mov	x0, #-ENOSYS			// set default errno if so
-	str	x0, [sp, #S_X0]
-1:	mov	x0, sp
-	bl	syscall_trace_enter
-	cmp	w0, #NO_SYSCALL			// skip the syscall?
-	b.eq	__sys_trace_return_skipped
-
-	mov	x0, sp
-	mov	w1, wscno
-	mov w2, wsc_nr
-	mov	x3, stbl
-	bl	invoke_syscall
-
-__sys_trace_return_skipped:
-	mov	x0, sp
-	bl	syscall_trace_exit
+	bl	el0_svc_common
 	b	ret_to_user
+ENDPROC(el0_svc)
 
 	.popsection				// .entry.text
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index b463b962d597..2adf1a073398 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/compiler.h>
+#include <linux/context_tracking.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
 
+#include <asm/daifflags.h>
+#include <asm/thread_info.h>
+
 long do_ni_syscall(struct pt_regs *regs);
 
 typedef long (*syscall_fn_t)(unsigned long, unsigned long,
@@ -16,9 +21,9 @@ static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
 				   regs->regs[4], regs->regs[5]);
 }
 
-asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
-			       unsigned int sc_nr,
-			       syscall_fn_t syscall_table[])
+static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
+			   unsigned int sc_nr,
+			   syscall_fn_t syscall_table[])
 {
 	if (scno < sc_nr) {
 		syscall_fn_t syscall_fn;
@@ -28,3 +33,50 @@ asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		regs->regs[0] = do_ni_syscall(regs);
 	}
 }
+
+static inline bool has_syscall_work(unsigned long flags)
+{
+	return unlikely(flags & _TIF_SYSCALL_WORK);
+}
+
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_exit(struct pt_regs *regs);
+
+asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
+			       syscall_fn_t syscall_table[])
+{
+	unsigned long flags = current_thread_info()->flags;
+
+	regs->orig_x0 = regs->regs[0];
+	regs->syscallno = scno;
+
+	local_daif_restore(DAIF_PROCCTX);
+	user_exit();
+
+	if (has_syscall_work(flags)) {
+		/* set default errno for user-issued syscall(-1) */
+		if (scno == NO_SYSCALL)
+			regs->regs[0] = -ENOSYS;
+		scno = syscall_trace_enter(regs);
+		if (scno == NO_SYSCALL)
+			goto trace_exit;
+	}
+
+	invoke_syscall(regs, scno, sc_nr, syscall_table);
+
+	/*
+	 * The tracing status may have changed under our feet, so we have to
+	 * check again. However, if we were tracing entry, then we always trace
+	 * exit regardless, as the old entry assembly did.
+	 */
+	if (!has_syscall_work(flags)) {
+		local_daif_mask();
+		flags = current_thread_info()->flags;
+		if (!has_syscall_work(flags))
+			return;
+		local_daif_restore(DAIF_PROCCTX);
+	}
+
+trace_exit:
+	syscall_trace_exit(regs);
+}
-- 
2.11.0
