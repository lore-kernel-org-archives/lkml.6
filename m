Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820372089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820372089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJPSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:55 -0400
Received: from foss.arm.com ([217.140.101.70]:34018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPSFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DB8A1596;
        Tue, 16 Oct 2018 03:16:12 -0700 (PDT)
Received: from queper01-lin.local (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C6F13F59C;
        Tue, 16 Oct 2018 03:16:07 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v8 11/15] sched/fair: Clean-up update_sg_lb_stats parameters
Date:   Tue, 16 Oct 2018 11:15:09 +0100
Message-Id: <20181016101513.26919-12-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the introduction of a new root domain flag which can
be set during load balance (the 'overutilized' flag), clean-up the set
of parameters passed to update_sg_lb_stats(). More specifically, the
'local_group' and 'local_idx' parameters can be removed since they can
easily be reconstructed from within the function.

While at it, transform the 'overload' parameter into a flag stored in
the 'sg_status' parameter hence facilitating the definition of new flags
when needed.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c  | 27 +++++++++++----------------
 kernel/sched/sched.h |  3 +++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e60858745071..13dc5da422a1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7836,16 +7836,16 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
  * @group: sched_group whose statistics are to be updated.
- * @load_idx: Load index of sched_domain of this_cpu for load calc.
- * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate pullable load (e.g. >1 runnable task).
+ * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
-			struct sched_group *group, int load_idx,
-			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+				      struct sched_group *group,
+				      struct sg_lb_stats *sgs,
+				      int *sg_status)
 {
+	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	int load_idx = get_sd_load_idx(env->sd, env->idle);
 	unsigned long load;
 	int i, nr_running;
 
@@ -7869,7 +7869,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
-			*overload = true;
+			*sg_status |= SG_OVERLOAD;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -7885,7 +7885,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
 		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
-			*overload = 1;
+			*sg_status |= SG_OVERLOAD;
 		}
 	}
 
@@ -8030,17 +8030,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx;
-	bool overload = false;
 	bool prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+	int sg_status = 0;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
 		env->flags |= LBF_NOHZ_STATS;
 #endif
 
-	load_idx = get_sd_load_idx(env->sd, env->idle);
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -8055,8 +8052,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+		update_sg_lb_stats(env, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
@@ -8106,8 +8102,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (READ_ONCE(env->dst_rq->rd->overload) != overload)
-			WRITE_ONCE(env->dst_rq->rd->overload, overload);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9d6cf58a8aff..69f31bc0d320 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -707,6 +707,9 @@ struct perf_domain {
 	struct rcu_head rcu;
 };
 
+/* Scheduling group status flags */
+#define SG_OVERLOAD		0x1 /* More than one runnable task on a CPU. */
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
-- 
2.19.1

