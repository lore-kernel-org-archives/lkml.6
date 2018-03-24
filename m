Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521851775; cv=none;
        d=google.com; s=arc-20160816;
        b=nw72N8zW6SINH77YgY8MrcDm8Nhr3+ab4G2zmlQ+gBQPLqTZSx8enPbwOO347qUt3L
         FTGxBZfMVLN8sDilztzJgHB4TpZtuJ8kkNKoXK0cWYPP0XfeB9HRTb5C4IbPF0btniwL
         upf8O8oWvzt7SNMl9EWp9mHY2GN2fXlKQWO1gSoh2vnJpiH5vG+CuVu8HUw0Hs9W1EWS
         ksD/I2iBhd1dkG2C0A10iqddGQqG9ne/nMTSfJt4DfObg4gq7loW6hKnkNca+d8Fwd5a
         7KD1YGXhOg8rg3Dd+S2zNHW5VAkMEoEvyhKZgaCGGXGPYC4q9ExlPltRZ4q56QTOcS3p
         HtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6RLDRWSS2Rr6ebE7p49TSN382UORnY5SJ5mCV/HiBpk=;
        b=wOkxVPAI1HvPmKocBa4cwj4oNiqhXBGbJkECZY3F3Wu2X1ewf6+Ulgq1kRPi6mDMn9
         EzAiFgtIbCXZXEU3awbvwL1X2dsOXA6k5711mNBsN8TgnzJgtbyeo7vOteR+Ih7bCoFA
         dO8zeVe7ioYsyYY6I3ZNosqcFNc63bswbTk2GCmN4qb5uTzKhM6bsNdfjJb6/uVanVgi
         9xPcoY5YI9QtVkHu0VbhCHffX0QN0qER3Mq78J8YE9ZoiZjh1/+q8D/q93JK0Z/23r0s
         /ZARUCbcf1MaoPYDdSkpocZTovw/oTZAs5Hdz6XT1NgAcX8QkoLsc2Dl72a3E3lOtqWU
         iKrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TusWDv88;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TusWDv88;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtFiHawlZSXjVxZM4LrlLcBx5EqWYPKNUKQ+VKRZ2F4mG8YRPzJfBQ5lFf0+pEwxTO8k1JwiHKCidiKHcOIvJ8=
MIME-Version: 1.0
In-Reply-To: <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com> <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
 <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 23 Mar 2018 17:36:13 -0700
Message-ID: <CAJWu+oo1J_0z3m84J6aZkOuvuR9mcy5jm+7HjZCzonT-oyrK4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
	Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595777247417872611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 9:00 AM, Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
> On Thu, Mar 22, 2018 at 09:27:43AM -0700, Joel Fernandes wrote:
>> >
>> > In case an energy model is available, waking tasks are re-routed into a
>> > new energy-aware placement algorithm. The eligible CPUs to be used in the
>> > energy-aware wakeup path are restricted to the highest non-overutilized
>> > sched_domain containing prev_cpu and this_cpu. If no such domain is found,
>> > the tasks go through the usual wake-up path, hence energy-aware placement
>> > happens only in lightly utilized scenarios.
>> >
>> > The selection of the most energy-efficient CPU for a task is achieved by
>> > estimating the impact on system-level active energy resulting from the
>> > placement of the task on each candidate CPU. The best CPU energy-wise is
>> > then selected if it saves a large enough amount of energy with respect to
>> > prev_cpu.
>> >
>> > Although it has already shown significant benefits on some existing
>> > targets, this brute force approach clearly cannot scale to platforms with
>> > numerous CPUs. This patch is an attempt to do something useful as writing
>> > a fast heuristic that performs reasonably well on a broad spectrum of
>> > architectures isn't an easy task. As a consequence, the scope of usability
>> > of the energy-aware wake-up path is restricted to systems with the
>> > SD_ASYM_CPUCAPACITY flag set. These systems not only show the most
>> > promising opportunities for saving energy but also typically feature a
>> > limited number of logical CPUs.
>> >
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > ---
>> >  kernel/sched/fair.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>> >  1 file changed, 71 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 76bd46502486..65a1bead0773 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
>> >         return energy;
>> >  }
>> >
>> > +static bool task_fits(struct task_struct *p, int cpu)
>> > +{
>> > +       unsigned long next_util = cpu_util_next(cpu, p, cpu);
>> > +
>> > +       return util_fits_capacity(next_util, capacity_orig_of(cpu));
>> > +}
>> > +
>> > +static int find_energy_efficient_cpu(struct sched_domain *sd,
>> > +                                       struct task_struct *p, int prev_cpu)
>> > +{
>> > +       unsigned long cur_energy, prev_energy, best_energy;
>> > +       int cpu, best_cpu = prev_cpu;
>> > +
>> > +       if (!task_util(p))
>> > +               return prev_cpu;
>> > +
>> > +       /* Compute the energy impact of leaving the task on prev_cpu. */
>> > +       prev_energy = best_energy = compute_energy(p, prev_cpu);
>>
>> Is it possible that before the wakeup, the task's affinity is changed
>> so that p->cpus_allowed no longer contains prev_cpu ? In that case
>> prev_energy wouldn't matter since previous CPU is no longer an option?
>
> It is possible to wake-up with a disallowed prev_cpu. In fact
> select_idle_sibling() may happily return a disallowed cpu in that case.
> The mistake gets fixed in select_task_rq() which uses
> select_fallback_rq() to find an allowed cpu instead.
>
> Could we fix the issue in find_energy_efficient_cpu() by a simple test
> like below
>
> if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
>         prev_energy = best_energy = compute_energy(p, prev_cpu);
> else
>         prev_energy = best_energy = ULONG_MAX;

Yes, I think setting to ULONG_MAX in this case is Ok with me.

thanks,

- Joel
