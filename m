Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELsFwAsFmdwMZKR9J42422DYokaPPa3fI56cXeCq6KdpAQ8YYBhvBoy7hlH92HAWcwE78Qac
ARC-Seal: i=1; a=rsa-sha256; t=1521820865; cv=none;
        d=google.com; s=arc-20160816;
        b=qaNrcIwuYZV0zFoD6ip+i96WNUltocJsz5GuEWgTCI9mWeFt7k/BChMTN+HTvmSk80
         TIGPT/R7RistgD3Zgw1uOvVrsa2OFvg4HO4FpxY0Yj1pnIHADWJqDJPo6SAnf3o4YRcm
         Re6YmxDJXFkOxsPJodYuRvqA8DOfK4vSRjll4eXUHoOGPOb4T4lkjQx3hC4nHO4dd22T
         Qj+mR2AtTQiCdyhPFlprKMVRo8udd9yRIQ50rYpR8cF5bkVLRImisLShrFF8cY6YePN5
         j/CKJqh+vfP1+vxVwRMtrUX+5aBv4Fm9VubOaDmoIJiTUMRMgOaK1tVPCQ+atrezgpsf
         EhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HCccpEIg9wQtGcsSfvckXSpvZHp+VkDXuzraV+HadfQ=;
        b=0dNqiu+ivM2X/3GTmSQfnbGUv0A65oAcVFMKg9a+SjxdOzKFsWE93o1ejIaX0ZLzsi
         Y6eAqbcXC9ssbvFDEY5eMC3pPIbVU6/oOh1fk3t1sk/m5yflqc0khf3D9h+S/2skR2KO
         DXuR5bUJhD5G6MQPYi/nbEhlaAHMnkG3mYY/QYaGGk301HJUoqcqwcIIesHxcLxsWufE
         eDtIGoNv19M98VDIilmihdLx897iyBEKlhm2d4FGBuJa6egcGXJ0ytN9oMmwtjL6dPLB
         k4WVMF7HzweA5tqW5AjCgallJjLyJNh1bu/lo4qhw966W6XTaHWG1ddvZFkBXrTPBJoQ
         o8Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Fri, 23 Mar 2018 16:00:59 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595744835666555071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 09:27:43AM -0700, Joel Fernandes wrote:
> Hi,
> 
> On Tue, Mar 20, 2018 at 2:43 AM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > From: Quentin Perret <quentin.perret@arm.com>
> >
> > In case an energy model is available, waking tasks are re-routed into a
> > new energy-aware placement algorithm. The eligible CPUs to be used in the
> > energy-aware wakeup path are restricted to the highest non-overutilized
> > sched_domain containing prev_cpu and this_cpu. If no such domain is found,
> > the tasks go through the usual wake-up path, hence energy-aware placement
> > happens only in lightly utilized scenarios.
> >
> > The selection of the most energy-efficient CPU for a task is achieved by
> > estimating the impact on system-level active energy resulting from the
> > placement of the task on each candidate CPU. The best CPU energy-wise is
> > then selected if it saves a large enough amount of energy with respect to
> > prev_cpu.
> >
> > Although it has already shown significant benefits on some existing
> > targets, this brute force approach clearly cannot scale to platforms with
> > numerous CPUs. This patch is an attempt to do something useful as writing
> > a fast heuristic that performs reasonably well on a broad spectrum of
> > architectures isn't an easy task. As a consequence, the scope of usability
> > of the energy-aware wake-up path is restricted to systems with the
> > SD_ASYM_CPUCAPACITY flag set. These systems not only show the most
> > promising opportunities for saving energy but also typically feature a
> > limited number of logical CPUs.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  kernel/sched/fair.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 71 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 76bd46502486..65a1bead0773 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> >         return energy;
> >  }
> >
> > +static bool task_fits(struct task_struct *p, int cpu)
> > +{
> > +       unsigned long next_util = cpu_util_next(cpu, p, cpu);
> > +
> > +       return util_fits_capacity(next_util, capacity_orig_of(cpu));
> > +}
> > +
> > +static int find_energy_efficient_cpu(struct sched_domain *sd,
> > +                                       struct task_struct *p, int prev_cpu)
> > +{
> > +       unsigned long cur_energy, prev_energy, best_energy;
> > +       int cpu, best_cpu = prev_cpu;
> > +
> > +       if (!task_util(p))
> > +               return prev_cpu;
> > +
> > +       /* Compute the energy impact of leaving the task on prev_cpu. */
> > +       prev_energy = best_energy = compute_energy(p, prev_cpu);
> 
> Is it possible that before the wakeup, the task's affinity is changed
> so that p->cpus_allowed no longer contains prev_cpu ? In that case
> prev_energy wouldn't matter since previous CPU is no longer an option?

It is possible to wake-up with a disallowed prev_cpu. In fact
select_idle_sibling() may happily return a disallowed cpu in that case.
The mistake gets fixed in select_task_rq() which uses
select_fallback_rq() to find an allowed cpu instead.

Could we fix the issue in find_energy_efficient_cpu() by a simple test
like below

if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
	prev_energy = best_energy = compute_energy(p, prev_cpu);
else
	prev_energy = best_energy = ULONG_MAX;
