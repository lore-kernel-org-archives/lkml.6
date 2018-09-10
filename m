Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD31206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD31206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIJPIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:08:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:08:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAEttA1807932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:14:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAEtgt1807929;
        Mon, 10 Sep 2018 03:14:55 -0700
Date:   Mon, 10 Sep 2018 03:14:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Morten Rasmussen <tipbot@zytor.com>
Message-ID: <tip-cad68e552e7774b68ae6a2c5fedb792936098b72@git.kernel.org>
Cc:     mingo@kernel.org, morten.rasmussen@arm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          morten.rasmussen@arm.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1530699470-29808-5-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-5-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Consider misfit tasks when
 load-balancing
Git-Commit-ID: cad68e552e7774b68ae6a2c5fedb792936098b72
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

Commit-ID:  cad68e552e7774b68ae6a2c5fedb792936098b72
Gitweb:     https://git.kernel.org/tip/cad68e552e7774b68ae6a2c5fedb792936098b72
Author:     Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:42 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:50 +0200

sched/fair: Consider misfit tasks when load-balancing

On asymmetric CPU capacity systems load intensive tasks can end up on
CPUs that don't suit their compute demand.  In this scenarios 'misfit'
tasks should be migrated to CPUs with higher compute capacity to ensure
better throughput. group_misfit_task indicates this scenario, but tweaks
to the load-balance code are needed to make the migrations happen.

Misfit balancing only makes sense between a source group of lower
per-CPU capacity and destination group of higher compute capacity.
Otherwise, misfit balancing is ignored. group_misfit_task has lowest
priority so any imbalance due to overload is dealt with first.

The modifications are:

1. Only pick a group containing misfit tasks as the busiest group if the
   destination group has higher capacity and has spare capacity.
2. When the busiest group is a 'misfit' group, skip the usual average
   load and group capacity checks.
3. Set the imbalance for 'misfit' balancing sufficiently high for a task
   to be pulled ignoring average load.
4. Pick the CPU with the highest misfit load as the source CPU.
5. If the misfit task is alone on the source CPU, go for active
   balancing.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-5-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe04315d57b3..24fe39e57bc3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6890,6 +6890,7 @@ struct lb_env {
 	unsigned int		loop_max;
 
 	enum fbq_type		fbq_type;
+	enum group_type		src_grp_type;
 	struct list_head	tasks;
 };
 
@@ -7873,6 +7874,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 {
 	struct sg_lb_stats *busiest = &sds->busiest_stat;
 
+	/*
+	 * Don't try to pull misfit tasks we can't help.
+	 * We can use max_capacity here as reduction in capacity on some
+	 * CPUs in the group should either be possible to resolve
+	 * internally or be covered by avg_load imbalance (eventually).
+	 */
+	if (sgs->group_type == group_misfit_task &&
+	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
+	     !group_has_capacity(env, &sds->local_stat)))
+		return false;
+
 	if (sgs->group_type > busiest->group_type)
 		return true;
 
@@ -7895,6 +7907,13 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
@@ -8192,8 +8211,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8227,6 +8247,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8293,6 +8319,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->group_no_capacity)
 		goto force_balance;
 
+	/* Misfit tasks should be dealt with regardless of the avg load */
+	if (busiest->group_type == group_misfit_task)
+		goto force_balance;
+
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
@@ -8330,6 +8360,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
+	env->src_grp_type = busiest->group_type;
 	calculate_imbalance(env, &sds);
 	return env->imbalance ? sds.busiest : NULL;
 
@@ -8377,6 +8408,19 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
@@ -8446,6 +8490,9 @@ static int need_active_balance(struct lb_env *env)
 			return 1;
 	}
 
+	if (env->src_grp_type == group_misfit_task)
+		return 1;
+
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
 
