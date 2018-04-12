Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeDLMnI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:43:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43230 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752017AbeDLMnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:43:06 -0400
From: Li Bin <huawei.libin@huawei.com>
To: <peterz@infradead.org>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH v2 1/2] sched/rt.c: pick and check task if double_lock_balance() unlock the rq
Date: Thu, 12 Apr 2018 20:33:03 +0800
Message-ID: <1523536384-26781-2-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1523536384-26781-1-git-send-email-huawei.libin@huawei.com>
References: <1523536384-26781-1-git-send-email-huawei.libin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou Chengming <zhouchengming1@huawei.com>

push_rt_task() pick the first pushable task and find an eligible
lowest_rq, then double_lock_balance(rq, lowest_rq). So if
double_lock_balance() unlock the rq (when double_lock_balance() return 1),
we have to check if this task is still on the rq.

The problem is that the check conditions are not sufficient:

if (unlikely(task_rq(task) != rq ||
	     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
	     task_running(rq, task) ||
	     !rt_task(task) ||
	     !task_on_rq_queued(task))) {

cpu2				cpu1			cpu0
push_rt_task(rq1)
  pick task_A on rq1
  find rq0
    double_lock_balance(rq1, rq0)
      unlock(rq1)
				rq1 __schedule
				  pick task_A run
				task_A sleep (dequeued)
      lock(rq0)
      lock(rq1)
    do_above_check(task_A)
      task_rq(task_A) == rq1
      cpus_allowed unchanged
      task_running == false
      rt_task(task_A) == true
							try_to_wake_up(task_A)
							  select_cpu = cpu3
							  enqueue(rq3, task_A)
							  task_A->on_rq = 1
      task_on_rq_queued(task_A)
    above_check passed, return rq0
    ...
    migrate task_A from rq1 to rq0

So we can't rely on these checks of task_A to make sure the task_A is
still on the rq1, even though we hold the rq1->lock. This patch will
repick the first pushable task to be sure the task is still on the rq.

Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
Signed-off-by: Li Bin <huawei.libin@huawei.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/rt.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aad49451..ff3bfce 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1695,6 +1695,26 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->rt.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	BUG_ON(rq->cpu != task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(p->nr_cpus_allowed <= 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!rt_task(p));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1722,17 +1742,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		/* if the prio of this runqueue changed, try again */
 		if (double_lock_balance(rq, lowest_rq)) {
+			struct task_struct *next_task;
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
-			 * Also make sure that it wasn't scheduled on its rq.
 			 */
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
-				     task_running(rq, task) ||
-				     !rt_task(task) ||
-				     !task_on_rq_queued(task))) {
+			next_task = pick_next_pushable_task(rq);
+			if (unlikely(next_task != task ||
+				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1752,26 +1770,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 	return lowest_rq;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p = plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
-- 
1.7.12.4
