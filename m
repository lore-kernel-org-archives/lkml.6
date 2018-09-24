Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803CEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E16820989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E16820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIXPNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:13:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56471 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeIXPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:13:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Muu-0005dT-Hc; Mon, 24 Sep 2018 03:12:32 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mus-0002zU-V1; Mon, 24 Sep 2018 03:12:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:08 +0200
Message-Id: <20180924091015.4458-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4Mus-0002zU-V1;;;mid=<20180924091015.4458-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ztJjcerqtxqrihsrvBQS56B8/7/w/xho=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 08/15] signal/arm64: Only perform one esr_to_fault_info call in do_page_fault
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this work is truly common between all of the signal sending cases
there is no need to repeat it between the different cases.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7df3d8b561c2..ab85533e2255 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -424,6 +424,7 @@ static bool is_el0_instruction_abort(unsigned int esr)
 static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				   struct pt_regs *regs)
 {
+	const struct fault_info *inf;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct siginfo si;
@@ -562,6 +563,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		return 0;
 	}
 
+	inf = esr_to_fault_info(esr);
 	if (fault & VM_FAULT_SIGBUS) {
 		/*
 		 * We had some memory, but were unable to successfully fix up
@@ -572,7 +574,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= BUS_ADRERR;
 		si.si_addr = (void __user *)addr;
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
+		arm64_force_sig_info(&si, inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -586,7 +588,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
+		arm64_force_sig_info(&si, inf->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -598,7 +600,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				  SEGV_ACCERR : SEGV_MAPERR;
 		si.si_addr = (void __user *)addr;
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
+		arm64_force_sig_info(&si, inf->name);
 	}
 
 	return 0;
-- 
2.17.1

