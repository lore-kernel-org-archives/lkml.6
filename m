Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D62FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A3D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A3D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeIJPIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:08:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:08:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAEMiR1807901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:14:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAEM9r1807898;
        Mon, 10 Sep 2018 03:14:22 -0700
Date:   Mon, 10 Sep 2018 03:14:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-e3d6d0cb66f2351cbfd09fbae04eb9804afe9577@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        morten.rasmussen@arm.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          morten.rasmussen@arm.com, peterz@infradead.org,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <1530699470-29808-4-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-4-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Add sched_group per-CPU max capacity
Git-Commit-ID: e3d6d0cb66f2351cbfd09fbae04eb9804afe9577
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e3d6d0cb66f2351cbfd09fbae04eb9804afe9577
Gitweb:     https://git.kernel.org/tip/e3d6d0cb66f2351cbfd09fbae04eb9804afe9577
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:41 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:49 +0200

sched/fair: Add sched_group per-CPU max capacity

The current sg->min_capacity tracks the lowest per-CPU compute capacity
available in the sched_group when rt/irq pressure is taken into account.
Minimum capacity isn't the ideal metric for tracking if a sched_group
needs offloading to another sched_group for some scenarios, e.g. a
sched_group with multiple CPUs if only one is under heavy pressure.
Tracking maximum capacity isn't perfect either but a better choice for
some situations as it indicates that the sched_group definitely compute
capacity constrained either due to rt/irq pressure on all CPUs or
asymmetric CPU capacities (e.g. big.LITTLE).

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-4-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c     | 24 ++++++++++++++++++++----
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e04bea5b11a..fe04315d57b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7557,13 +7557,14 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
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
@@ -7577,6 +7578,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 
 	capacity = 0;
 	min_capacity = ULONG_MAX;
+	max_capacity = 0;
 
 	if (child->flags & SD_OVERLAP) {
 		/*
@@ -7607,6 +7609,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			}
 
 			min_capacity = min(capacity, min_capacity);
+			max_capacity = max(capacity, max_capacity);
 		}
 	} else  {
 		/*
@@ -7620,12 +7623,14 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 
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
@@ -7721,16 +7726,27 @@ group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
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
@@ -7876,7 +7892,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * power/energy consequences are not considered.
 	 */
 	if (sgs->sum_nr_running <= sgs->group_weight &&
-	    group_smaller_cpu_capacity(sds->local, sg))
+	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
 asym_packing:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7dbf67d147a2..fe17e0be2d7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1197,6 +1197,7 @@ struct sched_group_capacity {
 	 */
 	unsigned long		capacity;
 	unsigned long		min_capacity;		/* Min per-CPU capacity in group */
+	unsigned long		max_capacity;		/* Max per-CPU capacity in group */
 	unsigned long		next_update;
 	int			imbalance;		/* XXX unrelated to capacity but shared group state */
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b0cdf5e95bda..2536e1b938f9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -693,6 +693,7 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	sg_span = sched_group_span(sg);
 	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
 	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
+	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 }
 
 static int
@@ -852,6 +853,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 
 	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sched_group_span(sg));
 	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
+	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 
 	return sg;
 }
