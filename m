Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0EECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB275214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB275214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeIRFmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:42:31 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53129 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeIRFm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dC-0007G0-PH; Mon, 17 Sep 2018 18:12:42 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Zf-0002Qk-GL; Mon, 17 Sep 2018 18:09:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:44 +0200
Message-Id: <20180918000546.12552-18-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Zf-0002Qk-GL;;;mid=<20180918000546.12552-18-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/dkKzcTfgCyixQOXDrxzaZPnqYvAFFEG0=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 18/20] signal/x86: Replace force_sig_info_fault with force_sig_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the pkey handling has been removed force_sig_info_fault and
force_sig_fault perform identical work.  Just the type of the address
paramter is different.  So replace calls to force_sig_info_fault with
calls to force_sig_fault, and remove force_sig_info_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ccfeed902eee..548396aa03e1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -153,21 +153,6 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 	return prefetch;
 }
 
-static void
-force_sig_info_fault(int si_signo, int si_code, unsigned long address,
-		     struct task_struct *tsk, u32 *pkey)
-{
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo	= si_signo;
-	info.si_errno	= 0;
-	info.si_code	= si_code;
-	info.si_addr	= (void __user *)address;
-
-	force_sig_info(si_signo, &info, tsk);
-}
-
 DEFINE_SPINLOCK(pgd_lock);
 LIST_HEAD(pgd_list);
 
@@ -672,8 +657,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 			tsk->thread.cr2 = address;
 
 			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_info_fault(signal, si_code, address,
-					     tsk, NULL);
+			force_sig_fault(signal, si_code, (void __user *)address,
+					tsk);
 		}
 
 		/*
@@ -835,7 +820,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (si_code == SEGV_PKUERR)
 			force_sig_pkuerr((void __user *)address, *pkey);
 
-		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 
 		return;
 	}
@@ -961,7 +946,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		return;
 	}
 #endif
-	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, NULL);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 }
 
 static noinline void
-- 
2.17.1

