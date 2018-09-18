Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C451ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5822088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5822088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeIRFnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:43:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53138 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbeIRFma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:42:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23dD-0007GH-8O; Mon, 17 Sep 2018 18:12:43 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23Z4-0002Qk-5f; Mon, 17 Sep 2018 18:08:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:39 +0200
Message-Id: <20180918000546.12552-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23Z4-0002Qk-5f;;;mid=<20180918000546.12552-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18dkKPqP3ksHlU9yehrJ+PTbBYc/q3wYYw=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 13/20] signal/x86: Remove the pkey parameter from do_sigbus
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function do_sigbus never sets si_code to PKUERR so it can never
return a pkey to userspace.  Therefore remove the unusable pkey
parameter from do_sigbus.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index cfc88920716f..6886866c072d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -962,7 +962,7 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
-	  u32 *pkey, unsigned int fault)
+	  unsigned int fault)
 {
 	struct task_struct *tsk = current;
 
@@ -994,7 +994,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		return;
 	}
 #endif
-	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, pkey);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk, NULL);
 }
 
 static noinline void
@@ -1023,7 +1023,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	} else {
 		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
 			     VM_FAULT_HWPOISON_LARGE))
-			do_sigbus(regs, error_code, address, pkey, fault);
+			do_sigbus(regs, error_code, address, fault);
 		else if (fault & VM_FAULT_SIGSEGV)
 			bad_area_nosemaphore(regs, error_code, address);
 		else
-- 
2.17.1

