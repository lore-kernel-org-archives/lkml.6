Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ADC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5E520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeFTJJu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:09:50 -0400
Received: from foss.arm.com ([217.140.101.70]:33974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeFTJGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:06:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2DED15BE;
        Wed, 20 Jun 2018 02:06:43 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BEBA3F246;
        Wed, 20 Jun 2018 02:06:42 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv3 3/9] sched: Add sched_group per-cpu max capacity
Date:   Wed, 20 Jun 2018 10:05:43 +0100
Message-Id: <1529485549-5191-4-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
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
index ed7eb2ac068f..6af3354e9e26 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7929,13 +7929,14 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
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
@@ -7949,6 +7950,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 
 	capacity = 0;
 	min_capacity = ULONG_MAX;
+	max_capacity = 0;
 
 	if (child->flags & SD_OVERLAP) {
 		/*
@@ -7979,6 +7981,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			}
 
 			min_capacity = min(capacity, min_capacity);
+			max_capacity = max(capacity, max_capacity);
 		}
 	} else  {
 		/*
@@ -7992,12 +7995,14 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 
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
@@ -8093,16 +8098,27 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
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
@@ -8248,7 +8264,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * power/energy consequences are not considered.
 	 */
 	if (sgs->sum_nr_running <= sgs->group_weight &&
-	    group_smaller_cpu_capacity(sds->local, sg))
+	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
 asym_packing:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 273d07dedc90..5ed67122cf59 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1165,6 +1165,7 @@ struct sched_group_capacity {
 	 */
 	unsigned long		capacity;
 	unsigned long		min_capacity;		/* Min per-CPU capacity in group */
+	unsigned long		max_capacity;		/* Max per-CPU capacity in group */
 	unsigned long		next_update;
 	int			imbalance;		/* XXX unrelated to capacity but shared group state */
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index edc87e35fc75..f32bf3a998b1 100644
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

