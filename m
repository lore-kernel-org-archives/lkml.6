Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeCOOri (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:47:38 -0400
Received: from foss.arm.com ([217.140.101.70]:40058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752670AbeCOOrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:47:35 -0400
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv2 6/7] sched: Wrap rq->rd->overload accesses with READ/WRITE_ONCE
Date: Thu, 15 Mar 2018 14:47:03 +0000
Message-Id: <1521125224-15434-7-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

This variable can be read and set locklessly within update_sd_lb_stats().
As such, READ/WRITE_ONCE are added to make sure nothing terribly wrong
can happen because of the compiler.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4824a37302..4e79ec8760be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8220,8 +8220,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (env->dst_rq->rd->overload != overload)
-			env->dst_rq->rd->overload = overload;
+		if (READ_ONCE(env->dst_rq->rd->overload) != overload)
+			WRITE_ONCE(env->dst_rq->rd->overload, overload);
 	}
 }
 
@@ -9659,7 +9659,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rq_unpin_lock(this_rq, rf);
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	    !READ_ONCE(this_rq->rd->overload)) {
 
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5379f647016d..31847b7f7d47 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1651,8 +1651,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
-		if (!rq->rd->overload)
-			rq->rd->overload = 1;
+		if (!READ_ONCE(rq->rd->overload))
+			WRITE_ONCE(rq->rd->overload, 1);
 #endif
 	}
 
-- 
2.7.4
