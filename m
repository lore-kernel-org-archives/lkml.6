Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48479C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDCA20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDCA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJBQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:47:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJBQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:47:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A4A0T1915180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:04:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A4AF61915177;
        Tue, 2 Oct 2018 03:04:10 -0700
Date:   Tue, 2 Oct 2018 03:04:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-3f9672baaa70fc62765857f13f007feb01f9ad33@git.kernel.org>
Cc:     riel@surriel.com, hpa@zytor.com, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, efault@gmx.de,
        srikar@linux.vnet.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, jhladky@redhat.com,
        torvalds@linux-foundation.org
Reply-To: jhladky@redhat.com, tglx@linutronix.de, peterz@infradead.org,
          torvalds@linux-foundation.org, efault@gmx.de,
          srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, mgorman@techsingularity.net, riel@surriel.com,
          hpa@zytor.com
In-Reply-To: <1537552141-27815-4-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-4-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Reset scan rate whenever task moves
 across nodes
Git-Commit-ID: 3f9672baaa70fc62765857f13f007feb01f9ad33
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

Commit-ID:  3f9672baaa70fc62765857f13f007feb01f9ad33
Gitweb:     https://git.kernel.org/tip/3f9672baaa70fc62765857f13f007feb01f9ad33
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 21 Sep 2018 23:18:58 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:42:23 +0200

sched/numa: Reset scan rate whenever task moves across nodes

Currently task scan rate is reset when NUMA balancer migrates the task
to a different node. If NUMA balancer initiates a swap, reset is only
applicable to the task that initiates the swap. Similarly no scan rate
reset is done if the task is migrated across nodes by traditional load
balancer.

Instead move the scan reset to the migrate_task_rq. This ensures the
task moved out of its preferred node, either gets back to its preferred
node quickly or finds a new preferred node. Doing so, would be fair to
all tasks migrating across nodes.

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     200668  203370   1.3465
1     321791  328431   2.06345

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev    Current  %Change
1     204848  206070   0.59654

2 Socket - 2  Node Power9 - PowerNV
JVMS  Prev    Current  %Change
4     188098  188386   0.153112
1     200351  201566   0.606436

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     58145.9  59157.4  1.73959
1     103798   105495   1.63491

Some events stats before and after applying the patch.

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        13,912,183      13,825,492
migrations                1,155,931       1,152,509
faults                    367,139         371,948
cache-misses              54,240,196,814  55,654,206,041
sched:sched_move_numa     1,571           1,856
sched:sched_stick_numa    9               4
sched:sched_swap_numa     463             428
migrate:mm_migrate_pages  703             898

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        50155   57146
numa_hint_faults_local  45264   51612
numa_hit                239652  238164
numa_huge_pte_updates   36      16
numa_interleave         68      63
numa_local              239576  238085
numa_other              76      79
numa_pages_migrated     680     883
numa_pte_updates        71146   67540

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        3,156,720       3,288,525
migrations                30,354          38,652
faults                    97,261          111,678
cache-misses              12,400,026,826  12,111,197,376
sched:sched_move_numa     4               900
sched:sched_stick_numa    0               0
sched:sched_swap_numa     1               5
migrate:mm_migrate_pages  20              714

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        272     18572
numa_hint_faults_local  186     14850
numa_hit                71362   73197
numa_huge_pte_updates   0       11
numa_interleave         23      25
numa_local              71299   73138
numa_other              63      59
numa_pages_migrated     2       712
numa_pte_updates        0       24021

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before       After
cs                        8,606,824    8,451,543
migrations                155,352      202,804
faults                    301,409      310,024
cache-misses              157,759,224  253,522,507
sched:sched_move_numa     168          213
sched:sched_stick_numa    0            0
sched:sched_swap_numa     3            2
migrate:mm_migrate_pages  125          88

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        4650    11830
numa_hint_faults_local  3946    11301
numa_hit                90489   90038
numa_huge_pte_updates   0       0
numa_interleave         892     855
numa_local              90034   89796
numa_other              455     242
numa_pages_migrated     124     88
numa_pte_updates        4818    12039

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before     After
cs                        2,113,167  2,049,153
migrations                10,533     11,405
faults                    142,727    162,309
cache-misses              5,594,192  7,203,343
sched:sched_move_numa     10         22
sched:sched_stick_numa    0          0
sched:sched_swap_numa     0          0
migrate:mm_migrate_pages  6          1

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        744     1693
numa_hint_faults_local  584     1669
numa_hit                25551   25177
numa_huge_pte_updates   0       0
numa_interleave         263     194
numa_local              25302   24993
numa_other              249     184
numa_pages_migrated     6       1
numa_pte_updates        744     1577

perf stats 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before           After
cs                        101,227,352      94,515,937
migrations                4,151,829        4,203,554
faults                    745,233          832,697
cache-misses              224,669,561,766  226,248,698,331
sched:sched_move_numa     617              1,730
sched:sched_stick_numa    2                14
sched:sched_swap_numa     187              432
migrate:mm_migrate_pages  316              1,398

vmstat 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        24195   80079
numa_hint_faults_local  21639   68620
numa_hit                238331  241187
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              238331  241186
numa_other              0       1
numa_pages_migrated     204     1347
numa_pte_updates        24561   80729

perf stats 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before          After
cs                        62,738,978      63,704,961
migrations                562,702         573,404
faults                    228,465         230,878
cache-misses              75,778,067,952  76,568,222,781
sched:sched_move_numa     648             509
sched:sched_stick_numa    13              31
sched:sched_swap_numa     137             182
migrate:mm_migrate_pages  733             541

vmstat 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        10281   8501
numa_hint_faults_local  3242    2960
numa_hit                36338   35526
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              36338   35526
numa_other              0       0
numa_pages_migrated     706     539
numa_pte_updates        10176   8433

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537552141-27815-4-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc768156239f..5cbfb3068bc6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1824,12 +1824,6 @@ static int task_numa_migrate(struct task_struct *p)
 	if (env.best_cpu == -1)
 		return -EAGAIN;
 
-	/*
-	 * Reset the scan period if the task is being rescheduled on an
-	 * alternative node to recheck if the tasks is now properly placed.
-	 */
-	p->numa_scan_period = task_scan_start(p);
-
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
 		ret = migrate_task_to(p, env.best_cpu);
@@ -2618,6 +2612,18 @@ void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	}
 }
 
+static void update_scan_period(struct task_struct *p, int new_cpu)
+{
+	int src_nid = cpu_to_node(task_cpu(p));
+	int dst_nid = cpu_to_node(new_cpu);
+
+	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
+		return;
+
+	if (src_nid != dst_nid)
+		p->numa_scan_period = task_scan_start(p);
+}
+
 #else
 static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
@@ -2631,6 +2637,10 @@ static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
 {
 }
 
+static inline void update_scan_period(struct task_struct *p, int new_cpu)
+{
+}
+
 #endif /* CONFIG_NUMA_BALANCING */
 
 static void
@@ -6297,7 +6307,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  * cfs_rq_of(p) references at time of call are still valid and identify the
  * previous CPU. The caller guarantees p->pi_lock or task_rq(p)->lock is held.
  */
-static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unused)
+static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
@@ -6350,6 +6360,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 
 	/* We have migrated, no longer consider this task hot */
 	p->se.exec_start = 0;
+
+	update_scan_period(p, new_cpu);
 }
 
 static void task_dead_fair(struct task_struct *p)
