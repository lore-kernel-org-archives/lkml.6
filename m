Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeBFTXZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:23:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37764 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbeBFTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:23:22 -0500
X-Google-Smtp-Source: AH8x225qoNpesB0xvERNJoIONnI5q/ChDS6TYxW6W+ZMm+U7DvCKzPxWTM4dWcAHC8KSFArwwov4pg==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/3] sched: reduce the periodic update duration
Date: Tue,  6 Feb 2018 20:23:06 +0100
Message-Id: <1517944987-343-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the cfs_rq_is_decayed() which monitors all *_avg
and *_sum, we create a cfs_rq_has_blocked() which only takes care of
util_avg and load_avg. We are only interested by these 2 values which are
decaying faster than the *_sum so we can stop the periodic update earlier.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9660b5..e203297 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7337,6 +7337,19 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
+static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->avg.load_avg)
+		return true;
+
+	if (cfs_rq->avg.util_avg)
+		return true;
+
+	return false;
+}
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->load.weight)
@@ -7354,8 +7367,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7391,7 +7402,9 @@ static void update_blocked_averages(int cpu)
 		 */
 		if (cfs_rq_is_decayed(cfs_rq))
 			list_del_leaf_cfs_rq(cfs_rq);
-		else
+
+		/* Don't need periodic decay once load/util_avg are null */
+		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
 
@@ -7461,7 +7474,7 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (cfs_rq_is_decayed(cfs_rq))
+	if (!cfs_rq_has_blocked(cfs_rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
-- 
2.7.4
