Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F043C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86142083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86142083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeHAKIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:08:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387776AbeHAKIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:08:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1908D7A9;
        Wed,  1 Aug 2018 01:24:05 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADB733F5B3;
        Wed,  1 Aug 2018 01:24:00 -0700 (PDT)
Date:   Wed, 1 Aug 2018 09:23:55 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <skannan@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@quicinc.com,
        skannan@quicinc.com, Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Message-ID: <20180801082353.egym4tsbr7ppql27@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
 <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
 <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 Aug 2018 at 09:32:49 (+0200), Rafael J. Wysocki wrote:
> On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
> > On 2018-07-31 00:59, Quentin Perret wrote:
> >>
> >> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
> >> [...]
> >>>
> >>> If it's going to be a different aggregation from what's done for
> >>> frequency
> >>> guidance, I don't see the point of having this inside schedutil. Why not
> >>> keep it inside the scheduler files?
> >>
> >>
> >> This code basically results from a discussion we had with Peter on v4.
> >> Keeping everything centralized can make sense from a maintenance
> >> perspective, I think. That makes it easy to see the impact of any change
> >> to utilization signals for both EAS and schedutil.
> >
> >
> > In that case, I'd argue it makes more sense to keep the code centralized in
> > the scheduler. The scheduler can let schedutil know about the utilization
> > after it aggregates them. There's no need for a cpufreq governor to know
> > that there are scheduling classes or how many there are. And the scheduler
> > can then choose to aggregate one way for task packing and another way for
> > frequency guidance.
> 
> Also the aggregate utilization may be used by cpuidle governors in
> principle to decide how deep they can go with idle state selection.

The only issue I see with this right now is that some of the things done
in this function are policy decisions which really belong to the governor,
I think. The RT-go-to-max-freq thing in particular. And I really don't
think EAS should cope with that, at least for now.

But if this specific bit is factored out of the aggregation function, I
suppose we could move it somewhere else. Maybe pelt.c ?

How ugly is something like the below (totally untested) code ? It would
change slightly how we deal with DL utilization in EAS but I don't think
this is an issue.

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index af86050edcf5..51c9ac9f30e8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,121 +178,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
        return cpufreq_driver_resolve_freq(policy, freq);
 }

-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the irq utilization.
- *
- * The DL bandwidth number otoh is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-                                 enum schedutil_type type)
-{
-       struct rq *rq = cpu_rq(cpu);
-       unsigned long util, irq, max;
-
-       max = arch_scale_cpu_capacity(NULL, cpu);
-
-       if (type == frequency_util && rt_rq_is_runnable(&rq->rt))
-               return max;
-
-       /*
-        * Early check to see if IRQ/steal time saturates the CPU, can be
-        * because of inaccuracies in how we track these -- see
-        * update_irq_load_avg().
-        */
-       irq = cpu_util_irq(rq);
-       if (unlikely(irq >= max))
-               return max;
-
-       /*
-        * Because the time spend on RT/DL tasks is visible as 'lost' time to
-        * CFS tasks and we use the same metric to track the effective
-        * utilization (PELT windows are synchronized) we can directly add them
-        * to obtain the CPU's actual utilization.
-        */
-       util = util_cfs;
-       util += cpu_util_rt(rq);
-
-       if (type == frequency_util) {
-               /*
-                * For frequency selection we do not make cpu_util_dl() a
-                * permanent part of this sum because we want to use
-                * cpu_bw_dl() later on, but we need to check if the
-                * CFS+RT+DL sum is saturated (ie. no idle time) such
-                * that we select f_max when there is no idle time.
-                *
-                * NOTE: numerical errors or stop class might cause us
-                * to not quite hit saturation when we should --
-                * something for later.
-                */
-
-               if ((util + cpu_util_dl(rq)) >= max)
-                       return max;
-       } else {
-               /*
-                * OTOH, for energy computation we need the estimated
-                * running time, so include util_dl and ignore dl_bw.
-                */
-               util += cpu_util_dl(rq);
-               if (util >= max)
-                       return max;
-       }
-
-       /*
-        * There is still idle time; further improve the number by using the
-        * irq metric. Because IRQ/steal time is hidden from the task clock we
-        * need to scale the task numbers:
-        *
-        *              1 - irq
-        *   U' = irq + ------- * U
-        *                max
-        */
-       util *= (max - irq);
-       util /= max;
-       util += irq;
-
-       if (type == frequency_util) {
-               /*
-                * Bandwidth required by DEADLINE must always be granted
-                * while, for FAIR and RT, we use blocked utilization of
-                * IDLE CPUs as a mechanism to gracefully reduce the
-                * frequency when no tasks show up for longer periods of
-                * time.
-                *
-                * Ideally we would like to set bw_dl as min/guaranteed
-                * freq and util + bw_dl as requested freq. However,
-                * cpufreq is not yet ready for such an interface. So,
-                * we only do the latter for now.
-                */
-               util += cpu_bw_dl(rq);
-       }
-
-       return min(max, util);
-}
-
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
        struct rq *rq = cpu_rq(sg_cpu->cpu);
-       unsigned long util = cpu_util_cfs(rq);

        sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
        sg_cpu->bw_dl = cpu_bw_dl(rq);

-       return schedutil_freq_util(sg_cpu->cpu, util, frequency_util);
+       if (rt_rq_is_runnable(&rq->rt))
+               return sg_cpu->max;
+
+       return cpu_util_total(sg_cpu->cpu, cpu_util_cfs(rq));
 }

 /**
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0c5419..5f99bd564dfc 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -397,3 +397,77 @@ int update_irq_load_avg(struct rq *rq, u64 running)
        return ret;
 }
 #endif
+
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
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long cpu_util_total(int cpu, unsigned long util_cfs)
+{
+       struct rq *rq = cpu_rq(cpu);
+       unsigned long util, irq, max;
+
+       max = arch_scale_cpu_capacity(NULL, cpu);
+
+       /*
+        * Early check to see if IRQ/steal time saturates the CPU, can be
+        * because of inaccuracies in how we track these -- see
+        * update_irq_load_avg().
+        */
+       irq = cpu_util_irq(rq);
+       if (unlikely(irq >= max))
+               return max;
+
+       /*
+        * Because the time spend on RT/DL tasks is visible as 'lost' time to
+        * CFS tasks and we use the same metric to track the effective
+        * utilization (PELT windows are synchronized) we can directly add them
+        * to obtain the CPU's actual utilization.
+        */
+       util = util_cfs;
+       util += cpu_util_rt(rq);
+
+       if ((util + cpu_util_dl(rq)) >= max)
+               return max;
+
+       /*
+        * There is still idle time; further improve the number by using the
+        * irq metric. Because IRQ/steal time is hidden from the task clock we
+        * need to scale the task numbers:
+        *
+        *              1 - irq
+        *   U' = irq + ------- * U
+        *                max
+        */
+       util *= (max - irq);
+       util /= max;
+       util += irq;
+
+       /*
+        * Bandwidth required by DEADLINE must always be granted while, for
+        * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+        * to gracefully reduce the frequency when no tasks show up for longer
+        * periods of time.
+        *
+        * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+        * bw_dl as requested freq. However, cpufreq is not yet ready for such
+        * an interface. So, we only do the latter for now.
+        */
+       return min(max, util + cpu_bw_dl(rq));
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 51e7f113ee23..7ad037bb653e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2185,14 +2185,9 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()   false
 #endif

-enum schedutil_type {
-       frequency_util,
-       energy_util,
-};

-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-                                 enum schedutil_type type);
+#ifdef CONFIG_SMP
+unsigned long cpu_util_total(int cpu, unsigned long cfs_util);

 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
@@ -2233,12 +2228,6 @@ static inline unsigned long cpu_util_irq(struct rq *rq)
 }

 #endif
-#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
-                                 enum schedutil_type type)
-{
-       return util;
-}
 #endif

 #ifdef CONFIG_SMP
