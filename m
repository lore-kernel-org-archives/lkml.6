Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FAFC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDEF23BFB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDEF23BFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934492AbeGDKSW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:22 -0400
Received: from foss.arm.com ([217.140.101.70]:35022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934329AbeGDKSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D00F91684;
        Wed,  4 Jul 2018 03:18:17 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 590C63F5AD;
        Wed,  4 Jul 2018 03:18:16 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 04/12] sched/fair: Consider misfit tasks when load-balancing
Date:   Wed,  4 Jul 2018 11:17:42 +0100
Message-Id: <1530699470-29808-5-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On asymmetric cpu capacity systems load intensive tasks can end up on
cpus that don't suit their compute demand.  In this scenarios 'misfit'
tasks should be migrated to cpus with higher compute capacity to ensure
better throughput. group_misfit_task indicates this scenario, but tweaks
to the load-balance code are needed to make the migrations happen.

Misfit balancing only makes sense between a source group of lower
per-cpu capacity and destination group of higher compute capacity.
Otherwise, misfit balancing is ignored. group_misfit_task has lowest
priority so any imbalance due to overload is dealt with first.

The modifications are:

1. Only pick a group containing misfit tasks as the busiest group if the
   destination group has higher capacity and has spare capacity.
2. When the busiest group is a 'misfit' group, skip the usual average
   load and group capacity checks.
3. Set the imbalance for 'misfit' balancing sufficiently high for a task
   to be pulled ignoring average load.
4. Pick the cpu with the highest misfit load as the source cpu.
5. If the misfit task is alone on the source cpu, go for active
   balancing.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09ede4321a3d..6e885d92fad2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7285,6 +7285,7 @@ struct lb_env {
 	unsigned int		loop_max;
 
 	enum fbq_type		fbq_type;
+	enum group_type		src_grp_type;
 	struct list_head	tasks;
 };
 
@@ -8243,6 +8244,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 {
 	struct sg_lb_stats *busiest = &sds->busiest_stat;
 
+	/*
+	 * Don't try to pull misfit tasks we can't help.
+	 * We can use max_capacity here as reduction in capacity on some
+	 * cpus in the group should either be possible to resolve
+	 * internally or be covered by avg_load imbalance (eventually).
+	 */
+	if (sgs->group_type == group_misfit_task &&
+	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
+	     !group_has_capacity(env, &sds->local_stat)))
+		return false;
+
 	if (sgs->group_type > busiest->group_type)
 		return true;
 
@@ -8265,6 +8277,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
+	/*
+	 * If we have more than one misfit sg go with the biggest misfit.
+	 */
+	if (sgs->group_type == group_misfit_task &&
+	    sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+		return false;
+
 asym_packing:
 	/* This is the busiest node in its class. */
 	if (!(env->sd->flags & SD_ASYM_PACKING))
@@ -8562,8 +8581,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 * factors in sg capacity and sgs with smaller group_type are
 	 * skipped when updating the busiest sg:
 	 */
-	if (busiest->avg_load <= sds->avg_load ||
-	    local->avg_load >= sds->avg_load) {
+	if (busiest->group_type != group_misfit_task &&
+	    (busiest->avg_load <= sds->avg_load ||
+	     local->avg_load >= sds->avg_load)) {
 		env->imbalance = 0;
 		return fix_small_imbalance(env, sds);
 	}
@@ -8597,6 +8617,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		(sds->avg_load - local->avg_load) * local->group_capacity
 	) / SCHED_CAPACITY_SCALE;
 
+	/* Boost imbalance to allow misfit task to be balanced. */
+	if (busiest->group_type == group_misfit_task) {
+		env->imbalance = max_t(long, env->imbalance,
+				       busiest->group_misfit_task_load);
+	}
+
 	/*
 	 * if *imbalance is less than the average load per runnable task
 	 * there is no guarantee that any tasks will be moved so we'll have
@@ -8663,6 +8689,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->group_no_capacity)
 		goto force_balance;
 
+	/* Misfit tasks should be dealt with regardless of the avg load */
+	if (busiest->group_type == group_misfit_task)
+		goto force_balance;
+
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
@@ -8700,6 +8730,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
+	env->src_grp_type = busiest->group_type;
 	calculate_imbalance(env, &sds);
 	return sds.busiest;
 
@@ -8747,6 +8778,19 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
+		/*
+		 * For ASYM_CPUCAPACITY domains with misfit tasks we simply
+		 * seek the "biggest" misfit task.
+		 */
+		if (env->src_grp_type == group_misfit_task) {
+			if (rq->misfit_task_load > busiest_load) {
+				busiest_load = rq->misfit_task_load;
+				busiest = rq;
+			}
+
+			continue;
+		}
+
 		capacity = capacity_of(i);
 
 		wl = weighted_cpuload(rq);
@@ -8816,6 +8860,9 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
+	if (env->src_grp_type == group_misfit_task)
+		return 1;
+
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
 
-- 
2.7.4

