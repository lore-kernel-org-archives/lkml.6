Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2239CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02E120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02E120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGXEbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:31:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41961 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbeGXEbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz3-00032Z-3H; Mon, 23 Jul 2018 21:27:33 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxT-0008AK-Pw; Mon, 23 Jul 2018 21:25:56 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:12 -0500
Message-Id: <20180724032419.20231-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxT-0008AK-Pw;;;mid=<20180724032419.20231-13-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++ynVFon7RuQmBMEWG9WKVKJAmxpEknn8=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 13/20] signal: Push pid type down into send_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information is already available in the callers and by pushing it
down it makes the code a little clearer, and allows better group
signal behavior in fork.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 2c09e6143dd8..8decc70c1dc2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1103,7 +1103,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 }
 
 static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
-			int group)
+			enum pid_type type)
 {
 	int from_ancestor_ns = 0;
 
@@ -1112,7 +1112,7 @@ static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
 			   !task_pid_nr_ns(current, task_active_pid_ns(t));
 #endif
 
-	return __send_signal(sig, info, t, group, from_ancestor_ns);
+	return __send_signal(sig, info, t, type != PIDTYPE_PID, from_ancestor_ns);
 }
 
 static void print_fatal_signal(int signr)
@@ -1151,13 +1151,13 @@ __setup("print-fatal-signals=", setup_print_fatal_signals);
 int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
-	return send_signal(sig, info, p, 1);
+	return send_signal(sig, info, p, PIDTYPE_TGID);
 }
 
 static int
 specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t)
 {
-	return send_signal(sig, info, t, 0);
+	return send_signal(sig, info, t, PIDTYPE_PID);
 }
 
 int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
@@ -1167,7 +1167,7 @@ int do_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
 	int ret = -ESRCH;
 
 	if (lock_task_sighand(p, &flags)) {
-		ret = send_signal(sig, info, p, type != PIDTYPE_PID);
+		ret = send_signal(sig, info, p, type);
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -3966,7 +3966,7 @@ void kdb_send_sig(struct task_struct *t, int sig)
 			   "the deadlock.\n");
 		return;
 	}
-	ret = send_signal(sig, SEND_SIG_PRIV, t, false);
+	ret = send_signal(sig, SEND_SIG_PRIV, t, PIDTYPE_PID);
 	spin_unlock(&t->sighand->siglock);
 	if (ret)
 		kdb_printf("Fail to deliver Signal %d to process %d.\n",
-- 
2.17.1

