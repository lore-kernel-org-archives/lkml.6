Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCYI5X (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 04:57:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54675 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeCYI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 04:57:21 -0400
X-Google-Smtp-Source: AG47ELvC/QJEmqTpewLMOFMhUxR/tQaG/y6EYg3MfpC6hBzNviex5dvFbxoN4IVS6CzQWPS2on474g==
Date: Sun, 25 Mar 2018 10:57:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20180325085717.c5ixdcmeibbsof4l@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e9ca267096674eadd1fd479279bcb58df1486049 sched/debug: Adjust newlines for better alignment

Two sched debug output related fixes: a console output fix and formatting fixes.

 Thanks,

	Ingo

------------------>
Joe Lawrence (2):
      sched/debug: Fix per-task line continuation for console output
      sched/debug: Adjust newlines for better alignment


 kernel/sched/debug.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ca0130ed4f9..72c401b3b15c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -32,7 +32,7 @@ static DEFINE_SPINLOCK(sched_debug_lock);
 	if (m)					\
 		seq_printf(m, x);		\
 	else					\
-		printk(x);			\
+		pr_cont(x);			\
  } while (0)
 
 /*
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
