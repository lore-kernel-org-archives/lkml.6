Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4/e0WIeRTZTkRxlcof3w4fPAQEszGZt5hTu5No52yj44Js9wrLM/foln6mgi5XLfj1wpnw5
ARC-Seal: i=1; a=rsa-sha256; t=1523267235; cv=none;
        d=google.com; s=arc-20160816;
        b=VDbOVfAkVTu2mgE6xS/0NEI+Gon6r3sQ1fhJ3xHbHjO/Ewz2GkXXoCA5sEd1OXbve1
         HNpSbfDeuNlTMSJgJfr9TvVDJFL09xJStFxjpF18bUMdo7736e6/QOePUB54vjs6T3Q0
         BkLPAqdhFKZ1DYR3zUjs0qHYWHESWAOX7h+XmgadyRfqvFToZOr5loHVa9O94Y1jjgn+
         zsAxAIQSHszbdBcPHvfJ4956bsTcYDWmmo0kKw4BrEm6SNs80C80B/yetAMI7Maz0hWu
         50SJ4CNejSM1mz+GrUyd0EYitfTr8avUckhNA/22skQKENkSIVTxcXQDGcwkAYp7W97i
         F24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=VMFDYTUk+pxvY0RuMw5ZPsyYLaVZMd4pJKh+9ndqy1s=;
        b=Ji6pFBrhATuO0KeUhWaMc0mCYyMNrQUPqptD7Kef43iDL+2014tERw+frgjrTnODRj
         i8rmd6wanuXf6eYzd8OZI+uBr2ckQd4o8hZwsQnDx1Kel5DFXc8sz73tutBQjuoXeCwO
         ViKwIT+6HHfBX/fmEuv0OqlF1Wu93eSgO7RPz8RGi5lnQCrj3R6vOS+JNkcz5nGe4Vj+
         40b8N2o1yWqCL2zSV+05hd6DO3AolIRN82/BzOOx0vPXj8TfHoVapu0gKTG0eot9N8Ni
         n96aeU8bIWino1y2uG1G2NbyEAVexkV6xkZaRBMlWeyqjQQPpU122K9D+xqQvpV6G0lL
         KsEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LIPMwnWW;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=LIPMwnWW;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 9 Apr 2018 11:47:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
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
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 3/6] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180409094710.GJ4129@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-4-dietmar.eggemann@arm.com>
 <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449336588138126?=
X-GMAIL-MSGID: =?utf-8?q?1597261464823001686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 11:40:01AM +0200, Peter Zijlstra wrote:
> 
> (I know there is a new version out; but I was reading through this to
> catch up with the discussion)
> 
> On Tue, Mar 20, 2018 at 09:43:09AM +0000, Dietmar Eggemann wrote:
> > +static inline int sd_overutilized(struct sched_domain *sd)
> > +{
> > +	return READ_ONCE(sd->shared->overutilized);
> > +}
> > +
> > +static inline void update_overutilized_status(struct rq *rq)
> > +{
> > +	struct sched_domain *sd;
> > +
> > +	rcu_read_lock();
> > +	sd = rcu_dereference(rq->sd);
> > +	if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
> > +		WRITE_ONCE(sd->shared->overutilized, 1);
> > +	rcu_read_unlock();
> > +}
> > +#else
> 
> I think you ought to go have a look at the end of
> kernel/sched/topology.c:sd_init(), where it says:
> 
> 	/*
> 	 * For all levels sharing cache; connect a sched_domain_shared
> 	 * instance.
> 	 */
> 	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> 		atomic_inc(&sd->shared->ref);
> 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> 	}
> 
> Because if I read all this correctly, your code assumes sd->shared
> exists unconditionally, while the quoted bit only ensures it does so <=
> LLC.

Argh, n/m, I should read the whole patch before commenting I suppose ;-)
