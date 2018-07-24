Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D0920875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbeGXEcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:32:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58867 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbeGXEby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz5-0005pp-1x; Mon, 23 Jul 2018 21:27:35 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxx-0008AK-6L; Mon, 23 Jul 2018 21:26:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:18 -0500
Message-Id: <20180724032419.20231-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxx-0008AK-6L;;;mid=<20180724032419.20231-19-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JBH7mYbLLQG145QkrFo8lOfz78n248a0=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 19/20] fork: Have new threads join on-going signal group stops
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two signals that are delivered to every member of a
signal group: SIGSTOP and SIGKILL.  Signal delivery requires every
signal appear to be delivered either before or after a clone syscall.
SIGKILL terminates the clone so does not need to be considered.  Which
leaves only SIGSTOP that needs to be considered when creating new
threads.

Today in the event of a group stop TIF_SIGPENDING will get set and the
fork will restart ensuring the fork syscall participates in the group
stop.

A fork (especially of a process with a lot of memory) is one of the
most expensive system so we really only want to restart a fork when
necessary.

It is easy so check to see if a SIGSTOP is ongoing have have the new
thread join it immediate after the clone completes.  Making it appear
the clone completed happened just before the SIGSTOP.

The calculate_sigpending function will see the bits set in jobctl and
set TIF_SIGPENDING to ensure the new task takes the slow path to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  2 ++
 kernel/fork.c                | 27 +++++++++++++++------------
 kernel/signal.c              | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7cabc0bc38f6..f3507bf165d0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -385,6 +385,8 @@ static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
 }
 
+void task_join_group_stop(struct task_struct *task);
+
 #ifdef TIF_RESTORE_SIGMASK
 /*
  * Legacy restore_sigmask accessors.  These are inefficient on
diff --git a/kernel/fork.c b/kernel/fork.c
index e07281254552..6c358846a8b8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1934,18 +1934,20 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
-	/*
-	 * Process group and session signals need to be delivered to just the
-	 * parent before the fork or both the parent and the child after the
-	 * fork. Restart if a signal comes in before we add the new process to
-	 * it's process group.
-	 * A fatal signal pending means that current will exit, so the new
-	 * thread can't slip out of an OOM kill (or normal SIGKILL).
-	*/
-	recalc_sigpending();
-	if (signal_pending(current)) {
-		retval = -ERESTARTNOINTR;
-		goto bad_fork_cancel_cgroup;
+	if (!(clone_flags & CLONE_THREAD)) {
+		/*
+		 * Process group and session signals need to be delivered to just the
+		 * parent before the fork or both the parent and the child after the
+		 * fork. Restart if a signal comes in before we add the new process to
+		 * it's process group.
+		 * A fatal signal pending means that current will exit, so the new
+		 * thread can't slip out of an OOM kill (or normal SIGKILL).
+		 */
+		recalc_sigpending();
+		if (signal_pending(current)) {
+			retval = -ERESTARTNOINTR;
+			goto bad_fork_cancel_cgroup;
+		}
 	}
 
 
@@ -1986,6 +1988,7 @@ static __latent_entropy struct task_struct *copy_process(
 					  &p->group_leader->thread_group);
 			list_add_tail_rcu(&p->thread_node,
 					  &p->signal->thread_head);
+			task_join_group_stop(p);
 		}
 		attach_pid(p, PIDTYPE_PID);
 		calculate_sigpending(p);
diff --git a/kernel/signal.c b/kernel/signal.c
index f6687c7d7a8c..78e2d5d196f3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -375,6 +375,20 @@ static bool task_participate_group_stop(struct task_struct *task)
 	return false;
 }
 
+void task_join_group_stop(struct task_struct *task)
+{
+	/* Have the new thread join an on-going signal group stop */
+	unsigned long jobctl = current->jobctl;
+	if (jobctl & JOBCTL_STOP_PENDING) {
+		struct signal_struct *sig = current->signal;
+		unsigned long signr = jobctl & JOBCTL_STOP_SIGMASK;
+		unsigned long gstop = JOBCTL_STOP_PENDING | JOBCTL_STOP_CONSUME;
+		if (task_set_jobctl_pending(task, signr | gstop)) {
+			sig->group_stop_count++;
+		}
+	}
+}
+
 /*
  * allocate a new signal queue record
  * - this may be called without locks if and only if t == current, otherwise an
-- 
2.17.1

