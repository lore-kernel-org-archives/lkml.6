Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A54C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449421486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A449421486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeIXPMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:12:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56427 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeIXPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:12:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mu3-0005aq-0f; Mon, 24 Sep 2018 03:11:39 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Mtn-0002zU-0O; Mon, 24 Sep 2018 03:11:38 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:03 +0200
Message-Id: <20180924091015.4458-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4Mtn-0002zU-0O;;;mid=<20180924091015.4458-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VqTbNdTF3xNJGjTIbyZaZyY+6fKlWmlE=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 03/15] signal/arm64: Factor out arm64_show_signal from arm64_force_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filling in siginfo is error prone and so it is wise to use more
specialized helpers to do that work.  Factor out the arm specific
unhandled signal reporting from the work of delivering a signal so
the code can be modified to use functions that take the information
to fill out siginfo as parameters.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/traps.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 24035d124608..daee8c2ca561 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -224,24 +224,19 @@ void die(const char *str, struct pt_regs *regs, int err)
 		do_exit(SIGSEGV);
 }
 
-static bool show_unhandled_signals_ratelimited(void)
+static void arm64_show_signal(int signo, const char *str)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	return show_unhandled_signals && __ratelimit(&rs);
-}
-
-void arm64_force_sig_info(struct siginfo *info, const char *str)
-{
 	struct task_struct *tsk = current;
 	unsigned int esr = tsk->thread.fault_code;
 	struct pt_regs *regs = task_pt_regs(tsk);
 
-	if (!unhandled_signal(tsk, info->si_signo))
-		goto send_sig;
-
-	if (!show_unhandled_signals_ratelimited())
-		goto send_sig;
+	/* Leave if the signal won't be shown */
+	if (!show_unhandled_signals ||
+	    !unhandled_signal(tsk, signo) ||
+	    !__ratelimit(&rs))
+		return;
 
 	pr_info("%s[%d]: unhandled exception: ", tsk->comm, task_pid_nr(tsk));
 	if (esr)
@@ -251,9 +246,12 @@ void arm64_force_sig_info(struct siginfo *info, const char *str)
 	print_vma_addr(KERN_CONT " in ", regs->pc);
 	pr_cont("\n");
 	__show_regs(regs);
+}
 
-send_sig:
-	force_sig_info(info->si_signo, info, tsk);
+void arm64_force_sig_info(struct siginfo *info, const char *str)
+{
+	arm64_show_signal(info->si_signo, str);
+	force_sig_info(info->si_signo, info, current);
 }
 
 void arm64_notify_die(const char *str, struct pt_regs *regs,
-- 
2.17.1

