Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBHTVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:21:15 -0500
Received: from foss.arm.com ([217.140.101.70]:39318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbeBHTVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:21:12 -0500
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <780a5b3a-4829-4195-c8fd-95da27248a82@arm.com>
 <CAKfTPtC0a1Ku4HxhTKBJFz2bamO+KQL9aCNab=gcd1FeNL1-ww@mail.gmail.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f9457186-bd80-f97f-dedc-5c15f8183e92@arm.com>
Date: Thu, 8 Feb 2018 19:21:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC0a1Ku4HxhTKBJFz2bamO+KQL9aCNab=gcd1FeNL1-ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 01:36 PM, Vincent Guittot wrote:
> On 8 February 2018 at 13:46, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 02/06/2018 07:23 PM, Vincent Guittot wrote:
>>> [...]
>>> @@ -7826,8 +7842,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>       for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>>>               struct rq *rq = cpu_rq(i);
>>>
>>> -             if (env->flags & LBF_NOHZ_STATS)
>>> -                     update_nohz_stats(rq);
>>> +             if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
>>> +                     env->flags |= LBF_NOHZ_AGAIN;
>>>
>>>               /* Bias balancing toward cpus of our domain */
>>>               if (local_group)
>>> @@ -7979,18 +7995,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>>       struct sg_lb_stats *local = &sds->local_stat;
>>>       struct sg_lb_stats tmp_sgs;
>>>       int load_idx, prefer_sibling = 0;
>>> +     int has_blocked = READ_ONCE(nohz.has_blocked);
>>>       bool overload = false;
>>>
>>>       if (child && child->flags & SD_PREFER_SIBLING)
>>>               prefer_sibling = 1;
>>>
>>>  #ifdef CONFIG_NO_HZ_COMMON
>>> -     if (env->idle == CPU_NEWLY_IDLE) {
>>> +     if (env->idle == CPU_NEWLY_IDLE && has_blocked)
>>>               env->flags |= LBF_NOHZ_STATS;
>>> -
>>> -             if (cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)))
>>> -                     nohz.next_stats = jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD);
>>> -     }
>>>  #endif
>>>
>>>       load_idx = get_sd_load_idx(env->sd, env->idle);
>>> @@ -8046,6 +8059,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>>               sg = sg->next;
>>>       } while (sg != env->sd->groups);
>>>
>>> +#ifdef CONFIG_NO_HZ_COMMON
>>> +     if ((env->flags & LBF_NOHZ_AGAIN) &&
>>> +         cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
>>> +
>>> +             WRITE_ONCE(nohz.next_blocked,
>>> +                             jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
>>
>> Here we push the stats update forward if we visited all the nohz CPUs but they
>> still have blocked load. IMO we should also clear the nohz.has_blocked flag
>> if we visited all the nohz CPUs and none had blocked load left.
>>
>> If we don't do that, we could very well have cleared all of the nohz blocked
>> load in idle_balance and successfully pulled a task, but the flag isn't
>> cleared so we'll end up doing a _nohz_idle_balance() later on for nothing.
>>
>>
>> As I said in a previous comment, we also have this problem with periodic
>> load balance: if a CPU goes nohz (nohz.has_blocked is raised) but wakes up,
>> e.g. before the next nohz.next_blocked, we should stop kicking ILBs
>>
>> Now I'd need to test this, but I think it can actually get worse: if that
>> CPU keeps generating blocked load after this short idle period, no matter
>> how many _nohz_idle_balance() we go through we will never reach a point
>> where nohz.has_blocked gets cleared, and we'll keep kicking those ILBs to
>> update blocked load that already gets updated in the periodic balance.
>>
>> I think that's where a nohz blocked load cpumask can also help: on top of
>> skipping nohz CPUs that don't need an update, we can stop the whole remote
>> update machinery when the last nohz cpu with blocked load wakes up, or say
>> when it goes through its first periodic balance.
> 
> The main question is : Do we want to remove all useless kicks to ilb
> or useless calls to _nohz_idle_balance at the cost of adding more
> latency in the idle/wakeup path because of the additional atomic
> operations to keep track of which CPUs are idle, tickless with blocked
> load or do we accept to kick ilb or call _nohz_idle_balance uselessly
> from time to time for some use cases
> 
> I agree with you that there are some useless calls with the proposal
> which can be removed with additional checks, variables and cpumask
> manipulation. Which use case will benefits from these additional
> checks and does it worth ?
> 
> Vincent

For now I've been using those made-up rt-app workloads to stress specific
bits of code, but I agree it would be really nice to have a "real" workload
to see how both power (additional kick_ilb()'s) and performance (additional
atomic ops) are affected. As Vincent suggested offline, it could be worth
giving it a shot on Android...


In the meantime I've done some more accurate profiling with cpumasks on my
Juno r2 (patch at the bottom). As a sidenote, I realised I don't have a test
case for the load update through load_balance() in idle_balance() - I only
test the !overload segment. Will think about that.

In summary:

20 iterations per test case
All non-mentioned CPUs are idling

---------------------
kick_ilb() test case:
---------------------

a, b = 100% rt-app tasks
- = idling

Accumulating load before sleeping
        ^
        ^
CPU1| a a a - - - a
CPU2| - - b b b b b
              v
              v > Periodically kicking ILBs to update nohz blocked load
	
Baseline:
    _nohz_idle_balance() takes 39µs in average
    nohz_balance_enter_idle() takes 233ns in average

W/ cpumask:
    _nohz_idle_balance() takes 33µs in average
    nohz_balance_enter_idle() takes 283ns in average

Diff:
    _nohz_idle_balance() -6µs in average (-16%)
    nohz_balance_enter_idle() +50ns in average (+21%)


---------------------------------------------------
Local _nohz_idle_balance() for NEWLY_IDLE test case:
---------------------------------------------------

a = 100% rt-app task
b = periodic rt-app task
- = idling

Accumulating load before sleeping
        ^
        ^
CPU1| a a a - - - - - a
CPU2| - - b - b - b - b
               v
               v > Periodically updating nohz blocked load through local
                   _nohz_idle_balance() in idle_balance()


(execution times are x2 as fast as previous test case because CPU2 is a
big CPU, whereas CPU0 - the ILB 99% of the time in the previous test - is a
LITTLE CPU ~ half as powerful).

Baseline:
    _nohz_idle_balance() takes 20µs in average
    nohz_balance_enter_idle() takes 183ns in average

W/ cpumask:
    _nohz_idle_balance() takes 13µs in average
    nohz_balance_enter_idle() takes 217ns in average

Diff:
    _nohz_idle_balance() -7µs in average (-38%)
    nohz_balance_enter_idle() +34ns in average (+18%)



For more details: https://gist.github.com/valschneider/78099acee87a18057d56cc6cc03978b1

---
 kernel/sched/fair.c | 82 +++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3abb3bc..4042025 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5404,8 +5404,8 @@ decay_load_missed(unsigned long load, unsigned long missed_updates, int idx)
 
 static struct {
 	cpumask_var_t idle_cpus_mask;
+	cpumask_var_t stale_cpus_mask; /* Idle CPUs with blocked load */
 	atomic_t nr_cpus;
-	int has_blocked;		/* Idle CPUS has blocked load */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
@@ -6968,7 +6968,6 @@ enum fbq_type { regular, remote, all };
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
 #define LBF_NOHZ_STATS	0x10
-#define LBF_NOHZ_AGAIN	0x20
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -7827,25 +7826,24 @@ group_type group_classify(struct sched_group *group,
 	return group_other;
 }
 
-static bool update_nohz_stats(struct rq *rq)
+static void update_nohz_stats(struct rq *rq)
 {
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned int cpu = rq->cpu;
 
-	if (!rq->has_blocked_load)
-		return false;
 
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
-		return false;
+	if (!cpumask_test_cpu(cpu, nohz.stale_cpus_mask))
+		return;
 
 	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
-		return true;
+		return;
 
 	update_blocked_averages(cpu);
 
-	return rq->has_blocked_load;
+	if (!rq->has_blocked_load)
+		cpumask_clear_cpu(cpu, nohz.stale_cpus_mask);
 #else
-	return false;
+	return;
 #endif
 }
 
@@ -7871,8 +7869,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
-			env->flags |= LBF_NOHZ_AGAIN;
+		if (env->flags & LBF_NOHZ_STATS)
+			update_nohz_stats(rq);
 
 		/* Bias balancing toward cpus of our domain */
 		if (local_group)
@@ -8024,7 +8022,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	int load_idx, prefer_sibling = 0;
-	int has_blocked = READ_ONCE(nohz.has_blocked);
+	int has_blocked = cpumask_intersects(sched_domain_span(env->sd),
+					     nohz.stale_cpus_mask);
 	bool overload = false;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
@@ -8089,8 +8088,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	} while (sg != env->sd->groups);
 
 #ifdef CONFIG_NO_HZ_COMMON
-	if ((env->flags & LBF_NOHZ_AGAIN) &&
-	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
+	/*
+	 * All nohz CPUs with blocked load were visited but some haven't fully
+	 * decayed. Visit them again later.
+	 */
+	if ((env->flags & LBF_NOHZ_STATS) &&
+	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)) &&
+	    !cpumask_empty(nohz.stale_cpus_mask)) {
 
 		WRITE_ONCE(nohz.next_blocked,
 				jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
@@ -8882,7 +8886,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
 	    !this_rq->rd->overload) {
-		unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
+		unsigned long has_blocked = !cpumask_empty(nohz.stale_cpus_mask);
 		unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
 
 		rcu_read_lock();
@@ -9137,7 +9141,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	struct sched_domain *sd;
 	int nr_busy, i, cpu = rq->cpu;
 	unsigned int flags = 0;
-	unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
+	unsigned long has_blocked = !cpumask_empty(nohz.stale_cpus_mask);
 	unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
 
 	if (unlikely(rq->idle_balance))
@@ -9297,10 +9301,10 @@ void nohz_balance_enter_idle(int cpu)
 
 out:
 	/*
-	 * Each time a cpu enter idle, we assume that it has blocked load and
-	 * enable the periodic update of the load of idle cpus
+	 * Each time a cpu enters idle, we assume that it has blocked load and
+	 * enable the periodic update of its blocked load
 	 */
-	WRITE_ONCE(nohz.has_blocked, 1);
+	cpumask_set_cpu(cpu, nohz.stale_cpus_mask);
 }
 #else
 static inline void nohz_balancer_kick(struct rq *rq) { }
@@ -9437,7 +9441,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
 	unsigned long next_balance = now + 60*HZ;
-	bool has_blocked_load = false;
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
 	int balance_cpu;
@@ -9447,16 +9450,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 
 	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
-	/*
-	 * We assume there will be no idle load after this update and clear
-	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
-	 * set the has_blocked flag and trig another update of idle load.
-	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
-	 * setting the flag, we are sure to not clear the state and not
-	 * check the load of an idle cpu.
-	 */
-	WRITE_ONCE(nohz.has_blocked, 0);
-
 	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
 		u64 t0, domain_cost;
 
@@ -9466,29 +9459,34 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 			continue;
 
 		/*
+		 * When using the nohz balance to only update blocked load,
+		 * we can skip nohz CPUs which no longer have blocked load.
+		 */
+		if ((flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK &&
+		    !cpumask_test_cpu(balance_cpu, nohz.stale_cpus_mask))
+			continue;
+
+		/*
 		 * If this cpu gets work to do, stop the load balancing
 		 * work being done for other cpus. Next load
 		 * balancing owner will pick it up.
 		 */
-		if (need_resched()) {
-			has_blocked_load = true;
+		if (need_resched())
 			goto abort;
-		}
 
 		/*
 		 * If the update is done while CPU becomes idle, we abort
 		 * the update when its cost is higher than the average idle
 		 * time in orde to not delay a possible wake up.
 		 */
-		if (idle == CPU_NEWLY_IDLE && this_rq->avg_idle < curr_cost) {
-			has_blocked_load = true;
+		if (idle == CPU_NEWLY_IDLE && this_rq->avg_idle < curr_cost)
 			goto abort;
-		}
 
 		rq = cpu_rq(balance_cpu);
 
 		update_blocked_averages(rq->cpu);
-		has_blocked_load |= rq->has_blocked_load;
+		if (!rq->has_blocked_load)
+			cpumask_clear_cpu(balance_cpu, nohz.stale_cpus_mask);
 
 		/*
 		 * If time for next balance is due,
@@ -9519,7 +9517,8 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	/* Newly idle CPU doesn't need an update */
 	if (idle != CPU_NEWLY_IDLE) {
 		update_blocked_averages(this_cpu);
-		has_blocked_load |= this_rq->has_blocked_load;
+		if (!this_rq->has_blocked_load)
+			cpumask_clear_cpu(this_cpu, nohz.stale_cpus_mask);
 	}
 
 	if (flags & NOHZ_BALANCE_KICK)
@@ -9532,10 +9531,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	ret = true;
 
 abort:
-	/* There is still blocked load, enable periodic update */
-	if (has_blocked_load)
-		WRITE_ONCE(nohz.has_blocked, 1);
-
 	/*
 	 * next_balance will be updated only when there is a need.
 	 * When the CPU is attached to null domain for ex, it will not be
@@ -10196,6 +10191,7 @@ __init void init_sched_fair_class(void)
 	nohz.next_balance = jiffies;
 	nohz.next_blocked = jiffies;
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
+	zalloc_cpumask_var(&nohz.stale_cpus_mask, GFP_NOWAIT);
 #endif
 #endif /* SMP */
 
-- 
2.7.4
