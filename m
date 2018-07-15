Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44289ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DCF20840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DCF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeGOXyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:54:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38795 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeGOXya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:54:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNTbp3921475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:29:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNTbCE921472;
        Sun, 15 Jul 2018 16:29:37 -0700
Date:   Sun, 15 Jul 2018 16:29:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-9033ea11889f88f243445495f72441e22256d5e9@git.kernel.org>
Cc:     viresh.kumar@linaro.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        mingo@kernel.org
Reply-To: vincent.guittot@linaro.org, mingo@kernel.org,
          peterz@infradead.org, viresh.kumar@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          torvalds@linux-foundation.org
In-Reply-To: <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cpufreq/schedutil: Take time spent in interrupts
 into account
Git-Commit-ID: 9033ea11889f88f243445495f72441e22256d5e9
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

Commit-ID:  9033ea11889f88f243445495f72441e22256d5e9
Gitweb:     https://git.kernel.org/tip/9033ea11889f88f243445495f72441e22256d5e9
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:21 +0200

cpufreq/schedutil: Take time spent in interrupts into account

The time spent executing IRQ handlers can be significant but it is not reflected
in the utilization of CPU when deciding to choose an OPP. Now that we have
access to this metric, schedutil can take it into account when selecting
the OPP for a CPU.

RQS utilization don't see the time spend under interrupt context and report
their value in the normal context time window. We need to compensate this when
adding interrupt utilization

The CPU utilization is:

  IRQ util_avg + (1 - IRQ util_avg / max capacity ) * /Sum rq util_avg

A test with iperf on hikey (octo arm64) gives the following speedup:

 iperf -c server_address -r -t 5

 w/o patch		w/ patch
 Tx 276 Mbits/sec	304 Mbits/sec +10%
 Rx 299 Mbits/sec	328 Mbits/sec  +9%

 8 iterations
 stdev is lower than 1%

Only WFI idle state is enabled (shallowest idle state).

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
Link: http://lkml.kernel.org/r/1530200714-4504-8-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++++++++----
 kernel/sched/sched.h             | 13 +++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 07760bc7f69a..7016bde9d194 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -58,6 +58,7 @@ struct sugov_cpu {
 	unsigned long		util_dl;
 	unsigned long		bw_dl;
 	unsigned long		util_rt;
+	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -190,21 +191,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->util_dl  = cpu_util_dl(rq);
 	sg_cpu->bw_dl    = cpu_bw_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
+	sg_cpu->util_irq = cpu_util_irq(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
+	unsigned long util, max = sg_cpu->max;
 
 	if (rt_rq_is_runnable(&rq->rt))
 		return sg_cpu->max;
 
+	if (unlikely(sg_cpu->util_irq >= max))
+		return max;
+
+	/* Sum rq utilization */
 	util = sg_cpu->util_cfs;
 	util += sg_cpu->util_rt;
 
-	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
-		return sg_cpu->max;
+	/*
+	 * Interrupt time is not seen by RQS utilization so we can compare
+	 * them with the CPU capacity
+	 */
+	if ((util + sg_cpu->util_dl) >= max)
+		return max;
 
 	/*
 	 * As there is still idle time on the CPU, we need to compute the
@@ -220,10 +230,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
 
+	/* Weight RQS utilization to normal context window */
+	util *= (max - sg_cpu->util_irq);
+	util /= max;
+
+	/* Add interrupt utilization */
+	util += sg_cpu->util_irq;
+
 	/* Add DL bandwidth requirement */
 	util += sg_cpu->bw_dl;
 
-	return min(sg_cpu->max, util);
+	return min(max, util);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b26d0c9948dd..b2833e2b4b6a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2228,4 +2228,17 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return rq->avg_rt.util_avg;
 }
+
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return rq->avg_irq.util_avg;
+}
+#else
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return 0;
+}
+
+#endif
 #endif
