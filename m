Return-Path: <patrick.bellasi@arm.com>
X-Google-Smtp-Source: AG47ELvkf6iC4rDWv79FPWUwNkLGC+GPJjYcig9gz6huaYSzyKaahWX4KJGlHjenjPyxWaplYcYB
ARC-Seal: i=1; a=rsa-sha256; t=1521646524; cv=none;
        d=google.com; s=arc-20160816;
        b=WPaNAEfz3WnL1TxYZ0V/inYxc22JnTGzdx9rcMIEUdQIoQEliHJejEyBfiGt2z0NT7
         tPQBsg3UdXEv9xtKkQAOFyv5A01bp2q1T2vSWS2/alH5WoGK2QcvoelmWxbnfuJR71HD
         iCdbQaJ4hWLPPXkh6ZkDxhyxc9JegO5t17Hr0+PxRf0gqhLpYHRU2ckHulrWI2ELTrec
         ZtKsYMW9gz12h5Ll+n0MBrZtqCsj2/FBtxVMTu2X57J8E3yuquN8KVV4AfbB1wruMTMv
         MTdNtAGZi6/T8b3u06S8vEJXlmnHOKowH5ERdjRXNgN95JsRSH1a+IaUXkqkboUR2ane
         Z4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=R0o02IGDsfFyCYkY6xZ8cm+2SguBYgrj1kJHYaT+N5E=;
        b=WK3Krd6rACcfF/62XAxU2u8qkI8QfMsa9UQyR9nBa2ya43S0izNpnFUOAXsSfVugHc
         NS/xcS/S50lYGzU9dGW67+TwCKN3tX4D7MOMaduGAUvj4jShysqYT6UVpNDrOgPnaj2c
         1ZMocZ0yq8fsBZ/mdgWdR3WYnfgmUsNQxydKDjC6e4bbf1uM6i6l3dya7hgMp+g2zBAy
         s38HkcmYPhOSQnPphqm/IqIl3hgxG3IH7lkjwEA6HCcA84HouuJSPFncJ0x58OyJh7GC
         dRX6nfrOheaCtvXisWIuG7elSnYoJKKoNWF1aj4hrdyCYsbFGks+s6IYdSSshakmXpKF
         sjYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of patrick.bellasi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=patrick.bellasi@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of patrick.bellasi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=patrick.bellasi@arm.com
Date: Wed, 21 Mar 2018 15:35:18 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180321153518.GC13951@e110439-lin>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-6-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595562025503595492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20-Mar 09:43, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 76bd46502486..65a1bead0773 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
>  	return energy;
>  }
> 
> +static bool task_fits(struct task_struct *p, int cpu)
> +{
> +	unsigned long next_util = cpu_util_next(cpu, p, cpu);
> +
> +	return util_fits_capacity(next_util, capacity_orig_of(cpu));
                                             ^^^^^^^^^^^^^^^^^^^^^

Since here we are at scheduling CFS tasks, should we not better use
capacity_of() to account for RT/IRQ pressure ?

> +}
> +
> +static int find_energy_efficient_cpu(struct sched_domain *sd,
> +					struct task_struct *p, int prev_cpu)
> +{
> +	unsigned long cur_energy, prev_energy, best_energy;
> +	int cpu, best_cpu = prev_cpu;
> +
> +	if (!task_util(p))

We are still waking up a task... what if the task was previously
running on a big CPU which is now idle?

I understand that from a _relative_ energy_diff standpoint there is
not much to do for a 0 utilization task. However, for those tasks we
can still try to return the most energy efficient CPU among the ones
in their cpus_allowed mask.

It should be a relatively low overhead (maybe contained in a fallback
most_energy_efficient_cpu() kind of function) which allows, for
example on ARM big.LITTLE systems, to consolidate those tasks on
LITTLE CPUs instead for example keep running them on a big CPU.

> +		return prev_cpu;
> +
> +	/* Compute the energy impact of leaving the task on prev_cpu. */
> +	prev_energy = best_energy = compute_energy(p, prev_cpu);
> +
> +	/* Look for the CPU that minimizes the energy. */
                                           ^^^^^^^^^^
nit-pick: would say explicitly "best_energy" here, just to avoid
confusion about (non) possible overflows in the following if check ;)

> +	for_each_cpu_and(cpu, &p->cpus_allowed, sched_domain_span(sd)) {
> +		if (!task_fits(p, cpu) || cpu == prev_cpu)

nit-pick: to me it would read better as:

                if (cpu == prev_cpu)
                        continue;
                if (!task_fits(p, cpu))
                        continue;

but it's more matter of (personal) taste then efficiency.

> +			continue;
> +		cur_energy = compute_energy(p, cpu);
> +		if (cur_energy < best_energy) {
> +			best_energy = cur_energy;
> +			best_cpu = cpu;
> +		}
> +	}
> +
> +	/*
> +	 * We pick the best CPU only if it saves at least 1.5% of the
> +	 * energy used by prev_cpu.
> +	 */
> +	if ((prev_energy - best_energy) > (prev_energy >> 6))
> +		return best_cpu;
> +
> +	return prev_cpu;
> +}

[...]

> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
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

Not entirely sure, but I was trying to understand if we can avoid to
modify the definition of want_affine (in the previous chunk) and move
this block before the previous "if (want_affine..." (in mainline but
not in this chunk), which will became an else, e.g.

        if (want_energy && !sd_overutilized(tmp) &&
                // ...
        else if (want_energy && !sd_overutilized(tmp) &&
                // ...

Isn't that the same?

Maybe there is a code path I'm missing... but otherwise it seems a
more self contained modification of select_task_rq_fair...

>  		if (tmp->flags & sd_flag)
>  			sd = tmp;
>  		else if (!want_affine)
> @@ -6586,6 +6652,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  			if (want_affine)
>  				current->recent_used_cpu = cpu;
>  		}
> +	} else if (energy_sd) {
> +		new_cpu = find_energy_efficient_cpu(energy_sd, p, prev_cpu);
>  	} else {
>  		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	}

-- 
#include <best/regards.h>

Patrick Bellasi
