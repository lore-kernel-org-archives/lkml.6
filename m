Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeFDKBg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752731AbeFDKB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:27 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 14/19] sched/numa: Updation of scan period need not be in lock
Date: Mon,  4 Jun 2018 15:30:23 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0028-0000-0000-000002CC715E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0029-0000-0000-00002382F620
Message-Id: <1528106428-19992-15-git-send-email-srikar@linux.vnet.ibm.com>
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

The metrics for updating scan periods are local or task specific.
Currently this updation happens under numa_group lock which seems
unnecessary. Hence move this updation outside the lock.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 709c77c..6b72240 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2162,8 +2162,6 @@ static void task_numa_placement(struct task_struct *p)
 		}
 	}
 
-	update_task_scan_period(p, fault_types[0], fault_types[1]);
-
 	if (p->numa_group) {
 		numa_group_count_active_nodes(p->numa_group);
 		spin_unlock_irq(group_lock);
@@ -2178,6 +2176,8 @@ static void task_numa_placement(struct task_struct *p)
 		if (task_node(p) != p->numa_preferred_nid)
 			numa_migrate_preferred(p);
 	}
+
+	update_task_scan_period(p, fault_types[0], fault_types[1]);
 }
 
 static inline int get_numa_group(struct numa_group *grp)
-- 
1.8.3.1
