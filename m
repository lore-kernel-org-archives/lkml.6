Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeDJK4M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:56:12 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37524 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDJK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:56:10 -0400
X-Google-Smtp-Source: AIpwx4+YOboz0rpCCuA7IOrlqbwZf6onGbDFbpEGGuo1cdGoUg5QQl/SfJRX8dBnmiyv+faT4EiM3w==
Date: Tue, 10 Apr 2018 16:26:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH] cpufreq/schedutil: Cleanup and document iowait boost
Message-ID: <20180410105606.GH7671@vireshk-i7>
References: <20180328090721.26068-1-patrick.bellasi@arm.com>
 <20180405095858.GP3572@vireshk-i7>
 <20180410104349.GE14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410104349.GE14248@e110439-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-18, 11:43, Patrick Bellasi wrote:
> On 05-Apr 15:28, Viresh Kumar wrote:
> What about this new version for the two functions,
> just compile tested:
> 
> ---8<---
> 
> static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> 				   unsigned int flags)
> {
> 	bool iowait = flags & SCHED_CPUFREQ_IOWAIT;
> 
> 	/* Reset boost if the CPU appears to have been idle enough */
> 	if (sg_cpu->iowait_boost) {
> 		s64 delta_ns = time - sg_cpu->last_update;
> 
> 		if (delta_ns > TICK_NSEC) {
> 			sg_cpu->iowait_boost = iowait
> 				? sg_cpu->sg_policy->policy->min : 0;

Yeah, I see you are trying to optimize it a bit here but this makes
things more confusing I would say :)

I would just set iowait_boost to 0 and drop the return; from below and
let the code fall through and reach the end of this routine.

> 			sg_cpu->iowait_boost_pending = iowait;
> 			return;
> 		}
> 	}
> 
> 	/* Boost only tasks waking up after IO */
> 	if (!iowait)
> 		return;
> 
> 	/* Ensure IO boost doubles only one time at each frequency increase */
> 	if (sg_cpu->iowait_boost_pending)
> 		return;
> 	sg_cpu->iowait_boost_pending = true;
> 
> 	/* Double the IO boost at each frequency increase */
> 	if (sg_cpu->iowait_boost) {
> 		sg_cpu->iowait_boost <<= 1;
> 		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> 			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> 		return;
> 	}
> 
> 	/* At first wakeup after IO, start with minimum boost */
> 	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
> }
> 
> static void sugov_iowait_boost(struct sugov_cpu *sg_cpu,
> 			       unsigned long *util, unsigned long *max)
> {
> 	unsigned int boost_util, boost_max;
> 
>         /* No IOWait boost active */
>         if (!sg_cpu->iowait_boost)
>                 return;
> 
> 	/* An IO waiting task has just woken up, use the boost value */
> 	if (sg_cpu->iowait_boost_pending) {
> 		sg_cpu->iowait_boost_pending = false;
> 	} else {
> 		/* Reduce the boost value otherwise */
> 		sg_cpu->iowait_boost >>= 1;
> 		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
> 			sg_cpu->iowait_boost = 0;
> 			return;
> 		}
> 	}
> 
> 	boost_util = sg_cpu->iowait_boost;
> 	boost_max = sg_cpu->iowait_boost_max;
> 
> 	/*
> 	 * A CPU is boosted only if its current utilization is smaller then
> 	 * the current IO boost level.
> 	 */
> 	if (*util * boost_max < *max * boost_util) {
> 		*util = boost_util;
> 		*max = boost_max;
> 	}
> }

So this is quite different than what you proposed, it is only fixing
the existing problem which I pointed out to. Looks fine, not much
changed really from the current state of code.

-- 
viresh
