Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeBLQG4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:06:56 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41326 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeBLQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:06:54 -0500
X-Google-Smtp-Source: AH8x226Qj/Jjptq3zekA6HHbXdmELE2RqwpfQB9UcLEU9+SppAMoHWPFXjLFmpaII2mwY9NWv9bDor/PyJ8BIL8MgxQ=
MIME-Version: 1.0
In-Reply-To: <20180212153805.GW25201@hirez.programming.kicks-ass.net>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-4-git-send-email-vincent.guittot@linaro.org>
 <20180212120411.GT25201@hirez.programming.kicks-ass.net> <20180212143444.GA12378@linaro.org>
 <20180212153805.GW25201@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Feb 2018 17:06:32 +0100
Message-ID: <CAKfTPtAXk=U2aNnnhFQHmRkCXZ_-uoW1n2CuCP4MD7YK1cOGmg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] sched: update blocked load when newly idle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1CG72cB021908

On 12 February 2018 at 16:38, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 12, 2018 at 03:34:44PM +0100, Vincent Guittot wrote:
>> Le Monday 12 Feb 2018 à 13:04:11 (+0100), Peter Zijlstra a écrit :
>> > On Mon, Feb 12, 2018 at 09:07:54AM +0100, Vincent Guittot wrote:
>
>> > So I really hate this one, also I suspect its broken, because we do this
>> > check before dropping rq->lock and _nohz_idle_balance() will take
>> > rq->lock.
>>
>> yes. it will take both newly idle rq and idle rq lock
>
> Right, can't do that, there's ordering rules for multiple RQ locks etc..
>
>>
>> >
>> >
>> > Aside from the above being an unreadable mess, I dislike that it breaks
>> > the various isolation crud, we should not touch CPUs outside of our
>> > domain.
>> >
>> >
>> > Maybe something like the below? (unfinished)
>> >
>>
>> good catch. I completely miss the isolation stuff.
>> But isn't already the case when kicking ilb ? I mean that an idle CPU touches
>> all idle CPUs and some can be outside its domain during ilb.
>
>> Shouldn't we test housekeeping_cpu(cpu, HK_FLAG_SCHED) instead if we want to
>> make sure that an isolated/full nohz CPU will not be used for updating blocked
>> load of CPUs outside its domain ?
>
> I _thought_ we had some 'housekeeping' crud in the ilb selection logic,
> but now I can't find it. Frederic?
>
>> Is something below more readable:
>>
>>               /*
>> +              * This CPU doesn't want to be disturbed by scheduler
>> +              * houskeeping
>>                */
>> +             if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
>> +                     goto out;
>> +
>> +             /* Will wake up very soon. No time for doing anything else*/
>> +             if (this_rq->avg_idle < sysctl_sched_migration_cost)
>> +                     goto out;
>> +
>> +             /* Don't need to update blocked load of idle CPUs*/
>> +             if (!has_blocked || time_after_eq(jiffies, next_blocked)
>> +                     goto out;
>> +
>> +             raw_spin_unlock(&this_rq->lock);
>> +             /*
>> +              * This CPU is going to be idle and blocked load of idle CPUs
>> +              * need to be updated. Run the ilb locally as it is a good
>> +              * candidate for ilb instead of waking up another idle CPU.
>> +              * Kick an normal ilb if we failed to do the update.
>> +              */
>> +             if !_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>>                       kick_ilb(NOHZ_STATS_KICK);
>> +             raw_spin_lock(&this_rq->lock);
>>
>>               goto out;
>
> It is, but I think you're still doing that avg_idle thing twice now,
> right?

yes the goal was to try to not exceed idle time but I wonder if it is
really needed because the need_resched() in the
"for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
" will abort the loop if something is schedule on this_cpu just like
for a normal ilb().
So I think that we can remove this test with avg_idle.

>
>> > @@ -7850,7 +7850,7 @@ static bool update_nohz_stats(struct rq
>> >     if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
>> >             return false;
>> >
>> > -   if (!time_after(jiffies, rq->last_blocked_load_update_tick))
>> > +   if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
>>
>> This fix the concern raised on the other thread, isn't it ?
>
> Yes.
>
>> > +static int nohz_age(struct sched_domain *sd)
>> > +{
>> > +   struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
>> > +   bool has_blocked_load;
>> > +
>> > +   WRITE_ONCE(nohz.has_blocked, 0);
>> > +
>> > +   smp_mb();
>> > +
>> > +   cpumask_and(cpus, sched_domain_span(sd), nohz.idle_cpus_mask);
>> > +
>> > +   has_blocked_load = cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(sd));
>> > +
>> > +   for_each_cpu(cpu, cpus) {
>> > +           struct rq *rq = cpu_rq(cpu);
>> > +
>> > +           has_blocked_load |= update_nohz_stats(rq, true);
>> > +   }
>> > +
>> > +   if (has_blocked_load)
>> > +           WRITE_ONCE(nohz.has_blocked, 1);
>> > +}
>> > +
>>
>> we duplicate what is done in nohe_idle_balance
>
> In parts yes.. I was too lazy to combine :-)
>
>> > @@ -8919,9 +8955,13 @@ static int idle_balance(struct rq *this_
>> >             if (sd->flags & SD_BALANCE_NEWIDLE) {
>> >                     t0 = sched_clock_cpu(this_cpu);
>> >
>> > -                   pulled_task = load_balance(this_cpu, this_rq,
>> > -                                              sd, CPU_NEWLY_IDLE,
>> > -                                              &continue_balancing);
>> > +                   if (nohz_blocked) {
>> > +                           nohz_age(sd);
>>
>> Do we really need to loop all sched_domain of newly idle CPU and call
>> nohz_age for each level ?
>> Can't we only call  nohz_age with the widest/last sched_domain level ?
>
> Yeah, dunno. I went back and forth on that a bit. The largest is
> rq->rd->span. The reason I settled on this variant in the end is that it
> keeps locality. When short idle, it will only scan nearby CPUs instead
> of reaching half-way across the machine.
>
>> Furthermore, we use sd->max_newidle_lb_cost to decide to abort the loop.
>> But this is updated with full load balancing which is longer than just
>> updating blocked load.
>> This will increase the chance to abort before reaching the last level.
>
> Yes.. I figured we'd take that hit :/
>
>> > +                   } else {
>> > +                           pulled_task = load_balance(this_cpu, this_rq,
>> > +                                           sd, CPU_NEWLY_IDLE,
>> > +                                           &continue_balancing);
>> > +                   }
>> >
>> >                     domain_cost = sched_clock_cpu(this_cpu) - t0;
>> >                     if (domain_cost > sd->max_newidle_lb_cost)
>>
>> We have to kick an ilb if we must abort before looping all levels and all
>> idle CPUs otherwise we can have situation where the load of some idle CPus
>> could stay blocked
>
> Yes, like said, was unfinished, I gave up before I got to that.
