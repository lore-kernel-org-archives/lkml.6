Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55709C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047FD20936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047FD20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbeGKCsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:30 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40164 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKCs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:29 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd598-00017q-AJ; Tue, 10 Jul 2018 20:46:26 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd595-00063R-84; Tue, 10 Jul 2018 20:46:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:54 -0500
Message-Id: <20180711024459.10654-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd595-00063R-84;;;mid=<20180711024459.10654-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+xBMRkUTyV6rEoSNzfQoj+W9bqZgqhY7g=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 06/11] pid: Implement PIDTYPE_TGID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everywhere except in the pid array we distinguish between a tasks pid and
a tasks tgid (thread group id).  Even in the enumeration we want that
distinction sometimes so we have added __PIDTYPE_TGID.  With leader_pid
we almost have an implementation of PIDTYPE_TGID in struct signal_struct.

Add PIDTYPE_TGID as a first class member of the pid_type enumeration and
into the pids array.  Then remove the __PIDTYPE_TGID special case and the
leader_pid in signal_struct.

The net size increase is just an extra pointer added to struct pid and
an extra pair of pointers of an hlist_node added to task_struct.

The effect on code maintenance is the removal of a number of special
cases today and the potential to remove many more special cases as
PIDTYPE_TGID gets used to it's fullest.  The long term potential
is allowing zombie thread group leaders to exit, which will remove
a lot more special cases in the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/asm-offsets.c  | 2 +-
 arch/ia64/kernel/fsys.S         | 4 ++--
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 fs/exec.c                       | 1 +
 include/linux/pid.h             | 3 +--
 include/linux/sched.h           | 4 ++--
 include/linux/sched/signal.h    | 5 ++---
 init/init_task.c                | 2 +-
 kernel/events/core.c            | 2 +-
 kernel/exit.c                   | 1 +
 kernel/fork.c                   | 3 ++-
 kernel/pid.c                    | 2 --
 kernel/time/itimer.c            | 5 +++--
 kernel/time/posix-cpu-timers.c  | 2 +-
 14 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index c1f8a57855af..00e8e2a1eb19 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -67,7 +67,7 @@ void foo(void)
 	DEFINE(IA64_SIGNAL_GROUP_STOP_COUNT_OFFSET,offsetof (struct signal_struct,
 							     group_stop_count));
 	DEFINE(IA64_SIGNAL_SHARED_PENDING_OFFSET,offsetof (struct signal_struct, shared_pending));
-	DEFINE(IA64_SIGNAL_LEADER_PID_OFFSET, offsetof (struct signal_struct, leader_pid));
+	DEFINE(IA64_SIGNAL_PIDS_TGID_OFFSET, offsetof (struct signal_struct, pids[PIDTYPE_TGID]));
 
 	BLANK();
 
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index e85ebdac678b..d80c99a5f55d 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -68,10 +68,10 @@ ENTRY(fsys_getpid)
 	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
 	;;
 	ld4 r9=[r9]
-	add r17=IA64_SIGNAL_LEADER_PID_OFFSET,r17
+	add r17=IA64_SIGNAL_PIDS_TGID_OFFSET,r17
 	;;
 	and r9=TIF_ALLWORK_MASK,r9
-	ld8 r17=[r17]				// r17 = current->signal->leader_pid
+	ld8 r17=[r17]				// r17 = current->signal->pids[PIDTYPE_TGID]
 	;;
 	add r8=IA64_PID_LEVEL_OFFSET,r17
 	;;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 0292d68e7dde..ca0b7ae894bb 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -665,7 +665,7 @@ static void cpumsf_output_event_pid(struct perf_event *event,
 		goto out;
 
 	/* Update the process ID (see also kernel/events/core.c) */
-	data->tid_entry.pid = cpumsf_pid_type(event, pid, __PIDTYPE_TGID);
+	data->tid_entry.pid = cpumsf_pid_type(event, pid, PIDTYPE_TGID);
 	data->tid_entry.tid = cpumsf_pid_type(event, pid, PIDTYPE_PID);
 
 	perf_output_sample(&handle, &header, data, event);
diff --git a/fs/exec.c b/fs/exec.c
index 2d4e0075bd24..79a11fbded7a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1146,6 +1146,7 @@ static int de_thread(struct task_struct *tsk)
 		 */
 		tsk->pid = leader->pid;
 		change_pid(tsk, PIDTYPE_PID, task_pid(leader));
+		transfer_pid(leader, tsk, PIDTYPE_TGID);
 		transfer_pid(leader, tsk, PIDTYPE_PGID);
 		transfer_pid(leader, tsk, PIDTYPE_SID);
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 3d4c504dcc8c..14a9a39da9c7 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -7,11 +7,10 @@
 enum pid_type
 {
 	PIDTYPE_PID,
+	PIDTYPE_TGID,
 	PIDTYPE_PGID,
 	PIDTYPE_SID,
 	PIDTYPE_MAX,
-	/* only valid to __task_pid_nr_ns() */
-	__PIDTYPE_TGID
 };
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 445bdf5b1f64..06b4e3bda93a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1275,12 +1275,12 @@ static inline pid_t task_session_vnr(struct task_struct *tsk)
 
 static inline pid_t task_tgid_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
 {
-	return __task_pid_nr_ns(tsk, __PIDTYPE_TGID, ns);
+	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, ns);
 }
 
 static inline pid_t task_tgid_vnr(struct task_struct *tsk)
 {
-	return __task_pid_nr_ns(tsk, __PIDTYPE_TGID, NULL);
+	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, NULL);
 }
 
 static inline pid_t task_ppid_nr_ns(const struct task_struct *tsk, struct pid_namespace *ns)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 2dcded16eb1e..ee30a5ba475f 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -147,7 +147,6 @@ struct signal_struct {
 #endif
 
 	/* PID/PID hash table linkage. */
-	struct pid *leader_pid;
 	struct pid *pids[PIDTYPE_MAX];
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -571,7 +570,7 @@ struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
 
 static inline struct pid *task_tgid(struct task_struct *task)
 {
-	return task->signal->leader_pid;
+	return task->signal->pids[PIDTYPE_TGID];
 }
 
 /*
@@ -607,7 +606,7 @@ static inline bool thread_group_leader(struct task_struct *p)
  */
 static inline bool has_group_leader_pid(struct task_struct *p)
 {
-	return task_pid(p) == p->signal->leader_pid;
+	return task_pid(p) == task_tgid(p);
 }
 
 static inline
diff --git a/init/init_task.c b/init/init_task.c
index db12a61259f1..4f97846256d7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -33,9 +33,9 @@ static struct signal_struct init_signals = {
 	},
 #endif
 	INIT_CPU_TIMERS(init_signals)
-	.leader_pid = &init_struct_pid,
 	.pids = {
 		[PIDTYPE_PID]	= &init_struct_pid,
+		[PIDTYPE_TGID]	= &init_struct_pid,
 		[PIDTYPE_PGID]	= &init_struct_pid,
 		[PIDTYPE_SID]	= &init_struct_pid,
 	},
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80cca2b30c4f..9025b1796ca8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1334,7 +1334,7 @@ static u32 perf_event_pid_type(struct perf_event *event, struct task_struct *p,
 
 static u32 perf_event_pid(struct perf_event *event, struct task_struct *p)
 {
-	return perf_event_pid_type(event, p, __PIDTYPE_TGID);
+	return perf_event_pid_type(event, p, PIDTYPE_TGID);
 }
 
 static u32 perf_event_tid(struct perf_event *event, struct task_struct *p)
diff --git a/kernel/exit.c b/kernel/exit.c
index 16432428fc6c..25582b442955 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -73,6 +73,7 @@ static void __unhash_process(struct task_struct *p, bool group_dead)
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
 	if (group_dead) {
+		detach_pid(p, PIDTYPE_TGID);
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d2952162399b..cc5be0d01ce6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1946,6 +1946,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 		init_task_pid(p, PIDTYPE_PID, pid);
 		if (thread_group_leader(p)) {
+			init_task_pid(p, PIDTYPE_TGID, pid);
 			init_task_pid(p, PIDTYPE_PGID, task_pgrp(current));
 			init_task_pid(p, PIDTYPE_SID, task_session(current));
 
@@ -1954,7 +1955,6 @@ static __latent_entropy struct task_struct *copy_process(
 				p->signal->flags |= SIGNAL_UNKILLABLE;
 			}
 
-			p->signal->leader_pid = pid;
 			p->signal->tty = tty_kref_get(current->signal->tty);
 			/*
 			 * Inherit has_child_subreaper flag under the same
@@ -1965,6 +1965,7 @@ static __latent_entropy struct task_struct *copy_process(
 							 p->real_parent->signal->is_child_subreaper;
 			list_add_tail(&p->sibling, &p->real_parent->children);
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
+			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
 			attach_pid(p, PIDTYPE_SID);
 			__this_cpu_inc(process_counts);
diff --git a/kernel/pid.c b/kernel/pid.c
index f8486d2e2346..de1cfc4f75a2 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -269,8 +269,6 @@ static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
 {
 	return (type == PIDTYPE_PID) ?
 		&task->thread_pid :
-		(type == __PIDTYPE_TGID) ?
-		&task->signal->leader_pid :
 		&task->signal->pids[type];
 }
 
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index f26acef5d7b4..9a65713c8309 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -139,9 +139,10 @@ enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
 	struct signal_struct *sig =
 		container_of(timer, struct signal_struct, real_timer);
+	struct pid *leader_pid = sig->pids[PIDTYPE_TGID];
 
-	trace_itimer_expire(ITIMER_REAL, sig->leader_pid, 0);
-	kill_pid_info(SIGALRM, SEND_SIG_PRIV, sig->leader_pid);
+	trace_itimer_expire(ITIMER_REAL, leader_pid, 0);
+	kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid);
 
 	return HRTIMER_NORESTART;
 }
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5a6251ac6f7a..40e6fae46cec 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -895,7 +895,7 @@ static void check_cpu_itimer(struct task_struct *tsk, struct cpu_itimer *it,
 
 		trace_itimer_expire(signo == SIGPROF ?
 				    ITIMER_PROF : ITIMER_VIRTUAL,
-				    tsk->signal->leader_pid, cur_time);
+				    task_tgid(tsk), cur_time);
 		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
 	}
 
-- 
2.17.1

