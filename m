Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4363ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8765821557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8765821557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391182AbeIUXjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:39:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391097AbeIUXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:39:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHnIrF176953
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:49:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mn3snm2kj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:49:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 18:49:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 18:49:38 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LHnbpA48824366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 17:49:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98C54AE055;
        Fri, 21 Sep 2018 20:48:42 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19250AE045;
        Fri, 21 Sep 2018 20:48:41 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.199.39.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 20:48:40 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jirka Hladky <jhladky@redhat.com>
Subject: [PATCH v2 3/6] sched/numa: Reset scan rate whenever task moves across nodes
Date:   Fri, 21 Sep 2018 23:18:58 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537552141-27815-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092117-0016-0000-0000-00000208E50A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092117-0017-0000-0000-0000325FEE77
Message-Id: <1537552141-27815-4-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changelog v1->v2:
Rename cpu to CPU
Rename numa to NUMA

 kernel/sched/fair.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc768156..5cbfb30 100644
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
-- 
2.7.4

