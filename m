Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeFDKDP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752087AbeFDKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:26 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/19] mm/migrate: Use xchg instead of spinlock
Date: Mon,  4 Jun 2018 15:30:22 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-4275-0000-0000-000002895CA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-4276-0000-0000-0000379070FF
Message-Id: <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently resetting the migrate rate limit is under a spinlock.
The spinlock will only serialize the migrate rate limiting and something
similar can actually be achieved by a simpler xchg.

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      435.67      707.28      527.49       97.85
numa01.sh       Sys:       76.41      231.19      162.49       56.13
numa01.sh      User:    38247.36    59033.52    45129.31     7642.69
numa02.sh      Real:       60.35       62.09       61.09        0.69
numa02.sh       Sys:       15.01       30.20       20.64        5.56
numa02.sh      User:     5195.93     5294.82     5240.99       40.55
numa03.sh      Real:      752.04      919.89      836.81       63.29
numa03.sh       Sys:      115.10      133.35      125.46        7.78
numa03.sh      User:    58736.44    70084.26    65103.67     4416.10
numa04.sh      Real:      418.43      709.69      512.53      104.17
numa04.sh       Sys:      242.99      370.47      297.39       42.20
numa04.sh      User:    34916.14    48429.54    38955.65     4928.05
numa05.sh      Real:      379.27      434.05      403.70       17.79
numa05.sh       Sys:      145.94      344.50      268.72       68.53
numa05.sh      User:    32679.32    35449.75    33989.10      913.19

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      490.04      774.86      596.26       96.46 	 -11.5%
numa01.sh       Sys:      151.52      242.88      184.82       31.71 	 -12.0%
numa01.sh      User:    41418.41    60844.59    48776.09     6564.27 	 -7.47%
numa02.sh      Real:       60.14       62.94       60.98        1.00 	 0.180%
numa02.sh       Sys:       16.11       30.77       21.20        5.28 	 -2.64%
numa02.sh      User:     5184.33     5311.09     5228.50       44.24 	 0.238%
numa03.sh      Real:      790.95      856.35      826.41       24.11 	 1.258%
numa03.sh       Sys:      114.93      118.85      117.05        1.63 	 7.184%
numa03.sh      User:    60990.99    64959.28    63470.43     1415.44 	 2.573%
numa04.sh      Real:      434.37      597.92      504.87       59.70 	 1.517%
numa04.sh       Sys:      237.63      397.40      289.74       55.98 	 2.640%
numa04.sh      User:    34854.87    41121.83    38572.52     2615.84 	 0.993%
numa05.sh      Real:      386.77      448.90      417.22       22.79 	 -3.24%
numa05.sh       Sys:      149.23      379.95      303.04       79.55 	 -11.3%
numa05.sh      User:    32951.76    35959.58    34562.18     1034.05 	 -1.65%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 include/linux/mmzone.h | 3 ---
 mm/migrate.c           | 8 +++-----
 mm/page_alloc.c        | 1 -
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b0767703..0dbe1d5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -669,9 +669,6 @@ struct zonelist {
 	struct task_struct *kcompactd;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
-	/* Lock serializing the migrate rate limiting window */
-	spinlock_t numabalancing_migrate_lock;
-
 	/* Rate limiting time interval */
 	unsigned long numabalancing_migrate_next_window;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8c0af0f..1c55956 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1874,11 +1874,9 @@ static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
 	 * all the time is being spent migrating!
 	 */
 	if (time_after(jiffies, pgdat->numabalancing_migrate_next_window)) {
-		spin_lock(&pgdat->numabalancing_migrate_lock);
-		pgdat->numabalancing_migrate_nr_pages = 0;
-		pgdat->numabalancing_migrate_next_window = jiffies +
-			msecs_to_jiffies(migrate_interval_millisecs);
-		spin_unlock(&pgdat->numabalancing_migrate_lock);
+		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
+			pgdat->numabalancing_migrate_next_window = jiffies +
+				msecs_to_jiffies(migrate_interval_millisecs);
 	}
 	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
 		trace_mm_numa_migrate_ratelimit(current, pgdat->node_id,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4526643..464a25c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6208,7 +6208,6 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	pgdat_resize_init(pgdat);
 #ifdef CONFIG_NUMA_BALANCING
-	spin_lock_init(&pgdat->numabalancing_migrate_lock);
 	pgdat->numabalancing_migrate_nr_pages = 0;
 	pgdat->active_node_migrate = 0;
 	pgdat->numabalancing_migrate_next_window = jiffies;
-- 
1.8.3.1
