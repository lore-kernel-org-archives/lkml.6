Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeCIJEa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:04:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeCIJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:04:29 -0500
Date: Fri, 9 Mar 2018 01:04:09 -0800
From: tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-1936c53ce8c8d4555e9ccad2dc8d98e0637b11f7@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        vincent.guittot@linaro.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
        vincent.guittot@linaro.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1518517879-2280-3-git-send-email-vincent.guittot@linaro.org>
References: <1518517879-2280-3-git-send-email-vincent.guittot@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Reduce the periodic update duration
Git-Commit-ID: 1936c53ce8c8d4555e9ccad2dc8d98e0637b11f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1936c53ce8c8d4555e9ccad2dc8d98e0637b11f7
Gitweb:     https://git.kernel.org/tip/1936c53ce8c8d4555e9ccad2dc8d98e0637b11f7
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Tue, 13 Feb 2018 11:31:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 07:59:22 +0100

sched/fair: Reduce the periodic update duration

Instead of using the cfs_rq_is_decayed() which monitors all *_avg
and *_sum, we create a cfs_rq_has_blocked() which only takes care of
util_avg and load_avg. We are only interested by these 2 values which are
decaying faster than the *_sum so we can stop the periodic update earlier.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: brendan.jackman@arm.com
Cc: dietmar.eggemann@arm.com
Cc: morten.rasmussen@foss.arm.com
Cc: valentin.schneider@arm.com
Link: http://lkml.kernel.org/r/1518517879-2280-3-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78b06a0814d1..aad7c03dbad8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7424,6 +7424,19 @@ static void attach_tasks(struct lb_env *env)
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
@@ -7441,8 +7454,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7478,7 +7489,9 @@ static void update_blocked_averages(int cpu)
 		 */
 		if (cfs_rq_is_decayed(cfs_rq))
 			list_del_leaf_cfs_rq(cfs_rq);
-		else
+
+		/* Don't need periodic decay once load/util_avg are null */
+		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
 
@@ -7548,7 +7561,7 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (cfs_rq_is_decayed(cfs_rq))
+	if (!cfs_rq_has_blocked(cfs_rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
