Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFAL2m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:28:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751942AbeFALZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:05 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 08/19] arm64: convert raw syscall invocation to C
Date: Fri,  1 Jun 2018 12:24:30 +0100
Message-Id: <20180601112441.37810-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
simplfiied and unified, as we no longer need the __ni_sys_trace path and
the __sys_trace_return label.

This only converts the invocation of the syscall. The rest of the
syscall triage and tracing is left in assembly for now, and will be
converted in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/Makefile  |  3 ++-
 arch/arm64/kernel/entry.S   | 36 ++++++++++--------------------------
 arch/arm64/kernel/syscall.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 27 deletions(-)
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
index 62f2876f9c63..46543f34b9dc 100644
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
+	mov w2, wsc_nr
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
index 000000000000..b463b962d597
--- /dev/null
+++ b/arch/arm64/kernel/syscall.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/nospec.h>
+#include <linux/ptrace.h>
+
+long do_ni_syscall(struct pt_regs *regs);
+
+typedef long (*syscall_fn_t)(unsigned long, unsigned long,
+			     unsigned long, unsigned long,
+			     unsigned long, unsigned long);
+
+static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
+{
+	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
+				   regs->regs[2], regs->regs[3],
+				   regs->regs[4], regs->regs[5]);
+}
+
+asmlinkage void invoke_syscall(struct pt_regs *regs, unsigned int scno,
+			       unsigned int sc_nr,
+			       syscall_fn_t syscall_table[])
+{
+	if (scno < sc_nr) {
+		syscall_fn_t syscall_fn;
+		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
+		__invoke_syscall(regs, syscall_fn);
+	} else {
+		regs->regs[0] = do_ni_syscall(regs);
+	}
+}
-- 
2.11.0
