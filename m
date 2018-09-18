Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA7ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3550E214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3550E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeIRFhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:37:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33525 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:37:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Y9-0007NF-Ad; Mon, 17 Sep 2018 18:07:29 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Y8-0002Qk-8D; Mon, 17 Sep 2018 18:07:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:33 +0200
Message-Id: <20180918000546.12552-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Y8-0002Qk-8D;;;mid=<20180918000546.12552-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Rgsx8dgUqYswomw3cKNrmGSI/mLaoXXg=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 07/20] signal/x86/traps: Factor out show_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code for conditionally printing unhanded signals is duplicated twice
in arch/x86/kernel/traps.c.  Factor it out into it's own subroutine
called show_signal to make the code clearer and easier to maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2155d2c7f49b..31a689b67be3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -217,6 +217,20 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 	return -1;
 }
 
+static void show_signal(struct task_struct *tsk, int signr,
+			const char *type, const char *desc,
+			struct pt_regs *regs, long error_code)
+{
+	if (show_unhandled_signals && unhandled_signal(tsk, signr) &&
+	    printk_ratelimit()) {
+		pr_info("%s[%d] %s%s ip:%lx sp:%lx error:%lx",
+			tsk->comm, task_pid_nr(tsk), type, desc,
+			regs->ip, regs->sp, error_code);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+}
+
 static siginfo_t *fill_trap_info(struct pt_regs *regs, int signr, int trapnr,
 				siginfo_t *info)
 {
@@ -269,14 +283,7 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = trapnr;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, signr) &&
-	    printk_ratelimit()) {
-		pr_info("%s[%d] trap %s ip:%lx sp:%lx error:%lx",
-			tsk->comm, tsk->pid, str,
-			regs->ip, regs->sp, error_code);
-		print_vma_addr(KERN_CONT " in ", regs->ip);
-		pr_cont("\n");
-	}
+	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
 	force_sig_info(signr, info ?: SEND_SIG_PRIV, tsk);
 }
@@ -542,6 +549,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
+	const char *desc = "general protection fault";
 	struct task_struct *tsk;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
@@ -565,23 +573,16 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
-		if (notify_die(DIE_GPF, "general protection fault", regs, error_code,
+		if (notify_die(DIE_GPF, desc, regs, error_code,
 			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
-			die("general protection fault", regs, error_code);
+			die(desc, regs, error_code);
 		return;
 	}
 
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_GP;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
-			printk_ratelimit()) {
-		pr_info("%s[%d] general protection ip:%lx sp:%lx error:%lx",
-			tsk->comm, task_pid_nr(tsk),
-			regs->ip, regs->sp, error_code);
-		print_vma_addr(KERN_CONT " in ", regs->ip);
-		pr_cont("\n");
-	}
+	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
 	force_sig_info(SIGSEGV, SEND_SIG_PRIV, tsk);
 }
-- 
2.17.1

