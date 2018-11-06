Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9B22083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lagq/+jI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9B22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbeKFWWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:22:19 -0500
Received: from aer-iport-2.cisco.com ([173.38.203.52]:51335 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbeKFWWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:22:18 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 17:22:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8173; q=dns/txt; s=iport;
  t=1541509032; x=1542718632;
  h=from:to:cc:subject:date:message-id;
  bh=zsD2yVsiJuYM+C34wqZc8428L/BrEs3L/909XVS0Dx8=;
  b=lagq/+jI9PHbMSE1xXnGie1PeMEEJyY9Sd+FyMk8Lv11Ru5U/tdTPXn8
   UOCjHbft+fqn/LbKdtAjiMT5Ln4Wx6+X+Eu4CyyuwIIam8XAIzSoIlKsj
   1owZC739MCX/n/6HH2eZt1EeFTcMtu3ZPKgnzoKaKw+keRGhlBVKfIOOl
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AyAAAkjOFb/xbLJq1lHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgVqBD3ASJ4wOX58XhV+Beg0jhEmDfDQNDQEDAQECAQECbRw?=
 =?us-ascii?q?MhWhSMIEOE4MhAYIBD6h+M4QtAYYEh06EP4FBP4ERgmSLBwKJB5YvCYZvgTq?=
 =?us-ascii?q?BaoMcg1gLGIFWIiqOPgGJRmqCXIo+gUM4gVUzGggbFYMnCQqCFBd+AQeHV4U?=
 =?us-ascii?q?/PgMwAQGOLQEB?=
X-IronPort-AV: E=Sophos;i="5.54,471,1534809600"; 
   d="scan'208";a="7843264"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 12:47:24 +0000
Received: from clotho.rd.cisco.com. ([10.47.77.53])
        by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id wA6ClNZX007769;
        Tue, 6 Nov 2018 12:47:23 GMT
From:   Henrik Austad <haustad@cisco.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     stable@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, mathieu.desnoyers@efficios.com,
        jdesfossez@efficios.com, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] backport: sched/rtmutex/deadline: Fix a PI crash for deadline tasks
Date:   Tue,  6 Nov 2018 13:47:21 +0100
Message-Id: <20181106124721.7516-1-haustad@cisco.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-SMTP-Client: 10.47.77.53, [10.47.77.53]
X-Outbound-Node: aer-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xunlei Pang <xlpang@redhat.com>

On some of our systems, we notice this error popping up on occasion,
completely hanging the system.

   [<ffffffc0000ee398>] enqueue_task_dl+0x1f0/0x420
   [<ffffffc0000d0f14>] activate_task+0x7c/0x90
   [<ffffffc0000edbdc>] push_dl_task+0x164/0x1c8
   [<ffffffc0000edc60>] push_dl_tasks+0x20/0x30
   [<ffffffc0000cc00c>] __balance_callback+0x44/0x68
   [<ffffffc000d2c018>] __schedule+0x6f0/0x728
   [<ffffffc000d2c278>] schedule+0x78/0x98
   [<ffffffc000d2e76c>] __rt_mutex_slowlock+0x9c/0x108
   [<ffffffc000d2e9d0>] rt_mutex_slowlock+0xd8/0x198
   [<ffffffc0000f7f28>] rt_mutex_timed_futex_lock+0x30/0x40
   [<ffffffc00012c1a8>] futex_lock_pi+0x200/0x3b0
   [<ffffffc00012cf84>] do_futex+0x1c4/0x550

It runs an 4.4 kernel on an arm64 rig. The signature looks suspciously
similar to what Xuneli Pang observed in his crash, and with this fix, my
issue goes away (my system has survivied approx 1500 reboots and a few
nasty tests so far)

Alongside this patch in the tree, there are a few other bits and pieces
pertaining to futex, rtmutex and kernel/sched/, but those patches
creates
weird crashes that I have not been able to dissect yet. Once (if) I have
been able to figure those out (and test), they will be sent later.

I am sure other users of LTS that also use sched_deadline will run into
this issue, so I think it is a good candidate for 4.4-stable. Possibly
also
to 4.9 and 4.14, but I have not had time to test for those versions.

Apart from a minor conflict in sched.h, the patch applied cleanly.

(Tested on arm64 running 4.4.<late-ish>)

-Henrik

A crash happened while I was playing with deadline PI rtmutex.

    BUG: unable to handle kernel NULL pointer dereference at
0000000000000018
    IP: [<ffffffff810eeb8f>] rt_mutex_get_top_task+0x1f/0x30
    PGD 232a75067 PUD 230947067 PMD 0
    Oops: 0000 [#1] SMP
    CPU: 1 PID: 10994 Comm: a.out Not tainted

    Call Trace:
    [<ffffffff810b658c>] enqueue_task+0x2c/0x80
    [<ffffffff810ba763>] activate_task+0x23/0x30
    [<ffffffff810d0ab5>] pull_dl_task+0x1d5/0x260
    [<ffffffff810d0be6>] pre_schedule_dl+0x16/0x20
    [<ffffffff8164e783>] __schedule+0xd3/0x900
    [<ffffffff8164efd9>] schedule+0x29/0x70
    [<ffffffff8165035b>] __rt_mutex_slowlock+0x4b/0xc0
    [<ffffffff81650501>] rt_mutex_slowlock+0xd1/0x190
    [<ffffffff810eeb33>] rt_mutex_timed_lock+0x53/0x60
    [<ffffffff810ecbfc>] futex_lock_pi.isra.18+0x28c/0x390
    [<ffffffff810ed8b0>] do_futex+0x190/0x5b0
    [<ffffffff810edd50>] SyS_futex+0x80/0x180

This is because rt_mutex_enqueue_pi() and rt_mutex_dequeue_pi()
are only protected by pi_lock when operating pi waiters, while
rt_mutex_get_top_task(), will access them with rq lock held but
not holding pi_lock.

In order to tackle it, we introduce new "pi_top_task" pointer
cached in task_struct, and add new rt_mutex_update_top_task()
to update its value, it can be called by rt_mutex_setprio()
which held both owner's pi_lock and rq lock. Thus "pi_top_task"
can be safely accessed by enqueue_task_dl() under rq lock.

Originally-From: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170323150216.157682758@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

(cherry picked from commit e96a7705e7d3fef96aec9b590c63b2f6f7d2ba22)

Conflicts:
	include/linux/sched.h

Backported-and-tested-by: Henrik Austad <haustad@cisco.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/init_task.h |  1 +
 include/linux/sched.h     |  2 ++
 include/linux/sched/rt.h  |  1 +
 kernel/fork.c             |  1 +
 kernel/locking/rtmutex.c  | 29 +++++++++++++++++++++--------
 kernel/sched/core.c       |  2 ++
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 1c1ff7e4faa4..a561ce0c5d7f 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -162,6 +162,7 @@ extern struct task_group root_task_group;
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters = RB_ROOT,						\
+	.pi_top_task = NULL,						\
 	.pi_waiters_leftmost = NULL,
 #else
 # define INIT_RT_MUTEXES(tsk)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a464ba71a993..19a3f946caf0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1628,6 +1628,8 @@ struct task_struct {
 	/* PI waiters blocked on a rt_mutex held by this task */
 	struct rb_root pi_waiters;
 	struct rb_node *pi_waiters_leftmost;
+	/* Updated under owner's pi_lock and rq lock */
+	struct task_struct		*pi_top_task;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
 #endif
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a30b172df6e1..60d0c4740b9f 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -19,6 +19,7 @@ static inline int rt_task(struct task_struct *p)
 extern int rt_mutex_getprio(struct task_struct *p);
 extern void rt_mutex_setprio(struct task_struct *p, int prio);
 extern int rt_mutex_get_effective_prio(struct task_struct *task, int newprio);
+extern void rt_mutex_update_top_task(struct task_struct *p);
 extern struct task_struct *rt_mutex_get_top_task(struct task_struct *task);
 extern void rt_mutex_adjust_pi(struct task_struct *p);
 static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
diff --git a/kernel/fork.c b/kernel/fork.c
index ac00f14208b7..1e5d15defe25 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1240,6 +1240,7 @@ static void rt_mutex_init_task(struct task_struct *p)
 #ifdef CONFIG_RT_MUTEXES
 	p->pi_waiters = RB_ROOT;
 	p->pi_waiters_leftmost = NULL;
+	p->pi_top_task = NULL;
 	p->pi_blocked_on = NULL;
 #endif
 }
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b066724d7a5b..8ddce9fb6724 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -319,6 +319,19 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 }
 
 /*
+ * Must hold both p->pi_lock and task_rq(p)->lock.
+ */
+void rt_mutex_update_top_task(struct task_struct *p)
+{
+	if (!task_has_pi_waiters(p)) {
+		p->pi_top_task = NULL;
+		return;
+	}
+
+	p->pi_top_task = task_top_pi_waiter(p)->task;
+}
+
+/*
  * Calculate task priority from the waiter tree priority
  *
  * Return task->normal_prio when the waiter tree is empty or when
@@ -333,12 +346,12 @@ int rt_mutex_getprio(struct task_struct *task)
 		   task->normal_prio);
 }
 
+/*
+ * Must hold either p->pi_lock or task_rq(p)->lock.
+ */
 struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
 {
-	if (likely(!task_has_pi_waiters(task)))
-		return NULL;
-
-	return task_top_pi_waiter(task)->task;
+	return task->pi_top_task;
 }
 
 /*
@@ -347,12 +360,12 @@ struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
  */
 int rt_mutex_get_effective_prio(struct task_struct *task, int newprio)
 {
-	if (!task_has_pi_waiters(task))
+	struct task_struct *top_task = rt_mutex_get_top_task(task);
+
+	if (!top_task)
 		return newprio;
 
-	if (task_top_pi_waiter(task)->task->prio <= newprio)
-		return task_top_pi_waiter(task)->task->prio;
-	return newprio;
+	return min(top_task->prio, newprio);
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d1511ad3753..4e23579cc38f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3428,6 +3428,8 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
 		goto out_unlock;
 	}
 
+	rt_mutex_update_top_task(p);
+
 	trace_sched_pi_setprio(p, prio);
 	oldprio = p->prio;
 	prev_class = p->sched_class;
-- 
2.11.0

