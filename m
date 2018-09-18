Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE03ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ACF214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ACF214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeIRFhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:37:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52792 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:37:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Y4-0006pK-S8; Mon, 17 Sep 2018 18:07:24 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Xo-0002Qk-T2; Mon, 17 Sep 2018 18:07:24 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:32 +0200
Message-Id: <20180918000546.12552-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Xo-0002Qk-T2;;;mid=<20180918000546.12552-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mBSihVhSZyMP8FP52XMIDYsxlwGJ5iS4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation into do_bounds
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This separates the logic of generating the signal from the logic of
gathering the information about the bounds violation.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/include/asm/mpx.h | 13 ++++++++++---
 arch/x86/kernel/traps.c    | 19 ++++++++++++++-----
 arch/x86/mm/mpx.c          | 30 +++++++++---------------------
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/mpx.h b/arch/x86/include/asm/mpx.h
index 61eb4b63c5ec..8f55ea0cd7da 100644
--- a/arch/x86/include/asm/mpx.h
+++ b/arch/x86/include/asm/mpx.h
@@ -57,8 +57,15 @@
 #define MPX_BNDCFG_ADDR_MASK	(~((1UL<<MPX_BNDCFG_TAIL)-1))
 #define MPX_BNDSTA_ERROR_CODE	0x3
 
+struct mpx_fault_info
+{
+	void __user *addr;
+	void __user *lower;
+	void __user *upper;
+};
+
 #ifdef CONFIG_X86_INTEL_MPX
-siginfo_t *mpx_generate_siginfo(struct pt_regs *regs);
+int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs);
 int mpx_handle_bd_fault(void);
 static inline int kernel_managing_mpx_tables(struct mm_struct *mm)
 {
@@ -78,9 +85,9 @@ void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 unsigned long mpx_unmapped_area_check(unsigned long addr, unsigned long len,
 		unsigned long flags);
 #else
-static inline siginfo_t *mpx_generate_siginfo(struct pt_regs *regs)
+static inline int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
 {
-	return NULL;
+	return -EINVAL;
 }
 static inline int mpx_handle_bd_fault(void)
 {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e6db475164ed..2155d2c7f49b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -455,7 +455,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code)
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 {
 	const struct mpx_bndcsr *bndcsr;
-	siginfo_t *info;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
@@ -493,8 +492,11 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 			goto exit_trap;
 		break; /* Success, it was handled */
 	case 1: /* Bound violation. */
-		info = mpx_generate_siginfo(regs);
-		if (IS_ERR(info)) {
+	{
+		struct mpx_fault_info mpx;
+		struct siginfo info;
+
+		if (mpx_fault_info(&mpx, regs)) {
 			/*
 			 * We failed to decode the MPX instruction.  Act as if
 			 * the exception was not caused by MPX.
@@ -508,9 +510,16 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		 * allows and application to possibly handle the
 		 * #BR exception itself.
 		 */
-		do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, info);
-		kfree(info);
+		clear_siginfo(&info);
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		info.si_code  = SEGV_BNDERR;
+		info.si_addr  = mpx.addr;
+		info.si_lower = mpx.lower;
+		info.si_upper = mpx.upper;
+		do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, &info);
 		break;
+	}
 	case 0: /* No exception caused by Intel MPX operations. */
 		goto exit_trap;
 	default:
diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index e500949bae24..2385538e8065 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -118,14 +118,11 @@ static int mpx_insn_decode(struct insn *insn,
  * anything it wants in to the instructions.  We can not
  * trust anything about it.  They might not be valid
  * instructions or might encode invalid registers, etc...
- *
- * The caller is expected to kfree() the returned siginfo_t.
  */
-siginfo_t *mpx_generate_siginfo(struct pt_regs *regs)
+int mpx_fault_info(struct mpx_fault_info *info, struct pt_regs *regs)
 {
 	const struct mpx_bndreg_state *bndregs;
 	const struct mpx_bndreg *bndreg;
-	siginfo_t *info = NULL;
 	struct insn insn;
 	uint8_t bndregno;
 	int err;
@@ -153,11 +150,6 @@ siginfo_t *mpx_generate_siginfo(struct pt_regs *regs)
 	/* now go select the individual register in the set of 4 */
 	bndreg = &bndregs->bndreg[bndregno];
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		err = -ENOMEM;
-		goto err_out;
-	}
 	/*
 	 * The registers are always 64-bit, but the upper 32
 	 * bits are ignored in 32-bit mode.  Also, note that the
@@ -168,27 +160,23 @@ siginfo_t *mpx_generate_siginfo(struct pt_regs *regs)
 	 * complains when casting from integers to different-size
 	 * pointers.
 	 */
-	info->si_lower = (void __user *)(unsigned long)bndreg->lower_bound;
-	info->si_upper = (void __user *)(unsigned long)~bndreg->upper_bound;
-	info->si_addr_lsb = 0;
-	info->si_signo = SIGSEGV;
-	info->si_errno = 0;
-	info->si_code = SEGV_BNDERR;
-	info->si_addr = insn_get_addr_ref(&insn, regs);
+	info->lower = (void __user *)(unsigned long)bndreg->lower_bound;
+	info->upper = (void __user *)(unsigned long)~bndreg->upper_bound;
+	info->addr  = insn_get_addr_ref(&insn, regs);
+
 	/*
 	 * We were not able to extract an address from the instruction,
 	 * probably because there was something invalid in it.
 	 */
-	if (info->si_addr == (void __user *)-1) {
+	if (info->addr == (void __user *)-1) {
 		err = -EINVAL;
 		goto err_out;
 	}
-	trace_mpx_bounds_register_exception(info->si_addr, bndreg);
-	return info;
+	trace_mpx_bounds_register_exception(info->addr, bndreg);
+	return 0;
 err_out:
 	/* info might be NULL, but kfree() handles that */
-	kfree(info);
-	return ERR_PTR(err);
+	return err;
 }
 
 static __user void *mpx_get_bounds_dir(void)
-- 
2.17.1

