Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523979615; cv=none;
        d=google.com; s=arc-20160816;
        b=FaAXCg/rZYeBMtEPG9IVmIMUSfDqW+6S75TOcpqmCW+F08NiOgE8fUV5HQYnOptqPa
         P8ER8nN0i6pHGvyGkI/ls5ArTABcL/eYrlLJsa2GwcCZlZNo3YdOxb8kODJprcjXfnPz
         lM8opPQWIhh70/Ayujfx60Fa6h3sg/PUo3bYsTL/HoO2HDZmoa3rrustrmliWUyighQD
         w8UKESB1M6YrHEsO3Mov9HT6SXuQNRwQ/AH9SaXQ26ovZPOq9Qtq1nv+61Yd2JYrkR5s
         DCT2JPAVnM/saocLYmiCC4/+vqox18ifUQwhvv3TsN2qsQQbxvWIFG/rABY1JqRJ7eLS
         VW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dxKvLoLexAqSueCh9j3qSQt3J8Xb9UQKqySm/dqQDlo=;
        b=ozFg2jP6qqJSoAwOlNPBgF6b6ImyJ1nAHUpplE5P26OSuHWwCJKYBtrGciBfa5n1Sn
         6Ush1SGwboruFiK2Oev1Hcut0FGS0E1jRIZ89b1aFj4oTFrRCIW3Th5/bLKbU7bCA04w
         rDxm1SBcYZIZAvRNZVRX2JmZiP1oqQMDBv7YWfqUBUl2+kEG+uTpLKhoi4BJrFX12b3j
         vyu598zEIOOQz93nTDzvm9VaPnrUheqvIMQGbIP8V+RRfHcabNzqgAXbFO3lv5QzSat+
         qws4m7WFXdksp7RWsVw5+9DAUktkeQ4az2snSrpvrsUIsrOxEUAH8O/flC36EGQMy16T
         W8mA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JRPKhzHH;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JRPKhzHH;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/SmzEhleaYXr5YHdhLaLsq3R8xTtDWit87QNwpw2qRXl2S5us0FPuSDPBKjPbmqUMPR8ntrA==
Date: Tue, 17 Apr 2018 23:39:44 +0800
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
Subject: Re: [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180417153944.GD18509@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-6-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011691670503989?=
X-GMAIL-MSGID: =?utf-8?q?1598008449545116942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> In case an energy model is available, waking tasks are re-routed into a
> new energy-aware placement algorithm. The eligible CPUs to be used in the
> energy-aware wakeup path are restricted to the highest non-overutilized
> sched_domain containing prev_cpu and this_cpu. If no such domain is found,
> the tasks go through the usual wake-up path, hence energy-aware placement
> happens only in lightly utilized scenarios.
> 
> The selection of the most energy-efficient CPU for a task is achieved by
> estimating the impact on system-level active energy resulting from the
> placement of the task on the CPU with the highest spare capacity in each
> frequency domain. The best CPU energy-wise is then selected if it saves
> a large enough amount of energy with respect to prev_cpu.
> 
> Although it has already shown significant benefits on some existing
> targets, this approach cannot scale to platforms with numerous CPUs.
> This patch is an attempt to do something useful as writing a fast
> heuristic that performs reasonably well on a broad spectrum of
> architectures isn't an easy task. As a consequence, the scope of
> usability of the energy-aware wake-up path is restricted to systems
> with the SD_ASYM_CPUCAPACITY flag set. These systems not only show the
> most promising opportunities for saving energy but also typically
> feature a limited number of logical CPUs.
> 
> Moreover, the energy-aware wake-up path is accessible only if
> sched_energy_enabled() is true. For systems which don't meet all
> dependencies for EAS (CONFIG_PM_OPP for ex.) at compile time,
> sched_enegy_enabled() defaults to a constant "false" value, hence letting
> the compiler remove the unused EAS code entirely.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8cb9fb04fff2..5ebb2d0306c7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6700,6 +6700,81 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
>  	return energy;
>  }
>  
> +static int find_energy_efficient_cpu(struct sched_domain *sd,
> +					struct task_struct *p, int prev_cpu)
> +{
> +	unsigned long cur_energy, prev_energy, best_energy, cpu_cap;
> +	unsigned long task_util = task_util_est(p);
> +	int cpu, best_energy_cpu = prev_cpu;
> +	struct freq_domain *fd;
> +
> +	if (!task_util)
> +		return prev_cpu;
> +
> +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> +	else
> +		prev_energy = best_energy = ULONG_MAX;
> +
> +	for_each_freq_domain(fd) {
> +		unsigned long spare_cap, max_spare_cap = 0;
> +		int max_spare_cap_cpu = -1;
> +		unsigned long util;
> +
> +		/* Find the CPU with the max spare cap in the freq. dom. */
> +		for_each_cpu_and(cpu, freq_domain_span(fd), sched_domain_span(sd)) {
> +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> +				continue;
> +
> +			if (cpu == prev_cpu)
> +				continue;
> +
> +			util = cpu_util_wake(cpu, p);
> +			cpu_cap = capacity_of(cpu);
> +			if (!util_fits_capacity(util + task_util, cpu_cap))
> +				continue;
> +
> +			spare_cap = cpu_cap - util;
> +			if (spare_cap > max_spare_cap) {
> +				max_spare_cap = spare_cap;
> +				max_spare_cap_cpu = cpu;
> +			}
> +		}

If have two clusters, and if firstly iterate the big cluster, then
max_spare_cap is a big value for big cluster and later LITTLE cluster
has no chance to have higher value for spare_cap.  For this case, the
LITTLE CPU will be skipped for energy computation?

> +
> +		/* Evaluate the energy impact of using this CPU. */
> +		if (max_spare_cap_cpu >= 0) {
> +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> +			if (cur_energy < best_energy) {
> +				best_energy = cur_energy;
> +				best_energy_cpu = max_spare_cap_cpu;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * We pick the best CPU only if it saves at least 1.5% of the
> +	 * energy used by prev_cpu.
> +	 */
> +	if ((prev_energy - best_energy) > (prev_energy >> 6))
> +		return best_energy_cpu;
> +
> +	return prev_cpu;
> +}
> +
> +static inline bool wake_energy(struct task_struct *p, int prev_cpu)
> +{
> +	struct sched_domain *sd;
> +
> +	if (!sched_energy_enabled())
> +		return false;
> +
> +	sd = rcu_dereference_sched(cpu_rq(prev_cpu)->sd);
> +	if (!sd || sd_overutilized(sd))
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -6716,18 +6791,22 @@ static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>  {
>  	struct sched_domain *tmp, *affine_sd = NULL, *sd = NULL;
> +	struct sched_domain *energy_sd = NULL;
>  	int cpu = smp_processor_id();
>  	int new_cpu = prev_cpu;
> -	int want_affine = 0;
> +	int want_affine = 0, want_energy = 0;
>  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>  
> +	rcu_read_lock();
> +
>  	if (sd_flag & SD_BALANCE_WAKE) {
>  		record_wakee(p);
> +		want_energy = wake_energy(p, prev_cpu);
>  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> -			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> +			      && cpumask_test_cpu(cpu, &p->cpus_allowed)
> +			      && !want_energy;
>  	}
>  
> -	rcu_read_lock();
>  	for_each_domain(cpu, tmp) {
>  		if (!(tmp->flags & SD_LOAD_BALANCE))
>  			break;
> @@ -6742,6 +6821,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  			break;
>  		}
>  
> +		/*
> +		 * Energy-aware task placement is performed on the highest
> +		 * non-overutilized domain spanning over cpu and prev_cpu.
> +		 */
> +		if (want_energy && !sd_overutilized(tmp) &&
> +		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
> +			energy_sd = tmp;
> +
>  		if (tmp->flags & sd_flag)
>  			sd = tmp;
>  		else if (!want_affine)
> @@ -6765,7 +6852,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  		sync_entity_load_avg(&p->se);
>  	}
>  
> -	if (!sd) {
> +	if (energy_sd) {
> +		new_cpu = find_energy_efficient_cpu(energy_sd, p, prev_cpu);
> +	} else if (!sd) {
>  pick_cpu:
>  		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
>  			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> -- 
> 2.11.0
> 
