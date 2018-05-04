Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeEDPlQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:41:16 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:53529 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751308AbeEDPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:41:15 -0400
Date: Fri, 4 May 2018 16:41:09 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] sched/numa: Stagger NUMA balancing scan periods for new
 threads v2
Message-ID: <20180504154109.mvrha2qo5wdl65vr@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Cosmetic changes and documentation (ingo)
o Note results were very similar to v1 and so I didn't update the changelog

Threads share an address space and each can change the protections of the
same address space to trap NUMA faults. This is redundant and potentially
counter-productive as any thread doing the update will suffice. Potentially
only one thread is required but that thread may be idle or it may not have
any locality concerns and pick an unsuitable scan rate.

This patch uses independent scan period but they are staggered based on
the number of address space users when the thread is created.  The intent
is that threads will avoid scanning at the same time and have a chance
to adapt their scan rate later if necessary. This reduces the total scan
activity early in the lifetime of the threads.

The different in headline performance across a range of machines and
workloads is marginal but the system CPU usage is reduced as well as overall
scan activity.  The following is the time reported by NAS Parallel Benchmark
using unbound openmp threads and a D size class.

                      4.17.0-rc1             4.17.0-rc1
                         vanilla           stagger-v1r1
Time bt.D      442.77 (   0.00%)      419.70 (   5.21%)
Time cg.D      171.90 (   0.00%)      180.85 (  -5.21%)
Time ep.D       33.10 (   0.00%)       32.90 (   0.60%)
Time is.D        9.59 (   0.00%)        9.42 (   1.77%)
Time lu.D      306.75 (   0.00%)      304.65 (   0.68%)
Time mg.D       54.56 (   0.00%)       52.38 (   4.00%)
Time sp.D     1020.03 (   0.00%)      903.77 (  11.40%)
Time ua.D      400.58 (   0.00%)      386.49 (   3.52%)

Note it's not a universal win but we have no prior knowledge of which
thread matters but the number of threads created often exceeds the size
of the node when the threads are not bound. However, there is a reducation
of overall system CPU usage

                            4.17.0-rc1             4.17.0-rc1
                               vanilla           stagger-v1r1
sys-time-bt.D         48.78 (   0.00%)       48.22 (   1.15%)
sys-time-cg.D         25.31 (   0.00%)       26.63 (  -5.22%)
sys-time-ep.D          1.65 (   0.00%)        0.62 (  62.42%)
sys-time-is.D         40.05 (   0.00%)       24.45 (  38.95%)
sys-time-lu.D         37.55 (   0.00%)       29.02 (  22.72%)
sys-time-mg.D         47.52 (   0.00%)       34.92 (  26.52%)
sys-time-sp.D        119.01 (   0.00%)      109.05 (   8.37%)
sys-time-ua.D         51.52 (   0.00%)       45.13 (  12.40%)

NUMA scan activity is also reduced

NUMA alloc local               1042828     1342670
NUMA base PTE updates        140481138    93577468
NUMA huge PMD updates           272171      180766
NUMA page range updates      279832690   186129660
NUMA hint faults               1395972     1193897
NUMA hint local faults          877925      855053
NUMA hint local percent             62          71
NUMA pages migrated           12057909     9158023

Similar observations are made for other thread-intensive workloads. System
CPU usage is lower even though the headline gains in performance tend to be
small. For example, specjbb 2005 shows almost no difference in performance
but scan activity is reduced by a third on a 4-socket box. I didn't find
a workload (thread intensive or otherwise) that suffered badly.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c  | 22 +---------------------
 kernel/sched/fair.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..9f47d6c3e386 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2174,27 +2174,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	INIT_HLIST_HEAD(&p->preempt_notifiers);
 #endif
 
-#ifdef CONFIG_NUMA_BALANCING
-	if (p->mm && atomic_read(&p->mm->mm_users) == 1) {
-		p->mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
-		p->mm->numa_scan_seq = 0;
-	}
-
-	if (clone_flags & CLONE_VM)
-		p->numa_preferred_nid = current->numa_preferred_nid;
-	else
-		p->numa_preferred_nid = -1;
-
-	p->node_stamp = 0ULL;
-	p->numa_scan_seq = p->mm ? p->mm->numa_scan_seq : 0;
-	p->numa_scan_period = sysctl_numa_balancing_scan_delay;
-	p->numa_work.next = &p->numa_work;
-	p->numa_faults = NULL;
-	p->last_task_numa_placement = 0;
-	p->last_sum_exec_runtime = 0;
-
-	p->numa_group = NULL;
-#endif /* CONFIG_NUMA_BALANCING */
+	init_numa_balancing(clone_flags, p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..a009c4b4f3a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1139,6 +1139,47 @@ static unsigned int task_scan_max(struct task_struct *p)
 	return max(smin, smax);
 }
 
+void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
+{
+	int mm_users = 0;
+	struct mm_struct *mm = p->mm;
+
+	if (mm) {
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1) {
+			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
+			mm->numa_scan_seq = 0;
+		}
+	}
+	p->node_stamp			= 0;
+	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
+	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_work.next		= &p->numa_work;
+	p->numa_faults			= NULL;
+	p->numa_group			= NULL;
+	p->last_task_numa_placement	= 0;
+	p->last_sum_exec_runtime	= 0;
+
+	/* New address space, reset the preferred nid */
+	if (!(clone_flags & CLONE_VM)) {
+		p->numa_preferred_nid = -1;
+		return;
+	}
+
+	/*
+	 * New thread, keep existing numa_preferred_nid which should be copied
+	 * already by arch_dup_task_struct but stagger when scans start.
+	 */
+	if (mm) {
+		unsigned int delay;
+
+		delay = min_t(unsigned int, task_scan_max(current),
+			current->numa_scan_period * mm_users * NSEC_PER_MSEC);
+		delay += 2 * TICK_NSEC;
+		p->node_stamp = delay;
+	}
+}
+
 static void account_numa_enqueue(struct rq *rq, struct task_struct *p)
 {
 	rq->nr_numa_running += (p->numa_preferred_nid != -1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..c9895d35c5f7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1069,6 +1069,12 @@ enum numa_faults_stats {
 extern void sched_setnuma(struct task_struct *p, int node);
 extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *, struct task_struct *);
+extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
+#else
+static inline void
+init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
+{
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SMP
