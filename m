Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772A9ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838A20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3838A20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJZW7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:59:09 -0400
Received: from verein.lst.de ([213.95.11.211]:37757 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeJZW7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:59:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 5F0D868C95; Fri, 26 Oct 2018 16:21:52 +0200 (CEST)
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: implement live patching
In-Reply-To: <20181026142008.D922868C94@newverein.lst.de>
References: <20181026142008.D922868C94@newverein.lst.de>
Message-Id: <20181026142152.5F0D868C95@newverein.lst.de>
Date:   Fri, 26 Oct 2018 16:21:52 +0200 (CEST)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on ftrace with regs, do the usual thing.
(see Documentation/livepatch/livepatch.txt)

Use task flag bit 6 to track patch transisiton state for the consistency
model. Add it to the work mask so it gets cleared on all kernel exits to
userland.

Tell livepatch regs->pc is the place to change the return address.
Make sure the graph tracer call hook is only called on the final function
entry in case regs->pc gets modified after an interception.

Signed-off-by: Torsten Duwe <duwe@suse.de>

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -120,6 +120,7 @@ config ARM64
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_LIVEPATCH
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
 	select HAVE_NMI
@@ -1350,4 +1351,6 @@ if CRYPTO
 source "arch/arm64/crypto/Kconfig"
 endif
 
+source "kernel/livepatch/Kconfig"
+
 source "lib/Kconfig"
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -76,6 +76,7 @@ void arch_release_task_struct(struct tas
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_PATCH_PENDING	6
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -94,6 +95,7 @@ void arch_release_task_struct(struct tas
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
+#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
@@ -106,7 +108,8 @@ void arch_release_task_struct(struct tas
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | \
+				 _TIF_PATCH_PENDING)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
--- /dev/null
+++ b/arch/arm64/include/asm/livepatch.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * livepatch.h - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2016,2018 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _ASM_ARM64_LIVEPATCH_H
+#define _ASM_ARM64_LIVEPATCH_H
+
+#include <asm/ptrace.h>
+
+static inline int klp_check_compiler_support(void)
+{
+	return 0;
+}
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->pc = ip;
+}
+
+#endif /* _ASM_ARM64_LIVEPATCH_H */
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -226,6 +226,7 @@ ftrace_common:
 
 	/* The program counter just after the ftrace call site */
 	str	lr, [x9, #S_PC]
+
 	/* The stack pointer as it was on ftrace_caller entry... */
 	add	x28, fp, #16
 	str	x28, [x9, #S_SP]
@@ -233,6 +234,10 @@ ftrace_common:
 	ldr	x28, [fp, 8]
 	str	x28, [x9, #S_LR]	/* to pt_regs.r[30] */
 
+#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	mov	x28, lr		/* remember old return address */
+#endif
+
 	ldr_l	x2, function_trace_op, x0
 	ldr	x1, [fp, #8]
 	sub	x0, lr, #8	/* function entry == IP */
@@ -245,6 +250,17 @@ ftrace_call:
 
 	bl	ftrace_stub
 
+#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	/* Is the trace function a live patcher an has messed with
+	 * the return address?
+	 */
+	add	x9, sp, #16	/* advance to pt_regs for restore */
+	ldr	x0, [x9, #S_PC]
+	cmp	x0, x28		/* compare with the value we remembered */
+	/* to not call graph tracer's "call" mechanism twice! */
+	b.ne	ftrace_common_return
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.global ftrace_graph_call
 ftrace_graph_call:			// ftrace_graph_caller();
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/tracehook.h>
+#include <linux/livepatch.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 
@@ -934,6 +935,9 @@ asmlinkage void do_notify_resume(struct
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
+			if (thread_flags & _TIF_PATCH_PENDING)
+				klp_update_patch_state(current);
+
 			if (thread_flags & _TIF_SIGPENDING)
 				do_signal(regs);
 
