Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524211989; cv=none;
        d=google.com; s=arc-20160816;
        b=nOdpzotJrlJ68FpFdQhBLoSRZE5kbQUOc8nwYFD/UAkGJ8/qfAt6MnTfiHEeTZQeee
         sw+qeLODtTrHu+eXSffoFIlxNK/xaNlajnGzHlZe3tepHJbpZ7KklkUE/SZkd6LgU4bu
         JCTn//75xTwtx1JaNjF0XeU0N8J8StO/WP8yBy51ELmYuTmmwYrgsi8PdR/dUaPM1ZU5
         RDW6a9AVQmF4puqtpvyrLwSAoRMQBAaqOX0bf8+842/vIt/yA/c2bUBPIVR7Kj62TSnx
         r9khH0ZOc5ECouYHf1qEbmFPX+3Ql1oxKXOAbsMZJp/bio26Ga2vOc+J/kCKHUqBToaQ
         60+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vPLy8iVB/OPyzmMzGfA4lufNaNT4dXvQx1Uoj5aTSgk=;
        b=1Jhk44U5lwj7i9yNrvQ+F+CRP0scOP+X8/l4rLSlPkTKhJq49kATgHP5Al3dSKV0Un
         CcUwXxRl02oIUFPeG8Nt4cEq6rxjTAhMMINyB1bHfSRaMbi7onzHe8pfxpr1fKJnaixM
         Kr1KUE7qSwdVs6+VliZfMRFtUnmy4pdffhR8CjpGuCGEqse1HSg/Zz8+9PyZ/ehrO/ID
         aBDZUhYnhPgtllpA98u+5b62Qp6EcJegXKDQUUfGHOjbNs3whfLkyHah7VBdIAXaW1rr
         wnNaR/gqKYJrftLN2Cl73SLzLV727r0Rd88l5bB82Tb1/veYsK2zkkrIRS9MppdtlbYJ
         88fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=U40TyM2G;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=U40TyM2G;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/wF28K4mZMt7zX+8osYwHCJIihAIw3GwD2nE7V3T69VS3MkE8yE0ByGmN0IPyo38co2ZArIT7/WRE+pCW++NA=
MIME-Version: 1.0
In-Reply-To: <20180418111729.GB6783@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com> <CAJWu+oqxGkUKzmj6OokRHoQ=1B+618cnLL_SXrnXFOgX1GWdkA@mail.gmail.com>
 <20180418111729.GB6783@e108498-lin.cambridge.arm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 20 Apr 2018 01:13:07 -0700
Message-ID: <CAJWu+opgqZ9DJtZtxzsum+d-CsCqvm2FOtaLAHuDv-mcD74Qew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point indicator
To: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
	Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011684825023112?=
X-GMAIL-MSGID: =?utf-8?q?1598252111033600076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 4:17 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Friday 13 Apr 2018 at 16:56:39 (-0700), Joel Fernandes wrote:
>> Hi,
>>
>> On Fri, Apr 6, 2018 at 8:36 AM, Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>> > From: Thara Gopinath <thara.gopinath@linaro.org>
>> >
>> > Energy-aware scheduling should only operate when the system is not
>> > overutilized. There must be cpu time available to place tasks based on
>> > utilization in an energy-aware fashion, i.e. to pack tasks on
>> > energy-efficient cpus without harming the overall throughput.
>> >
>> > In case the system operates above this tipping point the tasks have to
>> > be placed based on task and cpu load in the classical way of spreading
>> > tasks across as many cpus as possible.
>> >
>> > The point in which a system switches from being not overutilized to
>> > being overutilized is called the tipping point.
>> >
>> > Such a tipping point indicator on a sched domain as the system
>> > boundary is introduced here. As soon as one cpu of a sched domain is
>> > overutilized the whole sched domain is declared overutilized as well.
>> > A cpu becomes overutilized when its utilization is higher that 80%
>> > (capacity_margin) of its capacity.
>> >
>> > The implementation takes advantage of the shared sched domain which is
>> > shared across all per-cpu views of a sched domain level. The new
>> > overutilized flag is placed in this shared sched domain.
>> >
>> > Load balancing is skipped in case the energy model is present and the
>> > sched domain is not overutilized because under this condition the
>> > predominantly load-per-capacity driven load-balancer should not
>> > interfere with the energy-aware wakeup placement based on utilization.
>> >
>> > In case the total utilization of a sched domain is greater than the
>> > total sched domain capacity the overutilized flag is set at the parent
>> > sched domain level to let other sched groups help getting rid of the
>> > overutilization of cpus.
>> >
>> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > ---
>> >  include/linux/sched/topology.h |  1 +
>> >  kernel/sched/fair.c            | 62 ++++++++++++++++++++++++++++++++++++++++--
>> >  kernel/sched/sched.h           |  1 +
>> >  kernel/sched/topology.c        | 12 +++-----
>> >  4 files changed, 65 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> > index 26347741ba50..dd001c232646 100644
>> > --- a/include/linux/sched/topology.h
>> > +++ b/include/linux/sched/topology.h
>> > @@ -72,6 +72,7 @@ struct sched_domain_shared {
>> >         atomic_t        ref;
>> >         atomic_t        nr_busy_cpus;
>> >         int             has_idle_cores;
>> > +       int             overutilized;
>> >  };
>> >
>> >  struct sched_domain {
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 0a76ad2ef022..6960e5ef3c14 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -5345,6 +5345,28 @@ static inline void hrtick_update(struct rq *rq)
>> >  }
>> >  #endif
>> >
>> > +#ifdef CONFIG_SMP
>> > +static inline int cpu_overutilized(int cpu);
>> > +
>> > +static inline int sd_overutilized(struct sched_domain *sd)
>> > +{
>> > +       return READ_ONCE(sd->shared->overutilized);
>> > +}
>> > +
>> > +static inline void update_overutilized_status(struct rq *rq)
>> > +{
>> > +       struct sched_domain *sd;
>> > +
>> > +       rcu_read_lock();
>> > +       sd = rcu_dereference(rq->sd);
>> > +       if (sd && !sd_overutilized(sd) && cpu_overutilized(rq->cpu))
>> > +               WRITE_ONCE(sd->shared->overutilized, 1);
>> > +       rcu_read_unlock();
>> > +}
>> > +#else
>> > +static inline void update_overutilized_status(struct rq *rq) {}
>> > +#endif /* CONFIG_SMP */
>> > +
>> >  /*
>> >   * The enqueue_task method is called before nr_running is
>> >   * increased. Here we update the fair scheduling stats and
>> > @@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>> >                 update_cfs_group(se);
>> >         }
>> >
>> > -       if (!se)
>> > +       if (!se) {
>> >                 add_nr_running(rq, 1);
>> > +               update_overutilized_status(rq);
>> > +       }
>>
>> I'm wondering if it makes sense for considering scenarios whether
>> other classes cause CPUs in the domain to go above the tipping point.
>> Then in that case also, it makes sense to not to do EAS in that domain
>> because of the overutilization.
>>
>> I guess task_fits using cpu_util which is PELT only at the moment...
>> so may require some other method like aggregation of CFS PELT, with
>> RT-PELT and DL running bw or something.
>>
>
> So at the moment in cpu_overutilized() we comapre cpu_util() to
> capacity_of() which should include RT and IRQ pressure IIRC. But
> you're right, we might be able to do more here... Perhaps we
> could also use cpu_util_dl() which is available in sched.h now ?

Yes, should be Ok, and then when RT utilization stuff is available,
then that can be included in the equation as well (probably for now
you could use rt_avg).

Another crazy idea is to check the contribution of higher classes in
one-shot with (capacity_orig_of - capacity_of) although I think that
method would be less instantaneous/accurate.

thanks,

- Joel
