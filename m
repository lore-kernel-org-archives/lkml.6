Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbeCPL0X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:26:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46423 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbeCPLZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:25:57 -0400
X-Google-Smtp-Source: AG47ELv26GigJOWk+KvRo6t2625Yl1qT9Svtxd1yZR4G8h8dzdiO+eYJRErcRSc/72fKpLUcUde0bA==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/4 v4] sched/nohz: monitor rt utilization
Date: Fri, 16 Mar 2018 12:25:41 +0100
Message-Id: <1521199541-15308-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account rt's utilization when deciding to stop periodic update

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 60e3c4b..3f00e03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7131,6 +7131,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
+static inline bool rt_rq_has_blocked(struct rt_rq *rt_rq)
+{
+	if (rt_rq->avg.util_avg)
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7191,6 +7199,9 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), cpu, &rq->rt, 0);
+	/* Don't need periodic decay once load/util_avg are null */
+	if (rt_rq_has_blocked(&rq->rt))
+		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
@@ -7259,7 +7270,7 @@ static inline void update_blocked_averages(int cpu)
 	update_rt_rq_load_avg(rq_clock_task(rq), cpu, &rq->rt, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(&rq->rt))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
-- 
2.7.4
