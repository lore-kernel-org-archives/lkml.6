Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2079C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A977D20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A977D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJBQs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:48:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:48:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A5mcn1915431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:05:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A5mZG1915428;
        Tue, 2 Oct 2018 03:05:48 -0700
Date:   Tue, 2 Oct 2018 03:05:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-6fd98e775f24fd41520928d345f5db3ff52bb35d@git.kernel.org>
Cc:     mingo@kernel.org, riel@surriel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, mgorman@techsingularity.net, hpa@zytor.com,
        srikar@linux.vnet.ibm.com, jhladky@redhat.com, efault@gmx.de
Reply-To: efault@gmx.de, jhladky@redhat.com, srikar@linux.vnet.ibm.com,
          hpa@zytor.com, mgorman@techsingularity.net, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          riel@surriel.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1537552141-27815-7-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-7-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Avoid task migration for small NUMA
 improvement
Git-Commit-ID: 6fd98e775f24fd41520928d345f5db3ff52bb35d
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

Commit-ID:  6fd98e775f24fd41520928d345f5db3ff52bb35d
Gitweb:     https://git.kernel.org/tip/6fd98e775f24fd41520928d345f5db3ff52bb35d
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 21 Sep 2018 23:19:01 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:42:28 +0200

sched/numa: Avoid task migration for small NUMA improvement

If NUMA improvement from the task migration is going to be very
minimal, then avoid task migration.

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     198512  205910   3.72673
1     313559  318491   1.57291

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev     Current  %Change
8     74761.9  74935.9  0.232739
1     214874   226796   5.54837

2 Socket - 2  Node Power9 - PowerNV
JVMS  Prev    Current  %Change
4     180536  189780   5.12031
1     210281  205695   -2.18089

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     56511.4  60370    6.828
1     104899   108100   3.05151

1/7 cases is regressing, if we look at events migrate_pages seem
to vary the most especially in the regressing case. Also some
amount of variance is expected between different runs of
Specjbb2005.

Some events stats before and after applying the patch.

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        13,818,546      13,801,554
migrations                1,149,960       1,151,541
faults                    385,583         433,246
cache-misses              55,259,546,768  55,168,691,835
sched:sched_move_numa     2,257           2,551
sched:sched_stick_numa    9               24
sched:sched_swap_numa     512             904
migrate:mm_migrate_pages  2,225           1,571

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        72692   113682
numa_hint_faults_local  62270   102163
numa_hit                238762  240181
numa_huge_pte_updates   48      36
numa_interleave         75      64
numa_local              238676  240103
numa_other              86      78
numa_pages_migrated     2225    1564
numa_pte_updates        98557   134080

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        3,173,490       3,079,150
migrations                36,966          31,455
faults                    108,776         99,081
cache-misses              12,200,075,320  11,588,126,740
sched:sched_move_numa     1,264           1
sched:sched_stick_numa    0               0
sched:sched_swap_numa     0               0
migrate:mm_migrate_pages  899             36

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        21109   430
numa_hint_faults_local  17120   77
numa_hit                72934   71277
numa_huge_pte_updates   42      0
numa_interleave         33      22
numa_local              72866   71218
numa_other              68      59
numa_pages_migrated     915     23
numa_pte_updates        42326   0

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before       After
cs                        8,312,022    8,707,565
migrations                231,705      171,342
faults                    310,242      310,820
cache-misses              402,324,573  136,115,400
sched:sched_move_numa     193          215
sched:sched_stick_numa    0            6
sched:sched_swap_numa     3            24
migrate:mm_migrate_pages  93           162

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        11838   8985
numa_hint_faults_local  11216   8154
numa_hit                90689   93819
numa_huge_pte_updates   0       0
numa_interleave         1579    882
numa_local              89634   93496
numa_other              1055    323
numa_pages_migrated     92      169
numa_pte_updates        12109   9217

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before      After
cs                        2,170,481   2,152,072
migrations                10,126      10,704
faults                    160,962     164,376
cache-misses              10,834,845  3,818,437
sched:sched_move_numa     10          16
sched:sched_stick_numa    0           0
sched:sched_swap_numa     0           7
migrate:mm_migrate_pages  2           199

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        403     2248
numa_hint_faults_local  358     1666
numa_hit                25898   25704
numa_huge_pte_updates   0       0
numa_interleave         207     200
numa_local              25860   25679
numa_other              38      25
numa_pages_migrated     2       197
numa_pte_updates        400     2234

perf stats 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before           After
cs                        110,339,633      93,330,595
migrations                4,139,812        4,122,061
faults                    863,622          865,979
cache-misses              231,838,045,660  225,395,083,479
sched:sched_move_numa     2,196            2,372
sched:sched_stick_numa    33               24
sched:sched_swap_numa     544              769
migrate:mm_migrate_pages  2,469            1,677

vmstat 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        85748   91638
numa_hint_faults_local  66831   78096
numa_hit                242213  242225
numa_huge_pte_updates   0       0
numa_interleave         0       2
numa_local              242211  242219
numa_other              2       6
numa_pages_migrated     2376    1515
numa_pte_updates        86233   92274

perf stats 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before          After
cs                        59,331,057      51,487,271
migrations                552,019         537,170
faults                    266,586         256,921
cache-misses              73,796,312,990  70,073,831,187
sched:sched_move_numa     981             576
sched:sched_stick_numa    54              24
sched:sched_swap_numa     286             327
migrate:mm_migrate_pages  713             726

vmstat 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        14807   12000
numa_hint_faults_local  5738    5024
numa_hit                36230   36470
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              36228   36465
numa_other              2       5
numa_pages_migrated     703     726
numa_pte_updates        14742   11930

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537552141-27815-7-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3529bf61826b..25c7c7e09cbd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1567,6 +1567,13 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	return (imb > old_imb);
 }
 
+/*
+ * Maximum NUMA importance can be 1998 (2*999);
+ * SMALLIMP @ 30 would be close to 1998/64.
+ * Used to deter task migration.
+ */
+#define SMALLIMP	30
+
 /*
  * This checks if the overall compute and NUMA accesses of the system would
  * be improved if the source tasks was migrated to the target dst_cpu taking
@@ -1600,7 +1607,7 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 	if (!cur) {
-		if (maymove || imp > env->best_imp)
+		if (maymove && moveimp >= env->best_imp)
 			goto assign;
 		else
 			goto unlock;
@@ -1643,15 +1650,21 @@ static void task_numa_compare(struct task_numa_env *env,
 			       task_weight(cur, env->dst_nid, dist);
 	}
 
-	if (imp <= env->best_imp)
-		goto unlock;
-
 	if (maymove && moveimp > imp && moveimp > env->best_imp) {
-		imp = moveimp - 1;
+		imp = moveimp;
 		cur = NULL;
 		goto assign;
 	}
 
+	/*
+	 * If the NUMA importance is less than SMALLIMP,
+	 * task migration might only result in ping pong
+	 * of tasks and also hurt performance due to cache
+	 * misses.
+	 */
+	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
+		goto unlock;
+
 	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
