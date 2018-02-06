Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBFPnc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:43:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeBFPnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:43:24 -0500
Date: Tue, 6 Feb 2018 15:43:19 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Message-ID: <20180206154319.GF5739@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <f574036c-7572-9b97-79a0-794ff48e4d49@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f574036c-7572-9b97-79a0-794ff48e4d49@evidence.eu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudio,

On 06-Feb 11:55, Claudio Scordino wrote:
> Hi Peter,
> 
> Il 20/12/2017 16:30, Peter Zijlstra ha scritto:
> >
> >So I ended up with the below (on top of Juri's cpufreq-dl patches).
> >
> >It compiles, but that's about all the testing it had.
> >
> >--- a/include/linux/sched/cpufreq.h
> >+++ b/include/linux/sched/cpufreq.h

[..]

> >@@ -188,17 +187,23 @@ static void sugov_get_util(struct sugov_
> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  {
> >+	unsigned long util = sg_cpu->util_cfs + sg_cpu->util_dl;
> >+	struct rq *rq = cpu_rq(sg_cpu->cpu);
> >+
> >+	if (rq->rt.rt_nr_running)
> >+		util = sg_cpu->max;
> >+
> >  	/*
> >  	 * Ideally we would like to set util_dl as min/guaranteed freq and
> >  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> >  	 * ready for such an interface. So, we only do the latter for now.
> >  	 */
> >-	return min(sg_cpu->util_cfs + sg_cpu->util_dl, sg_cpu->max);
> >+	return min(util, sg_cpu->max);
> >  }

[...]

> 
> What is the status of this patch ? I couldn't find it on the
> tip/queue repositories.
> 
> BTW, I wonder if we actually want to remove also the information
> about the scheduling class who triggered the frequency change.

Removing flags was the main goal of the patch, since they represents
mainly duplicated information which scheduling classes already know.

This was making flags update error prone and difficult to keep
aligned with existing scheduling classes info.

> This prevents us from adopting class-specific behaviors.

In Peter's proposal he replaces flags with checks like:

   if (rq->rt.rt_nr_running)

> For example, we might want to skip the rate limits when deadline
> asks for an increase of frequency, as shown in the patch below.
> In this case, we could just remove the flags from sugov_cpu, but
> leave the defines and the argument for sugov_update_*()

At first glance, your proposal below makes to make sense.

However, I'm wondering if we cannot get it working using
rq->dl's provided information instead of flags?

> Best regards,
> 
>                 Claudio
>
> 
> From ed13fa5a8f93a43f8ff8f7d354b18c0031df482c Mon Sep 17 00:00:00 2001
> From: Claudio Scordino <claudio@evidence.eu.com>
> Date: Wed, 27 Sep 2017 17:16:36 +0200
> Subject: [PATCH RFC] cpufreq: schedutil: rate limits for SCHED_DEADLINE
> 
> When the SCHED_DEADLINE scheduling class asks to increase CPU frequency,
> we should not wait the rate limit, otherwise we may miss some deadline.
> The patch just ignores the limit whenever SCHED_DEADLINE asks for a
> higher CPU frequency.
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index dd062a1..5027ab1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -75,7 +75,8 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>  /************************ Governor internals ***********************/
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> +				     unsigned int next_freq, unsigned int flags)
>  {
>  	s64 delta_ns;
> @@ -112,6 +113,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  		return true;
>  	}
> +	/* Ignore rate limit if DL asked to increase CPU frequency */
> +	if ((flags & SCHED_CPUFREQ_DL) && (next_freq > sg_policy->next_freq))
> +		return true;


static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
{
        unsigned long util = sg_cpu->util_cfs + sg_cpu->util_dl;
        struct rq *rq = cpu_rq(sg_cpu->cpu);

        if (rq->dl.dl_nr_running)


> +
>  	delta_ns = time - sg_policy->last_freq_update_time;
>  	return delta_ns >= sg_policy->freq_update_delay_ns;
>  }
> @@ -275,9 +280,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	sugov_set_iowait_boost(sg_cpu, time);
>  	sg_cpu->last_update = time;
> -	if (!sugov_should_update_freq(sg_policy, time))
> -		return;
> -
>  	busy = sugov_cpu_is_busy(sg_cpu);
>  	if (flags & SCHED_CPUFREQ_RT) {
> @@ -299,7 +301,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  			sg_policy->cached_raw_freq = 0;
>  		}
>  	}
> -	sugov_update_commit(sg_policy, time, next_f);
> +	if (sugov_should_update_freq(sg_policy, time, next_f, flags))
> +		sugov_update_commit(sg_policy, time, next_f);
>  }
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> @@ -362,14 +365,13 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>  	sugov_set_iowait_boost(sg_cpu, time);
>  	sg_cpu->last_update = time;
> -	if (sugov_should_update_freq(sg_policy, time)) {
> -		if (flags & SCHED_CPUFREQ_RT)
> -			next_f = sg_policy->policy->cpuinfo.max_freq;
> -		else
> -			next_f = sugov_next_freq_shared(sg_cpu, time);
> +	if (flags & SCHED_CPUFREQ_RT)
> +		next_f = sg_policy->policy->cpuinfo.max_freq;
> +	else
> +		next_f = sugov_next_freq_shared(sg_cpu, time);
> +	if (sugov_should_update_freq(sg_policy, time, next_f, flags))
>  		sugov_update_commit(sg_policy, time, next_f);
> -	}
>  	raw_spin_unlock(&sg_policy->update_lock);
>  }
> -- 
> 2.7.4
> 
> 

-- 
#include <best/regards.h>

Patrick Bellasi
