Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeFDKBe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752680AbeFDKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:30 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 15/19] sched/numa: Use group_weights to identify if migration degrades locality
Date: Mon,  4 Jun 2018 15:30:24 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0028-0000-0000-000002CC7161
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0029-0000-0000-00002382F621
Message-Id: <1528106428-19992-16-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=859 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NUMA_BACKPLANE and NUMA_GLUELESS_MESH systems, tasks/memory should be
consolidated to the closest group of nodes. In such a case, relying on
group_fault metric may not always help to consolidate. There can always
be a case where a node closer to the preferred node may have lesser
faults than a node further away from the preferred node. In such a case,
moving to node with more faults might avoid numa consolidation.

Using group_weight would help to consolidate task/memory around the
preferred_node.

While here, to be on the conservative side, don't override migrate thread
degrades locality logic for CPU_NEWLY_IDLE load balancing.

Note: Similar problems exist with should_numa_migrate_memory and will be
dealt separately.

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      490.04      774.86      596.26       96.46
numa01.sh       Sys:      151.52      242.88      184.82       31.71
numa01.sh      User:    41418.41    60844.59    48776.09     6564.27
numa02.sh      Real:       60.14       62.94       60.98        1.00
numa02.sh       Sys:       16.11       30.77       21.20        5.28
numa02.sh      User:     5184.33     5311.09     5228.50       44.24
numa03.sh      Real:      790.95      856.35      826.41       24.11
numa03.sh       Sys:      114.93      118.85      117.05        1.63
numa03.sh      User:    60990.99    64959.28    63470.43     1415.44
numa04.sh      Real:      434.37      597.92      504.87       59.70
numa04.sh       Sys:      237.63      397.40      289.74       55.98
numa04.sh      User:    34854.87    41121.83    38572.52     2615.84
numa05.sh      Real:      386.77      448.90      417.22       22.79
numa05.sh       Sys:      149.23      379.95      303.04       79.55
numa05.sh      User:    32951.76    35959.58    34562.18     1034.05

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      493.19      672.88      597.51       59.38 	 -0.20%
numa01.sh       Sys:      150.09      245.48      207.76       34.26 	 -11.0%
numa01.sh      User:    41928.51    53779.17    48747.06     3901.39 	 0.059%
numa02.sh      Real:       60.63       62.87       61.22        0.83 	 -0.39%
numa02.sh       Sys:       16.64       27.97       20.25        4.06 	 4.691%
numa02.sh      User:     5222.92     5309.60     5254.03       29.98 	 -0.48%
numa03.sh      Real:      821.52      902.15      863.60       32.41 	 -4.30%
numa03.sh       Sys:      112.04      130.66      118.35        7.08 	 -1.09%
numa03.sh      User:    62245.16    69165.14    66443.04     2450.32 	 -4.47%
numa04.sh      Real:      414.53      519.57      476.25       37.00 	 6.009%
numa04.sh       Sys:      181.84      335.67      280.41       54.07 	 3.327%
numa04.sh      User:    33924.50    39115.39    37343.78     1934.26 	 3.290%
numa05.sh      Real:      408.30      441.45      417.90       12.05 	 -0.16%
numa05.sh       Sys:      233.41      381.60      295.58       57.37 	 2.523%
numa05.sh      User:    33301.31    35972.50    34335.19      938.94 	 0.661%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b72240..c388ecf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7222,8 +7222,8 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
 	struct numa_group *numa_group = rcu_dereference(p->numa_group);
-	unsigned long src_faults, dst_faults;
-	int src_nid, dst_nid;
+	unsigned long src_weight, dst_weight;
+	int src_nid, dst_nid, dist;
 
 	if (!static_branch_likely(&sched_numa_balancing))
 		return -1;
@@ -7250,18 +7250,19 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 		return 0;
 
 	/* Leaving a core idle is often worse than degrading locality. */
-	if (env->idle != CPU_NOT_IDLE)
+	if (env->idle == CPU_IDLE)
 		return -1;
 
+	dist = node_distance(src_nid, dst_nid);
 	if (numa_group) {
-		src_faults = group_faults(p, src_nid);
-		dst_faults = group_faults(p, dst_nid);
+		src_weight = group_weight(p, src_nid, dist);
+		dst_weight = group_weight(p, dst_nid, dist);
 	} else {
-		src_faults = task_faults(p, src_nid);
-		dst_faults = task_faults(p, dst_nid);
+		src_weight = task_weight(p, src_nid, dist);
+		dst_weight = task_weight(p, dst_nid, dist);
 	}
 
-	return dst_faults < src_faults;
+	return dst_weight < src_weight;
 }
 
 #else
-- 
1.8.3.1
