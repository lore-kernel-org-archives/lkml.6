Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4+10XixiWzQwjv/xtMQYBrCStlcp0TvLT2ZtDk/UeUKqAVoLvzbRSHBDlKFH5mg21KecwJ1
ARC-Seal: i=1; a=rsa-sha256; t=1523384091; cv=none;
        d=google.com; s=arc-20160816;
        b=BkYW0GSZZQEU7A09OV1mdA0ZfDtekRnRvr44bd8yivgE0i+/gmPoPfzO6s9/xAXIG3
         6aChbYTgtYST4qt2uBD2YITLpk0C4Ha1Y6pVuGUw5itw91pbWGWC5z/0qfxwNhKSOWiu
         IDJQSnfJMqooBRywEfSbJFDeovGWUw9bvjVqZwHB2gOawAXmykwIc8KUSl46r+3VGJv5
         zJ+Ylt6p97dTuEEqStL+Rob5ESSHXntz9QpqeP3LFuM45AlS+Y+vDvfM+M2kltwubcIB
         fMk2dXFlHFtdeZrV8hIisrKOgQaigCIKZN8tcU7HcuxaTMuYE2YUJR2CwUEdt3s9oPRs
         DwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WItcHhnO73E9uaui4Zhp0NFnluYWyeuLuk0/tMfNLB0=;
        b=RTemUhA+U1WrMHqp03ttrVvncDJxqbXjdYQX0x09jcGZhGEITo1eR7kInjoNg0926W
         a7pzPcDKR64AQlDASJXxxfNupJ0Y6Yek9dxlNBUOrdhqqd4RUa+2Y9aoq3RZEZClJHUR
         L6v+3XYaiH1yxCoCHwU5iGKApb3t4PfFhwoE3YY+jTdPJY+AeX6FDw2uQa5tJHXzxDIu
         v7G3pfNJd8NMCwRTsHjGkcUw5/e55lU3OH3Z/3XEWfIqw7S8wSTCyQjGYVLAzqNR5TIL
         XFVasGSSQWxg730SZyoRMAiEpnxXFae3acGvLu6vtVQ3VIkpDk0el/DL5W9sYiXXZZjs
         1raQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Tue, 10 Apr 2018 19:14:42 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20180410181442.GA9565@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
 <20180410172932.GD4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410172932.GD4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011691670503989?=
X-GMAIL-MSGID: =?utf-8?q?1597383997539567703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 10 Apr 2018 at 19:29:32 (+0200), Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
> > +	for_each_freq_domain(fd) {
> > +		unsigned long spare_cap, max_spare_cap = 0;
> > +		int max_spare_cap_cpu = -1;
> > +		unsigned long util;
> > +
> > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > +		for_each_cpu_and(cpu, freq_domain_span(fd), sched_domain_span(sd)) {
> > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > +				continue;
> > +
> > +			if (cpu == prev_cpu)
> > +				continue;
> > +
> > +			util = cpu_util_wake(cpu, p);
> > +			cpu_cap = capacity_of(cpu);
> > +			if (!util_fits_capacity(util + task_util, cpu_cap))
> > +				continue;
> > +
> > +			spare_cap = cpu_cap - util;
> > +			if (spare_cap > max_spare_cap) {
> > +				max_spare_cap = spare_cap;
> > +				max_spare_cap_cpu = cpu;
> > +			}
> > +		}
> > +
> > +		/* Evaluate the energy impact of using this CPU. */
> > +		if (max_spare_cap_cpu >= 0) {
> > +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> > +			if (cur_energy < best_energy) {
> > +				best_energy = cur_energy;
> > +				best_energy_cpu = max_spare_cap_cpu;
> > +			}
> > +		}
> > +	}
> 
> If each CPU has its own frequency domain, then the above loop ends up
> being O(n^2), no?

Hmmm, yes, that should be O(n^2) indeed.

> Is there really nothing we can do about that?

So, the only thing I see just now would be to make compute_energy()
smarter somehow. Today we compute the energy consumed by each frequency
domain and then sum them up to get the system energy. We re-compute the
energy of each frequency domain, even when it is not involved in the
migration. In the case you describe, we will end up re-computing the
energy of many frequency domains on which nothing happens every time
we re-call compute_energy(). So there is probably something we could do
by caching those values somehow.

Otherwise, on systems with 2 frequency domains (e.g. big.LITTLE), the
current code should behave relatively well. And I think that covers a
large portion of the real-world systems for which EAS is useful, as of
today at least ... :-)

> Also, I
> feel that warrants a comment warning about this.
> 
> Someone, somewhere will try and build a 64+64 cpu system and get
> surprised it doesn't work :-)
