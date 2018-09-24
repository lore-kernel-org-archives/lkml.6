Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CA320989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CA320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIXPNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:13:33 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39257 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeIXPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:13:32 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mup-0008Fv-HK; Mon, 24 Sep 2018 03:12:27 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MuZ-0002zU-Bo; Mon, 24 Sep 2018 03:12:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:07 +0200
Message-Id: <20180924091015.4458-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4MuZ-0002zU-Bo;;;mid=<20180924091015.4458-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18EGL1jXUVVKF6Cntv1kXpxOQzSdJIdQtw=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 07/15] signal/arm64: Expand __do_user_fault and remove it
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all of the signals passed to __do_user_fault can be handled
the same way so expand the now tiny __do_user_fault in it's callers
and remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 14d6ff895139..7df3d8b561c2 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -354,12 +354,6 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
 	current->thread.fault_code = esr;
 }
 
-static void __do_user_fault(struct siginfo *info, unsigned int esr)
-{
-	set_thread_esr((unsigned long)info->si_addr, esr);
-	arm64_force_sig_info(info, esr_to_fault_info(esr)->name);
-}
-
 static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	/*
@@ -375,7 +369,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		si.si_code	= inf->code;
 		si.si_addr	= (void __user *)addr;
 
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, inf->name);
 	} else {
 		__do_kernel_fault(addr, esr, regs);
 	}
@@ -576,7 +571,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
 		si.si_addr = (void __user *)addr;
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -589,7 +585,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= BUS_MCEERR_AR;
 		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -600,7 +597,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= fault == VM_FAULT_BADACCESS ?
 				  SEGV_ACCERR : SEGV_MAPERR;
 		si.si_addr = (void __user *)addr;
-		__do_user_fault(&si, esr);
+		set_thread_esr(addr, esr);
+		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
 	}
 
 	return 0;
-- 
2.17.1

