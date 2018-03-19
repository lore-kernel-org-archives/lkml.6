Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970386AbeCSSgJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:36:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S970365AbeCSSgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:36:05 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] sched/debug: adjust newlines for better alignment
Date: Mon, 19 Mar 2018 14:35:55 -0400
Message-Id: <1521484555-8620-3-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
References: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scheduler debug stats include newlines that display out of alignment
when prefixed by timestamps.  For example, the dmesg utility:

  % echo t > /proc/sysrq-trigger
  % dmesg
  ...
  [   83.124251]
  runnable tasks:
   S           task   PID         tree-key  switches  prio     wait-time
  sum-exec        sum-sleep
  -----------------------------------------------------------------------------------------------------------

At the same time, some syslog utilities (like rsyslog by default) don't
like the additional newlines control characters, saving lines like this
to /var/log/messages:

  Mar 16 16:02:29 localhost kernel: #012runnable tasks:#012 S           task   PID         tree-key ...
                                    ^^^^               ^^^^
Clean these up by moving newline characters to their own SEQ_printf
invocation.  This leaves the /proc/sched_debug unchanged, but brings the
entire output into alignment when prefixed:

  % echo t > /proc/sysrq-trigger
  % dmesg
  ...
  [   62.410368] runnable tasks:
  [   62.410368]  S           task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  [   62.410369] -----------------------------------------------------------------------------------------------------------
  [   62.410369]  I  kworker/u12:0     5      1932.215593       332   120         0.000000         3.621252         0.000000 0 0 /

and no escaped control characters from rsyslog in /var/log/messages:

  Mar 16 16:15:06 localhost kernel: runnable tasks:
  Mar 16 16:15:06 localhost kernel: S           task   PID         tree-key  ...

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 kernel/sched/debug.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 50026aa2d81e..72c401b3b15c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -501,12 +501,12 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 {
 	struct task_struct *g, *p;
 
-	SEQ_printf(m,
-	"\nrunnable tasks:\n"
-	" S           task   PID         tree-key  switches  prio"
-	"     wait-time             sum-exec        sum-sleep\n"
-	"-------------------------------------------------------"
-	"----------------------------------------------------\n");
+	SEQ_printf(m, "\n");
+	SEQ_printf(m, "runnable tasks:\n");
+	SEQ_printf(m, " S           task   PID         tree-key  switches  prio"
+		   "     wait-time             sum-exec        sum-sleep\n");
+	SEQ_printf(m, "-------------------------------------------------------"
+		   "----------------------------------------------------\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
@@ -527,9 +527,11 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	unsigned long flags;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	SEQ_printf(m, "\ncfs_rq[%d]:%s\n", cpu, task_group_path(cfs_rq->tg));
+	SEQ_printf(m, "\n");
+	SEQ_printf(m, "cfs_rq[%d]:%s\n", cpu, task_group_path(cfs_rq->tg));
 #else
-	SEQ_printf(m, "\ncfs_rq[%d]:\n", cpu);
+	SEQ_printf(m, "\n");
+	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
 #endif
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
 			SPLIT_NS(cfs_rq->exec_clock));
@@ -595,9 +597,11 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 {
 #ifdef CONFIG_RT_GROUP_SCHED
-	SEQ_printf(m, "\nrt_rq[%d]:%s\n", cpu, task_group_path(rt_rq->tg));
+	SEQ_printf(m, "\n");
+	SEQ_printf(m, "rt_rq[%d]:%s\n", cpu, task_group_path(rt_rq->tg));
 #else
-	SEQ_printf(m, "\nrt_rq[%d]:\n", cpu);
+	SEQ_printf(m, "\n");
+	SEQ_printf(m, "rt_rq[%d]:\n", cpu);
 #endif
 
 #define P(x) \
@@ -624,7 +628,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 {
 	struct dl_bw *dl_bw;
 
-	SEQ_printf(m, "\ndl_rq[%d]:\n", cpu);
+	SEQ_printf(m, "\n");
+	SEQ_printf(m, "dl_rq[%d]:\n", cpu);
 
 #define PU(x) \
 	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
-- 
1.8.3.1
