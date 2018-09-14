Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CAAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7800D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7800D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeINSdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:33:53 -0400
Received: from foss.arm.com ([217.140.101.70]:33272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbeINSdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:33:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2CC18A;
        Fri, 14 Sep 2018 06:19:24 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26EFA3F703;
        Fri, 14 Sep 2018 06:19:22 -0700 (PDT)
Date:   Fri, 14 Sep 2018 14:19:19 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Message-ID: <20180914131919.GO1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
 <20180914093240.GB24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914093240.GB24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Sep 11:32, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 02:53:14PM +0100, Patrick Bellasi wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 3fffad3bc8a8..949082555ee8 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -222,8 +222,13 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> >  	 * CFS tasks and we use the same metric to track the effective
> >  	 * utilization (PELT windows are synchronized) we can directly add them
> >  	 * to obtain the CPU's actual utilization.
> > +	 *
> > +	 * CFS utilization can be boosted or capped, depending on utilization
> > +	 * clamp constraints configured for currently RUNNABLE tasks.
> >  	 */
> >  	util = cpu_util_cfs(rq);
> > +	if (util)
> > +		util = uclamp_util(rq, util);
> 
> Should that not be:
> 
> 	util = clamp_util(rq, cpu_util_cfs(rq));
> 
> Because if !util might we not still want to enforce the min clamp?

If !util CFS tasks should have been gone since a long time
(proportional to their estimated utilization) and thus it probably
makes sense to not affect further energy efficiency for tasks of other
classes.

IOW, the blocked utiliation of a class gives us a bit of "hysteresis" in
case its tasks have a relatively small period and thus they are lucky
to wakeup soonish.

This "hysteresis" so far is based on the specific PELT decay rate,
which is not very tunable... what I would like instead, but that's for
a future update, is a dedicated (per-task) attribute which allows to
defined for how long a clamp has to last since the last task enqueue
time.

This will make up a much more flexible mechanism which allows
to completely decouple a clamp duration from PELT enabling scenarios
like quite similar to the 0lag we have in DL:
 - a small task with relatively long period which gets and ensured
   boost up to their next activation
 - a big task which has important things to do just at the beginning
   but can complete in a more energy efficient lower OPP

We already have this "boost holding" feature in Android and we found
it quite useful especially for RT tasks where it grants that an RT
tasks does not risk to wakeup on a lower OPP when that feature is
required (which can be not always).

Furthermore, based on such a generic "clamp holding mechanism" we can
thing also about replacing the IOWAIT boost with a more tunable and
task-specific boosting based on util_min.

... but again, if the above makes any sense, its for a future series
once we are happy with at least these bits.


> >  	util += cpu_util_rt(rq);
> >  
> >  	/*
> 
> > @@ -322,11 +328,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> >  		return;
> >  	sg_cpu->iowait_boost_pending = true;
> >  
> > +	/*
> > +	 * Boost FAIR tasks only up to the CPU clamped utilization.
> > +	 *
> > +	 * Since DL tasks have a much more advanced bandwidth control, it's
> > +	 * safe to assume that IO boost does not apply to those tasks.
> > +	 * Instead, since RT tasks are not utiliation clamped, we don't want
> > +	 * to apply clamping on IO boost while there is blocked RT
> > +	 * utilization.
> > +	 */
> > +	max_boost = sg_cpu->iowait_boost_max;
> > +	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> > +		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);
> 
> OK I suppose.

Yes, if we have a task constraint it should apply to boost too...

> > +
> >  	/* Double the boost at each request */
> >  	if (sg_cpu->iowait_boost) {
> >  		sg_cpu->iowait_boost <<= 1;
> > -		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> > -			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> > +		if (sg_cpu->iowait_boost > max_boost)
> > +			sg_cpu->iowait_boost = max_boost;
> >  		return;
> >  	}
> >  
> 
> 
> > +static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
> > +{
> > +	struct uclamp_cpu *uc_cpu = &rq->uclamp;
> > +
> > +	if (uc_cpu->value[clamp_id] == UCLAMP_NOT_VALID)
> > +		return uclamp_none(clamp_id);
> > +
> > +	return uc_cpu->value[clamp_id];
> > +}
> 
> Would that not be more readable as:
> 
> static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
> {
> 	unsigned int val = rq->uclamp.value[clamp_id];
> 
> 	if (unlikely(val == UCLAMP_NOT_VALID))
> 		val = uclamp_none(clamp_id);
> 
> 	return val;
> }

I'm trying to keep consistency in variable names usages by always
accessing the rq's clamps via a *uc_cpu to make it easy grepping the
code. Does this argument make sense ?

On the other side, what you propose above is more easy to read
by looking just at that function.... so, if you prefer it better, I'll
update it on v5.

> And how come NOT_VALID is possible? I thought the idea was to always
> have all things a valid value.

When we update the CPU's clamp for a "newly idle" CPU, there are not
tasks refcounting clamps and thus we end up with UCLAMP_NOT_VALID for
that CPU. That's how uclamp_cpu_update() is currently encoded.

Perhaps we can set the value to uclamp_none(clamp_id) from that
function, but I was thinking that perhaps it could be useful to track
explicitly that the CPU is now idle.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
