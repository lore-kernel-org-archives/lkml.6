Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08397C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB89E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB89E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeIXV3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:29:09 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44015 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIXV3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:29:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Skj-0006kE-Tg; Mon, 24 Sep 2018 09:26:25 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Ski-00018i-9L; Mon, 24 Sep 2018 09:26:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 17:25:36 +0200
Message-Id: <20180924152537.19515-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87lg7q2a2w.fsf@xmission.com>
References: <87lg7q2a2w.fsf@xmission.com>
X-XM-SPF: eid=1g4Ski-00018i-9L;;;mid=<20180924152537.19515-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qhlWIsWuIrX0L/SRx8fZRpTQdeKqXHuQ=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 2/3] signal/unicore32: Generate siginfo in ucs32_notify_die
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the signal number, and the signal code, and the faulting
address into uc32_notify_die so the callers do not need
to generate a struct siginfo.

In ucs32_ntoify_die use the newly passed in information to
call force_sig_fault to generate the siginfo and send the error.

This simplifies the code making the chances of bugs much less likely.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/unicore32/include/asm/bug.h |  3 ++-
 arch/unicore32/kernel/traps.c    |  5 +++--
 arch/unicore32/mm/fault.c        | 18 ++++--------------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/unicore32/include/asm/bug.h b/arch/unicore32/include/asm/bug.h
index 93a56f3e2344..83c7687a0e61 100644
--- a/arch/unicore32/include/asm/bug.h
+++ b/arch/unicore32/include/asm/bug.h
@@ -17,6 +17,7 @@ struct siginfo;
 
 extern void die(const char *msg, struct pt_regs *regs, int err);
 extern void uc32_notify_die(const char *str, struct pt_regs *regs,
-		struct siginfo *info, unsigned long err, unsigned long trap);
+		int sig, int code, void __user *addr,
+		unsigned long err, unsigned long trap);
 
 #endif /* __UNICORE_BUG_H__ */
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index c4ac6043ebb0..fb376d83e043 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -241,13 +241,14 @@ void die(const char *str, struct pt_regs *regs, int err)
 }
 
 void uc32_notify_die(const char *str, struct pt_regs *regs,
-		struct siginfo *info, unsigned long err, unsigned long trap)
+		int sig, int code, void __user *addr,
+		unsigned long err, unsigned long trap)
 {
 	if (user_mode(regs)) {
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
-		force_sig_info(info->si_signo, info, current);
+		force_sig_fault(sig, code, addr, current);
 	} else
 		die(str, regs, err);
 }
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 8f12a5b50a42..a942776110a0 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -466,7 +466,6 @@ asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
 			struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
@@ -474,19 +473,14 @@ asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
 	printk(KERN_ALERT "Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 	       inf->name, fsr, addr);
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code = inf->code;
-	info.si_addr = (void __user *)addr;
-	uc32_notify_die("", regs, &info, fsr, 0);
+	uc32_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+			fsr, 0);
 }
 
 asmlinkage void do_PrefetchAbort(unsigned long addr,
 			unsigned int ifsr, struct pt_regs *regs)
 {
 	const struct fsr_info *inf = fsr_info + fsr_fs(ifsr);
-	struct siginfo info;
 
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
@@ -494,10 +488,6 @@ asmlinkage void do_PrefetchAbort(unsigned long addr,
 	printk(KERN_ALERT "Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 	       inf->name, ifsr, addr);
 
-	clear_siginfo(&info);
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code = inf->code;
-	info.si_addr = (void __user *)addr;
-	uc32_notify_die("", regs, &info, ifsr, 0);
+	uc32_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
+			ifsr, 0);
 }
-- 
2.17.1

