Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D38627632
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeOeLXaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D38627632
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935474AbeF1PqG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:46:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40739 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030214AbeF1Pph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so9590943wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D5Qny5qPkCUDDQBYNsLYT5W10m4bYLoJk8RUhx4horE=;
        b=AeOeLXaO0HkF+rsvuOrXrJbqXOHKiqi5FRP39VMPdR/9PGh+DLz3QaklmEWl59nMb5
         bX8+O7tYJqwVyDzzxBSCi1OevO0lrp7r/mTSBSjGoXbq32mjSm1RavQNkwokRZ8pEYd3
         2lAzCn9oVtH2s806qcXKtjPy5LzTI5R8hOCFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D5Qny5qPkCUDDQBYNsLYT5W10m4bYLoJk8RUhx4horE=;
        b=sUNvprNl2Ib13Tz2llczbf0drup3o9CFsOVyG2V7TRUkCp3u/WJXw17vXBWLQSU8qj
         +p8aOc3aDSnOC8+hIrm8aqZP4WmfjVmc3CRs/qo2HPaaBUEBPZCLRnlCyOsHNKFP4X4T
         XW1qX6SVZWI/c/CFbUp0R1uo3/vPmnUzVlHCQJOuYmHbHrYrcI3uQrWkNWtv738iwG0y
         BLvPmLmszRYeI6xcCXEajdZNjreA03WuduzG+XnDc26kMYv4orsChvOJqtImYOu2YGRN
         jhS70nOqyvLKcCYSL6PyHvIz3YZp04gppT8fJLPPKOI8cOQIh0fZnoh5DMSfWmWjRGug
         mgsQ==
X-Gm-Message-State: APt69E1T3QuOvy95KrvTmL0r+0x6uQ6x5MIqe/eoCawekxTnAce0iFbL
        6CgluZ7fxxSJI5rbWlJ8Xl9ILw==
X-Google-Smtp-Source: AAOMgpeSI5onOdrlzuCxLTaarBojCqjKAHTfvNOLM+gEI8gf0ZH257D9AMQuU2EsFy4qN453EUV8vw==
X-Received: by 2002:a1c:5d0e:: with SMTP id r14-v6mr8384763wmb.152.1530200736285;
        Thu, 28 Jun 2018 08:45:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:35 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 10/11] sched: remove rt_avg code
Date:   Thu, 28 Jun 2018 17:45:13 +0200
Message-Id: <1530200714-4504-11-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt_avg is no more used anywhere so we can remove all related code

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 26 --------------------------
 kernel/sched/fair.c  |  2 --
 kernel/sched/sched.h | 17 -----------------
 3 files changed, 45 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e5263a4..e9aae7f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -652,23 +652,6 @@ bool sched_can_stop_tick(struct rq *rq)
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
@@ -5719,13 +5702,6 @@ void set_rq_offline(struct rq *rq)
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
@@ -5843,7 +5819,6 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
-	set_cpu_rq_start_time(cpu);
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6111,7 +6086,6 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
-	set_cpu_rq_start_time(smp_processor_id());
 #endif
 	init_sched_fair_class();
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ce0dcbf..7ddb13a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5322,8 +5322,6 @@ static void cpu_load_update(struct rq *this_rq, unsigned long this_load,
 
 		this_rq->cpu_load[i] = (old_load * (scale - 1) + new_load) >> i;
 	}
-
-	sched_avg_update(this_rq);
 }
 
 /* Used instead of source_load when we know the type == 0 */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 59a633d..c71ea81 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -846,8 +846,6 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
-	u64			rt_avg;
-	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
@@ -1712,11 +1710,6 @@ extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-static inline u64 sched_avg_period(void)
-{
-	return (u64)sysctl_sched_time_avg * NSEC_PER_MSEC / 2;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
@@ -1753,8 +1746,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #endif
 
 #ifdef CONFIG_SMP
-extern void sched_avg_update(struct rq *rq);
-
 #ifndef arch_scale_cpu_capacity
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
@@ -1765,12 +1756,6 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
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
@@ -1779,8 +1764,6 @@ unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
-static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-- 
2.7.4

