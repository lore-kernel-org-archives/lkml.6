Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62336C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F42D208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F42D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbeGKOCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:02:12 -0400
Received: from foss.arm.com ([217.140.101.70]:36396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388274AbeGKOCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:02:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30AFF1BB0;
        Wed, 11 Jul 2018 06:57:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20A1D3F5B1;
        Wed, 11 Jul 2018 06:57:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Cc:     catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv5 10/21] arm64: convert native/compat syscall entry to C
Date:   Wed, 11 Jul 2018 14:56:45 +0100
Message-Id: <20180711135656.20670-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
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
 arch/arm64/include/asm/syscall.h |  4 ++++
 arch/arm64/kernel/entry.S        | 42 ++++------------------------------------
 arch/arm64/kernel/syscall.c      | 37 +++++++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 50841cb1bfa9..b83d0e6980a3 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -26,6 +26,10 @@ typedef long (*syscall_fn_t)(unsigned long, unsigned long,
 
 extern const syscall_fn_t sys_call_table[];
 
+#ifdef CONFIG_COMPAT
+extern const syscall_fn_t compat_sys_call_table[];
+#endif
+
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
 {
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
index 3e1df8ca1e79..d1c66e6bd359 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -8,8 +8,10 @@
 #include <linux/syscalls.h>
 
 #include <asm/daifflags.h>
+#include <asm/fpsimd.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
+#include <asm/unistd.h>
 
 long compat_arm_syscall(struct pt_regs *regs);
 
@@ -58,8 +60,8 @@ static inline bool has_syscall_work(unsigned long flags)
 int syscall_trace_enter(struct pt_regs *regs);
 void syscall_trace_exit(struct pt_regs *regs);
 
-asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
-			       const syscall_fn_t syscall_table[])
+static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
+			   const syscall_fn_t syscall_table[])
 {
 	unsigned long flags = current_thread_info()->flags;
 
@@ -96,3 +98,34 @@ asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
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
+asmlinkage void el0_svc_handler(struct pt_regs *regs)
+{
+	sve_user_discard();
+	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+}
+
+#ifdef CONFIG_COMPAT
+asmlinkage void el0_svc_compat_handler(struct pt_regs *regs)
+{
+	el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+		       compat_sys_call_table);
+}
+#endif
-- 
2.11.0

