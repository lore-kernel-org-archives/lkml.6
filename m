Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeFDKBi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752801AbeFDKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:35 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 17/19] sched/numa: Pass destination cpu as a parameter to migrate_task_rq
Date: Mon,  4 Jun 2018 15:30:26 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0016-0000-0000-000001D773A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0017-0000-0000-0000322A035F
Message-Id: <1528106428-19992-18-git-send-email-srikar@linux.vnet.ibm.com>
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

This additional parameter (new_cpu) is used later for identifying if
task migration is across nodes.

No functional change.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 68849c2..7ecd131 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1170,7 +1170,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 
 	if (task_cpu(p) != new_cpu) {
 		if (p->sched_class->migrate_task_rq)
-			p->sched_class->migrate_task_rq(p);
+			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		perf_event_task_migrate(p);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e7b3008..4f6b376 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1608,7 +1608,7 @@ static void yield_task_dl(struct rq *rq)
 	return cpu;
 }
 
-static void migrate_task_rq_dl(struct task_struct *p)
+static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6851412..339c3dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6616,7 +6616,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
  * cfs_rq_of(p) references at time of call are still valid and identify the
  * previous CPU. The caller guarantees p->pi_lock or task_rq(p)->lock is held.
  */
-static void migrate_task_rq_fair(struct task_struct *p)
+static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 55bc6e1..33ddea7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1487,7 +1487,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
-	void (*migrate_task_rq)(struct task_struct *p);
+	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
-- 
1.8.3.1
