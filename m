Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeCOOsK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:48:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbeCOOrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:47:33 -0400
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv2 5/7] sched: Change root_domain->overload type to int
Date: Thu, 15 Mar 2018 14:47:02 +0000
Message-Id: <1521125224-15434-6-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

sizeof(_Bool) is implementation defined, so let's just go with 'int' as
is done for other structures e.g. sched_domain_shared->has_idle_cores.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 7 +++----
 kernel/sched/sched.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c791dd7ac9a8..fe4824a37302 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7969,7 +7969,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
 			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+			int *overload)
 {
 	unsigned long load;
 	int i, nr_running;
@@ -7994,7 +7994,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
-			*overload = true;
+			*overload = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -8143,8 +8143,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
-	bool overload = false;
+	int load_idx, prefer_sibling, overload = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22177dfc1f04..5379f647016d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -689,7 +689,7 @@ struct root_domain {
 	cpumask_var_t		online;
 
 	/* Indicate more than one runnable task for any CPU */
-	bool			overload;
+	int			overload;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -1652,7 +1652,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
 		if (!rq->rd->overload)
-			rq->rd->overload = true;
+			rq->rd->overload = 1;
 #endif
 	}
 
-- 
2.7.4
