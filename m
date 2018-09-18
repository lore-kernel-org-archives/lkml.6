Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318F4ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B92088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58B92088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeIRFnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:43:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33865 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIRFm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dB-0007nz-KP; Mon, 17 Sep 2018 18:12:41 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Ye-0002Qk-Tf; Mon, 17 Sep 2018 18:08:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:37 +0200
Message-Id: <20180918000546.12552-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Ye-0002Qk-Tf;;;mid=<20180918000546.12552-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+skK67AEuNzkTz1uusugkvBBg61oMjW5Q=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 11/20] signal/x86/traps: Simplify trap generation
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the DO_ERROR macro to take si_code and si_addr values for a siginfo,
removing the need for the fill_trap_info function.

Update do_trap to also take the sicode and si_addr values for a sigininfo
and modify the code to call force_sig when a sicode is not passed in
and to call force_sig_fault when all of the information is present.

Making this a more obvious, simpler and less error prone construction.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 85 ++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3e4a3172d711..eb54f1964252 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -241,40 +241,9 @@ static void show_signal(struct task_struct *tsk, int signr,
 	}
 }
 
-static siginfo_t *fill_trap_info(struct pt_regs *regs, int signr, int trapnr,
-				siginfo_t *info)
-{
-	unsigned long siaddr;
-	int sicode;
-
-	switch (trapnr) {
-	default:
-		return SEND_SIG_PRIV;
-
-	case X86_TRAP_DE:
-		sicode = FPE_INTDIV;
-		siaddr = uprobe_get_trap_addr(regs);
-		break;
-	case X86_TRAP_UD:
-		sicode = ILL_ILLOPN;
-		siaddr = uprobe_get_trap_addr(regs);
-		break;
-	case X86_TRAP_AC:
-		sicode = BUS_ADRALN;
-		siaddr = 0;
-		break;
-	}
-
-	info->si_signo = signr;
-	info->si_errno = 0;
-	info->si_code = sicode;
-	info->si_addr = (void __user *)siaddr;
-	return info;
-}
-
 static void
 do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
-	long error_code, siginfo_t *info)
+	long error_code, int sicode, void __user *addr)
 {
 	struct task_struct *tsk = current;
 
@@ -284,15 +253,16 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 
 	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
-	force_sig_info(signr, info ?: SEND_SIG_PRIV, tsk);
+	if (!sicode)
+		force_sig(signr, tsk);
+	else
+		force_sig_fault(signr, sicode, addr, tsk);
 }
 NOKPROBE_SYMBOL(do_trap);
 
 static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
-			  unsigned long trapnr, int signr)
+	unsigned long trapnr, int signr, int sicode, void __user *addr)
 {
-	siginfo_t info;
-
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
 	/*
@@ -305,26 +275,26 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
-		clear_siginfo(&info);
-		do_trap(trapnr, signr, str, regs, error_code,
-			fill_trap_info(regs, signr, trapnr, &info));
+		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
 	}
 }
 
-#define DO_ERROR(trapnr, signr, str, name)				\
-dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	\
-{									\
-	do_error_trap(regs, error_code, str, trapnr, signr);		\
+#define IP ((void __user *)uprobe_get_trap_addr(regs))
+#define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
+dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
+{									   \
+	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_DE,     SIGFPE,  "divide error",		divide_error)
-DO_ERROR(X86_TRAP_OF,     SIGSEGV, "overflow",			overflow)
-DO_ERROR(X86_TRAP_UD,     SIGILL,  "invalid opcode",		invalid_op)
-DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_segment_overrun)
-DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",		invalid_TSS)
-DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",	segment_not_present)
-DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",		stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",		alignment_check)
+DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
+DO_ERROR(X86_TRAP_OF,     SIGSEGV,          0, NULL, "overflow",            overflow)
+DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
+DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
+DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
+DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
+DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
+DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
+#undef IP
 
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
@@ -541,7 +511,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	 * up here if the kernel has MPX turned off at compile
 	 * time..
 	 */
-	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, NULL);
+	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
 dotraplinkage void
@@ -625,7 +595,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 		goto exit;
 
 	cond_local_irq_enable(regs);
-	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, NULL);
+	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, error_code, 0, NULL);
 	cond_local_irq_disable(regs);
 
 exit:
@@ -936,20 +906,13 @@ NOKPROBE_SYMBOL(do_device_not_available);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
 {
-	siginfo_t info;
-
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	local_irq_enable();
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_BADSTK;
-	info.si_addr = NULL;
 	if (notify_die(DIE_TRAP, "iret exception", regs, error_code,
 			X86_TRAP_IRET, SIGILL) != NOTIFY_STOP) {
 		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, error_code,
-			&info);
+			ILL_BADSTK, (void __user *)NULL);
 	}
 }
 #endif
-- 
2.17.1

