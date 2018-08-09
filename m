Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D172421C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D172421C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeHIJVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:21:00 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43876 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:20:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet4-0008Jd-QV; Thu, 09 Aug 2018 00:57:34 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet4-00054s-59; Thu, 09 Aug 2018 00:57:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  9 Aug 2018 01:56:04 -0500
Message-Id: <20180809065605.32345-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87wot0yqsx.fsf_-_@xmission.com>
References: <87wot0yqsx.fsf_-_@xmission.com>
X-XM-SPF: eid=1fnet4-00054s-59;;;mid=<20180809065605.32345-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ww3GyS0DV1xt2NGGGjhg+7q0DiDflhAE=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v5 5/6] fork: Have new threads join on-going signal group stops
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

It is easy so check to see if a SIGSTOP is ongoing and have the new
thread join it immediate after the clone completes.  Making it appear
the clone completed happened just before the SIGSTOP.

The calculate_sigpending function will see the bits set in jobctl and
set TIF_SIGPENDING to ensure the new task takes the slow path to userspace.

V2: The call to task_join_group_stop was moved before the new task is
    added to the thread group list.  This should not matter as
    sighand->siglock is held over both the addition of the threads,
    the call to task_join_group_stop and do_signal_stop.  But the change
    is trivial and it is one less thing to worry about when reading
    the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  2 ++
 kernel/fork.c                | 27 +++++++++++++++------------
 kernel/signal.c              | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b55fd293c1e5..ae2b0b81be25 100644
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
index 22d4cdb9a7ca..ab731e15a600 100644
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
 
 
@@ -1982,6 +1984,7 @@ static __latent_entropy struct task_struct *copy_process(
 			current->signal->nr_threads++;
 			atomic_inc(&current->signal->live);
 			atomic_inc(&current->signal->sigcnt);
+			task_join_group_stop(p);
 			list_add_tail_rcu(&p->thread_group,
 					  &p->group_leader->thread_group);
 			list_add_tail_rcu(&p->thread_node,
diff --git a/kernel/signal.c b/kernel/signal.c
index 1e06f1eba363..9f0eafb6d474 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -373,6 +373,20 @@ static bool task_participate_group_stop(struct task_struct *task)
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

