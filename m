Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4932C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73A325C8F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73A325C8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030437AbeGBLFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:05:04 -0400
Received: from foss.arm.com ([217.140.101.70]:57540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030359AbeGBLEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09AFB18A;
        Mon,  2 Jul 2018 04:04:47 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED63F3F5BA;
        Mon,  2 Jul 2018 04:04:44 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 09/19] arm64: convert native/compat syscall entry to C
Date:   Mon,  2 Jul 2018 12:04:05 +0100
Message-Id: <20180702110415.10465-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the syscall invocation logic is in C, we can migrate the rest
of the syscall entry logic over, so that the entry assembly needn't look
at the register values at all.

The SVE reset across syscall logic now unconditionally clears TIF_SVE,
but sve_user_disable() will only write back to CPACR_EL1 when SVE is
actually enabled.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S   | 42 ++++--------------------------------------
 arch/arm64/kernel/syscall.c | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 05b9f03f3e00..156c4e3fd1a4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -720,14 +720,9 @@ el0_sync_compat:
 	b.ge	el0_dbg
 	b	el0_inv
 el0_svc_compat:
-	/*
-	 * AArch32 syscall handling
-	 */
-	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
-	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
-	mov	wscno, w7			// syscall number in w7 (r7)
-	mov     wsc_nr, #__NR_compat_syscalls
-	b	el0_svc_naked
+	mov	x0, sp
+	bl	el0_svc_compat_handler
+	b	ret_to_user
 
 	.align	6
 el0_irq_compat:
@@ -925,37 +920,8 @@ ENDPROC(ret_to_user)
  */
 	.align	6
 el0_svc:
-	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
-	adrp	stbl, sys_call_table		// load syscall table pointer
-	mov	wscno, w8			// syscall number in w8
-	mov	wsc_nr, #__NR_syscalls
-
-#ifdef CONFIG_ARM64_SVE
-alternative_if_not ARM64_SVE
-	b	el0_svc_naked
-alternative_else_nop_endif
-	tbz	x16, #TIF_SVE, el0_svc_naked	// Skip unless TIF_SVE set:
-	bic	x16, x16, #_TIF_SVE		// discard SVE state
-	str	x16, [tsk, #TSK_TI_FLAGS]
-
-	/*
-	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
-	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
-	 * happens if a context switch or kernel_neon_begin() or context
-	 * modification (sigreturn, ptrace) intervenes.
-	 * So, ensure that CPACR_EL1 is already correct for the fast-path case:
-	 */
-	mrs	x9, cpacr_el1
-	bic	x9, x9, #CPACR_EL1_ZEN_EL0EN	// disable SVE for el0
-	msr	cpacr_el1, x9			// synchronised by eret to el0
-#endif
-
-el0_svc_naked:					// compat entry point
 	mov	x0, sp
-	mov	w1, wscno
-	mov	w2, wsc_nr
-	mov	x3, stbl
-	bl	el0_svc_common
+	bl	el0_svc_handler
 	b	ret_to_user
 ENDPROC(el0_svc)
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index e3153ffe7f8e..ea4fc5eea182 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -8,7 +8,9 @@
 #include <linux/syscalls.h>
 
 #include <asm/daifflags.h>
+#include <asm/fpsimd.h>
 #include <asm/thread_info.h>
+#include <asm/unistd.h>
 
 long compat_arm_syscall(struct pt_regs *regs);
 
@@ -61,8 +63,8 @@ static inline bool has_syscall_work(unsigned long flags)
 int syscall_trace_enter(struct pt_regs *regs);
 void syscall_trace_exit(struct pt_regs *regs);
 
-asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
-			       syscall_fn_t syscall_table[])
+static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
+			   syscall_fn_t syscall_table[])
 {
 	unsigned long flags = current_thread_info()->flags;
 
@@ -99,3 +101,38 @@ asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 trace_exit:
 	syscall_trace_exit(regs);
 }
+
+static inline void sve_user_discard(void)
+{
+	if (!system_supports_sve())
+		return;
+
+	clear_thread_flag(TIF_SVE);
+
+	/*
+	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
+	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
+	 * happens if a context switch or kernel_neon_begin() or context
+	 * modification (sigreturn, ptrace) intervenes.
+	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
+	 */
+	sve_user_disable();
+}
+
+extern syscall_fn_t sys_call_table[];
+
+asmlinkage void el0_svc_handler(struct pt_regs *regs)
+{
+	sve_user_discard();
+	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+}
+
+#ifdef CONFIG_COMPAT
+extern syscall_fn_t compat_sys_call_table[];
+
+asmlinkage void el0_svc_compat_handler(struct pt_regs *regs)
+{
+	el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+		       compat_sys_call_table);
+}
+#endif
-- 
2.11.0

