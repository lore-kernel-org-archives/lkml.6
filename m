Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ABBECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C2E21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C2E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeIXPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:17:17 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56605 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeIXPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:17:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MyR-0005nA-CT; Mon, 24 Sep 2018 03:16:11 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mv8-0002zU-Bx; Mon, 24 Sep 2018 03:12:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:11 +0200
Message-Id: <20180924091015.4458-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4Mv8-0002zU-Bx;;;mid=<20180924091015.4458-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ZBBtEkbCky5S7R9I04CUQ7lLjjbTN3QE=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 11/15] signal/arm64: Add and use arm64_force_sig_mceerr as appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arm64_force_sig_mceerr for consistency with arm64_force_sig_fault,
and use it in the one location that can take advantage of it.

This removes the fiddly filling out of siginfo before sending a signal
reporting an memory error to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h | 1 +
 arch/arm64/kernel/traps.c      | 7 +++++++
 arch/arm64/mm/fault.c          | 9 ++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 08e99901edbc..193f0b0e8ee3 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -38,6 +38,7 @@ void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
+void arm64_force_sig_mceerr(int code, void __user *addr, short lsb, const char *str);
 void arm64_force_sig_info(struct siginfo *info, const char *str);
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 37a3309863e0..baa96dfffeec 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -255,6 +255,13 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
 	force_sig_fault(signo, code, addr, current);
 }
 
+void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
+			    const char *str)
+{
+	arm64_show_signal(SIGBUS, str);
+	force_sig_mceerr(code, addr, lsb, current);
+}
+
 void arm64_force_sig_info(struct siginfo *info, const char *str)
 {
 	arm64_show_signal(info->si_signo, str);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 66c295019a9a..f0ccb209d181 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -422,7 +422,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	const struct fault_info *inf;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	struct siginfo si;
 	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
@@ -574,12 +573,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
-		clear_siginfo(&si);
-		si.si_signo	= SIGBUS;
-		si.si_code	= BUS_MCEERR_AR;
-		si.si_addr = (void __user *)addr;
-		si.si_addr_lsb	= lsb;
-		arm64_force_sig_info(&si, inf->name);
+		arm64_force_sig_mceerr(BUS_MCEERR_AR, (void __user *)addr, lsb,
+				       inf->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
-- 
2.17.1

