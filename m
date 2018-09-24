Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A16C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08AC208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08AC208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeIXSOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50620 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbeIXSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:13:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Pij-0006m3-5D; Mon, 24 Sep 2018 06:12:09 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Pih-0002Pv-LV; Mon, 24 Sep 2018 06:12:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 14:11:26 +0200
Message-Id: <20180924121128.5983-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87pnx32j2p.fsf@xmission.com>
References: <87pnx32j2p.fsf@xmission.com>
X-XM-SPF: eid=1g4Pih-0002Pv-LV;;;mid=<20180924121128.5983-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18WFM7bwHi9v9P4Qcps199p/w62tPaAAvc=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 2/4] signal/arm: Use force_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/kernel/ptrace.c | 11 ++---------
 arch/arm/mm/alignment.c  | 10 +---------
 arch/arm/mm/fault.c      | 10 +---------
 3 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 36718a424358..6fa5b6387556 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -203,15 +203,8 @@ void ptrace_disable(struct task_struct *child)
  */
 void ptrace_break(struct task_struct *tsk, struct pt_regs *regs)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code  = TRAP_BRKPT;
-	info.si_addr  = (void __user *)instruction_pointer(regs);
-
-	force_sig_info(SIGTRAP, &info, tsk);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT,
+			(void __user *)instruction_pointer(regs), tsk);
 }
 
 static int break_trap(struct pt_regs *regs, unsigned int instr)
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index bd2c739d8083..b54f8f8def36 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -948,15 +948,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto fixup;
 
 	if (ai_usermode & UM_SIGNAL) {
-		siginfo_t si;
-
-		clear_siginfo(&si);
-		si.si_signo = SIGBUS;
-		si.si_errno = 0;
-		si.si_code = BUS_ADRALN;
-		si.si_addr = (void __user *)addr;
-
-		force_sig_info(si.si_signo, &si, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr, current);
 	} else {
 		/*
 		 * We're about to disable the alignment trap and return to
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 544d2c8c2775..f4ea4c62c613 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -161,13 +161,9 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		unsigned int fsr, unsigned int sig, int code,
 		struct pt_regs *regs)
 {
-	struct siginfo si;
-
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
-	clear_siginfo(&si);
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -181,11 +177,7 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	force_sig_info(sig, &si, tsk);
+	force_sig_fault(sig, code, (void __user *)addr, tsk);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-- 
2.17.1

