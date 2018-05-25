Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936110AbeEYNNY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:13:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54313 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935768AbeEYNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:50 -0400
X-Google-Smtp-Source: ADUXVKIi5qh8zD7Z228L1gprJ5MfbEO10tfc2OAM6nooVRGRc74BZdYwiF10PdEbrHWOaIm7iP+Wrw==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 09/10] sched: remove rt_avg code
Date: Fri, 25 May 2018 15:12:30 +0200
Message-Id: <1527253951-22709-10-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt_avg is no more used anywhere so we can remove all related code

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 26 --------------------------
 kernel/sched/sched.h | 17 -----------------
 2 files changed, 43 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab58288..213d277 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -650,23 +650,6 @@ bool sched_can_stop_tick(struct rq *rq)
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
-
-void sched_avg_update(struct rq *rq)
-{
-	s64 period = sched_avg_period();
-
-	while ((s64)(rq_clock(rq) - rq->age_stamp) > period) {
-		/*
-		 * Inline assembly required to prevent the compiler
-		 * optimising this loop into a divmod call.
-		 * See __iter_div_u64_rem() for another example of this.
-		 */
-		asm("" : "+rm" (rq->age_stamp));
-		rq->age_stamp += period;
-		rq->rt_avg /= 2;
-	}
-}
-
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_RT_GROUP_SCHED) || (defined(CONFIG_FAIR_GROUP_SCHED) && \
@@ -5710,13 +5693,6 @@ void set_rq_offline(struct rq *rq)
 	}
 }
 
-static void set_cpu_rq_start_time(unsigned int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	rq->age_stamp = sched_clock_cpu(cpu);
-}
-
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -5834,7 +5810,6 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
-	set_cpu_rq_start_time(cpu);
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6102,7 +6077,6 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
-	set_cpu_rq_start_time(smp_processor_id());
 #endif
 	init_sched_fair_class();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 718c55d..1929db7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -846,8 +846,6 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
-	u64			rt_avg;
-	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 	struct sched_avg	avg_irq;
@@ -1710,11 +1708,6 @@ extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-static inline u64 sched_avg_period(void)
-{
-	return (u64)sysctl_sched_time_avg * NSEC_PER_MSEC / 2;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
@@ -1751,8 +1744,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #endif
 
 #ifdef CONFIG_SMP
-extern void sched_avg_update(struct rq *rq);
-
 #ifndef arch_scale_cpu_capacity
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
@@ -1763,12 +1754,6 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
-{
-	rq->rt_avg += rt_delta * arch_scale_freq_capacity(cpu_of(rq));
-	sched_avg_update(rq);
-}
 #else
 #ifndef arch_scale_cpu_capacity
 static __always_inline
@@ -1777,8 +1762,6 @@ unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
-static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-- 
2.7.4
