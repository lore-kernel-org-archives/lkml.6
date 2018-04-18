Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx48iMv0EWALEK3n8ZIov395q8pCYmMEXwhxRfhA4RJv7xi66pOK4+r10WIA6ygb6g3Ee43Uh
ARC-Seal: i=1; a=rsa-sha256; t=1524050254; cv=none;
        d=google.com; s=arc-20160816;
        b=OWeS88ot2sns87IbDmtuAWTuyel5y1TYcrVmC/E8sPdspbyWUyPPBBHja9ZTtVXjDI
         mQTsQPJnOGHtlfX7ecLmrMADQFyb26gsAHSPwqUFGOXECrj/uI6ROMNZosvAvMtzFWle
         2z1ng4eytsEPA9AgL/wPS/XdROA3hU/5SYJLFMZTcxxbqH3GXHtNOcOvGa6DMjp6c2iU
         DAvu4mlTw0vWaMNLH88qMEOzXnl6H35JjkQceZA5FIB9fyCuTgObZSDIo4Gal+LG+3hZ
         uK7yZDhhtvY/yi45Fs4owdY9aiU5dAVeg1amhtGFmml2QQuyuI8DKENqqR8eEdsnjUXd
         +xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=s1fnOesbc3T0mExAykJmKNrFUq0Xfl/PFTrhkTyfR18=;
        b=bWY7Nf3QPaLcQEZ5vs0q8f0GPiB98m1NyBHO2yXKi1pplXZPa1RJAqAcD7flP/OXmm
         O53J5sBiYDTZqGaWzu0bYD0EFz1yATJ3AcUWB4QQFy63syuEDXYWklBHC90LEe+Hl9ou
         6finyhsyEIvVP0fxtJD50o48tSTrs4RutX6uIG+Nee/IMEHoZJilWLOmOFzPUumDdzMt
         /eY6qyr36i6q4y8Rur9LA8IJloRXnFRK7h8xdL2sxC+5dTpne/q8EKs57IFPAJEqPQsp
         q+YAOQAa4e8UkYR99poycVfBgh6FgV11sL0YpOVtixplcYpIah5njOGoH1iJ+yW/EdEF
         KEwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Wed, 18 Apr 2018 12:17:29 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180418111729.GB6783@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <CAJWu+oqxGkUKzmj6OokRHoQ=1B+618cnLL_SXrnXFOgX1GWdkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqxGkUKzmj6OokRHoQ=1B+618cnLL_SXrnXFOgX1GWdkA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011684825023112?=
X-GMAIL-MSGID: =?utf-8?q?1598082519860921604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday 13 Apr 2018 at 16:56:39 (-0700), Joel Fernandes wrote:
> Hi,
> 
> On Fri, Apr 6, 2018 at 8:36 AM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> >
> > Energy-aware scheduling should only operate when the system is not
> > overutilized. There must be cpu time available to place tasks based on
> > utilization in an energy-aware fashion, i.e. to pack tasks on
> > energy-efficient cpus without harming the overall throughput.
> >
> > In case the system operates above this tipping point the tasks have to
> > be placed based on task and cpu load in the classical way of spreading
> > tasks across as many cpus as possible.
> >
> > The point in which a system switches from being not overutilized to
> > being overutilized is called the tipping point.
> >
> > Such a tipping point indicator on a sched domain as the system
> > boundary is introduced here. As soon as one cpu of a sched domain is
> > overutilized the whole sched domain is declared overutilized as well.
> > A cpu becomes overutilized when its utilization is higher that 80%
> > (capacity_margin) of its capacity.
> >
> > The implementation takes advantage of the shared sched domain which is
> > shared across all per-cpu views of a sched domain level. The new
> > overutilized flag is placed in this shared sched domain.
> >
> > Load balancing is skipped in case the energy model is present and the
> > sched domain is not overutilized because under this condition the
> > predominantly load-per-capacity driven load-balancer should not
> > interfere with the energy-aware wakeup placement based on utilization.
> >
> > In case the total utilization of a sched domain is greater than the
> > total sched domain capacity the overutilized flag is set at the parent
> > sched domain level to let other sched groups help getting rid of the
> > overutilization of cpus.
> >
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  include/linux/sched/topology.h |  1 +
> >  kernel/sched/fair.c            | 62 ++++++++++++++++++++++++++++++++++++++++--
> >  kernel/sched/sched.h           |  1 +
> >  kernel/sched/topology.c        | 12 +++-----
> >  4 files changed, 65 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index 26347741ba50..dd001c232646 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -72,6 +72,7 @@ struct sched_domain_shared {
> >         atomic_t        ref;
> >         atomic_t        nr_busy_cpus;
> >         int             has_idle_cores;
> > +       int             overutilized;
> >  };
> >
> >  struct sched_domain {
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0a76ad2ef022..6960e5ef3c14 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5345,6 +5345,28 @@ static inline void hrtick_update(struct rq *rq)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_SMP
> > +static inline int cpu_overutilized(int cpu);
> > +
> > +static inline int sd_overutilized(struct sched_domain *sd)
> > +{
> > +       return READ_ONCE(sd->shared->overutilized);
> > +}
> > +
> > +static inline void update_overutilized_status(struct rq *rq)
> > +{
> > +       struct sched_domain *sd;
> > +
> > +       rcu_read_lock();
> > +       sd = rcu_dereference(rq->sd);
> > +       if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
> > +               WRITE_ONCE(sd->shared->overutilized, 1);
> > +       rcu_read_unlock();
> > +}
> > +#else
> > +static inline void update_overutilized_status(struct rq *rq) {}
> > +#endif /* CONFIG_SMP */
> > +
> >  /*
> >   * The enqueue_task method is called before nr_running is
> >   * increased. Here we update the fair scheduling stats and
> > @@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >                 update_cfs_group(se);
> >         }
> >
> > -       if (!se)
> > +       if (!se) {
> >                 add_nr_running(rq, 1);
> > +               update_overutilized_status(rq);
> > +       }
> 
> I'm wondering if it makes sense for considering scenarios whether
> other classes cause CPUs in the domain to go above the tipping point.
> Then in that case also, it makes sense to not to do EAS in that domain
> because of the overutilization.
> 
> I guess task_fits using cpu_util which is PELT only at the moment...
> so may require some other method like aggregation of CFS PELT, with
> RT-PELT and DL running bw or something.
>

So at the moment in cpu_overutilized() we comapre cpu_util() to
capacity_of() which should include RT and IRQ pressure IIRC. But
you're right, we might be able to do more here... Perhaps we
could also use cpu_util_dl() which is available in sched.h now ?
