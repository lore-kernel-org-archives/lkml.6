Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752888AbeFDKEA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:04:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752571AbeFDKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:10 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/19] sched/numa: Skip nodes that are at hoplimit
Date: Mon,  4 Jun 2018 15:30:16 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0012-0000-0000-0000027A71B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0013-0000-0000-000020AB3167
Message-Id: <1528106428-19992-8-git-send-email-srikar@linux.vnet.ibm.com>
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

When comparing two nodes at a distance of hoplimit, we should consider
nodes only upto hoplimit. Currently we also consider nodes at hoplimit
distance too. Hence two nodes at a distance of "hoplimit" will have same
groupweight. Fix this by skipping nodes at hoplimit.

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      478.45      565.90      515.11       30.87
numa01.sh       Sys:      207.79      271.04      232.94       21.33
numa01.sh      User:    39763.93    47303.12    43210.73     2644.86
numa02.sh      Real:       60.00       61.46       60.78        0.49
numa02.sh       Sys:       15.71       25.31       20.69        3.42
numa02.sh      User:     5175.92     5265.86     5235.97       32.82
numa03.sh      Real:      776.42      834.85      806.01       23.22
numa03.sh       Sys:      114.43      128.75      121.65        5.49
numa03.sh      User:    60773.93    64855.25    62616.91     1576.39
numa04.sh      Real:      456.93      511.95      482.91       20.88
numa04.sh       Sys:      178.09      460.89      356.86       94.58
numa04.sh      User:    36312.09    42553.24    39623.21     2247.96
numa05.sh      Real:      393.98      493.48      436.61       35.59
numa05.sh       Sys:      164.49      329.15      265.87       61.78
numa05.sh      User:    33182.65    36654.53    35074.51     1187.71

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      414.64      819.20      556.08      147.70 	 -7.36%
numa01.sh       Sys:       77.52      205.04      139.40       52.05 	 67.10%
numa01.sh      User:    37043.24    61757.88    45517.48     9290.38 	 -5.06%
numa02.sh      Real:       60.80       63.32       61.63        0.88 	 -1.37%
numa02.sh       Sys:       17.35       39.37       25.71        7.33 	 -19.5%
numa02.sh      User:     5213.79     5374.73     5268.90       55.09 	 -0.62%
numa03.sh      Real:      780.09      948.64      831.43       63.02 	 -3.05%
numa03.sh       Sys:      104.96      136.92      116.31       11.34 	 4.591%
numa03.sh      User:    60465.42    73339.78    64368.03     4700.14 	 -2.72%
numa04.sh      Real:      412.60      681.92      521.29       96.64 	 -7.36%
numa04.sh       Sys:      210.32      314.10      251.77       37.71 	 41.74%
numa04.sh      User:    34026.38    45581.20    38534.49     4198.53 	 2.825%
numa05.sh      Real:      394.79      439.63      411.35       16.87 	 6.140%
numa05.sh       Sys:      238.32      330.09      292.31       38.32 	 -9.04%
numa05.sh      User:    33456.45    34876.07    34138.62      609.45 	 2.741%

While there is a regression with this change, this change is needed from a
correctness perspective. Also it helps consolidation as seen from perf bench
output.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7c07aa..d4bf973 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1273,7 +1273,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * of each group. Skip other nodes.
 		 */
 		if (sched_numa_topology_type == NUMA_BACKPLANE &&
-					dist > maxdist)
+					dist >= maxdist)
 			continue;
 
 		/* Add up the faults from nearby nodes. */
-- 
1.8.3.1
