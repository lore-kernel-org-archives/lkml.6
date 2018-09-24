Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D369ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC06B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC06B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbeIXUwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38152 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbeIXUwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4SB7-0001dH-PY; Mon, 24 Sep 2018 08:49:37 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4SB6-0002hz-QP; Mon, 24 Sep 2018 08:49:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 16:49:09 +0200
Message-Id: <20180924144910.14902-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <874lef2bqn.fsf@xmission.com>
References: <874lef2bqn.fsf@xmission.com>
X-XM-SPF: eid=1g4SB6-0002hz-QP;;;mid=<20180924144910.14902-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18c/MIjvdxmq+3uGmMuc03pds/y2avbelE=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 1/2] signal/arc: Push siginfo generation into unhandled_exception
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass signr, sicode, and address into unhandled_exception as explicit
parameters instead of members of struct siginfo.  Then in unhandled
exception generate and send the siginfo using force_sig_fault.

This keeps the code simpler and less error prone.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/traps.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index b123558bf0bb..a7fcbc0d3943 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -42,21 +42,22 @@ void die(const char *str, struct pt_regs *regs, unsigned long address)
  *  -for kernel, chk if due to copy_(to|from)_user, otherwise die()
  */
 static noinline int
-unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
+unhandled_exception(const char *str, struct pt_regs *regs,
+		    int signo, int si_code, void __user *addr)
 {
 	if (user_mode(regs)) {
 		struct task_struct *tsk = current;
 
-		tsk->thread.fault_address = (__force unsigned int)info->si_addr;
+		tsk->thread.fault_address = (__force unsigned int)addr;
 
-		force_sig_info(info->si_signo, info, tsk);
+		force_sig_fault(signo, si_code, addr, tsk);
 
 	} else {
 		/* If not due to copy_(to|from)_user, we are doomed */
 		if (fixup_exception(regs))
 			return 0;
 
-		die(str, regs, (unsigned long)info->si_addr);
+		die(str, regs, (unsigned long)addr);
 	}
 
 	return 1;
@@ -64,16 +65,9 @@ unhandled_exception(const char *str, struct pt_regs *regs, siginfo_t *info)
 
 #define DO_ERROR_INFO(signr, str, name, sicode) \
 int name(unsigned long address, struct pt_regs *regs) \
-{						\
-	siginfo_t info;				\
-						\
-	clear_siginfo(&info);			\
-	info.si_signo = signr;			\
-	info.si_errno = 0;			\
-	info.si_code  = sicode;			\
-	info.si_addr = (void __user *)address;	\
-						\
-	return unhandled_exception(str, regs, &info);\
+{								\
+	return unhandled_exception(str, regs, signr, sicode,	\
+				   (void __user *)address);	\
 }
 
 /*
-- 
2.17.1

