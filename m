Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE18A208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18A208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeGKCvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:51:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40360 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:51:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd5Bo-0001KT-Gl; Tue, 10 Jul 2018 20:49:12 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59b-00063R-8d; Tue, 10 Jul 2018 20:46:56 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:59 -0500
Message-Id: <20180711024459.10654-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd59b-00063R-8d;;;mid=<20180711024459.10654-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nnMwbE2jMVlGRjuG1JwVlRGhTrYavBWM=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 11/11] signal: Ignore all but multi-process signals that come in during fork.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Yang <wen.yang99@zte.com.cn> and majiang <ma.jiang@zte.com.cn>
report that a periodic signal received during fork can cause fork to
continually restart preventing an application from making progress.

The code was being overly pesimistic.  Fork needs to guarantee that a
signal sent to multiple processes is logically delivered before the
fork and just to the forking process or logically delivered after the
fork to both the forking process and it's newly spawned child.  For
signals like periodic timers that are always delivered to a single
process fork can safely complete and let them appear to logically
delivered after the fork().

While examining this issue I also discovered that fork today will miss
signals delivered to multiple processes during the fork and handled by
another thread.  Similarly the current code will also miss blocked
signals that are delivered to multiple process, as those signals will
not appear pending during fork.

Add a sequence counter to signal_struct that notes when a signal sent
to multiple processes has been received.  If that sequence counter is
incremented during fork, restart the fork process and let the signals
sent to multiple processes be received before the fork.

The sigaction of a child of fork is initially the same as the
sigaction of the parent process.  So a signal the parent ignores the
child will also initially ignore.  Therefore it is safe to ignore
signals sent to multiple processes and ignored by the forking process.

Ensure all multiple processes signals received during the fork are
processed before the fork by restarting the fork.  Forwarding signals
sent to multiple processes to the new child appears to be a lot of tricky
work that we will never test so it is not currently implemented.

Signals sent to only a single process or only a single thread and delivered
during fork are treated as if they are received after the fork, and generally
not dealt with.  They won't cause any problems.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200447
Reported-by: Wen Yang <wen.yang99@zte.com.cn> and
Reported-by: majiang <ma.jiang@zte.com.cn>
Fixes: 4a2c7a7837da ("[PATCH] make fork() atomic wrt pgrp/session signals")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/fork.c                | 19 +++++++++++++++++--
 kernel/signal.c              |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e99cd53cbd80..f557b23f1d60 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -89,6 +89,7 @@ struct signal_struct {
 
 	/* shared signal handling: */
 	struct sigpending	shared_pending;
+	seqcount_t		multi_process_seq;
 
 	/* thread group exit support */
 	int			group_exit_code;
diff --git a/kernel/fork.c b/kernel/fork.c
index cc5be0d01ce6..f2e1df5c8189 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1456,6 +1456,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	init_waitqueue_head(&sig->wait_chldexit);
 	sig->curr_target = tsk;
 	init_sigpending(&sig->shared_pending);
+	seqcount_init(&sig->multi_process_seq);
 	seqlock_init(&sig->stats_lock);
 	prev_cputime_init(&sig->prev_cputime);
 
@@ -1602,6 +1603,20 @@ static __latent_entropy struct task_struct *copy_process(
 {
 	int retval;
 	struct task_struct *p;
+	unsigned seq;
+
+	/*
+	 * Signals that are delivered to multiple processes need to be
+	 * delivered to just the parent before the fork or both the
+	 * parent and the child after the fork.  Cache the multiple
+	 * process signal sequence number so we can detect any of
+	 * these signals that happen during the fork.  In the unlikely
+	 * event a signal comes in while fork is starting and restart
+	 * fork to handle the signal.
+	 */
+	seq = read_seqcount_begin(&current->signal->multi_process_seq);
+	if (signal_pending(current))
+		return ERR_PTR(-ERESTARTNOINTR);
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1930,8 +1945,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 * A fatal signal pending means that current will exit, so the new
 	 * thread can't slip out of an OOM kill (or normal SIGKILL).
 	*/
-	recalc_sigpending();
-	if (signal_pending(current)) {
+	if (read_seqcount_retry(&current->signal->multi_process_seq, seq) ||
+	    fatal_signal_pending(current)) {
 		retval = -ERESTARTNOINTR;
 		goto bad_fork_cancel_cgroup;
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index 2cf4ddc8e3a3..515275b3f68f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1096,6 +1096,8 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 out_set:
 	signalfd_notify(t, sig);
 	sigaddset(&pending->signal, sig);
+	if (type > PIDTYPE_TGID)
+		write_seqcount_invalidate(&t->signal->multi_process_seq);
 	complete_signal(sig, t, type);
 ret:
 	trace_signal_generate(sig, info, t, type, result);
-- 
2.17.1

