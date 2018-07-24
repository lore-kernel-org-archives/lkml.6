Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8325920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8325920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbeGXEaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:30:07 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51292 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeGXEaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:30:06 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxL-0007Vg-BA; Mon, 23 Jul 2018 21:25:47 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxK-0008AK-Kx; Mon, 23 Jul 2018 21:25:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:08 -0500
Message-Id: <20180724032419.20231-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxK-0008AK-Kx;;;mid=<20180724032419.20231-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rwbuEXsWmvXYWFIqV4fDdBB26B/fp+Kg=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/20] signal: Pass pid and pid type into send_sigqueue
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more maintainable by performing more of the signal
related work in send_sigqueue.

A quick inspection of do_timer_create will show that this code path
does not lookup a thread group by a thread's pid.  Making it safe
to find the task pointed to by it_pid with "pid_task(it_pid, type)";

This supports the changes needed in fork to tell if a signal was sent
to a single process or a group of processes.

Having the pid to task transition in signal.c will also make it easier
to sort out races with de_thread and and the thread group leader
exiting when it comes time to address that.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  2 +-
 kernel/signal.c              | 14 +++++++++-----
 kernel/time/posix-timers.c   | 13 ++++---------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ee30a5ba475f..94558ffa82ab 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -330,7 +330,7 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *,  struct task_struct *, int group);
+extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline int restart_syscall(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 8d8a940422a8..40feb14e276d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1664,17 +1664,20 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct task_struct *t, int group)
+int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
+	struct task_struct *t;
 	unsigned long flags;
 	int ret, result;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
 
 	ret = -1;
-	if (!likely(lock_task_sighand(t, &flags)))
+	rcu_read_lock();
+	t = pid_task(pid, type);
+	if (!t || !likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
 	ret = 1; /* the signal is ignored */
@@ -1696,15 +1699,16 @@ int send_sigqueue(struct sigqueue *q, struct task_struct *t, int group)
 	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
-	pending = group ? &t->signal->shared_pending : &t->pending;
+	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
 	list_add_tail(&q->list, &pending->list);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, group);
+	complete_signal(sig, t, type != PIDTYPE_PID);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
-	trace_signal_generate(sig, &q->info, t, group, result);
+	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
 ret:
+	rcu_read_unlock();
 	return ret;
 }
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2bdf08a2bae9..2d2e739fbc57 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -332,8 +332,8 @@ void posixtimer_rearm(struct siginfo *info)
 
 int posix_timer_event(struct k_itimer *timr, int si_private)
 {
-	struct task_struct *task;
-	int shared, ret = -1;
+	enum pid_type type;
+	int ret = -1;
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
@@ -347,13 +347,8 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
 	 */
 	timr->sigq->info.si_sys_private = si_private;
 
-	rcu_read_lock();
-	task = pid_task(timr->it_pid, PIDTYPE_PID);
-	if (task) {
-		shared = !(timr->it_sigev_notify & SIGEV_THREAD_ID);
-		ret = send_sigqueue(timr->sigq, task, shared);
-	}
-	rcu_read_unlock();
+	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
-- 
2.17.1

