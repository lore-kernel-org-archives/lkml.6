Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeFDKBO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752416AbeFDKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:11 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/19] sched/numa: Remove unused task_capacity from numa_stats
Date: Mon,  4 Jun 2018 15:30:17 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0012-0000-0000-0000027A71B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0013-0000-0000-000020AB316A
Message-Id: <1528106428-19992-9-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_capacity field in struct numa_stats is redundant.
Also move nr_running for better packing within the struct.

No functional changes.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bf973..35c4a75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1411,14 +1411,12 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
-	unsigned long nr_running;
 	unsigned long load;
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
 
-	/* Approximate capacity in terms of runnable tasks on a node */
-	unsigned long task_capacity;
+	unsigned int nr_running;
 	int has_free_capacity;
 };
 
@@ -1456,9 +1454,9 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	smt = DIV_ROUND_UP(SCHED_CAPACITY_SCALE * cpus, ns->compute_capacity);
 	capacity = cpus / smt; /* cores */
 
-	ns->task_capacity = min_t(unsigned, capacity,
+	capacity = min_t(unsigned, capacity,
 		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
-	ns->has_free_capacity = (ns->nr_running < ns->task_capacity);
+	ns->has_free_capacity = (ns->nr_running < capacity);
 }
 
 struct task_numa_env {
-- 
1.8.3.1
