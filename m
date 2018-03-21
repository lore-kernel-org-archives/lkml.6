Return-Path: <patrick.bellasi@arm.com>
X-Google-Smtp-Source: AG47ELtuBoQn6h8zc3lpmwBCJfnAjB8Lz7pHIgGHAUye43EmtfVNMdkHiB2arNpyeBj0RB//+biI
ARC-Seal: i=1; a=rsa-sha256; t=1521635967; cv=none;
        d=google.com; s=arc-20160816;
        b=aSMLmeMYdJ9aXTSZIxtj8e5reh4yCK8VhTaVNZYpqasIm4TSQ5N9Ty58eby0FLzXL2
         b5fL+0DK4WVgLVQZQTToImL7pYx3Gur2bhc5MNbeYqEBJ2f/MUA8kdu8YfwIhmZuxCcZ
         ZdEEvxesVP+JMSw/yjrKF/w6mgI47o61KG0TlrzYQx4gkSEUR9dxiEM7KAuVU0+xFjZg
         GmKFvogCo8KWY6kBuHPmWFSx0ugGjWs9FVX928mfJW1Z3rFD4sPa9tNBkt4oKbqE77qF
         FA6Mc2NJ4IM3JSM/G/kf+HIIYsZw7aRjpLz0P3RtmmXPC1gRrtD8gdBR+D//M3V915Wz
         UJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1q0R0iv4VaKynwK23Ou8w7NS+/MdjYN6ev2Ly57oo80=;
        b=qzksZUWyJnuE7yYP4DkHd9MwWhphTHcq4tP9+i3SrpwJR2JKLtMz39c0b6s3koEgW8
         BrIvnhXf/IxUcKMQ1h7H6u3V7myJ/GF/PWbWpDCEq+pBen9dzx136fnaeRquOGJB4oYL
         IKanmtBj57/7FwqmLZYGFiNvCQhtsTk8PFWEvNjzX/DaHzRV8MptGLecW6QZO/x0Cck0
         rJYBxCyBBSUGQf05IEXpRmcjMX7tKFY60nJs+7M9usqFyVTigy8lnxAOB/50Tg9PfNSQ
         hF6RD84rfECrUCpBeLdZ6uUGWufD04H4LHGYZ5rOIj4G0O2DhtHh/j2bnRMQ5dAm0DV7
         g5aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of patrick.bellasi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=patrick.bellasi@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of patrick.bellasi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=patrick.bellasi@arm.com
Date: Wed, 21 Mar 2018 12:39:21 +0000
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
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180321123921.GB13951@e110439-lin>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595550955946328774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20-Mar 09:43, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>

[...]

> +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long util, fdom_max_util;
> +	struct capacity_state *cs;
> +	unsigned long energy = 0;
> +	struct freq_domain *fdom;
> +	int cpu;
> +
> +	for_each_freq_domain(fdom) {
> +		fdom_max_util = 0;
> +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);

Would be nice to find a way to cache all these util and reuse them
below... even just to ensure data consistency between the "cs"
computation and its usage...

> +			fdom_max_util = max(util, fdom_max_util);
> +		}
> +
> +		/*
> +		 * Here we assume that the capacity states of CPUs belonging to
> +		 * the same frequency domains are shared. Hence, we look at the
> +		 * capacity state of the first CPU and re-use it for all.
> +		 */
> +		cpu = cpumask_first(&(fdom->span));
> +		cs = find_cap_state(cpu, fdom_max_util);
                ^^^^

The above code could theoretically return NULL, although likely EAS is
completely disabled if em->nb_cap_states == 0, right?

If that's the case then, in the previous function, you can certainly
avoid the initialization of *cs and maybe also add an explicit:

    BUG_ON(em->nb_cap_states == 0);

which helps even just as "in code documentation".

But, I'm not sure if maintainers like BUG_ON in scheduler code :)


> +
> +		/*
> +		 * The energy consumed by each CPU is derived from the power
                      ^

Should we make more explicit that this is just the "active" energy
consumed?

> +		 * it dissipates at the expected OPP and its percentage of
> +		 * busy time.
> +		 */
> +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			energy += cs->power * util / cs->cap;
> +		}
> +	}

nit-pick: empty line before return?

> +	return energy;
> +}
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> -- 
> 2.11.0
> 

-- 
#include <best/regards.h>

Patrick Bellasi
