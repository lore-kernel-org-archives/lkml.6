Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeETIju (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:39:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeETIjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:39:48 -0400
Date: Sun, 20 May 2018 10:39:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805201037090.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

Three trivial fixlets for the scheduler:

 - Move print_rt_rq() and print_dl_rq() declarations to the right place

 - Make grub_reclaim() static

 - Fix the bogus documentation reference in Kconfig

Thanks,

	tglx

------------------>
Mathieu Malaterre (2):
      sched/debug: Move the print_rt_rq() and print_dl_rq() declarations to kernel/sched/sched.h
      sched/deadline: Make the grub_reclaim() function static

Sebastian Andrzej Siewior (1):
      sched/fair: Fix documentation file path


 init/Kconfig            | 2 +-
 kernel/sched/deadline.c | 4 +---
 kernel/sched/rt.c       | 2 --
 kernel/sched/sched.h    | 5 +++--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index f013afc74b11..18b151f0ddc1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -738,7 +738,7 @@ config CFS_BANDWIDTH
 	  tasks running within the fair group scheduler.  Groups with no limit
 	  set are considered to be unconstrained and will run with no
 	  restriction.
-	  See tip/Documentation/scheduler/sched-bwc.txt for more information.
+	  See Documentation/scheduler/sched-bwc.txt for more information.
 
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e7b3008b85bb..1356afd1eeb6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1117,7 +1117,7 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
  * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
  * So, overflow is not an issue here.
  */
-u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
+static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
 	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 	u64 u_act;
@@ -2731,8 +2731,6 @@ bool dl_cpu_busy(unsigned int cpu)
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
-extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
-
 void print_dl_stats(struct seq_file *m, int cpu)
 {
 	print_dl_rq(m, cpu, &cpu_rq(cpu)->dl);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..ef3c4e6f5345 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2701,8 +2701,6 @@ int sched_rr_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_SCHED_DEBUG
-extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
-
 void print_rt_stats(struct seq_file *m, int cpu)
 {
 	rt_rq_iter_t iter;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..1f0a4bc6a39d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2025,8 +2025,9 @@ extern bool sched_debug_enabled;
 extern void print_cfs_stats(struct seq_file *m, int cpu);
 extern void print_rt_stats(struct seq_file *m, int cpu);
 extern void print_dl_stats(struct seq_file *m, int cpu);
-extern void
-print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
+extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
+extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
+extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
