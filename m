Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13EEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5EC20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5EC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJBQqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:46:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37845 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJBQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:46:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A34Ts1913529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:03:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A34FW1913526;
        Tue, 2 Oct 2018 03:03:04 -0700
Date:   Tue, 2 Oct 2018 03:03:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-a4739eca4456e3d140cc656c5331d42b7465f91d@git.kernel.org>
Cc:     jhladky@redhat.com, mingo@kernel.org, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, efault@gmx.de, mgorman@techsingularity.net,
        hpa@zytor.com, riel@surriel.com, peterz@infradead.org
Reply-To: peterz@infradead.org, mgorman@techsingularity.net, hpa@zytor.com,
          riel@surriel.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, efault@gmx.de, tglx@linutronix.de,
          jhladky@redhat.com, mingo@kernel.org, srikar@linux.vnet.ibm.com
In-Reply-To: <1537552141-27815-2-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-2-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Stop multiple tasks from moving to the
 CPU at the same time
Git-Commit-ID: a4739eca4456e3d140cc656c5331d42b7465f91d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a4739eca4456e3d140cc656c5331d42b7465f91d
Gitweb:     https://git.kernel.org/tip/a4739eca4456e3d140cc656c5331d42b7465f91d
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 21 Sep 2018 23:18:56 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:42:20 +0200

sched/numa: Stop multiple tasks from moving to the CPU at the same time

Task migration under NUMA balancing can happen in parallel. More than
one task might choose to migrate to the same CPU at the same time. This
can result in:

- During task swap, choosing a task that was not part of the evaluation.
- During task swap, task which just got moved into its preferred node,
  moving to a completely different node.
- During task swap, task failing to move to the preferred node, will have
  to wait an extra interval for the next migrate opportunity.
- During task movement, multiple task movements can cause load imbalance.

This problem is more likely if there are more cores per node or more
nodes in the system.

Use a per run-queue variable to check if NUMA-balance is active on the
run-queue.

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     200194  203353   1.57797
1     311331  328205   5.41995

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev    Current  %Change
1     197654  214384   8.46429

2 Socket - 2  Node Power9 - PowerNV
JVMS  Prev    Current  %Change
4     192605  188553   -2.10379
1     213402  196273   -8.02664

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     52227.1  57581.2  10.2516
1     102529   103468   0.915838

There is a regression on power 9 box. If we look at the details,
that box has a sudden jump in cache-misses with this patch.
All other parameters seem to be pointing towards NUMA
consolidation.

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        13,345,784      13,941,377
migrations                1,127,820       1,157,323
faults                    374,736         382,175
cache-misses              55,132,054,603  54,993,823,500
sched:sched_move_numa     1,923           2,005
sched:sched_stick_numa    52              14
sched:sched_swap_numa     595             529
migrate:mm_migrate_pages  1,932           1,573

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        60605   67099
numa_hint_faults_local  51804   58456
numa_hit                239945  240416
numa_huge_pte_updates   14      18
numa_interleave         60      65
numa_local              239865  240339
numa_other              80      77
numa_pages_migrated     1931    1574
numa_pte_updates        67823   77182

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        3,016,467       3,176,453
migrations                37,326          30,238
faults                    115,342         87,869
cache-misses              11,692,155,554  12,544,479,391
sched:sched_move_numa     965             23
sched:sched_stick_numa    8               0
sched:sched_swap_numa     35              6
migrate:mm_migrate_pages  1,168           10

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        16286   236
numa_hint_faults_local  11863   201
numa_hit                112482  72293
numa_huge_pte_updates   33      0
numa_interleave         20      26
numa_local              112419  72233
numa_other              63      60
numa_pages_migrated     1144    8
numa_pte_updates        32859   0

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before       After
cs                        8,629,724    8,478,820
migrations                221,052      171,323
faults                    308,661      307,499
cache-misses              135,574,913  240,353,599
sched:sched_move_numa     147          214
sched:sched_stick_numa    0            0
sched:sched_swap_numa     2            4
migrate:mm_migrate_pages  64           89

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        11481   5301
numa_hint_faults_local  10968   4745
numa_hit                89773   92943
numa_huge_pte_updates   0       0
numa_interleave         1116    899
numa_local              89220   92345
numa_other              553     598
numa_pages_migrated     62      88
numa_pte_updates        11694   5505

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before     After
cs                        2,272,887  2,066,172
migrations                12,206     11,076
faults                    163,704    149,544
cache-misses              4,801,186  10,398,067
sched:sched_move_numa     44         43
sched:sched_stick_numa    0          0
sched:sched_swap_numa     0          0
migrate:mm_migrate_pages  17         6

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        2261    3552
numa_hint_faults_local  1993    3347
numa_hit                25726   25611
numa_huge_pte_updates   0       0
numa_interleave         239     213
numa_local              25498   25583
numa_other              228     28
numa_pages_migrated     17      6
numa_pte_updates        2266    3535

perf stats 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before           After
cs                        117,980,962      99,358,136
migrations                3,950,220        4,041,607
faults                    736,979          749,653
cache-misses              224,976,072,879  225,562,543,251
sched:sched_move_numa     504              771
sched:sched_stick_numa    50               14
sched:sched_swap_numa     239              204
migrate:mm_migrate_pages  1,260            1,180

vmstat 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        18293   27409
numa_hint_faults_local  11969   20677
numa_hit                240854  239988
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              240851  239983
numa_other              3       5
numa_pages_migrated     1190    1016
numa_pte_updates        18106   27916

perf stats 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before          After
cs                        61,053,158      60,899,307
migrations                551,586         544,668
faults                    244,174         270,834
cache-misses              74,326,766,973  74,543,455,635
sched:sched_move_numa     344             735
sched:sched_stick_numa    24              25
sched:sched_swap_numa     140             174
migrate:mm_migrate_pages  568             816

vmstat 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        6461    11059
numa_hint_faults_local  2283    4733
numa_hit                35661   41384
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              35661   41383
numa_other              0       1
numa_pages_migrated     568     815
numa_pte_updates        6518    11323

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537552141-27815-2-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 22 ++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f808ddf2a868..3b0b75de1141 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1514,6 +1514,21 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	struct rq *rq = cpu_rq(env->dst_cpu);
+
+	/* Bail out if run-queue part of active NUMA balance. */
+	if (xchg(&rq->numa_migrate_on, 1))
+		return;
+
+	/*
+	 * Clear previous best_cpu/rq numa-migrate flag, since task now
+	 * found a better CPU to move/swap.
+	 */
+	if (env->best_cpu != -1) {
+		rq = cpu_rq(env->best_cpu);
+		WRITE_ONCE(rq->numa_migrate_on, 0);
+	}
+
 	if (env->best_task)
 		put_task_struct(env->best_task);
 	if (p)
@@ -1569,6 +1584,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	long moveimp = imp;
 	int dist = env->dist;
 
+	if (READ_ONCE(dst_rq->numa_migrate_on))
+		return;
+
 	rcu_read_lock();
 	cur = task_rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
@@ -1710,6 +1728,7 @@ static int task_numa_migrate(struct task_struct *p)
 		.best_cpu = -1,
 	};
 	struct sched_domain *sd;
+	struct rq *best_rq;
 	unsigned long taskweight, groupweight;
 	int nid, ret, dist;
 	long taskimp, groupimp;
@@ -1811,14 +1830,17 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	p->numa_scan_period = task_scan_start(p);
 
+	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
 		ret = migrate_task_to(p, env.best_cpu);
+		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
 		return ret;
 	}
 
 	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+	WRITE_ONCE(best_rq->numa_migrate_on, 0);
 
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..0b9161241bda 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -783,6 +783,7 @@ struct rq {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
+	unsigned int		numa_migrate_on;
 #endif
 	#define CPU_LOAD_IDX_MAX 5
 	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
