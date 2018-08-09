Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D5121C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D5121C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeHIJVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:21:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43285 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:21:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet7-0000sq-3D; Thu, 09 Aug 2018 00:57:37 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnet6-00054s-9e; Thu, 09 Aug 2018 00:57:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  9 Aug 2018 01:56:05 -0500
Message-Id: <20180809065605.32345-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87wot0yqsx.fsf_-_@xmission.com>
References: <87wot0yqsx.fsf_-_@xmission.com>
X-XM-SPF: eid=1fnet6-00054s-9e;;;mid=<20180809065605.32345-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+LKmwfmaDxCMdDxGb5IuDY/VN26Ekrab4=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v5 6/6] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

Add a list of each thread that is currently forking, and keep on that
list a signal set that records all of the signals sent to multiple
processes.  When fork completes initialize the new processes
shared_pending signal set with it.  The calculate_sigpending function
will see those signals and set TIF_SIGPENDING causing the new task to
take the slow path to userspace to handle those signals.  Making it
appear as if those signals were received immediately after the fork.

It is not possible to send real time signals to multiple processes and
exceptions don't go to multiple processes, which means that that are
no signals sent to multiple processes that require siginfo.  This
means it is safe to not bother collecting siginfo on signals sent
during fork.

The sigaction of a child of fork is initially the same as the
sigaction of the parent process.  So a signal the parent ignores the
child will also initially ignore.  Therefore it is safe to ignore
signals sent to multiple processes and ignored by the forking process.

Signals sent to only a single process or only a single thread and delivered
during fork are treated as if they are received after the fork, and generally
not dealt with.  They won't cause any problems.

V2: Added removal from the multiprocess list on failure.
V3: Use -ERESTARTNOINTR directly
V4: - Don't queue both SIGCONT and SIGSTOP
    - Initialize signal_struct.multiprocess in init_task
    - Move setting of shared_pending to before the new task
      is visible to signals.  This prevents signals from comming
      in before shared_pending.signal is set to delayed.signal
      and being lost.
V5: - rework list add and delete to account for idle threads

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200447
Reported-by: Wen Yang <wen.yang99@zte.com.cn> and
Reported-by: majiang <ma.jiang@zte.com.cn>
Fixes: 4a2c7a7837da ("[PATCH] make fork() atomic wrt pgrp/session signals")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  8 +++++++
 init/init_task.c             |  1 +
 kernel/fork.c                | 43 +++++++++++++++++++++---------------
 kernel/signal.c              | 18 +++++++++++++++
 4 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ae2b0b81be25..4e9b77fb702d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -69,6 +69,11 @@ struct thread_group_cputimer {
 	bool checking_timer;
 };
 
+struct multiprocess_signals {
+	sigset_t signal;
+	struct hlist_node node;
+};
+
 /*
  * NOTE! "signal_struct" does not have its own
  * locking, because a shared signal_struct always
@@ -90,6 +95,9 @@ struct signal_struct {
 	/* shared signal handling: */
 	struct sigpending	shared_pending;
 
+	/* For collecting multiprocess signals during fork */
+	struct hlist_head	multiprocess;
+
 	/* thread group exit support */
 	int			group_exit_code;
 	/* overloaded:
diff --git a/init/init_task.c b/init/init_task.c
index 4f97846256d7..5aebe3be4d7c 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -22,6 +22,7 @@ static struct signal_struct init_signals = {
 		.list = LIST_HEAD_INIT(init_signals.shared_pending.list),
 		.signal =  {{0}}
 	},
+	.multiprocess	= HLIST_HEAD_INIT,
 	.rlim		= INIT_RLIMITS,
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 #ifdef CONFIG_POSIX_TIMERS
diff --git a/kernel/fork.c b/kernel/fork.c
index ab731e15a600..411e34acace7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1456,6 +1456,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	init_waitqueue_head(&sig->wait_chldexit);
 	sig->curr_target = tsk;
 	init_sigpending(&sig->shared_pending);
+	INIT_HLIST_HEAD(&sig->multiprocess);
 	seqlock_init(&sig->stats_lock);
 	prev_cputime_init(&sig->prev_cputime);
 
@@ -1602,6 +1603,7 @@ static __latent_entropy struct task_struct *copy_process(
 {
 	int retval;
 	struct task_struct *p;
+	struct multiprocess_signals delayed;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1649,6 +1651,24 @@ static __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	/*
+	 * Force any signals received before this point to be delivered
+	 * before the fork happens.  Collect up signals sent to multiple
+	 * processes that happen during the fork and delay them so that
+	 * they appear to happen after the fork.
+	 */
+	sigemptyset(&delayed.signal);
+	INIT_HLIST_NODE(&delayed.node);
+
+	spin_lock_irq(&current->sighand->siglock);
+	if (!(clone_flags & CLONE_THREAD))
+		hlist_add_head(&delayed.node, &current->signal->multiprocess);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+	retval = -ERESTARTNOINTR;
+	if (signal_pending(current))
+		goto fork_out;
+
 	retval = -ENOMEM;
 	p = dup_task_struct(current, node);
 	if (!p)
@@ -1934,22 +1954,6 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
-	if (!(clone_flags & CLONE_THREAD)) {
-		/*
-		 * Process group and session signals need to be delivered to just the
-		 * parent before the fork or both the parent and the child after the
-		 * fork. Restart if a signal comes in before we add the new process to
-		 * it's process group.
-		 * A fatal signal pending means that current will exit, so the new
-		 * thread can't slip out of an OOM kill (or normal SIGKILL).
-		 */
-		recalc_sigpending();
-		if (signal_pending(current)) {
-			retval = -ERESTARTNOINTR;
-			goto bad_fork_cancel_cgroup;
-		}
-	}
-
 
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
@@ -1965,7 +1969,7 @@ static __latent_entropy struct task_struct *copy_process(
 				ns_of_pid(pid)->child_reaper = p;
 				p->signal->flags |= SIGNAL_UNKILLABLE;
 			}
-
+			p->signal->shared_pending.signal = delayed.signal;
 			p->signal->tty = tty_kref_get(current->signal->tty);
 			/*
 			 * Inherit has_child_subreaper flag under the same
@@ -1993,8 +1997,8 @@ static __latent_entropy struct task_struct *copy_process(
 		attach_pid(p, PIDTYPE_PID);
 		nr_threads++;
 	}
-
 	total_forks++;
+	hlist_del_init(&delayed.node);
 	spin_unlock(&current->sighand->siglock);
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
@@ -2059,6 +2063,9 @@ static __latent_entropy struct task_struct *copy_process(
 	put_task_stack(p);
 	free_task(p);
 fork_out:
+	spin_lock_irq(&current->sighand->siglock);
+	hlist_del_init(&delayed.node);
+	spin_unlock_irq(&current->sighand->siglock);
 	return ERR_PTR(retval);
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9f0eafb6d474..850885db2c1e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1121,6 +1121,24 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 out_set:
 	signalfd_notify(t, sig);
 	sigaddset(&pending->signal, sig);
+
+	/* Let multiprocess signals appear after on-going forks */
+	if (type > PIDTYPE_TGID) {
+		struct multiprocess_signals *delayed;
+		hlist_for_each_entry(delayed, &t->signal->multiprocess, node) {
+			sigset_t *signal = &delayed->signal;
+			/* Can't queue both a stop and a continue signal */
+			if (sig == SIGCONT) {
+				sigset_t flush;
+				siginitset(&flush, SIG_KERNEL_STOP_MASK);
+				sigandnsets(signal, signal, &flush);
+			} else if (sig_kernel_stop(sig)) {
+				sigdelset(signal, SIGCONT);
+			}
+			sigaddset(signal, sig);
+		}
+	}
+
 	complete_signal(sig, t, type);
 ret:
 	trace_signal_generate(sig, info, t, type != PIDTYPE_PID, result);
-- 
2.17.1

