Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbeCKKa4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:30:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61653 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbeCKKay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:30:54 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v3 5/6] sched: idle: Select idle state before stopping the tick
Date: Sun, 11 Mar 2018 11:31:31 +0100
Message-ID: <1998186.Se6Zm9i2s4@aspire.rjw.lan>
In-Reply-To: <20180311014435.GA30062@lerouge>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <3333184.WFRNK4vEe0@aspire.rjw.lan> <20180311014435.GA30062@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 11, 2018 2:44:37 AM CET Frederic Weisbecker wrote:
> On Fri, Mar 09, 2018 at 10:46:55AM +0100, Rafael J. Wysocki wrote:
> > --- linux-pm.orig/kernel/time/tick-sched.h
> > +++ linux-pm/kernel/time/tick-sched.h
> > @@ -30,6 +30,7 @@ enum tick_nohz_mode {
> >   *			when the CPU returns from nohz sleep.
> >   * @next_tick:		Next tick to be fired when in dynticks mode.
> >   * @tick_stopped:	Indicator that the idle tick has been stopped
> > + * @tick_may_stop:	Indicator that the idle tick may be stopped shortly
> 
> Perhaps we can set timer_expires to 0 instead when we want to invalidate
> the last value?

timer_expires can be 0 for other reasons.

I can use timer_expires_basemono for that (I actually did that in one version
of my patches, but it looked odd and I decided to use a new field for clarity)
if you prefer to avoid adding an extra field.

> >   * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
> >   * @idle_calls:		Total number of idle calls
> >   * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
> > @@ -38,7 +39,6 @@ enum tick_nohz_mode {
> >   * @idle_exittime:	Time when the idle state was left
> >   * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
> >   * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
> > - * @sleep_length:	Duration of the current idle sleep
> >   * @do_timer_lst:	CPU was the last one doing do_timer before going idle
> >   */
> >  struct tick_sched {
> > @@ -49,6 +49,7 @@ struct tick_sched {
> >  	ktime_t				next_tick;
> >  	int				inidle;
> >  	int				tick_stopped;
> > +	int				tick_may_stop;
> >  	unsigned long			idle_jiffies;
> >  	unsigned long			idle_calls;
> >  	unsigned long			idle_sleeps;
> > @@ -58,8 +59,9 @@ struct tick_sched {
> >  	ktime_t				idle_exittime;
> >  	ktime_t				idle_sleeptime;
> >  	ktime_t				iowait_sleeptime;
> > -	ktime_t				sleep_length;
> >  	unsigned long			last_jiffies;
> > +	u64				timer_expires;
> > +	u64				timer_expires_basemono;
> 
> We may need documentation for the above fields too.

OK

> > Index: linux-pm/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-pm.orig/kernel/time/tick-sched.c
> > +++ linux-pm/kernel/time/tick-sched.c
> > @@ -652,13 +652,10 @@ static inline bool local_timer_softirq_p
> >  	return local_softirq_pending() & TIMER_SOFTIRQ;
> >  }
> >  
> > -static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
> > -					 ktime_t now, int cpu)
> > +static ktime_t __tick_nohz_next_event(struct tick_sched *ts, int cpu)
> 
> Since we don't seem to have a lower level version, can we remove the underscores?

Sure, will do.

> >  {
> > -	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
> >  	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
> >  	unsigned long seq, basejiff;
> > -	ktime_t	tick;
> >  
> >  	/* Read jiffies and the time when jiffies were updated last */
> >  	do {
> [...]
> 
> 
> > +static void __tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> 
> (Same comment here about the underscores).

Yup.

> > +{
> > +	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
> > +	u64 basemono = ts->timer_expires_basemono;
> > +	u64 expires = ts->timer_expires;
> > +	ktime_t tick = expires;
> > +
> > +	/* Make sure we won't be trying to stop it twice in a row. */
> > +	ts->tick_may_stop = 0;
> > +
> > +	/*
> > +	 * If this CPU is the one which updates jiffies, then give up
> > +	 * the assignment and let it be taken by the CPU which runs
> > +	 * the tick timer next, which might be this CPU as well. If we
> > +	 * don't drop this here the jiffies might be stale and
> > +	 * do_timer() never invoked. Keep track of the fact that it
> > +	 * was the one which had the do_timer() duty last.
> > +	 */
> > +	if (cpu == tick_do_timer_cpu) {
> > +		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> > +		ts->do_timer_last = 1;
> > +	}
> >  
> >  	/* Skip reprogram of event if its not changed */
> >  	if (ts->tick_stopped && (expires == ts->next_tick)) {
> >  		/* Sanity check: make sure clockevent is actually programmed */
> >  		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
> > -			goto out;
> > +			return;
> >  
> >  		WARN_ON_ONCE(1);
> >  		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
> [...]
> > +void tick_nohz_idle_retain_tick(void)
> > +{
> > +	__this_cpu_write(tick_cpu_sched.tick_may_stop, 0);
> > +}
> > +
> 
> So, I've become overly-paranoid about cached expiration on nohz code, we've run
> into bugs that took months to debug before. It seems that the cached version shouldn't
> leak in any way there, still can we have checks such as this in tick_nohz_idle_enter/exit()?
> 
>      WARN_ON_ONCE(__this_cpu_read(tick_cpu_sched.tick_may_stop));

OK

> Otherwise a leaking cached expiration may mislead further nohz tick stop and
> bypass calls to tick_nohz_next_event().
> 
> Also let's make sure we never call tick_nohz_get_sleep_length() outside idle:
> 
>      WARN_ON_ONCE(!__this_cpu_read(tick_cpu_sched.inidle));

OK

I'll respin the series with the above comments addressed early next week.

Thanks!
