Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeCTLTd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:19:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeCTLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:19:29 -0400
Date: Tue, 20 Mar 2018 04:19:08 -0700
From: tip-bot for Joe Lawrence <tipbot@zytor.com>
Message-ID: <tip-e9ca267096674eadd1fd479279bcb58df1486049@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        joe.lawrence@redhat.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org, joe.lawrence@redhat.com,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1521484555-8620-3-git-send-email-joe.lawrence@redhat.com>
References: <1521484555-8620-3-git-send-email-joe.lawrence@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/debug: Adjust newlines for better
 alignment
Git-Commit-ID: e9ca267096674eadd1fd479279bcb58df1486049
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e9ca267096674eadd1fd479279bcb58df1486049
Gitweb:     https://git.kernel.org/tip/e9ca267096674eadd1fd479279bcb58df1486049
Author:     Joe Lawrence <joe.lawrence@redhat.com>
AuthorDate: Mon, 19 Mar 2018 14:35:55 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 09:30:09 +0100

sched/debug: Adjust newlines for better alignment

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
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1521484555-8620-3-git-send-email-joe.lawrence@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
