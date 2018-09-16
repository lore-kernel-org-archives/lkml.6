Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E3ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3320883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E3320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeIPXaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:30:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51527 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIPXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:30:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bRE-0007bj-6t; Sun, 16 Sep 2018 12:06:28 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bRD-0004M6-3P; Sun, 16 Sep 2018 12:06:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87musyl3fa.fsf@xmission.com> <87lg81pbe2.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 20:06:18 +0200
In-Reply-To: <87lg81pbe2.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 20:04:05 +0200")
Message-ID: <874leppbad.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1bRD-0004M6-3P;;;mid=<874leppbad.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Veq2h+Tjtc/v7Ibn/MHjojq7VwCKmAP8=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/4] signal: Remove specific_send_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This function is static and it only has two callers.  As
specific_send_sig_info is only called twice remembering what
specific_send_sig_info does when reading the code is difficutl and it
makes it hard to see which sending sending functions are equivalent to
which others.

So remove specific_send_sig_info to make the code easier to read.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ec136fda457a..99e91163c9a3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1199,12 +1199,6 @@ __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 	return send_signal(sig, info, p, PIDTYPE_TGID);
 }
 
-static int
-specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
-{
-	return send_signal(sig, info, t, PIDTYPE_PID);
-}
-
 int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
 			enum pid_type type)
 {
@@ -1254,7 +1248,7 @@ force_sig_info(int sig, struct siginfo *info, struct task_struct *t)
 	 */
 	if (action->sa.sa_handler == SIG_DFL && !t->ptrace)
 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
-	ret = specific_send_sig_info(sig, info, t);
+	ret = send_signal(sig, info, t, PIDTYPE_PID);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
 	return ret;
@@ -2330,7 +2324,7 @@ static int ptrace_signal(int signr, siginfo_t *info)
 
 	/* If the (new) signal is now blocked, requeue it.  */
 	if (sigismember(&current->blocked, signr)) {
-		specific_send_sig_info(signr, info, current);
+		send_signal(signr, info, current, PIDTYPE_PID);
 		signr = 0;
 	}
 
-- 
2.17.1

