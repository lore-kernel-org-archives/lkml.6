Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6BECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A90208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A90208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeGOX5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:57:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:57:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNWfiu921896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:32:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNWfJN921893;
        Sun, 15 Jul 2018 16:32:41 -0700
Date:   Sun, 15 Jul 2018 16:32:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-523e979d31648112bad07f427c183525c0258c75@git.kernel.org>
Cc:     torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          vincent.guittot@linaro.org, torvalds@linux-foundation.org
In-Reply-To: <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Use PELT for scale_rt_capacity()
Git-Commit-ID: 523e979d31648112bad07f427c183525c0258c75
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

Commit-ID:  523e979d31648112bad07f427c183525c0258c75
Gitweb:     https://git.kernel.org/tip/523e979d31648112bad07f427c183525c0258c75
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:12 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:16:25 +0200

sched/core: Use PELT for scale_rt_capacity()

The utilization of the CPU by RT, DL and IRQs are now tracked with
PELT so we can use these metrics instead of rt_avg to evaluate the remaining
capacity available for CFS class.

scale_rt_capacity() behavior has been changed and now returns the remaining
capacity available for CFS instead of a scaling factor because RT, DL and
IRQ provide now absolute utilization value.

The same formula as schedutil is used:

  IRQ util_avg + (1 - IRQ util_avg / max capacity ) * /Sum rq util_avg

but the implementation is different because it doesn't return the same value
and doesn't benefit of the same optimization.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Cc: viresh.kumar@linaro.org
Link: http://lkml.kernel.org/r/1530200714-4504-10-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c |  2 --
 kernel/sched/fair.c     | 44 ++++++++++++++++++++++----------------------
 kernel/sched/pelt.c     |  2 +-
 kernel/sched/rt.c       |  2 --
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f4de26982d80..68b8a9f1c9ca 100644
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
index c2782b29c79f..d265fa9756a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7551,39 +7551,39 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	u64 total, used, age_stamp, avg;
-	s64 delta;
-
-	/*
-	 * Since we're reading these variables without serialization make sure
-	 * we read them once before doing sanity checks on them.
-	 */
-	age_stamp = READ_ONCE(rq->age_stamp);
-	avg = READ_ONCE(rq->rt_avg);
-	delta = __rq_clock_broken(rq) - age_stamp;
+	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long used, free;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	unsigned long irq;
+#endif
 
-	if (unlikely(delta < 0))
-		delta = 0;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	irq = READ_ONCE(rq->avg_irq.util_avg);
 
-	total = sched_avg_period() + delta;
+	if (unlikely(irq >= max))
+		return 1;
+#endif
 
-	used = div_u64(avg, total);
+	used = READ_ONCE(rq->avg_rt.util_avg);
+	used += READ_ONCE(rq->avg_dl.util_avg);
 
-	if (likely(used < SCHED_CAPACITY_SCALE))
-		return SCHED_CAPACITY_SCALE - used;
+	if (unlikely(used >= max))
+		return 1;
 
-	return 1;
+	free = max - used;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	free *= (max - irq);
+	free /= max;
+#endif
+	return free;
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = arch_scale_cpu_capacity(sd, cpu);
+	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = capacity;
-
-	capacity *= scale_rt_capacity(cpu);
-	capacity >>= SCHED_CAPACITY_SHIFT;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
 
 	if (!capacity)
 		capacity = 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index ead6d8b4a8b8..35475c0c5419 100644
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
index 0dc8ad1915e6..2df72abfa24a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -973,8 +973,6 @@ static void update_curr_rt(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
