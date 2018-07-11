Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE4D208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE4D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbeGKOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:02:08 -0400
Received: from foss.arm.com ([217.140.101.70]:36390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388376AbeGKOCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:02:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25A11BA8;
        Wed, 11 Jul 2018 06:57:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B13353F5B1;
        Wed, 11 Jul 2018 06:57:35 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Cc:     catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv5 09/21] arm64: convert syscall trace logic to C
Date:   Wed, 11 Jul 2018 14:56:44 +0100
Message-Id: <20180711135656.20670-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently syscall tracing is a tricky assembly state machine, which can
be rather difficult to follow, and even harder to modify. Before we
start fiddling with it for pt_regs syscalls, let's convert it to C.

This is not intended to have any functional change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S   | 53 ++---------------------------------------
 arch/arm64/kernel/syscall.c | 57 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c0392f78e392..05b9f03f3e00 100644
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
-	mov	w2, wsc_nr
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
index 93d36f22647e..3e1df8ca1e79 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/compiler.h>
+#include <linux/context_tracking.h>
 #include <linux/errno.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
 #include <linux/syscalls.h>
 
+#include <asm/daifflags.h>
 #include <asm/syscall.h>
+#include <asm/thread_info.h>
 
 long compat_arm_syscall(struct pt_regs *regs);
 
@@ -29,9 +33,9 @@ static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
 			  regs->regs[3], regs->regs[4], regs->regs[5]);
 }
 
-asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
-			       unsigned int sc_nr,
-			       const syscall_fn_t syscall_table[])
+static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
+			   unsigned int sc_nr,
+			   const syscall_fn_t syscall_table[])
 {
 	long ret;
 
@@ -45,3 +49,50 @@ asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 
 	regs->regs[0] = ret;
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
+			       const syscall_fn_t syscall_table[])
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

