Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D64C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681FE2150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681FE2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeGDKU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:20:56 -0400
Received: from foss.arm.com ([217.140.101.70]:35008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934442AbeGDKSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A93F1650;
        Wed,  4 Jul 2018 03:18:16 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97D423F5AD;
        Wed,  4 Jul 2018 03:18:14 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 03/12] sched: Add sched_group per-cpu max capacity
Date:   Wed,  4 Jul 2018 11:17:41 +0100
Message-Id: <1530699470-29808-4-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sg->min_capacity tracks the lowest per-cpu compute capacity
available in the sched_group when rt/irq pressure is taken into account.
Minimum capacity isn't the ideal metric for tracking if a sched_group
needs offloading to another sched_group for some scenarios, e.g. a
sched_group with multiple cpus if only one is under heavy pressure.
Tracking maximum capacity isn't perfect either but a better choice for
some situations as it indicates that the sched_group definitely compute
capacity constrained either due to rt/irq pressure on all cpus or
asymmetric cpu capacities (e.g. big.LITTLE).

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c     | 24 ++++++++++++++++++++----
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e05e5202a1d2..09ede4321a3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7927,13 +7927,14 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	cpu_rq(cpu)->cpu_capacity = capacity;
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
+	sdg->sgc->max_capacity = capacity;
 }
 
 void update_group_capacity(struct sched_domain *sd, int cpu)
 {
 	struct sched_domain *child = sd->child;
 	struct sched_group *group, *sdg = sd->groups;
-	unsigned long capacity, min_capacity;
+	unsigned long capacity, min_capacity, max_capacity;
 	unsigned long interval;
 
 	interval = msecs_to_jiffies(sd->balance_interval);
@@ -7947,6 +7948,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 
 	capacity = 0;
 	min_capacity = ULONG_MAX;
+	max_capacity = 0;
 
 	if (child->flags & SD_OVERLAP) {
 		/*
@@ -7977,6 +7979,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			}
 
 			min_capacity = min(capacity, min_capacity);
+			max_capacity = max(capacity, max_capacity);
 		}
 	} else  {
 		/*
@@ -7990,12 +7993,14 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 
 			capacity += sgc->capacity;
 			min_capacity = min(sgc->min_capacity, min_capacity);
+			max_capacity = max(sgc->max_capacity, max_capacity);
 			group = group->next;
 		} while (group != child->groups);
 	}
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = min_capacity;
+	sdg->sgc->max_capacity = max_capacity;
 }
 
 /*
@@ -8091,16 +8096,27 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 }
 
 /*
- * group_smaller_cpu_capacity: Returns true if sched_group sg has smaller
+ * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
  * per-CPU capacity than sched_group ref.
  */
 static inline bool
-group_smaller_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
+group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
 	return sg->sgc->min_capacity * capacity_margin <
 						ref->sgc->min_capacity * 1024;
 }
 
+/*
+ * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
+ * per-CPU capacity_orig than sched_group ref.
+ */
+static inline bool
+group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
+{
+	return sg->sgc->max_capacity * capacity_margin <
+						ref->sgc->max_capacity * 1024;
+}
+
 static inline enum
 group_type group_classify(struct sched_group *group,
 			  struct sg_lb_stats *sgs)
@@ -8246,7 +8262,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * power/energy consequences are not considered.
 	 */
 	if (sgs->sum_nr_running <= sgs->group_weight &&
-	    group_smaller_cpu_capacity(sds->local, sg))
+	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
 asym_packing:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3376bacab712..6c39a07e8a68 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1172,6 +1172,7 @@ struct sched_group_capacity {
 	 */
 	unsigned long		capacity;
 	unsigned long		min_capacity;		/* Min per-CPU capacity in group */
+	unsigned long		max_capacity;		/* Max per-CPU capacity in group */
 	unsigned long		next_update;
 	int			imbalance;		/* XXX unrelated to capacity but shared group state */
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0cfdeff669fe..71330e0e41db 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -708,6 +708,7 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	sg_span = sched_group_span(sg);
 	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
 	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
+	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 }
 
 static int
@@ -867,6 +868,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 
 	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sched_group_span(sg));
 	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
+	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 
 	return sg;
 }
-- 
2.7.4

