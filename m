Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB5ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69D214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeIRFhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:37:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33531 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:37:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23YD-0007Nh-Os; Mon, 17 Sep 2018 18:07:33 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23YC-0002Qk-Mu; Mon, 17 Sep 2018 18:07:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:34 +0200
Message-Id: <20180918000546.12552-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23YC-0002Qk-Mu;;;mid=<20180918000546.12552-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oaLMFoknm5O+MEOb/bPIBa4txPjjjaxY=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code and trap_nr into do_trap_no_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Half of the times when error_code and trap_nr are set are already in
do_trap_no_signal.  Move the other time these are set into do_trap_no_signal,
and give do_trap_no_signal a single exit where a signals are sent.

After the move the comment documeting this all is much easier to follow
as everything is together in one place.

Also update the string that is passed in to const.  The only user of that
str is die and it already takes a const string, so this just makes it explicit
that the string won't change.

This prepares the way for adding a second caller to do_trap_no_signal.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 31a689b67be3..f31c0ddee278 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -189,7 +189,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 }
 
 static nokprobe_inline int
-do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
+do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
 {
 	if (v8086_mode(regs)) {
@@ -202,10 +202,8 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 						error_code, trapnr))
 				return 0;
 		}
-		return -1;
 	}
-
-	if (!user_mode(regs)) {
+	else if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr))
 			return 0;
 
@@ -214,6 +212,18 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 		die(str, regs, error_code);
 	}
 
+	/*
+	 * We want error_code and trap_nr set for userspace faults and
+	 * kernelspace faults which result in die(), but not
+	 * kernelspace faults which are fixed up.  die() gives the
+	 * process no chance to handle the signal and notice the
+	 * kernel fault information, so that won't result in polluting
+	 * the information about previously queued, but not yet
+	 * delivered, faults.  See also do_general_protection below.
+	 */
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = trapnr;
+
 	return -1;
 }
 
@@ -271,17 +281,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
-	/*
-	 * We want error_code and trap_nr set for userspace faults and
-	 * kernelspace faults which result in die(), but not
-	 * kernelspace faults which are fixed up.  die() gives the
-	 * process no chance to handle the signal and notice the
-	 * kernel fault information, so that won't result in polluting
-	 * the information about previously queued, but not yet
-	 * delivered, faults.  See also do_general_protection below.
-	 */
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = trapnr;
 
 	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
-- 
2.17.1

