Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeEPJ5N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:57:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeEPJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:57:10 -0400
Date: Wed, 16 May 2018 11:56:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC/RFT] [PATCH 01/10] x86,sched: Add support for frequency
 invariance
Message-ID: <20180516095648.GB12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-2-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for posting this one; I meant to start a thread on this for a
while but never got around to doing so.

I left the 'important' parts of the patch for context but removed all
the arch fiddling to find the max freq, as that is not so important
here.

On Tue, May 15, 2018 at 09:49:02PM -0700, Srinivas Pandruvada wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Implement arch_scale_freq_capacity() for 'modern' x86. This function
> is used by the scheduler to correctly account usage in the face of
> DVFS.
> 
> For example; suppose a CPU has two frequencies: 500 and 1000 Mhz. When
> running a task that would consume 1/3rd of a CPU at 1000 MHz, it would
> appear to consume 2/3rd (or 66.6%) when running at 500 MHz, giving the
> false impression this CPU is almost at capacity, even though it can go
> faster [*].
> 
> Since modern x86 has hardware control over the actual frequency we run
> at (because amongst other things, Turbo-Mode), we cannot simply use
> the frequency as requested through cpufreq.
> 
> Instead we use the APERF/MPERF MSRs to compute the effective frequency
> over the recent past. Also, because reading MSRs is expensive, don't
> do so every time we need the value, but amortize the cost by doing it
> every tick.
> 
> [*] this assumes a linear frequency/performance relation; which
> everybody knows to be false, but given realities its the best
> approximation we can make.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index c1d2a98..3fb5346 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -172,4 +172,33 @@ static inline void sched_clear_itmt_support(void)
>  }
>  #endif /* CONFIG_SCHED_MC_PRIO */
>  
> +#ifdef CONFIG_SMP
> +#include <asm/cpufeature.h>
> +
> +#define arch_scale_freq_tick arch_scale_freq_tick
> +#define arch_scale_freq_capacity arch_scale_freq_capacity
> +
> +DECLARE_PER_CPU(unsigned long, arch_cpu_freq);
> +
> +static inline long arch_scale_freq_capacity(int cpu)
> +{
> +	if (static_cpu_has(X86_FEATURE_APERFMPERF))
> +		return per_cpu(arch_cpu_freq, cpu);
> +
> +	return 1024 /* SCHED_CAPACITY_SCALE */;
> +}
> +
> +extern void arch_scale_freq_tick(void);
> +extern void x86_arch_scale_freq_tick_enable(void);
> +extern void x86_arch_scale_freq_tick_disable(void);
> +#else
> +static inline void x86_arch_scale_freq_tick_enable(void)
> +{
> +}
> +
> +static inline void x86_arch_scale_freq_tick_disable(void)
> +{
> +}
> +#endif
> +
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 0f1cbb0..9e2cb82 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c

> @@ -1676,3 +1680,193 @@ void native_play_dead(void)
>  }
>  
>  #endif
> +
> +/*
> + * APERF/MPERF frequency ratio computation.
> + *
> + * The scheduler wants to do frequency invariant accounting and needs a <1
> + * ratio to account for the 'current' frequency.
> + *
> + * Since the frequency on x86 is controlled by micro-controller and our P-state
> + * setting is little more than a request/hint, we need to observe the effective
> + * frequency. We do this with APERF/MPERF.
> + *
> + * One complication is that the APERF/MPERF ratio can be >1, specifically
> + * APERF/MPERF gives the ratio relative to the max non-turbo P-state. Therefore
> + * we need to re-normalize the ratio.
> + *
> + * We do this by tracking the max APERF/MPERF ratio previously observed and
> + * scaling our MPERF delta with that. Every time our ratio goes over 1, we
> + * proportionally scale up our old max.

One very important point however is that I wrote this patch in the
context of Vincent's new scale invariance proposal:

  https://lkml.kernel.org/r/1493389435-2525-1-git-send-email-vincent.guittot@linaro.org

The reason is that while this 'works' with the current scale invariance,
the way turbo is handled is not optimal for it.

At OSPM we briefly touched upon this subject, since also ARM will need
something like this for some of their chips, so this is of general
interrest.

The problem with turbo of course is that our max frequency is variable;
but we really rather would like a unit value for scaling. Returning a >1
value results in weird things (think of running for 1.5ms in 1ms
wall-time for example).

This implementation simply finds the absolute max observed and scales
that as 1, with a result that when we're busy we'll always run at <1
because we cannot sustain turbo. This might result in the scheduler
thinking we're not fully busy, when in fact we are.

At OSPM it was suggested to instead track an average max or set 1 at the
sustainable freq and clip overshoot. The problem with that is that it is
actually hard to track an average max if you cannot tell what max even
is.

The problem with clipping of course is that we'll end up biasing the
frequencies higher than required -- which might be OK if the overshoot
is 'small' as it would typically be for an average max thing, but not
when we set 1 at the sustainable frequency.

I think the new scale invariance solves a bunch of these problems by
always saturating, irrespective of the actual frequency we run at.

Of course, IIRC it had other issues...

> + * The down-side to this runtime max search is that you have to trigger the
> + * actual max frequency before your scale is right. Therefore allow
> + * architectures to initialize the max ratio on CPU bringup.
> + */
> +
> +static DEFINE_PER_CPU(u64, arch_prev_aperf);
> +static DEFINE_PER_CPU(u64, arch_prev_mperf);
> +static DEFINE_PER_CPU(u64, arch_prev_max_freq) = SCHED_CAPACITY_SCALE;
> +

> +DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
> +
> +static bool tick_disable;
> +
> +void arch_scale_freq_tick(void)
> +{
> +	u64 freq, max_freq = this_cpu_read(arch_prev_max_freq);
> +	u64 aperf, mperf;
> +	u64 acnt, mcnt;
> +
> +	if (!static_cpu_has(X86_FEATURE_APERFMPERF) || tick_disable)
> +		return;
> +
> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +	acnt = aperf - this_cpu_read(arch_prev_aperf);
> +	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> +	if (!mcnt)
> +		return;
> +
> +	this_cpu_write(arch_prev_aperf, aperf);
> +	this_cpu_write(arch_prev_mperf, mperf);
> +
> +	acnt <<= 2*SCHED_CAPACITY_SHIFT;
> +	mcnt *= max_freq;
> +
> +	freq = div64_u64(acnt, mcnt);
> +
> +	if (unlikely(freq > SCHED_CAPACITY_SCALE)) {
> +		max_freq *= freq;
> +		max_freq >>= SCHED_CAPACITY_SHIFT;
> +
> +		this_cpu_write(arch_prev_max_freq, max_freq);
> +
> +		freq = SCHED_CAPACITY_SCALE;
> +	}
> +
> +	this_cpu_write(arch_cpu_freq, freq);
> +}

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 092f7c4..2bdef36 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3076,6 +3076,7 @@ void scheduler_tick(void)
>  	struct task_struct *curr = rq->curr;
>  	struct rq_flags rf;
>  
> +	arch_scale_freq_tick();
>  	sched_clock_tick();
>  
>  	rq_lock(rq, &rf);
