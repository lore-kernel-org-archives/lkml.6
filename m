Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx481hGSYKQX1y4R3NfEEVZD3W/nnSktY9DCbBq3kZt3DIqcbo1yvUToJ68fymMyTEQvo3y3k
ARC-Seal: i=1; a=rsa-sha256; t=1521640565; cv=none;
        d=google.com; s=arc-20160816;
        b=yniE303N4tdavprtXWxMSvItOyvpWEKJz409JfCj0mvKQraoUSjNiVEYJWtrfFLnkI
         UKgUYiVaOFf2E/4yq8Mu0KuV5HZbVS3K4Ce68HlIBr0QJt5yymxnmXJ1+yAIyBH1AaVP
         bnx/MRGq4Wqc29Upt99wIMTVkkENvly3fzUnqIRrCY6selhADmU5fU4j+124fluPCHAR
         t8d0vmn+awipBah9RcS0TghDswRUu1zsoSKK8+/CkHAnpq23lDzXP6M5uot+thQVg82n
         UbbTi9a2GWYzxBOiOt7xnQpMbpgL8mIMH+nmCyjoPpwMVdlSMgSXX1Nv0c+EwekKC+v2
         ZvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5W2kQ6gKL3H5WyTTvmSI7eIV1Wb+FgZg191HZ5djFFs=;
        b=p01mc+VFRFcFuLFdIvbdBw0D2bhwXk/KbNVluzYN4H5V9z+186K6r4bghsER8l2gbz
         aGX2Y3udhhU5DnRUOTxcShzhVgL0Ttx9qhz0E5YrIRsE+fgY5usQva8C2gd87pRxvePo
         qDQuy/Apo0vJxp4aU/LKB4TKNZgP0002pPvk1VZ4JNqINZtcFgMoFFvAS1HUpQ6zCmyX
         +poXm03XhCRmJen0K1vawp/zNKavQzMQsTXZVmND5BhDeBrtaiXvsxCUZio+A1R2mhtX
         mitbUPj/gOCJtS2rsdZte7GakZDmMa9Qd51B7ocrkJwZpCMtUh7w1nKk6f6NMIWo6zKz
         KKtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Wed, 21 Mar 2018 13:55:58 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <20180321135557.GB1373@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
 <20180321125925.GB15165@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321125925.GB15165@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595555777228112991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday 21 Mar 2018 at 13:59:25 (+0100), Juri Lelli wrote:
> On 21/03/18 12:26, Patrick Bellasi wrote:
> > On 21-Mar 10:04, Juri Lelli wrote:
> > > Hi,
> > > 
> > > On 20/03/18 09:43, Dietmar Eggemann wrote:
> > > > From: Quentin Perret <quentin.perret@arm.com>
> > > > 
> > > > In preparation for the definition of an energy-aware wakeup path, a
> > > > helper function is provided to estimate the consequence on system energy
> > > > when a specific task wakes-up on a specific CPU. compute_energy()
> > > > estimates the OPPs to be reached by all frequency domains and estimates
> > > > the consumption of each online CPU according to its energy model and its
> > > > percentage of busy time.
> > > > 
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > ---
> > > >  kernel/sched/fair.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 81 insertions(+)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 6c72a5e7b1b0..76bd46502486 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -6409,6 +6409,30 @@ static inline int cpu_overutilized(int cpu)
> > > >  }
> > > >  
> > > >  /*
> > > > + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> > > > + */
> > > > +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> > > > +{
> > > > +	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
> > > 
> > > What about other classes? Shouldn't we now also take into account
> > > DEADLINE (as schedutil does)?
> > 
> > Good point, although that would likely require to factor out from
> > schedutil the utilization aggregation function, isn't it?
> 
> Maybe, or simply use getter methods and aggregate again here.

I agree with you both, taking DL into account here is most likely the
right thing to do. Thinking about this, there are other places in those
patches where we should really use capacity_of() instead of
capacity_orig_of() (in task_fits() in patch 5/6 for ex) in order to
avoid CPUs under heavy RT pressure. I'll try to improve the integration
with other scheduling classes in v2.

> 
> > 
> > > BTW, we now also have a getter method in sched/sched.h; it takes
> > > UTIL_EST into account, though. Do we need to take that into account when
> > > estimating energy consumption?

Yes, I think that using UTIL_EST makes a lot of sense for energy
calculation. This is what is used for frequency selection (with
schedutil obviously) and this is also our best guess on how much time
a task will spend on a CPU. V2 will be rebased on the latest
tip/sched/core and I'll make sure to integrate things better with
util_est.

> > 
> > Actually I think that this whole function can be written "just" as:
> > 
> > ---8<---
> >    unsigned long util = cpu_util_wake(cpu);
> > 
> >    if (cpu != dst_cpu)
> >         return util;
> > 
> >    return min(util + task_util(p), capacity_orig_of(cpu));
> > ---8<---
> > 
> > which will reuse existing functions as well as getting for free other
> > stuff (like the CPU util_est).
> > 
> > Considering your observation above, it makes also easy to add into
> > util the DEADLINE and RT utilizations, just before returning the
> > value.
> 
> Well, for RT we should problably consider the fact that schedutil is
> going to select max OPP...

Right, but I need to think about the right place to put that, and how to
compute the energy accurately in this case. Some modification might also
be required in find_cap_state() (patch 5/6).

> 
> Apart from that I guess it could work like you said.
> 
> > 
> > > > +	unsigned long capacity = capacity_orig_of(cpu);
> > > > +
> > > > +	/*
> > > > +	 * If p is where it should be, or if it has no impact on cpu, there is
> > > > +	 * not much to do.
> > > > +	 */
> > > > +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> > > > +		goto clamp_util;
> > > > +
> > > > +	if (dst_cpu == cpu)
> > > > +		util += task_util(p);
> > > > +	else
> > > > +		util = max_t(long, util - task_util(p), 0);
> > > > +
> > > > +clamp_util:
> > > > +	return (util >= capacity) ? capacity : util;
> > > > +}
> > > > +
> > > > +/*
> > > >   * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
> > > >   * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
> > > >   *
> > > > @@ -6432,6 +6456,63 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
> > > >  	return !util_fits_capacity(task_util(p), min_cap);
> > > >  }
> > > >  
> > > > +static struct capacity_state *find_cap_state(int cpu, unsigned long util)
> > > > +{
> > > > +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> > > > +	struct capacity_state *cs = NULL;
> > > > +	int i;
> > > > +
> > > > +	/*
> > > > +	 * As the goal is to estimate the OPP reached for a specific util
> > > > +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> > > > +	 */
> > > > +	util += util >> 2;
> > > 
> > > What about other governors (ondemand for example). Is this supposed to
> > > work only when schedutil is in use (if so we should probably make it
> > > conditional on that)?
> > 
> > Yes, I would say that EAS mostly makes sense when you have a "minimum"
> > control on OPPs... otherwise all the energy estimations are really
> > fuzzy.
> 
> Make sense to me. Shouldn't we then make all this conditional on using
> schedutil?

So, in theory, EAS could make sense even for other governors than
schedutil. Even with the performance governor it is probably more
energy efficient (although users using "performance" probably don't care
about energy, but that's just an example) to place small tasks onto little
CPUs up to a certain point given by the energy model. The ideal solution
would be to change the behaviour of find_cap_state() depending on the
governor being used, but I don't know if this extra complexity is worth
it really.
I'm happy to make all this conditional on schedutil as a first step and
we can see later if that makes sense to extend EAS to other use-cases.

> 
> > 
> > > Also, even when schedutil is in use, shouldn't we ask it for a util
> > > "computation" instead of replicating its _current_ heuristic?
> > 
> > Are you proposing to have the 1.25 factor only here and remove it from
> > schedutil?
> 
> I'm only saying that we shouldn't probably have two places where we add
> this 1.25 factor to utilization before using it, as in the future one of
> the two might modify that 1.25 to something else and then we'll have
> problems. So, maybe a common wrapper that adds such factor?

Ok, I can definitely factorize this code between schedutil and EAS. And
BTW, would it make sense to make schedutil use "capacity_margin" instead
of an arbitrary value ? The semantics feels pretty close. Out of curiosity,
what was the reason to use C=1.25 in the first place ?

> 
> > 
> > > I fear  the two might diverge in the future.
> > 
> > That could be avoided by factoring out from schedutil the
> > "compensation" factor into a proper function to be used by all the
> > interested playes, isn't it?
> 
> And I should have read till the end before writing the above paragraph
> it seems. :)
> 
> Thanks,
> 
> - Juri

Thank you very much for the feedback !
