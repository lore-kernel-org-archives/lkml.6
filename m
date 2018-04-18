Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524053768; cv=none;
        d=google.com; s=arc-20160816;
        b=p5KSxMpaxsCUhT/h2URwpWmHPJZZl1lrOcGIjNg1BxFVt1ZSeFi8C8akeujRuiyxt1
         90I2Abf+HsSmfWYgAFcFbdc/YVTsBPNWbeoWjIKT8loNzHTPjMVZiIcr+0/gFWHUJQBJ
         obHCNLc5lOZkX5nGKM5E0fGID2ja8XHjr+zKzRk7mF/hERG7LPIVOroKfhijjD/NHW1S
         7wUBGvQqGMOjzul3wcdxsxbeCQtC20/Jpw92sipivwcAeVPyp/LD8byL5+zvdHrXO4rw
         DpVECX1zp2Vb+HT1lVFgxKSEncymL0jzhBXUJnRqOIHHliFZG3IUx98vXJhLsVk2wQU9
         9G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=sBkh+GfiFhbCuqNV1ANC3ch6yey98qOibe+2FgTXN60=;
        b=I2Jp/5BiGjLyJYN9RUCfHFVempxUnOazOh8TFMZ+dkhA7YQCDseycyLeFSid0RJrsH
         6HbbPuhMr6Up1x920GnlNJAUky4AgdTGadbjFb98XpyocIU4kuC+cox9JESM+ATJoems
         nTTqLToNDeI6yEnAQPD62GpB/CI/PbcERx8nEWXeSi829ODyS+jyTRATDvLRXEKYG0Ed
         ciGIFLidpXkx+xcmGcqJDc9gPSt2MR3/3ZND1NiwBzw1GcrPAK/wUntHf0zwBZS2FeAs
         HaVrM92AOp52wTJ9P2xRjR0yKMdNAUp77vOc+moFJw0PHZLrGs3kL6dOgqI+zx1Ozs3j
         5Nyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hhppE8/M;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hhppE8/M;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48EF7LkLiHmvbbah73IvrKMf+3fOCpWaECIdc6H1PcArDFdJ5DIZdfONtDrxcKNRk0JPDr9BA==
Date: Wed, 18 Apr 2018 20:15:47 +0800
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
Message-ID: <20180418121547.GC15682@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598086204267865789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Quentin,

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
> +
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

Sorry I introduce mess at here to spread my questions in several
replying, later will try to ask questions in one replying.  Below are
more questions which it's good to bring up:

The code for energy computation is quite neat and simple, but I think
the energy computation mixes two concepts for CPU util: one concept is
the estimated CPU util which is used to select CPU OPP in schedutil,
another concept is the raw CPU util according to CPU real running time;
for example, cpu_util_next() predicts CPU util but this value might be
much higher than cpu_util(), especially after enabled UTIL_EST feature
(I have shallow understanding for UTIL_EST so correct me as needed);
but this patch simply computes CPU capacity and energy with the single
one CPU utilization value (and it will be an inflated value afte enable
UTIL_EST).  Is this purposed for simple implementation?

IMHO, cpu_util_next() can be used to predict CPU capacity, on the other
hand, should we use the CPU util without UTIL_EST capping for 'sum_util',
this can be more reasonable to reflect the CPU utilization?

Furthermore, if we consider RT thread is running on CPU and connect with
'schedutil' governor, the CPU will run at maximum frequency, but we
cannot say the CPU has 100% utilization.  The RT thread case is not
handled in this patch.

> +
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
