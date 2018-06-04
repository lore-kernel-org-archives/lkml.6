Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeFDKCE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:02:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752731AbeFDKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:37 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 18/19] sched/numa: Reset scan rate whenever task moves across nodes
Date: Mon,  4 Jun 2018 15:30:27 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-4275-0000-0000-000002895CA8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-4276-0000-0000-000037907105
Message-Id: <1528106428-19992-19-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently task scan rate is reset when numa balancer migrates the task
to a different node. If numa balancer initiates a swap, reset is only
applicable to the task that initiates the swap. Similarly no scan rate
reset is done if the task is migrated across nodes by traditional load
balancer.

Instead move the scan reset to the migrate_task_rq. This ensures the
task moved out of its preferred node, either gets back to its preferred
node quickly or finds a new preferred node. Doing so, would be fair to
all tasks migrating across nodes.


Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      428.48      837.17      700.45      162.77
numa01.sh       Sys:       78.64      247.70      164.45       58.32
numa01.sh      User:    37487.25    63728.06    54399.27    10088.13
numa02.sh      Real:       60.07       62.65       61.41        0.85
numa02.sh       Sys:       15.83       29.36       21.04        4.48
numa02.sh      User:     5194.27     5280.60     5236.55       28.01
numa03.sh      Real:      814.33      881.93      849.69       27.06
numa03.sh       Sys:      111.45      134.02      125.28        7.69
numa03.sh      User:    63007.36    68013.46    65590.46     2023.37
numa04.sh      Real:      412.19      438.75      424.43        9.28
numa04.sh       Sys:      232.97      315.77      268.98       26.98
numa04.sh      User:    33997.30    35292.88    34711.66      415.78
numa05.sh      Real:      394.88      449.45      424.30       22.53
numa05.sh       Sys:      262.03      390.10      314.53       51.01
numa05.sh      User:    33389.03    35684.40    34561.34      942.34

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      449.46      770.77      615.22      101.70 	 13.85%
numa01.sh       Sys:      132.72      208.17      170.46       24.96 	 -3.52%
numa01.sh      User:    39185.26    60290.89    50066.76     6807.84 	 8.653%
numa02.sh      Real:       60.85       61.79       61.28        0.37 	 0.212%
numa02.sh       Sys:       15.34       24.71       21.08        3.61 	 -0.18%
numa02.sh      User:     5204.41     5249.85     5231.21       17.60 	 0.102%
numa03.sh      Real:      785.50      916.97      840.77       44.98 	 1.060%
numa03.sh       Sys:      108.08      133.60      119.43        8.82 	 4.898%
numa03.sh      User:    61422.86    70919.75    64720.87     3310.61 	 1.343%
numa04.sh      Real:      429.57      587.37      480.80       57.40 	 -11.7%
numa04.sh       Sys:      240.61      321.97      290.84       33.58 	 -7.51%
numa04.sh      User:    34597.65    40498.99    37079.48     2060.72 	 -6.38%
numa05.sh      Real:      392.09      431.25      414.65       13.82 	 2.327%
numa05.sh       Sys:      229.41      372.48      297.54       53.14 	 5.710%
numa05.sh      User:    33390.86    34697.49    34222.43      556.42 	 0.990%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 339c3dc..fc1f388 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1808,12 +1808,6 @@ static int task_numa_migrate(struct task_struct *p)
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
 		pg_data_t *pgdat = NODE_DATA(cpu_to_node(env.dst_cpu));
@@ -6669,6 +6663,19 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 
 	/* We have migrated, no longer consider this task hot */
 	p->se.exec_start = 0;
+
+#ifdef CONFIG_NUMA_BALANCING
+	if (!p->mm || (p->flags & PF_EXITING))
+		return;
+
+	if (p->numa_faults) {
+		int src_nid = cpu_to_node(task_cpu(p));
+		int dst_nid = cpu_to_node(new_cpu);
+
+		if (src_nid != dst_nid)
+			p->numa_scan_period = task_scan_start(p);
+	}
+#endif
 }
 
 static void task_dead_fair(struct task_struct *p)
-- 
1.8.3.1
