Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425751AbeBOQVl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:21:41 -0500
Received: from foss.arm.com ([217.140.101.70]:57118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425701AbeBOQVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:30 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of asymmetric capacity groups
Date: Thu, 15 Feb 2018 16:20:51 +0000
Message-Id: <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with asymmetric cpu capacities, a skewed load distribution
might yield better throughput than balancing load per group capacity.
For example, preferring high capacity cpus for compute intensive tasks
leaving low capacity cpus idle rather than balancing the number of idle
cpus across different cpu types. Instead, let load-balance back off if
the busiest group isn't really overloaded.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d70838ed711..e036aef3f10a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7794,6 +7794,19 @@ group_smaller_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 						ref->sgc->min_capacity * 1024;
 }
 
+/*
+ * group_similar_cpu_capacity: Returns true if the minimum capacity of the
+ * compared groups differ by less than 12.5%.
+ */
+static inline bool
+group_similar_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
+{
+	long diff = sg->sgc->min_capacity - ref->sgc->min_capacity;
+	long max = max(sg->sgc->min_capacity, ref->sgc->min_capacity);
+
+	return abs(diff) < max >> 3;
+}
+
 static inline enum
 group_type group_classify(struct sched_group *group,
 			  struct sg_lb_stats *sgs)
@@ -7925,6 +7938,15 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	    group_smaller_cpu_capacity(sds->local, sg))
 		return false;
 
+	/*
+	 * Candidate sg doesn't face any severe imbalance issues so
+	 * don't disturb unless the groups are of similar capacity
+	 * where balancing is more harmless.
+	 */
+	if (sgs->group_type == group_other &&
+		!group_similar_cpu_capacity(sds->local, sg))
+		return false;
+
 asym_packing:
 	/* This is the busiest node in its class. */
 	if (!(env->sd->flags & SD_ASYM_PACKING))
-- 
2.7.4
