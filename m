Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB9EECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F58214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F58214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeIRFg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:36:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52739 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:36:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23XN-0006mR-QR; Mon, 17 Sep 2018 18:06:41 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23XM-0002Qk-6P; Mon, 17 Sep 2018 18:06:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:29 +0200
Message-Id: <20180918000546.12552-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23XM-0002Qk-6P;;;mid=<20180918000546.12552-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19w1qUUrXq4dMTlyGAlPCvyclnWXJojHN0=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 03/20] signal/x86: Move MCE error reporting out of force_sig_info_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the call from do_sigbus will send SIGBUS due to a memory machine
check error.  Consolidate all of the machine check signal generation
code in do_sigbus and remove the now unnecessary fault parameter from
force_sig_info_fault.

Explicitly use the now constant si_code BUS_ADRERR in the call
to force_sig_info_fault from do_sigbus.

This makes the code in arch/x86/mm/fault.c easier to follower and
simpler to maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..4112b05d0dec 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -205,9 +205,8 @@ static void fill_sig_info_pkey(int si_signo, int si_code, siginfo_t *info,
 
 static void
 force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk, u32 *pkey, int fault)
+		     struct task_struct *tsk, u32 *pkey)
 {
-	unsigned lsb = 0;
 	siginfo_t info;
 
 	clear_siginfo(&info);
@@ -215,11 +214,6 @@ force_sig_info_fault(int si_signo, int si_code, unsigned long address,
 	info.si_errno	= 0;
 	info.si_code	= si_code;
 	info.si_addr	= (void __user *)address;
-	if (fault & VM_FAULT_HWPOISON_LARGE)
-		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault)); 
-	if (fault & VM_FAULT_HWPOISON)
-		lsb = PAGE_SHIFT;
-	info.si_addr_lsb = lsb;
 
 	fill_sig_info_pkey(si_signo, si_code, &info, pkey);
 
@@ -731,7 +725,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 
 			/* XXX: hwpoison faults will set the wrong code. */
 			force_sig_info_fault(signal, si_code, address,
-					     tsk, NULL, 0);
+					     tsk, NULL);
 		}
 
 		/*
@@ -890,7 +884,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		tsk->thread.error_code	= error_code;
 		tsk->thread.trap_nr	= X86_TRAP_PF;
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey, 0);
+		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey);
 
 		return;
 	}
@@ -971,7 +965,6 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  u32 *pkey, unsigned int fault)
 {
 	struct task_struct *tsk = current;
-	int code = BUS_ADRERR;
 
 	/* Kernel mode? Handle exceptions or die: */
 	if (!(error_code & X86_PF_USER)) {
@@ -989,13 +982,19 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		unsigned lsb = 0;
 		printk(KERN_ERR
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 			tsk->comm, tsk->pid, address);
-		code = BUS_MCEERR_AR;
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+		if (fault & VM_FAULT_HWPOISON)
+			lsb = PAGE_SHIFT;
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
+		return;
 	}
 #endif
-	force_sig_info_fault(SIGBUS, code, address, tsk, pkey, fault);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, pkey);
 }
 
 static noinline void
-- 
2.17.1

