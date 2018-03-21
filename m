Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AG47ELsA8D/1rq32ZsW9/SROM34vkhEFOUkBQYKy47sNNwa5R0jg3QCVcbdRV8BhKGHSvp1B7aeR
ARC-Seal: i=1; a=rsa-sha256; t=1521642400; cv=none;
        d=google.com; s=arc-20160816;
        b=B0Q9/YR9uUMGect6UdpPxl6rw1Rpue0cfFRmGoiRkvs+mUjX7Pl17vEguqecio7lfo
         3GDCUGa3jqIJLNQeCTPh/Ns+He2OowSuXP/aNbcmF/BxJIHfmOL3rL6YLcIrPV83x9iT
         e2TA91N6rsL+aE11hnt1LAW82uGcmzIZ/zSwKvX+h0N4Dq5oZful0OGkgPr/5i98ntg9
         cR2RQAPDLqzCKtggfrgzhzZXkXXcoGvrkuw6ZVAqN1iYCIvTViOWMS+6cjQFID7m0vML
         PRzBIc88nljJGDRfo43xKt+VGVOLFjwZYlNEje3DyDKpgd7NIuN43fX8BcQ6+rUMdKAj
         WhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=QdzJxFfjMRqkyQKjx5cAfOmNMlqcLQGci+wyPCYASh0=;
        b=IUzRgAOwntCcD0PrC2PkCMy+dRjHXM4c4I9W3W18i0+vPYh4Ae/F3OeIAKeurKp7+6
         lJhAbEWCiX66ugqslAFkmYejf4BCJtZPJC/2NIeD6RpXyyU4lawOg3YZUZYIBtQ0K4m0
         ihwjVpXcx9Styg5+vNctTizUzrCQHiiKnBwZ28BCCujkBOWrOcXK6q9NtcnUT8tRVoNc
         oHAKHE+tXXls2ur8tkffBE+IR6YVk49/AqEzXMNoMdL0FF83/rjKcLQuPXTgnLa7W7rh
         LAzRwMGedbr1MkjsuHO+9c/ERPun+Q0RcM7WdUasa0P8+H0T995ZGkbzM9lhbdSNuqaB
         DiHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Wed, 21 Mar 2018 14:26:32 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180321142630.GB2168@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321123921.GB13951@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321123921.GB13951@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595557700981068154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday 21 Mar 2018 at 12:39:21 (+0000), Patrick Bellasi wrote:
> On 20-Mar 09:43, Dietmar Eggemann wrote:
> > From: Quentin Perret <quentin.perret@arm.com>
> 
> [...]
> 
> > +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> > +{
> > +	unsigned long util, fdom_max_util;
> > +	struct capacity_state *cs;
> > +	unsigned long energy = 0;
> > +	struct freq_domain *fdom;
> > +	int cpu;
> > +
> > +	for_each_freq_domain(fdom) {
> > +		fdom_max_util = 0;
> > +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> 
> Would be nice to find a way to cache all these util and reuse them
> below... even just to ensure data consistency between the "cs"
> computation and its usage...

So actually, what I can do is add something like

    fdom_tot_util += util;

to this loop and compute

    energy = cs->power * fdom_tot_util / cs->cap;

only once, instead of having the second loop to compute the energy. We don't
have to scale the util for each and every CPU since they share the same
cap state. That would save some divisions and ensure the consistency
between the selection of the cap state and the associated energy
computation. What do you think ?

Or maybe you were talking about consistency between several consecutive
calls to compute_energy() ?

> 
> > +			fdom_max_util = max(util, fdom_max_util);
> > +		}
> > +
> > +		/*
> > +		 * Here we assume that the capacity states of CPUs belonging to
> > +		 * the same frequency domains are shared. Hence, we look at the
> > +		 * capacity state of the first CPU and re-use it for all.
> > +		 */
> > +		cpu = cpumask_first(&(fdom->span));
> > +		cs = find_cap_state(cpu, fdom_max_util);
>                 ^^^^
> 
> The above code could theoretically return NULL, although likely EAS is
> completely disabled if em->nb_cap_states == 0, right?

That's right. sched_energy_present cannot be enabled with
em->nb_cap_states == 0, and compute_energy() is never called without
sched_energy_present in the proposed implementation.

> 
> If that's the case then, in the previous function, you can certainly
> avoid the initialization of *cs and maybe also add an explicit:
> 
>     BUG_ON(em->nb_cap_states == 0);
> 
> which helps even just as "in code documentation".
> 
> But, I'm not sure if maintainers like BUG_ON in scheduler code :)

Yes, I'm not sure about the BUG_ON either :). I agree that it would be
nice to document somewhere that compute_energy() is unsafe to call
without sched_energy_present. I can simply add a proper doc comment to
this function actually. Would that work ?

> 
> 
> > +
> > +		/*
> > +		 * The energy consumed by each CPU is derived from the power
>                       ^
> 
> Should we make more explicit that this is just the "active" energy
> consumed?

Ok, np.

> 
> > +		 * it dissipates at the expected OPP and its percentage of
> > +		 * busy time.
> > +		 */
> > +		for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> > +			energy += cs->power * util / cs->cap;
> > +		}
> > +	}
> 
> nit-pick: empty line before return?

Will do.

> 
> > +	return energy;
> > +}
> > +
> >  /*
> >   * select_task_rq_fair: Select target runqueue for the waking task in domains
> >   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> > -- 
> > 2.11.0
> > 
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi

Thanks,
Quentin
