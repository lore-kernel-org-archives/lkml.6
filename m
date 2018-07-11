Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C08C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED3208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ED3208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeGKCsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41529 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGKCsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd593-0006yC-Mg; Tue, 10 Jul 2018 20:46:21 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd591-00063R-Gy; Tue, 10 Jul 2018 20:46:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:53 -0500
Message-Id: <20180711024459.10654-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd591-00063R-Gy;;;mid=<20180711024459.10654-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18U2TeEzbl+HzGhdTkmvT2zHuJcQDP2I6s=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 05/11] pids: Move the pgrp and session pid pointers from task_struct to signal_struct
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To access these fields the code always has to go to group leader so
going to signal struct is no loss and is actually a fundamental simplification.

This saves a little bit of memory by only allocating the pid pointer array
once instead of once for every thread, and even better this removes a
few potential races caused by the fact that group_leader can be changed
by de_thread, while signal_struct can not.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/asm-offsets.c |  2 +-
 arch/ia64/kernel/fsys.S        |  4 +--
 fs/autofs/autofs_i.h           |  1 +
 include/linux/init_task.h      |  9 -------
 include/linux/pid.h            |  8 +-----
 include/linux/sched.h          | 22 +++--------------
 include/linux/sched/signal.h   | 26 +++++++++++++++++---
 init/init_task.c               | 11 +++++----
 kernel/fork.c                  | 23 +++++++++++++----
 kernel/pid.c                   | 45 +++++++++++++++++-----------------
 10 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index f5433bb7f04a..c1f8a57855af 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -50,7 +50,7 @@ void foo(void)
 
 	DEFINE(IA64_TASK_BLOCKED_OFFSET,offsetof (struct task_struct, blocked));
 	DEFINE(IA64_TASK_CLEAR_CHILD_TID_OFFSET,offsetof (struct task_struct, clear_child_tid));
-	DEFINE(IA64_TASK_TGIDLINK_OFFSET, offsetof (struct task_struct, pids[PIDTYPE_PID].pid));
+	DEFINE(IA64_TASK_THREAD_PID_OFFSET,offsetof (struct task_struct, thread_pid));
 	DEFINE(IA64_PID_LEVEL_OFFSET, offsetof (struct pid, level));
 	DEFINE(IA64_PID_UPID_OFFSET, offsetof (struct pid, numbers[0]));
 	DEFINE(IA64_TASK_PENDING_OFFSET,offsetof (struct task_struct, pending));
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index eaf5a0d6f3e0..e85ebdac678b 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -96,11 +96,11 @@ ENTRY(fsys_set_tid_address)
 	.altrp b6
 	.body
 	add r9=TI_FLAGS+IA64_TASK_SIZE,r16
-	add r17=IA64_TASK_TGIDLINK_OFFSET,r16
+	add r17=IA64_TASK_THREAD_PID_OFFSET,r16
 	;;
 	ld4 r9=[r9]
 	tnat.z p6,p7=r32		// check argument register for being NaT
-	ld8 r17=[r17]				// r17 = current->pids[PIDTYPE_PID].pid
+	ld8 r17=[r17]				// r17 = current->thread_pid
 	;;
 	and r9=TIF_ALLWORK_MASK,r9
 	add r8=IA64_PID_LEVEL_OFFSET,r17
diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 9400a9f6318a..502812289850 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/uaccess.h>
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a454b8aeb938..a7083a45a26c 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -46,15 +46,6 @@ extern struct cred init_cred;
 #define INIT_CPU_TIMERS(s)
 #endif
 
-#define INIT_PID_LINK(type) 					\
-{								\
-	.node = {						\
-		.next = NULL,					\
-		.pprev = NULL,					\
-	},							\
-	.pid = &init_struct_pid,				\
-}
-
 #define INIT_TASK_COMM "swapper"
 
 /* Attach to the init_task data structure for proper alignment */
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 7633d55d9a24..3d4c504dcc8c 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -67,12 +67,6 @@ struct pid
 
 extern struct pid init_struct_pid;
 
-struct pid_link
-{
-	struct hlist_node node;
-	struct pid *pid;
-};
-
 static inline struct pid *get_pid(struct pid *pid)
 {
 	if (pid)
@@ -177,7 +171,7 @@ pid_t pid_vnr(struct pid *pid);
 	do {								\
 		if ((pid) != NULL)					\
 			hlist_for_each_entry_rcu((task),		\
-				&(pid)->tasks[type], pids[type].node) {
+				&(pid)->tasks[type], pid_links[type]) {
 
 			/*
 			 * Both old and new leaders may be attached to
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a461ff89a3af..445bdf5b1f64 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -775,7 +775,8 @@ struct task_struct {
 	struct list_head		ptrace_entry;
 
 	/* PID/PID hash table linkage. */
-	struct pid_link			pids[PIDTYPE_MAX];
+	struct pid			*thread_pid;
+	struct hlist_node		pid_links[PIDTYPE_MAX];
 	struct list_head		thread_group;
 	struct list_head		thread_node;
 
@@ -1199,22 +1200,7 @@ struct task_struct {
 
 static inline struct pid *task_pid(struct task_struct *task)
 {
-	return task->pids[PIDTYPE_PID].pid;
-}
-
-/*
- * Without tasklist or RCU lock it is not safe to dereference
- * the result of task_pgrp/task_session even if task == current,
- * we can race with another thread doing sys_setsid/sys_setpgid.
- */
-static inline struct pid *task_pgrp(struct task_struct *task)
-{
-	return task->group_leader->pids[PIDTYPE_PGID].pid;
-}
-
-static inline struct pid *task_session(struct task_struct *task)
-{
-	return task->group_leader->pids[PIDTYPE_SID].pid;
+	return task->thread_pid;
 }
 
 /*
@@ -1263,7 +1249,7 @@ static inline pid_t task_tgid_nr(struct task_struct *tsk)
  */
 static inline int pid_alive(const struct task_struct *p)
 {
-	return p->pids[PIDTYPE_PID].pid != NULL;
+	return p->thread_pid != NULL;
 }
 
 static inline pid_t task_pgrp_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b95a272c1ab5..2dcded16eb1e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -146,7 +146,9 @@ struct signal_struct {
 
 #endif
 
+	/* PID/PID hash table linkage. */
 	struct pid *leader_pid;
+	struct pid *pids[PIDTYPE_MAX];
 
 #ifdef CONFIG_NO_HZ_FULL
 	atomic_t tick_dep_mask;
@@ -559,9 +561,12 @@ void walk_process_tree(struct task_struct *top, proc_visitor, void *);
 static inline
 struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
 {
-	if (type != PIDTYPE_PID)
-		task = task->group_leader;
-	return task->pids[type].pid;
+	struct pid *pid;
+	if (type == PIDTYPE_PID)
+		pid = task_pid(task);
+	else
+		pid = task->signal->pids[type];
+	return pid;
 }
 
 static inline struct pid *task_tgid(struct task_struct *task)
@@ -569,6 +574,21 @@ static inline struct pid *task_tgid(struct task_struct *task)
 	return task->signal->leader_pid;
 }
 
+/*
+ * Without tasklist or RCU lock it is not safe to dereference
+ * the result of task_pgrp/task_session even if task == current,
+ * we can race with another thread doing sys_setsid/sys_setpgid.
+ */
+static inline struct pid *task_pgrp(struct task_struct *task)
+{
+	return task->signal->pids[PIDTYPE_PGID];
+}
+
+static inline struct pid *task_session(struct task_struct *task)
+{
+	return task->signal->pids[PIDTYPE_SID];
+}
+
 static inline int get_nr_threads(struct task_struct *tsk)
 {
 	return tsk->signal->nr_threads;
diff --git a/init/init_task.c b/init/init_task.c
index 7914ffb8dc73..db12a61259f1 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -34,6 +34,11 @@ static struct signal_struct init_signals = {
 #endif
 	INIT_CPU_TIMERS(init_signals)
 	.leader_pid = &init_struct_pid,
+	.pids = {
+		[PIDTYPE_PID]	= &init_struct_pid,
+		[PIDTYPE_PGID]	= &init_struct_pid,
+		[PIDTYPE_SID]	= &init_struct_pid,
+	},
 	INIT_PREV_CPUTIME(init_signals)
 };
 
@@ -112,11 +117,7 @@ struct task_struct init_task
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
-	.pids = {
-		[PIDTYPE_PID]  = INIT_PID_LINK(PIDTYPE_PID),
-		[PIDTYPE_PGID] = INIT_PID_LINK(PIDTYPE_PGID),
-		[PIDTYPE_SID]  = INIT_PID_LINK(PIDTYPE_SID),
-	},
+	.thread_pid	= &init_struct_pid,
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
 #ifdef CONFIG_AUDITSYSCALL
diff --git a/kernel/fork.c b/kernel/fork.c
index 9440d61b925c..d2952162399b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1549,10 +1549,22 @@ static void posix_cpu_timers_init(struct task_struct *tsk)
 static inline void posix_cpu_timers_init(struct task_struct *tsk) { }
 #endif
 
+static inline void init_task_pid_links(struct task_struct *task)
+{
+	enum pid_type type;
+
+	for (type = PIDTYPE_PID; type < PIDTYPE_MAX; ++type) {
+		INIT_HLIST_NODE(&task->pid_links[type]);
+	}
+}
+
 static inline void
 init_task_pid(struct task_struct *task, enum pid_type type, struct pid *pid)
 {
-	 task->pids[type].pid = pid;
+	if (type == PIDTYPE_PID)
+		task->thread_pid = pid;
+	else
+		task->signal->pids[type] = pid;
 }
 
 static inline void rcu_copy_process(struct task_struct *p)
@@ -1928,6 +1940,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
 
@@ -2036,13 +2049,13 @@ static __latent_entropy struct task_struct *copy_process(
 	return ERR_PTR(retval);
 }
 
-static inline void init_idle_pids(struct pid_link *links)
+static inline void init_idle_pids(struct task_struct *idle)
 {
 	enum pid_type type;
 
 	for (type = PIDTYPE_PID; type < PIDTYPE_MAX; ++type) {
-		INIT_HLIST_NODE(&links[type].node); /* not really needed */
-		links[type].pid = &init_struct_pid;
+		INIT_HLIST_NODE(&idle->pid_links[type]); /* not really needed */
+		init_task_pid(idle, type, &init_struct_pid);
 	}
 }
 
@@ -2052,7 +2065,7 @@ struct task_struct *fork_idle(int cpu)
 	task = copy_process(CLONE_VM, 0, 0, NULL, &init_struct_pid, 0, 0,
 			    cpu_to_node(cpu));
 	if (!IS_ERR(task)) {
-		init_idle_pids(task->pids);
+		init_idle_pids(task);
 		init_idle(task, cpu);
 	}
 
diff --git a/kernel/pid.c b/kernel/pid.c
index d0de2b59f86f..f8486d2e2346 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -265,27 +265,35 @@ struct pid *find_vpid(int nr)
 }
 EXPORT_SYMBOL_GPL(find_vpid);
 
+static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
+{
+	return (type == PIDTYPE_PID) ?
+		&task->thread_pid :
+		(type == __PIDTYPE_TGID) ?
+		&task->signal->leader_pid :
+		&task->signal->pids[type];
+}
+
 /*
  * attach_pid() must be called with the tasklist_lock write-held.
  */
 void attach_pid(struct task_struct *task, enum pid_type type)
 {
-	struct pid_link *link = &task->pids[type];
-	hlist_add_head_rcu(&link->node, &link->pid->tasks[type]);
+	struct pid *pid = *task_pid_ptr(task, type);
+	hlist_add_head_rcu(&task->pid_links[type], &pid->tasks[type]);
 }
 
 static void __change_pid(struct task_struct *task, enum pid_type type,
 			struct pid *new)
 {
-	struct pid_link *link;
+	struct pid **pid_ptr = task_pid_ptr(task, type);
 	struct pid *pid;
 	int tmp;
 
-	link = &task->pids[type];
-	pid = link->pid;
+	pid = *pid_ptr;
 
-	hlist_del_rcu(&link->node);
-	link->pid = new;
+	hlist_del_rcu(&task->pid_links[type]);
+	*pid_ptr = new;
 
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
 		if (!hlist_empty(&pid->tasks[tmp]))
@@ -310,8 +318,9 @@ void change_pid(struct task_struct *task, enum pid_type type,
 void transfer_pid(struct task_struct *old, struct task_struct *new,
 			   enum pid_type type)
 {
-	new->pids[type].pid = old->pids[type].pid;
-	hlist_replace_rcu(&old->pids[type].node, &new->pids[type].node);
+	if (type == PIDTYPE_PID)
+		new->thread_pid = old->thread_pid;
+	hlist_replace_rcu(&old->pid_links[type], &new->pid_links[type]);
 }
 
 struct task_struct *pid_task(struct pid *pid, enum pid_type type)
@@ -322,7 +331,7 @@ struct task_struct *pid_task(struct pid *pid, enum pid_type type)
 		first = rcu_dereference_check(hlist_first_rcu(&pid->tasks[type]),
 					      lockdep_tasklist_lock_is_held());
 		if (first)
-			result = hlist_entry(first, struct task_struct, pids[(type)].node);
+			result = hlist_entry(first, struct task_struct, pid_links[(type)]);
 	}
 	return result;
 }
@@ -360,9 +369,7 @@ struct pid *get_task_pid(struct task_struct *task, enum pid_type type)
 {
 	struct pid *pid;
 	rcu_read_lock();
-	if (type != PIDTYPE_PID)
-		task = task->group_leader;
-	pid = get_pid(rcu_dereference(task->pids[type].pid));
+	pid = get_pid(rcu_dereference(*task_pid_ptr(task, type)));
 	rcu_read_unlock();
 	return pid;
 }
@@ -420,16 +427,8 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
 	rcu_read_lock();
 	if (!ns)
 		ns = task_active_pid_ns(current);
-	if (likely(pid_alive(task))) {
-		struct pid *pid;
-		if (type == PIDTYPE_PID)
-			pid = task_pid(task);
-		else if (type == __PIDTYPE_TGID)
-			pid = task_tgid(task);
-		else
-			pid = rcu_dereference(task->group_leader->pids[type].pid);
-		nr = pid_nr_ns(pid, ns);
-	}
+	if (likely(pid_alive(task)))
+		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
 	rcu_read_unlock();
 
 	return nr;
-- 
2.17.1

