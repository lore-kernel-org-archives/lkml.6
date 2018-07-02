Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C86CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A8125A96
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A8125A96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030370AbeGBLEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:04:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030288AbeGBLEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72EAE1713;
        Mon,  2 Jul 2018 04:04:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62BA83F5BA;
        Mon,  2 Jul 2018 04:04:39 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 07/19] arm64: convert raw syscall invocation to C
Date:   Mon,  2 Jul 2018 12:04:03 +0100
Message-Id: <20180702110415.10465-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a first step towards invoking syscalls with a pt_regs argument,
convert the raw syscall invocation logic to C. We end up with a bit more
register shuffling, but the unified invocation logic means we can unify
the tracing paths, too.

Previously, assembly had to open-code calls to ni_sys() when the system
call number was out-of-bounds for the relevant syscall table. This case
is now handled by invoke_syscall(), and the assembly no longer need to
handle this case explicitly. This allows the tracing paths to be
simplified and unified, as we no longer need the __ni_sys_trace path and
the __sys_trace_return label.

This only converts the invocation of the syscall. The rest of the
syscall triage and tracing is left in assembly for now, and will be
converted in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/Makefile  |  3 ++-
 arch/arm64/kernel/entry.S   | 36 +++++++++------------------------
 arch/arm64/kernel/syscall.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/traps.c   | 16 ---------------
 4 files changed, 61 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm64/kernel/syscall.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 0025f8691046..4e24d2244bd1 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,7 +18,8 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   hyp-stub.o psci.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
-			   smp.o smp_spin_table.o topology.o smccc-call.o
+			   smp.o smp_spin_table.o topology.o smccc-call.o	\
+			   syscall.o
 
 extra-$(CONFIG_EFI)			:= efi-entry.o
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 62f2876f9c63..c0392f78e392 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -903,7 +903,6 @@ ENDPROC(el0_error)
  */
 ret_fast_syscall:
 	disable_daif
-	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
@@ -976,15 +975,11 @@ el0_svc_naked:					// compat entry point
 
 	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
 	b.ne	__sys_trace
-	cmp     wscno, wsc_nr			// check upper syscall limit
-	b.hs	ni_sys
-	mask_nospec64 xscno, xsc_nr, x19	// enforce bounds for syscall number
-	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
-	blr	x16				// call sys_* routine
-	b	ret_fast_syscall
-ni_sys:
 	mov	x0, sp
-	bl	do_ni_syscall
+	mov	w1, wscno
+	mov	w2, wsc_nr
+	mov	x3, stbl
+	bl	invoke_syscall
 	b	ret_fast_syscall
 ENDPROC(el0_svc)
 
@@ -1001,29 +996,18 @@ __sys_trace:
 	bl	syscall_trace_enter
 	cmp	w0, #NO_SYSCALL			// skip the syscall?
 	b.eq	__sys_trace_return_skipped
-	mov	wscno, w0			// syscall number (possibly new)
-	mov	x1, sp				// pointer to regs
-	cmp	wscno, wsc_nr			// check upper syscall limit
-	b.hs	__ni_sys_trace
-	ldp	x0, x1, [sp]			// restore the syscall args
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
-	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
-	blr	x16				// call sys_* routine
 
-__sys_trace_return:
-	str	x0, [sp, #S_X0]			// save returned x0
+	mov	x0, sp
+	mov	w1, wscno
+	mov	w2, wsc_nr
+	mov	x3, stbl
+	bl	invoke_syscall
+
 __sys_trace_return_skipped:
 	mov	x0, sp
 	bl	syscall_trace_exit
 	b	ret_to_user
 
-__ni_sys_trace:
-	mov	x0, sp
-	bl	do_ni_syscall
-	b	__sys_trace_return
-
 	.popsection				// .entry.text
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
new file mode 100644
index 000000000000..8bc2530c8472
--- /dev/null
+++ b/arch/arm64/kernel/syscall.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/errno.h>
+#include <linux/nospec.h>
+#include <linux/ptrace.h>
+#include <linux/syscalls.h>
+
+long compat_arm_syscall(struct pt_regs *regs);
+
+asmlinkage long do_ni_syscall(struct pt_regs *regs)
+{
+#ifdef CONFIG_COMPAT
+	long ret;
+	if (is_compat_task()) {
+		ret = compat_arm_syscall(regs);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+#endif
+
+	return sys_ni_syscall();
+}
+
+typedef long (*syscall_fn_t)(unsigned long, unsigned long,
+			     unsigned long, unsigned long,
+			     unsigned long, unsigned long);
+
+static long __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
+{
+	return syscall_fn(regs->regs[0], regs->regs[1], regs->regs[2],
+			  regs->regs[3], regs->regs[4], regs->regs[5]);
+}
+
+asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
+			       unsigned int sc_nr,
+			       syscall_fn_t syscall_table[])
+{
+	long ret;
+
+	if (scno < sc_nr) {
+		syscall_fn_t syscall_fn;
+		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
+		ret = __invoke_syscall(regs, syscall_fn);
+	} else {
+		ret = do_ni_syscall(regs);
+	}
+
+	regs->regs[0] = ret;
+}
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c27292703bd1..039e9ff379cc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -547,22 +547,6 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 	do_undefinstr(regs);
 }
 
-long compat_arm_syscall(struct pt_regs *regs);
-
-asmlinkage long do_ni_syscall(struct pt_regs *regs)
-{
-#ifdef CONFIG_COMPAT
-	long ret;
-	if (is_compat_task()) {
-		ret = compat_arm_syscall(regs);
-		if (ret != -ENOSYS)
-			return ret;
-	}
-#endif
-
-	return sys_ni_syscall();
-}
-
 static const char *esr_class_str[] = {
 	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
 	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
-- 
2.11.0

