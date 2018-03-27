Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeC0VvR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:51:17 -0400
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:44151 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbeC0VvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:51:15 -0400
Subject: Re: [RFT][PATCH v7 6/8] sched: idle: Select idle state before
 stopping the tick
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
CC: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Doug Smythies" <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
 <2249320.0Z4q8AXauv@aspire.rjw.lan>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Message-ID: <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de>
Date: Tue, 27 Mar 2018 23:50:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2249320.0Z4q8AXauv@aspire.rjw.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MSX-L106.msx.ad.zih.tu-dresden.de (172.26.34.106) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 16:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to address the issue with short idle duration predictions
> by the idle governor after the tick has been stopped, reorder the
> code in cpuidle_idle_call() so that the governor idle state selection
> runs before tick_nohz_idle_go_idle() and use the "nohz" hint returned
> by cpuidle_select() to decide whether or not to stop the tick.
> 
> This isn't straightforward, because menu_select() invokes
> tick_nohz_get_sleep_length() to get the time to the next timer
> event and the number returned by the latter comes from
> __tick_nohz_idle_enter().  Fortunately, however, it is possible
> to compute that number without actually stopping the tick and with
> the help of the existing code.

I think something is wrong with the new tick_nohz_get_sleep_length.
It seems to return a value that is too large, ignoring immanent
non-sched timer.

I tested idle-loop-v7.3. It looks very similar to my previous results
on the first idle-loop-git-version [1]. Idle and traditional synthetic
powernightmares are mostly good. But it selects too deep C-states
for short idle periods, which is bad for power consumption [2].

I tracked this down with additional tests using
__attribute__((optimize("O0"))) menu_select
and perf probe. With this the behavior seems slightly different, but it
shows that data->next_timer_us is:
v4.16-rc6: the expected ~500 us [3]
idle-loop-v7.3: many milliseconds to minutes [4].
This leads to the governor to wrongly selecting C6.

Checking with 372be9e and 6ea0577, I can confirm that the change is
introduced by this patch.

[1] https://lkml.org/lkml/2018/3/20/238
[2] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_3_skl_sp.png
[3] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/next_timer_us-v4.16-rc6.png
[4] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/next_timer_us-idle-loop-v7.3.png
  
> Namely, notice that tick_nohz_stop_sched_tick() already computes the
> next timer event time to reprogram the scheduler tick hrtimer and
> that time can be used as a proxy for the actual next timer event
> time in the idle duration predicition.  Moreover, it is possible
> to split tick_nohz_stop_sched_tick() into two separate routines,
> one computing the time to the next timer event and the other
> simply stopping the tick when the time to the next timer event
> is known.
> 
> Accordingly, split tick_nohz_stop_sched_tick() into
> tick_nohz_next_event() and tick_nohz_stop_tick() and use the
> former in tick_nohz_get_sleep_length().  Add two new extra fields,
> timer_expires and timer_expires_base, to struct tick_sched for
> passing data between these two new functions and to indicate that
> tick_nohz_next_event() has run and tick_nohz_stop_tick() can be
> called now.  Also drop the now redundant sleep_length field from
> there.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v5 -> v7:
>    * Rebase on top of the new [5/8].
> 
> ---
>   include/linux/tick.h     |    2
>   kernel/sched/idle.c      |   11 ++-
>   kernel/time/tick-sched.c |  156 +++++++++++++++++++++++++++++++----------------
>   kernel/time/tick-sched.h |    6 +
>   4 files changed, 120 insertions(+), 55 deletions(-)
> 
> Index: linux-pm/kernel/time/tick-sched.h
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.h
> +++ linux-pm/kernel/time/tick-sched.h
> @@ -38,7 +38,8 @@ enum tick_nohz_mode {
>    * @idle_exittime:	Time when the idle state was left
>    * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
>    * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
> - * @sleep_length:	Duration of the current idle sleep
> + * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
> + * @timer_expires_base:	Base time clock monotonic for @timer_expires
>    * @do_timer_lst:	CPU was the last one doing do_timer before going idle
>    */
>   struct tick_sched {
> @@ -58,8 +59,9 @@ struct tick_sched {
>   	ktime_t				idle_exittime;
>   	ktime_t				idle_sleeptime;
>   	ktime_t				iowait_sleeptime;
> -	ktime_t				sleep_length;
>   	unsigned long			last_jiffies;
> +	u64				timer_expires;
> +	u64				timer_expires_base;
>   	u64				next_timer;
>   	ktime_t				idle_expires;
>   	int				do_timer_last;
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -190,13 +190,18 @@ static void cpuidle_idle_call(void)
>   	} else {
>   		bool stop_tick = true;
>   
> -		tick_nohz_idle_stop_tick();
> -		rcu_idle_enter();
> -
>   		/*
>   		 * Ask the cpuidle framework to choose a convenient idle state.
>   		 */
>   		next_state = cpuidle_select(drv, dev, &stop_tick);
> +
> +		if (stop_tick)
> +			tick_nohz_idle_stop_tick();
> +		else
> +			tick_nohz_idle_retain_tick();
> +
> +		rcu_idle_enter();
> +
>   		entered_state = call_cpuidle(drv, dev, next_state);
>   		/*
>   		 * Give the governor an opportunity to reflect on the outcome
> Index: linux-pm/kernel/time/tick-sched.c
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.c
> +++ linux-pm/kernel/time/tick-sched.c
> @@ -652,13 +652,10 @@ static inline bool local_timer_softirq_p
>   	return local_softirq_pending() & TIMER_SOFTIRQ;
>   }
>   
> -static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
> -					 ktime_t now, int cpu)
> +static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>   {
> -	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
>   	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
>   	unsigned long seq, basejiff;
> -	ktime_t	tick;
>   
>   	/* Read jiffies and the time when jiffies were updated last */
>   	do {
> @@ -667,6 +664,7 @@ static ktime_t tick_nohz_stop_sched_tick
>   		basejiff = jiffies;
>   	} while (read_seqretry(&jiffies_lock, seq));
>   	ts->last_jiffies = basejiff;
> +	ts->timer_expires_base = basemono;
>   
>   	/*
>   	 * Keep the periodic tick, when RCU, architecture or irq_work
> @@ -711,31 +709,24 @@ static ktime_t tick_nohz_stop_sched_tick
>   		 * next period, so no point in stopping it either, bail.
>   		 */
>   		if (!ts->tick_stopped) {
> -			tick = 0;
> +			ts->timer_expires = 0;
>   			goto out;
>   		}
>   	}
>   
>   	/*
> -	 * If this CPU is the one which updates jiffies, then give up
> -	 * the assignment and let it be taken by the CPU which runs
> -	 * the tick timer next, which might be this CPU as well. If we
> -	 * don't drop this here the jiffies might be stale and
> -	 * do_timer() never invoked. Keep track of the fact that it
> -	 * was the one which had the do_timer() duty last. If this CPU
> -	 * is the one which had the do_timer() duty last, we limit the
> -	 * sleep time to the timekeeping max_deferment value.
> +	 * If this CPU is the one which had the do_timer() duty last, we limit
> +	 * the sleep time to the timekeeping max_deferment value.
>   	 * Otherwise we can sleep as long as we want.
>   	 */
>   	delta = timekeeping_max_deferment();
> -	if (cpu == tick_do_timer_cpu) {
> -		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> -		ts->do_timer_last = 1;
> -	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> -		delta = KTIME_MAX;
> -		ts->do_timer_last = 0;
> -	} else if (!ts->do_timer_last) {
> -		delta = KTIME_MAX;
> +	if (cpu != tick_do_timer_cpu) {
> +		if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> +			delta = KTIME_MAX;
> +			ts->do_timer_last = 0;
> +		} else if (!ts->do_timer_last) {
> +			delta = KTIME_MAX;
> +		}
>   	}
>   
>   #ifdef CONFIG_NO_HZ_FULL
> @@ -750,14 +741,40 @@ static ktime_t tick_nohz_stop_sched_tick
>   	else
>   		expires = KTIME_MAX;
>   
> -	expires = min_t(u64, expires, next_tick);
> -	tick = expires;
> +	ts->timer_expires = min_t(u64, expires, next_tick);
> +
> +out:
> +	return ts->timer_expires;
> +}
> +
> +static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> +{
> +	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
> +	u64 basemono = ts->timer_expires_base;
> +	u64 expires = ts->timer_expires;
> +	ktime_t tick = expires;
> +
> +	/* Make sure we won't be trying to stop it twice in a row. */
> +	ts->timer_expires_base = 0;
> +
> +	/*
> +	 * If this CPU is the one which updates jiffies, then give up
> +	 * the assignment and let it be taken by the CPU which runs
> +	 * the tick timer next, which might be this CPU as well. If we
> +	 * don't drop this here the jiffies might be stale and
> +	 * do_timer() never invoked. Keep track of the fact that it
> +	 * was the one which had the do_timer() duty last.
> +	 */
> +	if (cpu == tick_do_timer_cpu) {
> +		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> +		ts->do_timer_last = 1;
> +	}
>   
>   	/* Skip reprogram of event if its not changed */
>   	if (ts->tick_stopped && (expires == ts->next_tick)) {
>   		/* Sanity check: make sure clockevent is actually programmed */
>   		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
> -			goto out;
> +			return;
>   
>   		WARN_ON_ONCE(1);
>   		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
> @@ -791,7 +808,7 @@ static ktime_t tick_nohz_stop_sched_tick
>   	if (unlikely(expires == KTIME_MAX)) {
>   		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
>   			hrtimer_cancel(&ts->sched_timer);
> -		goto out;
> +		return;
>   	}
>   
>   	hrtimer_set_expires(&ts->sched_timer, tick);
> @@ -800,15 +817,23 @@ static ktime_t tick_nohz_stop_sched_tick
>   		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
>   	else
>   		tick_program_event(tick, 1);
> -out:
> -	/*
> -	 * Update the estimated sleep length until the next timer
> -	 * (not only the tick).
> -	 */
> -	ts->sleep_length = ktime_sub(dev->next_event, now);
> -	return tick;
>   }
>   
> +static void tick_nohz_retain_tick(struct tick_sched *ts)
> +{
> +	ts->timer_expires_base = 0;
> +}
> +
> +#ifdef CONFIG_NO_HZ_FULL
> +static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
> +{
> +	if (tick_nohz_next_event(ts, cpu))
> +		tick_nohz_stop_tick(ts, cpu);
> +	else
> +		tick_nohz_retain_tick(ts);
> +}
> +#endif /* CONFIG_NO_HZ_FULL */
> +
>   static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
>   {
>   	/* Update jiffies first */
> @@ -844,7 +869,7 @@ static void tick_nohz_full_update_tick(s
>   		return;
>   
>   	if (can_stop_full_tick(cpu, ts))
> -		tick_nohz_stop_sched_tick(ts, ktime_get(), cpu);
> +		tick_nohz_stop_sched_tick(ts, cpu);
>   	else if (ts->tick_stopped)
>   		tick_nohz_restart_sched_tick(ts, ktime_get());
>   #endif
> @@ -870,10 +895,8 @@ static bool can_stop_idle_tick(int cpu,
>   		return false;
>   	}
>   
> -	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE)) {
> -		ts->sleep_length = NSEC_PER_SEC / HZ;
> +	if (unlikely(ts->nohz_mode == NOHZ_MODE_INACTIVE))
>   		return false;
> -	}
>   
>   	if (need_resched())
>   		return false;
> @@ -913,25 +936,33 @@ static void __tick_nohz_idle_stop_tick(s
>   	ktime_t expires;
>   	int cpu = smp_processor_id();
>   
> -	if (can_stop_idle_tick(cpu, ts)) {
> +	/*
> +	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
> +	 * tick timer expiration time is known already.
> +	 */
> +	if (ts->timer_expires_base)
> +		expires = ts->timer_expires;
> +	else if (can_stop_idle_tick(cpu, ts))
> +		expires = tick_nohz_next_event(ts, cpu);
> +	else
> +		return;
> +
> +	ts->idle_calls++;
> +
> +	if (expires > 0LL) {
>   		int was_stopped = ts->tick_stopped;
>   
> -		ts->idle_calls++;
> +		tick_nohz_stop_tick(ts, cpu);
>   
> -		/*
> -		 * The idle entry time should be a sufficient approximation of
> -		 * the current time at this point.
> -		 */
> -		expires = tick_nohz_stop_sched_tick(ts, ts->idle_entrytime, cpu);
> -		if (expires > 0LL) {
> -			ts->idle_sleeps++;
> -			ts->idle_expires = expires;
> -		}
> +		ts->idle_sleeps++;
> +		ts->idle_expires = expires;
>   
>   		if (!was_stopped && ts->tick_stopped) {
>   			ts->idle_jiffies = ts->last_jiffies;
>   			nohz_balance_enter_idle(cpu);
>   		}
> +	} else {
> +		tick_nohz_retain_tick(ts);
>   	}
>   }
>   
> @@ -945,6 +976,11 @@ void tick_nohz_idle_stop_tick(void)
>   	__tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched));
>   }
>   
> +void tick_nohz_idle_retain_tick(void)
> +{
> +	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
> +}
> +
>   /**
>    * tick_nohz_idle_enter - prepare for entering idle on the current CPU
>    *
> @@ -957,7 +993,7 @@ void tick_nohz_idle_enter(void)
>   	lockdep_assert_irqs_enabled();
>   	/*
>   	 * Update the idle state in the scheduler domain hierarchy
> -	 * when tick_nohz_stop_sched_tick() is called from the idle loop.
> +	 * when tick_nohz_stop_tick() is called from the idle loop.
>   	 * State will be updated to busy during the first busy tick after
>   	 * exiting idle.
>   	 */
> @@ -966,6 +1002,9 @@ void tick_nohz_idle_enter(void)
>   	local_irq_disable();
>   
>   	ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	WARN_ON_ONCE(ts->timer_expires_base);
> +
>   	ts->inidle = 1;
>   	tick_nohz_start_idle(ts);
>   
> @@ -1005,15 +1044,31 @@ bool tick_nohz_idle_got_tick(void)
>   }
>   
>   /**
> - * tick_nohz_get_sleep_length - return the length of the current sleep
> + * tick_nohz_get_sleep_length - return the expected length of the current sleep
>    *
>    * Called from power state control code with interrupts disabled
>    */
>   ktime_t tick_nohz_get_sleep_length(void)
>   {
> +	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
>   	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +	int cpu = smp_processor_id();
> +	/*
> +	 * The idle entry time is expected to be a sufficient approximation of
> +	 * the current time at this point.
> +	 */
> +	ktime_t now = ts->idle_entrytime;
> +
> +	WARN_ON_ONCE(!ts->inidle);
> +
> +	if (can_stop_idle_tick(cpu, ts)) {
> +		ktime_t next_event = tick_nohz_next_event(ts, cpu);
> +
> +		if (next_event)
> +			return ktime_sub(next_event, now);
> +	}
>   
> -	return ts->sleep_length;
> +	return ktime_sub(dev->next_event, now);
>   }
>   
>   /**
> @@ -1091,6 +1146,7 @@ void tick_nohz_idle_exit(void)
>   	local_irq_disable();
>   
>   	WARN_ON_ONCE(!ts->inidle);
> +	WARN_ON_ONCE(ts->timer_expires_base);
>   
>   	ts->inidle = 0;
>   
> Index: linux-pm/include/linux/tick.h
> ===================================================================
> --- linux-pm.orig/include/linux/tick.h
> +++ linux-pm/include/linux/tick.h
> @@ -115,6 +115,7 @@ enum tick_dep_bits {
>   extern bool tick_nohz_enabled;
>   extern int tick_nohz_tick_stopped(void);
>   extern void tick_nohz_idle_stop_tick(void);
> +extern void tick_nohz_idle_retain_tick(void);
>   extern void tick_nohz_idle_restart_tick(void);
>   extern void tick_nohz_idle_enter(void);
>   extern void tick_nohz_idle_exit(void);
> @@ -137,6 +138,7 @@ static inline void tick_nohz_idle_stop_t
>   #define tick_nohz_enabled (0)
>   static inline int tick_nohz_tick_stopped(void) { return 0; }
>   static inline void tick_nohz_idle_stop_tick(void) { }
> +static inline void tick_nohz_idle_retain_tick(void) { }
>   static inline void tick_nohz_idle_restart_tick(void) { }
>   static inline void tick_nohz_idle_enter(void) { }
>   static inline void tick_nohz_idle_exit(void) { }
> 
