Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B67C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5432E20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5432E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeGXEbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:31:52 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41957 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388130AbeGXEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz2-00032R-Iy; Mon, 23 Jul 2018 21:27:32 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxY-0008AK-W4; Mon, 23 Jul 2018 21:26:01 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:14 -0500
Message-Id: <20180724032419.20231-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxY-0008AK-W4;;;mid=<20180724032419.20231-15-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Prr5i69ukkQtEk8V22mSEII/ti0z69Z4=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 15/20] signal: Push pid type down into complete_signal.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the bottom and by pushing this down it simplifies the callers
and otherwise leaves things as is.  This is in preparation for allowing
fork to implement better handling of signals set to groups of processes.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 1ef94303d87a..dddbea558455 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -895,7 +895,7 @@ static inline int wants_signal(int sig, struct task_struct *p)
 	return task_curr(p) || !signal_pending(p);
 }
 
-static void complete_signal(int sig, struct task_struct *p, int group)
+static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 {
 	struct signal_struct *signal = p->signal;
 	struct task_struct *t;
@@ -908,7 +908,7 @@ static void complete_signal(int sig, struct task_struct *p, int group)
 	 */
 	if (wants_signal(sig, p))
 		t = p;
-	else if (!group || thread_group_empty(p))
+	else if ((type == PIDTYPE_PID) || thread_group_empty(p))
 		/*
 		 * There is just one thread and it does not need to be woken.
 		 * It will dequeue unblocked signals before it runs again.
@@ -1096,7 +1096,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 out_set:
 	signalfd_notify(t, sig);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, type != PIDTYPE_PID);
+	complete_signal(sig, t, type);
 ret:
 	trace_signal_generate(sig, info, t, type != PIDTYPE_PID, result);
 	return ret;
@@ -1704,7 +1704,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
 	list_add_tail(&q->list, &pending->list);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, type != PIDTYPE_PID);
+	complete_signal(sig, t, type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
 	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
-- 
2.17.1

