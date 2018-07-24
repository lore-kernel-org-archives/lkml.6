Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE220C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E49B20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E49B20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbeGXEbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:31:53 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51373 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbeGXEbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz3-0007ic-Bz; Mon, 23 Jul 2018 21:27:33 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxW-0008AK-LM; Mon, 23 Jul 2018 21:25:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:13 -0500
Message-Id: <20180724032419.20231-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxW-0008AK-LM;;;mid=<20180724032419.20231-14-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19KDukiOfJbBuMvMD9YM8s+IzUojiCQLls=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 14/20] signal: Push pid type down into __send_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information is already available in the callers and by pushing it
down it makes the code a little clearer, and allows implementing
better handling of signales set to a group of processes in fork.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8decc70c1dc2..1ef94303d87a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -998,7 +998,7 @@ static inline void userns_fixup_signal_uid(struct siginfo *info, struct task_str
 #endif
 
 static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
-			int group, int from_ancestor_ns)
+			enum pid_type type, int from_ancestor_ns)
 {
 	struct sigpending *pending;
 	struct sigqueue *q;
@@ -1012,7 +1012,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 			from_ancestor_ns || (info == SEND_SIG_FORCED)))
 		goto ret;
 
-	pending = group ? &t->signal->shared_pending : &t->pending;
+	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
 	/*
 	 * Short-circuit ignored signals and support queuing
 	 * exactly one non-rt signal, so that we can get more
@@ -1096,9 +1096,9 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 out_set:
 	signalfd_notify(t, sig);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, group);
+	complete_signal(sig, t, type != PIDTYPE_PID);
 ret:
-	trace_signal_generate(sig, info, t, group, result);
+	trace_signal_generate(sig, info, t, type != PIDTYPE_PID, result);
 	return ret;
 }
 
@@ -1112,7 +1112,7 @@ static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
 			   !task_pid_nr_ns(current, task_active_pid_ns(t));
 #endif
 
-	return __send_signal(sig, info, t, type != PIDTYPE_PID, from_ancestor_ns);
+	return __send_signal(sig, info, t, type, from_ancestor_ns);
 }
 
 static void print_fatal_signal(int signr)
@@ -1377,7 +1377,7 @@ int kill_pid_info_as_cred(int sig, struct siginfo *info, struct pid *pid,
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, info, p, 1, 0);
+			ret = __send_signal(sig, info, p, PIDTYPE_TGID, 0);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
-- 
2.17.1

