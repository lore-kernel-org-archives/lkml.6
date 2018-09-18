Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E8ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94C52088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94C52088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeIRFma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:42:30 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53122 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeIRFm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dC-0007Fs-IA; Mon, 17 Sep 2018 18:12:42 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Za-0002Qk-U2; Mon, 17 Sep 2018 18:08:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:43 +0200
Message-Id: <20180918000546.12552-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Za-0002Qk-U2;;;mid=<20180918000546.12552-17-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3DHG33wEPrBZPx8s8q4LGInzdwTcpfw4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 17/20] signal/x86: Call force_sig_pkuerr from __bad_area_nosemaphore
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one code path that can generate a pkuerr signal.  That
code path calls __bad_area_nosemaphore and can be dectected by testing
if si_code == SEGV_PKUERR.  It can be seen from inspection that all of
the other tests in fill_sig_info_pkey are unnecessary.

Therefore call force_sig_pkuerr directly from __bad_area_semaphore
and remove fill_sig_info_pkey.

At the same time move the comment above force_sig_info_pkey into
bad_area_access_error, so that the documentation of about pkey
generation races is not lost.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 75 ++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 52 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 11a93f14a674..ccfeed902eee 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -153,56 +153,6 @@ is_prefetch(struct pt_regs *regs, unsigned long error_code, unsigned long addr)
 	return prefetch;
 }
 
-/*
- * A protection key fault means that the PKRU value did not allow
- * access to some PTE.  Userspace can figure out what PKRU was
- * from the XSAVE state, and this function fills out a field in
- * siginfo so userspace can discover which protection key was set
- * on the PTE.
- *
- * If we get here, we know that the hardware signaled a X86_PF_PK
- * fault and that there was a VMA once we got in the fault
- * handler.  It does *not* guarantee that the VMA we find here
- * was the one that we faulted on.
- *
- * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
- * 2. T1   : set PKRU to deny access to pkey=4, touches page
- * 3. T1   : faults...
- * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
- * 5. T1   : enters fault handler, takes mmap_sem, etc...
- * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
- *	     faulted on a pte with its pkey=4.
- */
-static void fill_sig_info_pkey(int si_signo, int si_code, siginfo_t *info,
-		u32 *pkey)
-{
-	/* This is effectively an #ifdef */
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	/* Fault not from Protection Keys: nothing to do */
-	if ((si_code != SEGV_PKUERR) || (si_signo != SIGSEGV))
-		return;
-	/*
-	 * force_sig_info_fault() is called from a number of
-	 * contexts, some of which have a VMA and some of which
-	 * do not.  The X86_PF_PK handing happens after we have a
-	 * valid VMA, so we should never reach this without a
-	 * valid VMA.
-	 */
-	if (!pkey) {
-		WARN_ONCE(1, "PKU fault with no VMA passed in");
-		info->si_pkey = 0;
-		return;
-	}
-	/*
-	 * si_pkey should be thought of as a strong hint, but not
-	 * absolutely guranteed to be 100% accurate because of
-	 * the race explained above.
-	 */
-	info->si_pkey = *pkey;
-}
-
 static void
 force_sig_info_fault(int si_signo, int si_code, unsigned long address,
 		     struct task_struct *tsk, u32 *pkey)
@@ -215,8 +165,6 @@ force_sig_info_fault(int si_signo, int si_code, unsigned long address,
 	info.si_code	= si_code;
 	info.si_addr	= (void __user *)address;
 
-	fill_sig_info_pkey(si_signo, si_code, &info, pkey);
-
 	force_sig_info(si_signo, &info, tsk);
 }
 
@@ -884,6 +832,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		tsk->thread.error_code	= error_code;
 		tsk->thread.trap_nr	= X86_TRAP_PF;
 
+		if (si_code == SEGV_PKUERR)
+			force_sig_pkuerr((void __user *)address, *pkey);
+
 		force_sig_info_fault(SIGSEGV, si_code, address, tsk, pkey);
 
 		return;
@@ -949,6 +900,26 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 	 * if pkeys are compiled out.
 	 */
 	if (bad_area_access_from_pkeys(error_code, vma)) {
+		/*
+		 * A protection key fault means that the PKRU value did not allow
+		 * access to some PTE.  Userspace can figure out what PKRU was
+		 * from the XSAVE state.  This function captures the pkey from
+		 * the vma and passes it to userspace so userspace can discover
+		 * which protection key was set on the PTE.
+		 *
+		 * If we get here, we know that the hardware signaled a X86_PF_PK
+		 * fault and that there was a VMA once we got in the fault
+		 * handler.  It does *not* guarantee that the VMA we find here
+		 * was the one that we faulted on.
+		 *
+		 * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
+		 * 2. T1   : set PKRU to deny access to pkey=4, touches page
+		 * 3. T1   : faults...
+		 * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
+		 * 5. T1   : enters fault handler, takes mmap_sem, etc...
+		 * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
+		 *	     faulted on a pte with its pkey=4.
+		 */
 		u32 pkey = vma_pkey(vma);
 		__bad_area(regs, error_code, address, &pkey, SEGV_PKUERR);
 	}
-- 
2.17.1

