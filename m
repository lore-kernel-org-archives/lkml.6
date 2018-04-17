Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523978553; cv=none;
        d=google.com; s=arc-20160816;
        b=rRaqYbwwDjeaWvV9Tof4haAaADYoa+FBQh5yb5Jhk63frhbk3XRyKmkRVqzOFC4VhD
         flCTWOeVj0/mWax7xuM5yWsc01hXjr8xwupUanNkSpSN3Sku6VWPjpL19WinAQm5SIDD
         seB+15tVArsYjBtuuZPstj7cdwP18ZefJDiIreOLYxr5hSaIPHEs45BK6h53gWIpS6RD
         5AzIXfIfAq/CAvw/C2WlK+0MUr7igN14nUPROKe3gwxPVdgdLFwPlgJyB9xt3GFDrw3O
         tps86GnEjZisEDRc+H5dweCSwo4M6rIIJG9Rqx5GCBzR5lLOx54sytplcvzaU1VYjK32
         lCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ublVbYgVxsqLrJ3N+sE6YPYuq3MntBs3H+XOBxx6P4U=;
        b=nyMJ4I3Vdy302qFbRLsEz7e4Yg8eOF3pAEdL/LefUdMEa234hxGBsBJWrZhraVZi5u
         UuVBai1wP8DhCnhlgLlSb6hmSOSXW4SwLxwI0GVC5PLMmogji9rMbdFHAoniZmKsfNjj
         Pp6T4AkNXUDVfa4H/8yqcBDOVzwaS5YIihBNl9r1xQp9Hqvr7AjFb/4f4GyWCjphZwo2
         tVxDyI3JTF/F1pAygyYqcePnC1zVptuvr2rnhGG1LDn6qV3WL0m/dESuQd9xD07akj1Z
         nRUPPIGb4/ISuyHDTqe5PWoKA7w2DNlujRxrosKcrVELCVZTaiBj+YeInysmz+sHfIu/
         FSwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=P2d22Ulv;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=P2d22Ulv;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/2TfTs+zB9qqmxXLc/4rklI6HVjuN984Lusox3xtuRWGS5OeCBROzaTAfllLgHIFfoeLV+Fg==
Date: Tue, 17 Apr 2018 23:22:13 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180417152213.GC18509@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598007335128406990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> In preparation for the definition of an energy-aware wakeup path, a
> helper function is provided to estimate the consequence on system energy
> when a specific task wakes-up on a specific CPU. compute_energy()
> estimates the OPPs to be reached by all frequency domains and estimates
> the consumption of each online CPU according to its energy model and its
> percentage of busy time.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  include/linux/sched/energy.h | 20 +++++++++++++
>  kernel/sched/fair.c          | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h         |  2 +-
>  3 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h
> index 941071eec013..b4110b145228 100644
> --- a/include/linux/sched/energy.h
> +++ b/include/linux/sched/energy.h
> @@ -27,6 +27,24 @@ static inline bool sched_energy_enabled(void)
>  	return static_branch_unlikely(&sched_energy_present);
>  }
>  
> +static inline
> +struct capacity_state *find_cap_state(int cpu, unsigned long util)
> +{
> +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> +	struct capacity_state *cs = NULL;
> +	int i;
> +
> +	util += util >> 2;
> +
> +	for (i = 0; i < em->nr_cap_states; i++) {
> +		cs = &em->cap_states[i];
> +		if (cs->cap >= util)
> +			break;
> +	}
> +
> +	return cs;

'cs' is possible to return NULL.

> +}
> +
>  static inline struct cpumask *freq_domain_span(struct freq_domain *fd)
>  {
>  	return &fd->span;
> @@ -42,6 +60,8 @@ struct freq_domain;
>  static inline bool sched_energy_enabled(void) { return false; }
>  static inline struct cpumask
>  *freq_domain_span(struct freq_domain *fd) { return NULL; }
> +static inline struct capacity_state
> +*find_cap_state(int cpu, unsigned long util) { return NULL; }
>  static inline void init_sched_energy(void) { }
>  #define for_each_freq_domain(fdom) for (; fdom; fdom = NULL)
>  #endif
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6960e5ef3c14..8cb9fb04fff2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6633,6 +6633,74 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  }
>  
>  /*
> + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> + */
> +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util, util_est;
> +	struct cfs_rq *cfs_rq;
> +
> +	/* Task is where it should be, or has no impact on cpu */
> +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> +		return cpu_util(cpu);
> +
> +	cfs_rq = &cpu_rq(cpu)->cfs;
> +	util = READ_ONCE(cfs_rq->avg.util_avg);
> +
> +	if (dst_cpu == cpu)
> +		util += task_util(p);
> +	else
> +		util = max_t(long, util - task_util(p), 0);

I tried to understand the logic at here, below code is more clear for
myself:

        int prev_cpu = task_cpu(p);

        cfs_rq = &cpu_rq(cpu)->cfs;
        util = READ_ONCE(cfs_rq->avg.util_avg);

        /* Bail out if src and dst CPUs are the same one */
        if (prev_cpu == cpu && dst_cpu == cpu)
                return util;

        /* Remove task utilization for src CPU */
        if (cpu == prev_cpu)
                util = max_t(long, util - task_util(p), 0);

        /* Add task utilization for dst CPU */
        if (dst_cpu == cpu)
                util += task_util(p);

BTW, CPU utilization is decayed value and task_util() is not decayed
value, so 'util - task_util(p)' calculates a smaller value than the
prev CPU pure utilization, right?

Another question is can we reuse the function cpu_util_wake() and
just compenstate task util for dst cpu?

> +	if (sched_feat(UTIL_EST)) {
> +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +		if (dst_cpu == cpu)
> +			util_est += _task_util_est(p);
> +		else
> +			util_est = max_t(long, util_est - _task_util_est(p), 0);
> +		util = max(util, util_est);
> +	}
> +
> +	return min_t(unsigned long, util, capacity_orig_of(cpu));
> +}
> +
> +/*
> + * Estimates the system level energy assuming that p wakes-up on dst_cpu.
> + *
> + * compute_energy() is safe to call only if an energy model is available for
> + * the platform, which is when sched_energy_enabled() is true.
> + */
> +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util, max_util, sum_util;
> +	struct capacity_state *cs;
> +	unsigned long energy = 0;
> +	struct freq_domain *fd;
> +	int cpu;
> +
> +	for_each_freq_domain(fd) {
> +		max_util = sum_util = 0;
> +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util += cpu_util_dl(cpu_rq(cpu));
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		/*
> +		 * Here we assume that the capacity states of CPUs belonging to
> +		 * the same frequency domains are shared. Hence, we look at the
> +		 * capacity state of the first CPU and re-use it for all.
> +		 */
> +		cpu = cpumask_first(freq_domain_span(fd));
> +		cs = find_cap_state(cpu, max_util);
> +		energy += cs->power * sum_util / cs->cap;
> +	}

This means all CPUs will be iterated for calculation, the complexity is
O(n)...

Thanks,
Leo Yan

> +	return energy;
> +}
> +
> +/*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
>   * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5d552c0d7109..6eb38f41d5d9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2156,7 +2156,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  # define arch_scale_freq_invariant()	false
>  #endif
>  
> -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> +#ifdef CONFIG_SMP
>  static inline unsigned long cpu_util_dl(struct rq *rq)
>  {
>  	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> -- 
> 2.11.0
> 
