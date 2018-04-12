Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeDLLJF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:09:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48263 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752793AbeDLLJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:09:02 -0400
From: Li Bin <huawei.libin@huawei.com>
To: <peterz@infradead.org>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH 2/2] sched/deadline.c: pick and check task if double_lock_balance() unlock the rq
Date: Thu, 12 Apr 2018 18:58:55 +0800
Message-ID: <1523530735-20011-3-git-send-email-huawei.libin@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
References: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

push_dl_task() pick the first pushable task and find an eligible
later_rq, then double_lock_balance(rq, lowest_rq). So if
double_lock_balance() unlock the rq (when double_lock_balance() return
1), we have to check if this task is still on the rq.

The problem is that the check conditions are not sufficient:

if (unlikely(task_rq(task) != rq ||
             !cpumask_test_cpu(later_rq->cpu, &task->cpus_allowed) ||
             task_running(rq, task) ||
             !dl_task(task) ||
             !task_on_rq_queued(task))) {

cpu2                                cpu1                    cpu0
push_dl_task(rq1)
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
      dl_task(task_A) == true
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

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 kernel/sched/deadline.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9df0978..87cd7ca 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1936,6 +1936,26 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p = rb_entry(rq->dl.pushable_dl_tasks_root.rb_leftmost,
+		     struct task_struct, pushable_dl_tasks);
+
+	BUG_ON(rq->cpu != task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(p->nr_cpus_allowed <= 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1965,11 +1985,9 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_allowed) ||
-				     task_running(rq, task) ||
-				     !dl_task(task) ||
-				     !task_on_rq_queued(task))) {
+			struct task_struct *next_task = pick_next_pushable_dl_task(rq);
+			if (unlikely(next_task != task ||
+						!cpumask_test_cpu(later_rq->cpu, &task->cpus_allowed))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -1994,26 +2012,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = rb_entry(rq->dl.pushable_dl_tasks_root.rb_leftmost,
-		     struct task_struct, pushable_dl_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt
-- 
1.7.12.4
