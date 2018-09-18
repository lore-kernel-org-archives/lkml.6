Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98051ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2BE21502
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2BE21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeIRFm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:42:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53114 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeIRFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dB-0007Fd-QZ; Mon, 17 Sep 2018 18:12:41 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Zj-0002Qk-UX; Mon, 17 Sep 2018 18:09:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:45 +0200
Message-Id: <20180918000546.12552-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Zj-0002Qk-UX;;;mid=<20180918000546.12552-19-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18P2EJgSMAdSO55NTiPJercMP+DgBLmKpU=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 19/20] signal/x86: Pass pkey by value
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that si_code == SEGV_PKUERR is the flag indicating that a pkey
is present there is no longer a need to pass a pointer to a local
pkey value, instead pkey can be passed more efficiently by value.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 548396aa03e1..c09a0c2fa614 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -769,7 +769,7 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		       unsigned long address, u32 *pkey, int si_code)
+		       unsigned long address, u32 pkey, int si_code)
 {
 	struct task_struct *tsk = current;
 
@@ -818,7 +818,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		tsk->thread.trap_nr	= X86_TRAP_PF;
 
 		if (si_code == SEGV_PKUERR)
-			force_sig_pkuerr((void __user *)address, *pkey);
+			force_sig_pkuerr((void __user *)address, pkey);
 
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 
@@ -835,12 +835,12 @@ static noinline void
 bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		     unsigned long address)
 {
-	__bad_area_nosemaphore(regs, error_code, address, NULL, SEGV_MAPERR);
+	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR);
 }
 
 static void
 __bad_area(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, u32 *pkey, int si_code)
+	   unsigned long address, u32 pkey, int si_code)
 {
 	struct mm_struct *mm = current->mm;
 	/*
@@ -855,7 +855,7 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 static noinline void
 bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	__bad_area(regs, error_code, address, NULL, SEGV_MAPERR);
+	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
 }
 
 static inline bool bad_area_access_from_pkeys(unsigned long error_code,
@@ -906,10 +906,10 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 		 *	     faulted on a pte with its pkey=4.
 		 */
 		u32 pkey = vma_pkey(vma);
-		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);
+		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
 	}
 	else
-		__bad_area(regs, error_code, address, NULL, SEGV_ACCERR);
+		__bad_area(regs, error_code, address, 0, SEGV_ACCERR);
 }
 
 static void
-- 
2.17.1

