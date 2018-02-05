Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBEWS6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:18:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58592 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbeBEWSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:18:51 -0500
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
From: Valentin Schneider <valentin.schneider@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <20171222075934.f6yenvcb2zkf2ysd@hirez.programming.kicks-ass.net>
 <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org>
 <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org>
 <b1efd041-2faa-76e0-7d9b-3d2917e03012@arm.com>
 <CAKfTPtCmFC2mmR9SBTjjuuzPS8tFNmmrSRMmKrOrkh3uPkYYoA@mail.gmail.com>
 <4fb17712-3f98-c407-42b3-4601a4f294d9@arm.com>
Message-ID: <5694b3f8-9726-d5a8-dba3-e4c1619a05be@arm.com>
Date: Mon, 5 Feb 2018 22:18:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4fb17712-3f98-c407-42b3-4601a4f294d9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 11:41 AM, Valentin Schneider wrote:
> [...]
>> I have studied a way to keep track of how many cpus still have blocked
>> load to try to minimize the number of useless ilb kick but this add
>> more atomic operations which can impact the system throughput with
>> heavy load and lot of very small wake up. that's why i have propose
>> this solution which is more simple. But it's probably just a matter of
>> where we want to "waste" time. Either we accept to spent a bit more
>> time to check the state of idle CPUs or we accept to kick ilb from
>> time to time for no good reason.
>>
> 
> Agreed. I have the feeling that spending more time doing atomic ops could be worth it - I'll try to test this out and see if it's actually relevant.
> 

I gave this a spin, still using Vincent's patches with the included patch on top. Nothing too clever, just seeing how replacing nohz.stats_state with a cpumask would go.

I've replaced nohz.stats_state by nohz.stale_cpus_mask. I kept changes minimal - there are some places where I think nohz.idle_cpus_mask could be substituted by nohz.stale_cpus_mask. Speaking about that, I was about to write a comment regarding the fact that nohz.stale_cpus_mask should be a subset of nohz.idle_cpus_mask, but I realized it's actually not true:

In the current implementation (cpumask or stats_state flag), an idle CPU is defined as having blocked load as soon as it goes through nohz_balance_enter_idle(), and that flag is cleared when we go through _nohz_idle_balance() (and newly idle load balance in my cpumask implementation).
However we can imagine a scenario where a CPU goes idle, is flagged as having blocked load, then it wakes up and goes through its periodic balance code and updates that load. Yet, the flag (or cpumask) won't have been updated.
So I think there could be a discussion on whether the flag should be cleared on nohz_balance_exit_idle() if we assume periodic balance now takes care of this. It could cause issues if we have a weird scenario where a CPU keeps going online/idle but never stays online long enough for a tick though.
Alternatively we could clear that flag when going through the first periodic balance after idling, but then that's a bit weird because we're using a nohz structure in a non-nohz context.


Anyway, I tried to get some profiling done with the cpumask but there's something wrong with my setup, I would only get nonsense numbers (for both baseline & my patch), so I added start/end trace_printks to _nohz_idle_balance(). It's ugly, inaccurate and unorthodox but it still gives a rough idea of how the cpumask impacts stuff.
I ran 20 iterations of my "nohz update" test case (a task accumulates load, goes to sleep, and another always-running task keeps kicking an ILB to decay that blocked load) and the time saved by skipping CPUs is in the ballpark of 20%. Notebook is at [1].

I'll try to get a proper function profiling working for when Vincent posts his "v2".

[1]: https://gist.github.com/valschneider/6f203143bee1e149f24c44e9582a9eff

---
 kernel/sched/fair.c | 72 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ada92b..8bcf465 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5404,8 +5404,8 @@ decay_load_missed(unsigned long load, unsigned long missed_updates, int idx)
 
 static struct {
 	cpumask_var_t idle_cpus_mask;
+	cpumask_var_t stale_cpus_mask;
 	atomic_t nr_cpus;
-	atomic_t stats_state;
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_stats;
 } nohz ____cacheline_aligned;
@@ -6968,7 +6968,6 @@ enum fbq_type { regular, remote, all };
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
 #define LBF_NOHZ_STATS	0x10
-#define LBF_NOHZ_AGAIN	0x20
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -7829,25 +7828,25 @@ group_type group_classify(struct sched_group *group,
 	return group_other;
 }
 
-static bool update_nohz_stats(struct rq *rq)
+static void update_nohz_stats(struct rq *rq)
 {
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned int cpu = rq->cpu;
 
-	if (!rq->has_blocked_load)
-		return false;
-
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
-		return false;
+	if (!cpumask_test_cpu(cpu, nohz.stale_cpus_mask))
+		return;
 
 	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
-		return true;
+		return;
 
 	update_blocked_averages(cpu);
 
-	return rq->has_blocked_load;
+	if (rq->has_blocked_load)
+		return;
+
+	cpumask_clear_cpu(cpu, nohz.stale_cpus_mask);
 #else
-	return false;
+	return;
 #endif
 }
 
@@ -7873,8 +7872,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
-			env->flags |= LBF_NOHZ_AGAIN;
+		if (env->flags & LBF_NOHZ_STATS)
+			update_nohz_stats(rq);
 
 		/* Bias balancing toward cpus of our domain */
 		if (local_group)
@@ -8032,7 +8031,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		prefer_sibling = 1;
 
 #ifdef CONFIG_NO_HZ_COMMON
-	if (env->idle == CPU_NEWLY_IDLE && atomic_read(&nohz.stats_state)) {
+	if (env->idle == CPU_NEWLY_IDLE &&
+	    cpumask_intersects(sched_domain_span(env->sd), nohz.stale_cpus_mask)) {
 		env->flags |= LBF_NOHZ_STATS;
 	}
 #endif
@@ -8091,8 +8091,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
 
 		WRITE_ONCE(nohz.next_stats,
 				jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
@@ -8897,7 +8902,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 		 * ilb if it takes too much time and might delay next local
 		 * wake up
 		 */
-		if (time_after(jiffies, next) && atomic_read(&nohz.stats_state) &&
+		if (time_after(jiffies, next) && !cpumask_empty(nohz.stale_cpus_mask) &&
 				!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 			kick_ilb(NOHZ_STATS_KICK);
 
@@ -9153,7 +9158,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (likely(!atomic_read(&nohz.nr_cpus)))
 		return;
 
-	if (time_after(now, nohz.next_stats) && atomic_read(&nohz.stats_state))
+	if (time_after(now, nohz.next_stats) && !cpumask_empty(nohz.stale_cpus_mask))
 		flags = NOHZ_STATS_KICK;
 
 	if (time_before(now, nohz.next_balance))
@@ -9292,10 +9297,10 @@ void nohz_balance_enter_idle(int cpu)
 	set_cpu_sd_state_idle(cpu);
 
 	/*
-	 * Each time a cpu enter idle, we assume that it has blocked load and
-	 * enable the periodic update of the load of idle cpus
+	 * Each time a cpu enters idle, we assume that it has blocked load and
+	 * thus enable the periodic update of its load
 	 */
-	atomic_set(&nohz.stats_state, 1);
+	cpumask_set_cpu(cpu, nohz.stale_cpus_mask);
 }
 #else
 static inline void nohz_balancer_kick(struct rq *rq) { }
@@ -9432,7 +9437,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
 	unsigned long next_balance = now + 60*HZ;
-	bool has_blocked_load = false;
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
 	int balance_cpu;
@@ -9450,7 +9454,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	 * setting the stats state, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
 	 */
-	atomic_set(&nohz.stats_state, 0);
 
 	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
 		u64 t0, domain_cost;
@@ -9460,30 +9463,31 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
 			continue;
 
+		if ((flags & NOHZ_KICK_MASK) == NOHZ_STATS_KICK &&
+		    !cpumask_test_cpu(balance_cpu, nohz.stale_cpus_mask))
+			continue;
+
 		/*
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
@@ -9514,7 +9518,9 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	/* Newly idle CPU doesn't need an update */
 	if (idle != CPU_NEWLY_IDLE) {
 		update_blocked_averages(this_cpu);
-		has_blocked_load |= this_rq->has_blocked_load;
+		if (!this_rq->has_blocked_load)
+			cpumask_clear_cpu(this_cpu, nohz.stale_cpus_mask);
+
 	}
 
 	if (flags & NOHZ_BALANCE_KICK)
@@ -9527,9 +9533,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_
 	ret = true;
 
 abort:
-	/* There is still blocked load, enable periodic update */
-	if (has_blocked_load)
-		atomic_set(&nohz.stats_state, 1);
 
 	/*
 	 * next_balance will be updated only when there is a need.
@@ -10190,6 +10193,7 @@ __init void init_sched_fair_class(void)
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance = jiffies;
 	nohz.next_stats = jiffies;
+	zalloc_cpumask_var(&nohz.stale_cpus_mask, GFP_NOWAIT);
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
 #endif /* SMP */
-- 
2.7.4
