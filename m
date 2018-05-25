Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935990AbeEYNMw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:12:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39024 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935167AbeEYNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:47 -0400
X-Google-Smtp-Source: ADUXVKJgamJ+YvLZJUdPZzhPBJsAcOQb8KeCLyJrPgcwBnjjBfypBOLgx7mn7DDndWUH9GbGzsoFQQ==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 06/10] sched: remove rt and dl from sched_avg
Date: Fri, 25 May 2018 15:12:27 +0200
Message-Id: <1527253951-22709-7-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the utilization level of the CPU by rt and dl tasks is now tracked with
PELT so we can use these metrics and remove them from the rt_avg which
will track only interrupt and stolen virtual time.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/deadline.c | 2 --
 kernel/sched/fair.c     | 2 ++
 kernel/sched/pelt.c     | 2 +-
 kernel/sched/rt.c       | 2 --
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 950b3fb..da839e7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1180,8 +1180,6 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 967e873..da75eda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7562,6 +7562,8 @@ static unsigned long scale_rt_capacity(int cpu)
 
 	used = div_u64(avg, total);
 
+	used += READ_ONCE(rq->avg_rt.util_avg);
+	used += READ_ONCE(rq->avg_dl.util_avg);
 	if (likely(used < SCHED_CAPACITY_SCALE))
 		return SCHED_CAPACITY_SCALE - used;
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b07db80..3d5bd3a 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -237,7 +237,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
 	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
-	sa->util_avg = sa->util_sum / divider;
+	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
 /*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b4148a9..3393c63 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -970,8 +970,6 @@ static void update_curr_rt(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
-- 
2.7.4
