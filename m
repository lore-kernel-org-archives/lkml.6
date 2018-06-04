Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeFDL66 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:58:58 -0400
Received: from foss.arm.com ([217.140.101.70]:42226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDL64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:58:56 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, yuyang.du@intel.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        patrick.bellasi@arm.com, vincent.guittot@linaro.org,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH] sched/fair: Fix util_avg of new tasks for asymmetric systems
Date: Mon,  4 Jun 2018 12:58:30 +0100
Message-Id: <20180604115830.18781-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new task wakes-up for the first time, its initial utilization
is set to half of the spare capacity of its CPU. The current
implementation of post_init_entity_util_avg() uses SCHED_CAPACITY_SCALE
directly as a capacity reference. As a result, on a big.LITTLE system, a
new task waking up on an idle little CPU will be given ~512 of util_avg,
even if the CPU's capacity is significantly less than that.

Fix this by computing the spare capacity with arch_scale_cpu_capacity().

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05aab7f..f19432c17017 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -735,11 +735,12 @@ static void attach_entity_cfs_rq(struct sched_entity *se);
  * To solve this problem, we also cap the util_avg of successive tasks to
  * only 1/2 of the left utilization budget:
  *
- *   util_avg_cap = (1024 - cfs_rq->avg.util_avg) / 2^n
+ *   util_avg_cap = (cpu_scale - cfs_rq->avg.util_avg) / 2^n
  *
- * where n denotes the nth task.
+ * where n denotes the nth task and cpu_scale the CPU capacity.
  *
- * For example, a simplest series from the beginning would be like:
+ * For example, for a CPU with 1024 of capacity, a simplest series from
+ * the beginning would be like:
  *
  *  task  util_avg: 512, 256, 128,  64,  32,   16,    8, ...
  * cfs_rq util_avg: 512, 768, 896, 960, 992, 1008, 1016, ...
@@ -751,7 +752,8 @@ void post_init_entity_util_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
-	long cap = (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
+	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
-- 
2.17.0
