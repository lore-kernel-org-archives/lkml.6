Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C939ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E69214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E69214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeIRFmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:42:31 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53133 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeIRFm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dD-0007G9-00; Mon, 17 Sep 2018 18:12:43 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Yk-0002Qk-Ne; Mon, 17 Sep 2018 18:08:22 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:38 +0200
Message-Id: <20180918000546.12552-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Yk-0002Qk-Ne;;;mid=<20180918000546.12552-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5CPIpcbdNzRrNkvdh3so1+pVq6EAfxkY=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 12/20] signal/x86: Remove pkey parameter from bad_area_nosemaphore
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function bad_area_nosemaphore always sets si_code to SEGV_MAPERR
and as such can never return a pkey parameter.  Therefore remove the
unusable pkey parameter from bad_area_nosemaphore.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4112b05d0dec..cfc88920716f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -897,9 +897,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 static noinline void
 bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		     unsigned long address, u32 *pkey)
+		     unsigned long address)
 {
-	__bad_area_nosemaphore(regs, error_code, address, pkey, SEGV_MAPERR);
+	__bad_area_nosemaphore(regs, error_code, address, NULL, SEGV_MAPERR);
 }
 
 static void
@@ -1025,7 +1025,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, pkey, fault);
 		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address, pkey);
+			bad_area_nosemaphore(regs, error_code, address);
 		else
 			BUG();
 	}
@@ -1255,7 +1255,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock:
 		 */
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, error_code, address);
 
 		return;
 	}
@@ -1268,7 +1268,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		pgtable_bad(regs, error_code, address);
 
 	if (unlikely(smap_violation(error_code, regs))) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1277,7 +1277,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1323,7 +1323,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
 		if (!(error_code & X86_PF_USER) &&
 		    !search_exception_tables(regs->ip)) {
-			bad_area_nosemaphore(regs, error_code, address, NULL);
+			bad_area_nosemaphore(regs, error_code, address);
 			return;
 		}
 retry:
-- 
2.17.1

