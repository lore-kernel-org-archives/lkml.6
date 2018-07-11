Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F865C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF665208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF665208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeGKCs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:58 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57111 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeGKCs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59Z-0007IG-MQ; Tue, 10 Jul 2018 20:46:53 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59K-00063R-2a; Tue, 10 Jul 2018 20:46:53 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:58 -0500
Message-Id: <20180711024459.10654-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd59K-00063R-2a;;;mid=<20180711024459.10654-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kK0mesNhVuAqn6YrGIZF6//QEw9BdofI=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 10/11] signal: Push pid type from signal senders down into __send_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the information we already have to document which signals are sent
to a group of processes and which signals are sent to a single process
or a single thread.  This information will be needed later to ensure
signals are atomic with respect to fork (always coming in before or
after the system call), and so that fork doesn't restart when
unnecessary.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/sysrq.c           |  2 +-
 drivers/tty/tty_io.c          |  6 ++--
 fs/fcntl.c                    | 22 +++++---------
 include/linux/sched/signal.h  |  2 +-
 include/linux/signal.h        |  6 ++--
 include/trace/events/signal.h | 12 ++++----
 kernel/exit.c                 |  3 +-
 kernel/signal.c               | 55 +++++++++++++++++++----------------
 kernel/time/posix-timers.c    | 12 +++-----
 mm/oom_kill.c                 |  4 +--
 10 files changed, 60 insertions(+), 64 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6364890575ec..06ed20dd01ba 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -348,7 +348,7 @@ static void send_sig_all(int sig)
 		if (is_global_init(p))
 			continue;
 
-		do_send_sig_info(sig, SEND_SIG_FORCED, p, true);
+		do_send_sig_info(sig, SEND_SIG_FORCED, p, PIDTYPE_MAX);
 	}
 	read_unlock(&tasklist_lock);
 }
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 42ac168c2a47..c8b4cfaceed1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2747,7 +2747,7 @@ void __do_SAK(struct tty_struct *tty)
 	do_each_pid_task(session, PIDTYPE_SID, p) {
 		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
 			   task_pid_nr(p), p->comm);
-		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
+		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_SID);
 	} while_each_pid_task(session, PIDTYPE_SID, p);
 
 	/* Now kill any processes that happen to have the tty open */
@@ -2755,7 +2755,7 @@ void __do_SAK(struct tty_struct *tty)
 		if (p->signal->tty == tty) {
 			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
 				   task_pid_nr(p), p->comm);
-			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
+			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_SID);
 			continue;
 		}
 		task_lock(p);
@@ -2763,7 +2763,7 @@ void __do_SAK(struct tty_struct *tty)
 		if (i != 0) {
 			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
 				   task_pid_nr(p), p->comm, i - 1);
-			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
+			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_SID);
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index cf10909cfa0a..21927688cbcf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -723,7 +723,7 @@ static inline int sigio_perm(struct task_struct *p,
 
 static void send_sigio_to_task(struct task_struct *p,
 			       struct fown_struct *fown,
-			       int fd, int reason, int group)
+			       int fd, int reason, enum pid_type type)
 {
 	/*
 	 * F_SETSIG can change ->signum lockless in parallel, make
@@ -767,11 +767,11 @@ static void send_sigio_to_task(struct task_struct *p,
 			else
 				si.si_band = mangle_poll(band_table[reason - POLL_IN]);
 			si.si_fd    = fd;
-			if (!do_send_sig_info(signum, &si, p, group))
+			if (!do_send_sig_info(signum, &si, p, type))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
 		case 0:
-			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, group);
+			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
 	}
 }
 
@@ -780,21 +780,17 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
-	int group = 1;
 	
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_PID)
-		group = 0;
-
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
 	
 	read_lock(&tasklist_lock);
 	do_each_pid_task(pid, type, p) {
-		send_sigio_to_task(p, fown, fd, band, group);
+		send_sigio_to_task(p, fown, fd, band, type);
 	} while_each_pid_task(pid, type, p);
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
@@ -802,10 +798,10 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 }
 
 static void send_sigurg_to_task(struct task_struct *p,
-				struct fown_struct *fown, int group)
+				struct fown_struct *fown, enum pid_type type)
 {
 	if (sigio_perm(p, fown, SIGURG))
-		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, group);
+		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, type);
 }
 
 int send_sigurg(struct fown_struct *fown)
@@ -813,15 +809,11 @@ int send_sigurg(struct fown_struct *fown)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
-	int group = 1;
 	int ret = 0;
 	
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_PID)
-		group = 0;
-
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
@@ -830,7 +822,7 @@ int send_sigurg(struct fown_struct *fown)
 	
 	read_lock(&tasklist_lock);
 	do_each_pid_task(pid, type, p) {
-		send_sigurg_to_task(p, fown, group);
+		send_sigurg_to_task(p, fown, type);
 	} while_each_pid_task(pid, type, p);
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ee30a5ba475f..e99cd53cbd80 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -330,7 +330,7 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *,  struct task_struct *, int group);
+extern int send_sigqueue(struct sigqueue *,  struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline int restart_syscall(void)
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3c5200137b24..fe125b0335f7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -254,11 +254,13 @@ static inline int valid_signal(unsigned long sig)
 
 struct timespec;
 struct pt_regs;
+enum pid_type;
 
 extern int next_signal(struct sigpending *pending, sigset_t *mask);
 extern int do_send_sig_info(int sig, struct siginfo *info,
-				struct task_struct *p, bool group);
-extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
+				struct task_struct *p, enum pid_type type);
+extern int group_send_sig_info(int sig, struct siginfo *info,
+			       struct task_struct *p, enum pid_type type);
 extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern void set_current_blocked(sigset_t *);
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 86582923d51c..e3901aee9b0f 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -39,7 +39,7 @@ enum {
  * @sig: signal number
  * @info: pointer to struct siginfo
  * @task: pointer to struct task_struct
- * @group: shared or private
+ * @type: kind of signal generated
  * @result: TRACE_SIGNAL_*
  *
  * Current process sends a 'sig' signal to 'task' process with
@@ -51,9 +51,9 @@ enum {
 TRACE_EVENT(signal_generate,
 
 	TP_PROTO(int sig, struct siginfo *info, struct task_struct *task,
-			int group, int result),
+			enum pid_type type, int result),
 
-	TP_ARGS(sig, info, task, group, result),
+	TP_ARGS(sig, info, task, type, result),
 
 	TP_STRUCT__entry(
 		__field(	int,	sig			)
@@ -61,7 +61,7 @@ TRACE_EVENT(signal_generate,
 		__field(	int,	code			)
 		__array(	char,	comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	pid			)
-		__field(	int,	group			)
+		__field(	enum pid_type,	type		)
 		__field(	int,	result			)
 	),
 
@@ -70,13 +70,13 @@ TRACE_EVENT(signal_generate,
 		TP_STORE_SIGINFO(__entry, info);
 		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
 		__entry->pid	= task->pid;
-		__entry->group	= group;
+		__entry->type	= type;
 		__entry->result	= result;
 	),
 
 	TP_printk("sig=%d errno=%d code=%d comm=%s pid=%d grp=%d res=%d",
 		  __entry->sig, __entry->errno, __entry->code,
-		  __entry->comm, __entry->pid, __entry->group,
+		  __entry->comm, __entry->pid, __entry->type != PIDTYPE_PID,
 		  __entry->result)
 );
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 25582b442955..0e21e6d21f35 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -681,7 +681,8 @@ static void forget_original_parent(struct task_struct *father,
 				t->parent = t->real_parent;
 			if (t->pdeath_signal)
 				group_send_sig_info(t->pdeath_signal,
-						    SEND_SIG_NOINFO, t);
+						    SEND_SIG_NOINFO, t,
+						    PIDTYPE_TGID);
 		}
 		/*
 		 * If this is a threaded reparent there is no need to
diff --git a/kernel/signal.c b/kernel/signal.c
index 7caf17d76a84..2cf4ddc8e3a3 100644
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
@@ -998,7 +998,7 @@ static inline void userns_fixup_signal_uid(struct siginfo *info, struct task_str
 #endif
 
 static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
-			int group, int from_ancestor_ns)
+			 enum pid_type type, int from_ancestor_ns)
 {
 	struct sigpending *pending;
 	struct sigqueue *q;
@@ -1012,7 +1012,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 			from_ancestor_ns || (info == SEND_SIG_FORCED)))
 		goto ret;
 
-	pending = group ? &t->signal->shared_pending : &t->pending;
+	pending = type != PIDTYPE_PID ? &t->signal->shared_pending : &t->pending;
 	/*
 	 * Short-circuit ignored signals and support queuing
 	 * exactly one non-rt signal, so that we can get more
@@ -1096,14 +1096,14 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 out_set:
 	signalfd_notify(t, sig);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, group);
+	complete_signal(sig, t, type);
 ret:
-	trace_signal_generate(sig, info, t, group, result);
+	trace_signal_generate(sig, info, t, type, result);
 	return ret;
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
+	return __send_signal(sig, info, t, type, from_ancestor_ns);
 }
 
 static void print_fatal_signal(int signr)
@@ -1151,23 +1151,23 @@ __setup("print-fatal-signals=", setup_print_fatal_signals);
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
-			bool group)
+			enum pid_type type)
 {
 	unsigned long flags;
 	int ret = -ESRCH;
 
 	if (lock_task_sighand(p, &flags)) {
-		ret = send_signal(sig, info, p, group);
+		ret = send_signal(sig, info, p, type);
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -1274,7 +1274,8 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 /*
  * send signal info to all the members of a group
  */
-int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p,
+	enum pid_type type)
 {
 	int ret;
 
@@ -1283,7 +1284,7 @@ int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 	rcu_read_unlock();
 
 	if (!ret && sig)
-		ret = do_send_sig_info(sig, info, p, true);
+		ret = do_send_sig_info(sig, info, p, type);
 
 	return ret;
 }
@@ -1301,7 +1302,7 @@ int __kill_pgrp_info(int sig, struct siginfo *info, struct pid *pgrp)
 	success = 0;
 	retval = -ESRCH;
 	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
-		int err = group_send_sig_info(sig, info, p);
+		int err = group_send_sig_info(sig, info, p, PIDTYPE_PGID);
 		success |= !err;
 		retval = err;
 	} while_each_pid_task(pgrp, PIDTYPE_PGID, p);
@@ -1317,7 +1318,7 @@ int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_TGID);
 		if (p)
-			error = group_send_sig_info(sig, info, p);
+			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
 		rcu_read_unlock();
 		if (likely(!p || error != -ESRCH))
 			return error;
@@ -1376,7 +1377,7 @@ int kill_pid_info_as_cred(int sig, struct siginfo *info, struct pid *pid,
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, info, p, 1, 0);
+			ret = __send_signal(sig, info, p, PIDTYPE_TGID, 0);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
@@ -1420,7 +1421,7 @@ static int kill_something_info(int sig, struct siginfo *info, pid_t pid)
 		for_each_process(p) {
 			if (task_pid_vnr(p) > 1 &&
 					!same_thread_group(p, current)) {
-				int err = group_send_sig_info(sig, info, p);
+				int err = group_send_sig_info(sig, info, p, PIDTYPE_MAX);
 				++count;
 				if (err != -EPERM)
 					retval = err;
@@ -1446,7 +1447,7 @@ int send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 	if (!valid_signal(sig))
 		return -EINVAL;
 
-	return do_send_sig_info(sig, info, p, false);
+	return do_send_sig_info(sig, info, p, PIDTYPE_PID);
 }
 
 #define __si_special(priv) \
@@ -1664,15 +1665,18 @@ void sigqueue_free(struct sigqueue *q)
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
 
+	rcu_read_lock();
+	t = pid_task(pid, type);
 	ret = -1;
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
@@ -1696,15 +1700,16 @@ int send_sigqueue(struct sigqueue *q, struct task_struct *t, int group)
 	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
-	pending = group ? &t->signal->shared_pending : &t->pending;
+	pending = type != PIDTYPE_PID ? &t->signal->shared_pending : &t->pending;
 	list_add_tail(&q->list, &pending->list);
 	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, group);
+	complete_signal(sig, t, type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
-	trace_signal_generate(sig, &q->info, t, group, result);
+	trace_signal_generate(sig, &q->info, t, type, result);
 	unlock_task_sighand(t, &flags);
 ret:
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -3193,7 +3198,7 @@ do_send_specific(pid_t tgid, pid_t pid, int sig, struct siginfo *info)
 		 * probe.  No signal is actually delivered.
 		 */
 		if (!error && sig) {
-			error = do_send_sig_info(sig, info, p, false);
+			error = do_send_sig_info(sig, info, p, PIDTYPE_PID);
 			/*
 			 * If lock_task_sighand() failed we pretend the task
 			 * dies after receiving the signal. The window is tiny,
@@ -3960,7 +3965,7 @@ void kdb_send_sig(struct task_struct *t, int sig)
 			   "the deadlock.\n");
 		return;
 	}
-	ret = send_signal(sig, SEND_SIG_PRIV, t, false);
+	ret = send_signal(sig, SEND_SIG_PRIV, t, PIDTYPE_PID);
 	spin_unlock(&t->sighand->siglock);
 	if (ret)
 		kdb_printf("Fail to deliver Signal %d to process %d.\n",
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d640e26d0de0..f0c8d98e9eff 100644
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
@@ -347,12 +347,8 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
 	 */
 	timr->sigq->info.si_sys_private = si_private;
 
-	shared = !(timr->it_sigev_notify & SIGEV_THREAD_ID);
-	rcu_read_lock();
-	task = pid_task(timr->it_pid, shared ? PIDTYPE_TGID : PIDTYPE_PID);
-	if (task)
-		ret = send_sigqueue(timr->sigq, task, shared);
-	rcu_read_unlock();
+	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e77bc51..2cc9b238368f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -920,7 +920,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * in order to prevent the OOM victim from depleting the memory
 	 * reserves from the user space under its control.
 	 */
-	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, true);
+	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
 	pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 		task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
@@ -958,7 +958,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 		 */
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
-		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
+		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
 	}
 	rcu_read_unlock();
 
-- 
2.17.1

