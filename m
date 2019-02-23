Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B983C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D459320661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957345;
	bh=lybZ9p3wiMEm6+nxbuV0Ou2b2swlf11t6ZgwB8dKBXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2utE1/PauGoWZwIozthicS0aU1CotPYrP0/kA6eXWGDesmugPNwcTars6crwMb2hG
	 KxXIVHY+fEl1vTXGxT0c27pCruewNJnoorjqDbmmu/9pSKnj+W2zkZGf+3xdKSiQU1
	 eINKnH7jTAyv7yMoPpWTe7GQE/zClL6R9g2P92RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfBWVGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfBWVGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C215E2085B;
        Sat, 23 Feb 2019 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955993;
        bh=lybZ9p3wiMEm6+nxbuV0Ou2b2swlf11t6ZgwB8dKBXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwnvj42ilbqdEpxBVeXiGV1j7TMLtzuhslNuRE5uXAJssMXPKXx2EsMUBfYTuMzBg
         gqpML1EzVxcKf4pUmhei7XGmTR7Zqv0SYK3FSpTiBfhGs+hDxy2EBITF4Jj5lSMx2E
         Bwnv3EPjaU3IZOzy7eAZjd/jKpniTRhdZ1iWe/E8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 68/72] psi: fix aggregation idle shut-off
Date:   Sat, 23 Feb 2019 16:04:18 -0500
Message-Id: <20190223210422.199966-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit 1b69ac6b40ebd85eed73e4dbccde2a36961ab990 ]

psi has provisions to shut off the periodic aggregation worker when
there is a period of no task activity - and thus no data that needs
aggregating.  However, while developing psi monitoring, Suren noticed
that the aggregation clock currently won't stay shut off for good.

Debugging this revealed a flaw in the idle design: an aggregation run
will see no task activity and decide to go to sleep; shortly thereafter,
the kworker thread that executed the aggregation will go idle and cause
a scheduling change, during which the psi callback will kick the
!pending worker again.  This will ping-pong forever, and is equivalent
to having no shut-off logic at all (but with more code!)

Fix this by exempting aggregation workers from psi's clock waking logic
when the state change is them going to sleep.  To do this, tag workers
with the last work function they executed, and if in psi we see a worker
going to sleep after aggregating psi data, we will not reschedule the
aggregation work item.

What if the worker is also executing other items before or after?

Any psi state times that were incurred by work items preceding the
aggregation work will have been collected from the per-cpu buckets
during the aggregation itself.  If there are work items following the
aggregation work, the worker's last_func tag will be overwritten and the
aggregator will be kept alive to process this genuine new activity.

If the aggregation work is the last thing the worker does, and we decide
to go idle, the brief period of non-idle time incurred between the
aggregation run and the kworker's dequeue will be stranded in the
per-cpu buckets until the clock is woken by later activity.  But that
should not be a problem.  The buckets can hold 4s worth of time, and
future activity will wake the clock with a 2s delay, giving us 2s worth
of data we can leave behind when disabling aggregation.  If it takes a
worker more than two seconds to go idle after it finishes its last work
item, we likely have bigger problems in the system, and won't notice one
sample that was averaged with a bogus per-CPU weight.

Link: http://lkml.kernel.org/r/20190116193501.1910-1-hannes@cmpxchg.org
Fixes: eb414681d5a0 ("psi: pressure stall information for CPU, memory, and IO")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/psi.c          | 21 +++++++++++++++++----
 kernel/workqueue.c          | 23 +++++++++++++++++++++++
 kernel/workqueue_internal.h |  6 +++++-
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fe24de3fbc938..c3484785b1795 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -124,6 +124,7 @@
  * sampling of the aggregate task states would be.
  */
 
+#include "../workqueue_internal.h"
 #include <linux/sched/loadavg.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
@@ -480,9 +481,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 			groupc->tasks[t]++;
 
 	write_seqcount_end(&groupc->seq);
-
-	if (!delayed_work_pending(&group->clock_work))
-		schedule_delayed_work(&group->clock_work, PSI_FREQ);
 }
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
@@ -513,6 +511,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
+	bool wake_clock = true;
 	void *iter = NULL;
 
 	if (!task->pid)
@@ -530,8 +529,22 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	task->psi_flags &= ~clear;
 	task->psi_flags |= set;
 
-	while ((group = iterate_groups(task, &iter)))
+	/*
+	 * Periodic aggregation shuts off if there is a period of no
+	 * task changes, so we wake it back up if necessary. However,
+	 * don't do this if the task change is the aggregation worker
+	 * itself going to sleep, or we'll ping-pong forever.
+	 */
+	if (unlikely((clear & TSK_RUNNING) &&
+		     (task->flags & PF_WQ_WORKER) &&
+		     wq_worker_last_func(task) == psi_update_work))
+		wake_clock = false;
+
+	while ((group = iterate_groups(task, &iter))) {
 		psi_group_change(group, cpu, clear, set);
+		if (wake_clock && !delayed_work_pending(&group->clock_work))
+			schedule_delayed_work(&group->clock_work, PSI_FREQ);
+	}
 }
 
 void psi_memstall_tick(struct task_struct *task, int cpu)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0280deac392e2..288b2105bbb1a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -909,6 +909,26 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
 	return to_wakeup ? to_wakeup->task : NULL;
 }
 
+/**
+ * wq_worker_last_func - retrieve worker's last work function
+ *
+ * Determine the last function a worker executed. This is called from
+ * the scheduler to get a worker's last known identity.
+ *
+ * CONTEXT:
+ * spin_lock_irq(rq->lock)
+ *
+ * Return:
+ * The last work function %current executed as a worker, NULL if it
+ * hasn't executed any work yet.
+ */
+work_func_t wq_worker_last_func(struct task_struct *task)
+{
+	struct worker *worker = kthread_data(task);
+
+	return worker->last_func;
+}
+
 /**
  * worker_set_flags - set worker flags and adjust nr_running accordingly
  * @worker: self
@@ -2184,6 +2204,9 @@ __acquires(&pool->lock)
 	if (unlikely(cpu_intensive))
 		worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
 
+	/* tag the worker for identification in schedule() */
+	worker->last_func = worker->current_func;
+
 	/* we're done with it, release */
 	hash_del(&worker->hentry);
 	worker->current_work = NULL;
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 66fbb5a9e633b..cb68b03ca89aa 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -53,6 +53,9 @@ struct worker {
 
 	/* used only by rescuers to point to the target workqueue */
 	struct workqueue_struct	*rescue_wq;	/* I: the workqueue to rescue */
+
+	/* used by the scheduler to determine a worker's last known identity */
+	work_func_t		last_func;
 };
 
 /**
@@ -67,9 +70,10 @@ static inline struct worker *current_wq_worker(void)
 
 /*
  * Scheduler hooks for concurrency managed workqueue.  Only to be used from
- * sched/core.c and workqueue.c.
+ * sched/ and workqueue.c.
  */
 void wq_worker_waking_up(struct task_struct *task, int cpu);
 struct task_struct *wq_worker_sleeping(struct task_struct *task);
+work_func_t wq_worker_last_func(struct task_struct *task);
 
 #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
-- 
2.19.1

