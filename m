Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9E4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9275520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9275520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeGYPfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:35:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:35:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEMhdm400282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:22:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEMhHF400279;
        Wed, 25 Jul 2018 07:22:43 -0700
Date:   Wed, 25 Jul 2018 07:22:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, mingo@kernel.org, hpa@zytor.com,
        vincent.guittot@linaro.org, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: mingo@redhat.com, viresh.kumar@linaro.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          vincent.guittot@linaro.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove #ifdefs from
 scale_rt_capacity()
Git-Commit-ID: 2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
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

Commit-ID:  2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
Gitweb:     https://git.kernel.org/tip/2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 19 Jul 2018 14:00:06 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:05 +0200

sched/fair: Remove #ifdefs from scale_rt_capacity()

Reuse cpu_util_irq() that has been defined for schedutil and set irq util
to 0 when !CONFIG_IRQ_TIME_ACCOUNTING.

But the compiler is not able to optimize the sequence (at least with
aarch64 GCC 7.2.1):

	free *= (max - irq);
	free /= max;

when irq is fixed to 0

Add a new inline function scale_irq_capacity() that will scale utilization
when irq is accounted. Reuse this funciton in schedutil which applies
similar formula.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net
Link: http://lkml.kernel.org/r/1532001606-6689-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c |  3 +--
 kernel/sched/fair.c              | 13 +++----------
 kernel/sched/sched.h             | 20 ++++++++++++++++++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3cf7d992159..fc177c06e490 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -177,7 +177,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->clock_task += delta;
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef HAVE_SCHED_AVG_IRQ
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 97dcd4472a0e..3fffad3bc8a8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -247,8 +247,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 *   U' = irq + ------- * U
 	 *                max
 	 */
-	util *= (max - irq);
-	util /= max;
+	util = scale_irq_capacity(util, irq, max);
 	util += irq;
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5f7d521e448..14c3fddf822a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7551,16 +7551,12 @@ static unsigned long scale_rt_capacity(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
 	unsigned long used, free;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	unsigned long irq;
-#endif
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	irq = READ_ONCE(rq->avg_irq.util_avg);
+	irq = cpu_util_irq(rq);
 
 	if (unlikely(irq >= max))
 		return 1;
-#endif
 
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
@@ -7569,11 +7565,8 @@ static unsigned long scale_rt_capacity(int cpu)
 		return 1;
 
 	free = max - used;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	free *= (max - irq);
-	free /= max;
-#endif
-	return free;
+
+	return scale_irq_capacity(free, irq, max);
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ebb4b3c3ece7..614170d9b1aa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -856,6 +856,7 @@ struct rq {
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#define HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
 	u64			idle_stamp;
@@ -2210,17 +2211,32 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
+#endif
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return rq->avg_irq.util_avg;
 }
+
+static inline
+unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
+{
+	util *= (max - irq);
+	util /= max;
+
+	return util;
+
+}
 #else
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return 0;
 }
 
-#endif
+static inline
+unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
+{
+	return util;
+}
 #endif
