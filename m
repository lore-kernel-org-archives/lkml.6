Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324E8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CF123F89
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DVtv8J3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CF123F89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeGEMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:36:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbeGEMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VBHjqHTXlaLmHjKIbLJhjnlHKzcolX/S1N+Rejp+t20=; b=DVtv8J3x7unHLij/dcNctDz1c
        Dy4poysThReINS90qGtnmObhiRgSlISvkAKNQoYQq70X7iw4AG+TnhKEnOUi4Aw+Ps+K0AKn1adK7
        Z3F8R4RQa0+wZjTo7n6gUUBfDzEAkjhMjH8HL/Uc5s4kTA6LpOJowAkK+JNET/4mbXrMWntBSz+3H
        P4YfSSDxSqL3tpjVqSP9yaeZMDYF1emRI7dwlnuYG+IMjdViFGSyhLkT0Wvow/h+Ycm0TG7KUH9hD
        HwTFTXnRbd+X8/D2/0cHRSWBgUvg5dFeCrdw8yIJRTuh6PWt6EZpdivOeAi2bb7N6+WVbZ0i/52Z5
        ZjxTszU0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb3Ui-00074d-F0; Thu, 05 Jul 2018 12:36:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC5E02028932F; Thu,  5 Jul 2018 14:36:17 +0200 (CEST)
Date:   Thu, 5 Jul 2018 14:36:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com
Subject: Re: [PATCH v7 00/11] track CPU utilization
Message-ID: <20180705123617.GM2458@hirez.programming.kicks-ass.net>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:45:03PM +0200, Vincent Guittot wrote:
> Vincent Guittot (11):
>   sched/pelt: Move pelt related code in a dedicated file
>   sched/rt: add rt_rq utilization tracking
>   cpufreq/schedutil: use rt utilization tracking
>   sched/dl: add dl_rq utilization tracking
>   cpufreq/schedutil: use dl utilization tracking
>   sched/irq: add irq utilization tracking
>   cpufreq/schedutil: take into account interrupt
>   sched: schedutil: remove sugov_aggregate_util()
>   sched: use pelt for scale_rt_capacity()
>   sched: remove rt_avg code
>   proc/sched: remove unused sched_time_avg_ms
> 
>  include/linux/sched/sysctl.h     |   1 -
>  kernel/sched/Makefile            |   2 +-
>  kernel/sched/core.c              |  38 +---
>  kernel/sched/cpufreq_schedutil.c |  65 ++++---
>  kernel/sched/deadline.c          |   8 +-
>  kernel/sched/fair.c              | 403 +++++----------------------------------
>  kernel/sched/pelt.c              | 399 ++++++++++++++++++++++++++++++++++++++
>  kernel/sched/pelt.h              |  72 +++++++
>  kernel/sched/rt.c                |  15 +-
>  kernel/sched/sched.h             |  68 +++++--
>  kernel/sysctl.c                  |   8 -
>  11 files changed, 632 insertions(+), 447 deletions(-)
>  create mode 100644 kernel/sched/pelt.c
>  create mode 100644 kernel/sched/pelt.h

OK, this looks good I suppose. Rafael, are you OK with me taking these?

I have the below on top because I once again forgot how it all worked;
does this work for you Vincent?

---
Subject: sched/cpufreq: Clarify sugov_get_util()

Add a few comments (hopefully) clarifying some of the magic in
sugov_get_util().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 cpufreq_schedutil.c |   69 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 18 deletions(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -177,6 +177,26 @@ static unsigned int get_next_freq(struct
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued in
+ * the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured meric but a value computed
+ * based on the task model parameters and gives the minimal u required to meet
+ * deadlines.
+ */
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
@@ -188,26 +208,50 @@ static unsigned long sugov_get_util(stru
 	if (rt_rq_is_runnable(&rq->rt))
 		return max;
 
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
 	irq = cpu_util_irq(rq);
-
 	if (unlikely(irq >= max))
 		return max;
 
-	/* Sum rq utilization */
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 */
 	util = cpu_util_cfs(rq);
 	util += cpu_util_rt(rq);
 
 	/*
-	 * Interrupt time is not seen by rqs utilization nso we can compare
-	 * them with the CPU capacity
+	 * We do not make cpu_util_dl() a permanent part of this sum because we
+	 * want to use cpu_bw_dl() later on, but we need to check if the
+	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
+	 * f_max when there is no idle time.
+	 *
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
 	 */
 	if ((util + cpu_util_dl(rq)) >= max)
 		return max;
 
 	/*
-	 * As there is still idle time on the CPU, we need to compute the
-	 * utilization level of the CPU.
+	 * There is still idle time; further improve the number by using the
+	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
 	 *
+	 *              1 - irq
+	 *   U' = irq + ------- * U
+	 *                max
+	 */
+	util *= (max - irq);
+	util /= max;
+	util += irq;
+
+	/*
 	 * Bandwidth required by DEADLINE must always be granted while, for
 	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
 	 * to gracefully reduce the frequency when no tasks show up for longer
@@ -217,18 +261,7 @@ static unsigned long sugov_get_util(stru
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-
-	/* Weight rqs utilization to normal context window */
-	util *= (max - irq);
-	util /= max;
-
-	/* Add interrupt utilization */
-	util += irq;
-
-	/* Add DL bandwidth requirement */
-	util += sg_cpu->bw_dl;
-
-	return min(max, util);
+	return min(max, util + sg_cpu->bw_dl);
 }
 
 /**
