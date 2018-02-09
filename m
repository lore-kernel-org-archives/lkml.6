Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBILmU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:42:20 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:50349 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeBILmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:42:18 -0500
X-Google-Smtp-Source: AH8x227rOkg0MKNXmmJGOIpR4o5+PNX07jkOzNM5J6+UIz1G4gdq96c6ILoun+G/DlHKgOJ9U/8VcFnwK4i+0zP/r7U=
MIME-Version: 1.0
In-Reply-To: <f9457186-bd80-f97f-dedc-5c15f8183e92@arm.com>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <780a5b3a-4829-4195-c8fd-95da27248a82@arm.com> <CAKfTPtC0a1Ku4HxhTKBJFz2bamO+KQL9aCNab=gcd1FeNL1-ww@mail.gmail.com>
 <f9457186-bd80-f97f-dedc-5c15f8183e92@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Feb 2018 12:41:56 +0100
Message-ID: <CAKfTPtDmjREQLbxd+NSk8Oo8cKV7xfA7Dm6YTudvv2ZsDAX-5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w19BgPa1013220

On 8 February 2018 at 20:21, Valentin Schneider
<valentin.schneider@arm.com> wrote:
> On 02/08/2018 01:36 PM, Vincent Guittot wrote:
>> On 8 February 2018 at 13:46, Valentin Schneider
>> <valentin.schneider@arm.com> wrote:
>>> On 02/06/2018 07:23 PM, Vincent Guittot wrote:
>>>> [...]

>
> For now I've been using those made-up rt-app workloads to stress specific
> bits of code, but I agree it would be really nice to have a "real" workload
> to see how both power (additional kick_ilb()'s) and performance (additional
> atomic ops) are affected. As Vincent suggested offline, it could be worth
> giving it a shot on Android...
>
>
> In the meantime I've done some more accurate profiling with cpumasks on my
> Juno r2 (patch at the bottom). As a sidenote, I realised I don't have a test
> case for the load update through load_balance() in idle_balance() - I only
> test the !overload segment. Will think about that.
>
> In summary:
>
> 20 iterations per test case
> All non-mentioned CPUs are idling
>
> ---------------------
> kick_ilb() test case:
> ---------------------
>
> a, b = 100% rt-app tasks
> - = idling
>
> Accumulating load before sleeping
>         ^
>         ^
> CPU1| a a a - - - a
> CPU2| - - b b b b b
>               v
>               v > Periodically kicking ILBs to update nohz blocked load
>
> Baseline:
>     _nohz_idle_balance() takes 39µs in average
>     nohz_balance_enter_idle() takes 233ns in average
>
> W/ cpumask:
>     _nohz_idle_balance() takes 33µs in average
>     nohz_balance_enter_idle() takes 283ns in average
>
> Diff:
>     _nohz_idle_balance() -6µs in average (-16%)
>     nohz_balance_enter_idle() +50ns in average (+21%)

In your use case, there is no contention when accessing the cpumask.
Have you tried a use case with tasks that wake ups and go back to idle
simultaneously on several/all cpus so they will fight to update the
atomic resources ?
That would be interesting to see the impact on the runtime of the
nohz_balance_enter_idle function

>
>
> ---------------------------------------------------
> Local _nohz_idle_balance() for NEWLY_IDLE test case:
> ---------------------------------------------------
>
> a = 100% rt-app task
> b = periodic rt-app task
> - = idling
>
> Accumulating load before sleeping
>         ^
>         ^
> CPU1| a a a - - - - - a
> CPU2| - - b - b - b - b
>                v
>                v > Periodically updating nohz blocked load through local
>                    _nohz_idle_balance() in idle_balance()
>
>
> (execution times are x2 as fast as previous test case because CPU2 is a
> big CPU, whereas CPU0 - the ILB 99% of the time in the previous test - is a
> LITTLE CPU ~ half as powerful).
>
> Baseline:
>     _nohz_idle_balance() takes 20µs in average
>     nohz_balance_enter_idle() takes 183ns in average
>
> W/ cpumask:
>     _nohz_idle_balance() takes 13µs in average
>     nohz_balance_enter_idle() takes 217ns in average
>
> Diff:
>     _nohz_idle_balance() -7µs in average (-38%)
>     nohz_balance_enter_idle() +34ns in average (+18%)
>
>
>
> For more details: https://gist.github.com/valschneider/78099acee87a18057d56cc6cc03978b1
>
> ---
>  kernel/sched/fair.c | 82 +++++++++++++++++++++++++----------------------------
>  1 file changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3abb3bc..4042025 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5404,8 +5404,8 @@ decay_load_missed(unsigned long load, unsigned long missed_updates, int idx)
>
>  static struct {
>         cpumask_var_t idle_cpus_mask;
> +       cpumask_var_t stale_cpus_mask; /* Idle CPUs with blocked load */
>         atomic_t nr_cpus;
> -       int has_blocked;                /* Idle CPUS has blocked load */
>         unsigned long next_balance;     /* in jiffy units */
>         unsigned long next_blocked;     /* Next update of blocked load in jiffies */
>  } nohz ____cacheline_aligned;
> @@ -6968,7 +6968,6 @@ enum fbq_type { regular, remote, all };
>  #define LBF_DST_PINNED  0x04
>  #define LBF_SOME_PINNED        0x08
>  #define LBF_NOHZ_STATS 0x10
> -#define LBF_NOHZ_AGAIN 0x20
>
>  struct lb_env {
>         struct sched_domain     *sd;
> @@ -7827,25 +7826,24 @@ group_type group_classify(struct sched_group *group,
>         return group_other;
>  }
>
> -static bool update_nohz_stats(struct rq *rq)
> +static void update_nohz_stats(struct rq *rq)
>  {
>  #ifdef CONFIG_NO_HZ_COMMON
>         unsigned int cpu = rq->cpu;
>
> -       if (!rq->has_blocked_load)
> -               return false;
>
> -       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> -               return false;
> +       if (!cpumask_test_cpu(cpu, nohz.stale_cpus_mask))
> +               return;
>
>         if (!time_after(jiffies, rq->last_blocked_load_update_tick))
> -               return true;
> +               return;
>
>         update_blocked_averages(cpu);
>
> -       return rq->has_blocked_load;
> +       if (!rq->has_blocked_load)
> +               cpumask_clear_cpu(cpu, nohz.stale_cpus_mask);
>  #else
> -       return false;
> +       return;
>  #endif
>  }
>
> @@ -7871,8 +7869,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>                 struct rq *rq = cpu_rq(i);
>
> -               if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
> -                       env->flags |= LBF_NOHZ_AGAIN;
> +               if (env->flags & LBF_NOHZ_STATS)
> +                       update_nohz_stats(rq);
>
>                 /* Bias balancing toward cpus of our domain */
>                 if (local_group)
> @@ -8024,7 +8022,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         struct sg_lb_stats *local = &sds->local_stat;
>         struct sg_lb_stats tmp_sgs;
>         int load_idx, prefer_sibling = 0;
> -       int has_blocked = READ_ONCE(nohz.has_blocked);
> +       int has_blocked = cpumask_intersects(sched_domain_span(env->sd),
> +                                            nohz.stale_cpus_mask);
>         bool overload = false;
>
>         if (child && child->flags & SD_PREFER_SIBLING)
> @@ -8089,8 +8088,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         } while (sg != env->sd->groups);
>
>  #ifdef CONFIG_NO_HZ_COMMON
> -       if ((env->flags & LBF_NOHZ_AGAIN) &&
> -           cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> +       /*
> +        * All nohz CPUs with blocked load were visited but some haven't fully
> +        * decayed. Visit them again later.
> +        */
> +       if ((env->flags & LBF_NOHZ_STATS) &&
> +           cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)) &&
> +           !cpumask_empty(nohz.stale_cpus_mask)) {
>
>                 WRITE_ONCE(nohz.next_blocked,
>                                 jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
> @@ -8882,7 +8886,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>             !this_rq->rd->overload) {
> -               unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
> +               unsigned long has_blocked = !cpumask_empty(nohz.stale_cpus_mask);
>                 unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
>
>                 rcu_read_lock();
> @@ -9137,7 +9141,7 @@ static void nohz_balancer_kick(struct rq *rq)
>         struct sched_domain *sd;
>         int nr_busy, i, cpu = rq->cpu;
>         unsigned int flags = 0;
> -       unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
> +       unsigned long has_blocked = !cpumask_empty(nohz.stale_cpus_mask);
>         unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
>
>         if (unlikely(rq->idle_balance))
> @@ -9297,10 +9301,10 @@ void nohz_balance_enter_idle(int cpu)
>
>  out:
>         /*
> -        * Each time a cpu enter idle, we assume that it has blocked load and
> -        * enable the periodic update of the load of idle cpus
> +        * Each time a cpu enters idle, we assume that it has blocked load and
> +        * enable the periodic update of its blocked load
>          */
> -       WRITE_ONCE(nohz.has_blocked, 1);
> +       cpumask_set_cpu(cpu, nohz.stale_cpus_mask);
>  }
>  #else
>  static inline void nohz_balancer_kick(struct rq *rq) { }
> @@ -9437,7 +9441,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
>         /* Earliest time when we have to do rebalance again */
>         unsigned long now = jiffies;
>         unsigned long next_balance = now + 60*HZ;
> -       bool has_blocked_load = false;
>         int update_next_balance = 0;
>         int this_cpu = this_rq->cpu;
>         int balance_cpu;
> @@ -9447,16 +9450,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
>
>         SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>
> -       /*
> -        * We assume there will be no idle load after this update and clear
> -        * the has_blocked flag. If a cpu enters idle in the mean time, it will
> -        * set the has_blocked flag and trig another update of idle load.
> -        * Because a cpu that becomes idle, is added to idle_cpus_mask before
> -        * setting the flag, we are sure to not clear the state and not
> -        * check the load of an idle cpu.
> -        */
> -       WRITE_ONCE(nohz.has_blocked, 0);
> -
>         for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>                 u64 t0, domain_cost;
>
> @@ -9466,29 +9459,34 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
>                         continue;
>
>                 /*
> +                * When using the nohz balance to only update blocked load,
> +                * we can skip nohz CPUs which no longer have blocked load.
> +                */
> +               if ((flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK &&
> +                   !cpumask_test_cpu(balance_cpu, nohz.stale_cpus_mask))
> +                       continue;
> +
> +               /*
>                  * If this cpu gets work to do, stop the load balancing
>                  * work being done for other cpus. Next load
>                  * balancing owner will pick it up.
>                  */
> -               if (need_resched()) {
> -                       has_blocked_load = true;
> +               if (need_resched())
>                         goto abort;
> -               }
>
>                 /*
>                  * If the update is done while CPU becomes idle, we abort
>                  * the update when its cost is higher than the average idle
>                  * time in orde to not delay a possible wake up.
>                  */
> -               if (idle == CPU_NEWLY_IDLE && this_rq->avg_idle < curr_cost) {
> -                       has_blocked_load = true;
> +               if (idle == CPU_NEWLY_IDLE && this_rq->avg_idle < curr_cost)
>                         goto abort;
> -               }
>
>                 rq = cpu_rq(balance_cpu);
>
>                 update_blocked_averages(rq->cpu);
> -               has_blocked_load |= rq->has_blocked_load;
> +               if (!rq->has_blocked_load)
> +                       cpumask_clear_cpu(balance_cpu, nohz.stale_cpus_mask);
>
>                 /*
>                  * If time for next balance is due,
> @@ -9519,7 +9517,8 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
>         /* Newly idle CPU doesn't need an update */
>         if (idle != CPU_NEWLY_IDLE) {
>                 update_blocked_averages(this_cpu);
> -               has_blocked_load |= this_rq->has_blocked_load;
> +               if (!this_rq->has_blocked_load)
> +                       cpumask_clear_cpu(this_cpu, nohz.stale_cpus_mask);
>         }
>
>         if (flags & NOHZ_BALANCE_KICK)
> @@ -9532,10 +9531,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
>         ret = true;
>
>  abort:
> -       /* There is still blocked load, enable periodic update */
> -       if (has_blocked_load)
> -               WRITE_ONCE(nohz.has_blocked, 1);
> -
>         /*
>          * next_balance will be updated only when there is a need.
>          * When the CPU is attached to null domain for ex, it will not be
> @@ -10196,6 +10191,7 @@ __init void init_sched_fair_class(void)
>         nohz.next_balance = jiffies;
>         nohz.next_blocked = jiffies;
>         zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
> +       zalloc_cpumask_var(&nohz.stale_cpus_mask, GFP_NOWAIT);
>  #endif
>  #endif /* SMP */
>
> --
> 2.7.4
>
>
