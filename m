Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDFM4h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:56:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54507 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeDFM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:56:27 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 05/10] cpuidle: Return nohz hint from cpuidle_select()
Date: Fri, 06 Apr 2018 14:56:36 +0200
Message-ID: <34634950.bjF6TWOVDx@aspire.rjw.lan>
In-Reply-To: <6471749.luEdDuCiOl@aspire.rjw.lan>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <20180406024413.GB4400@lerouge> <6471749.luEdDuCiOl@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 6, 2018 10:11:04 AM CEST Rafael J. Wysocki wrote:
> On Friday, April 6, 2018 4:44:14 AM CEST Frederic Weisbecker wrote:
> > On Wed, Apr 04, 2018 at 10:39:50AM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Index: linux-pm/kernel/time/tick-sched.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/time/tick-sched.c
> > > +++ linux-pm/kernel/time/tick-sched.c
> > > @@ -991,6 +991,20 @@ void tick_nohz_irq_exit(void)
> > >  }

[cut]

> So what about this?  And moving the duplicated piece of got_idle_tick
> manipulation on top of it?

And appended is a patch to get rid of the code duplication (on top of the one
below), for completeness.

> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Subject: [PATCH] nohz: Gather tick_sched booleans under a common flag field
> 
> Optimize the space and leave plenty of room for further flags.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> [ rjw: Do not use __this_cpu_read() to access tick_stopped and add
>        got_idle_tick to avoid overloading inidle ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/time/tick-sched.c |   12 +++++++-----
>  kernel/time/tick-sched.h |   12 ++++++++----
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/kernel/time/tick-sched.h
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.h
> +++ linux-pm/kernel/time/tick-sched.h
> @@ -41,19 +41,24 @@ enum tick_nohz_mode {
>   * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
>   * @timer_expires_base:	Base time clock monotonic for @timer_expires
>   * @do_timer_lst:	CPU was the last one doing do_timer before going idle
> + * @got_idle_tick:	Tick timer function has run with @inidle set
>   */
>  struct tick_sched {
>  	struct hrtimer			sched_timer;
>  	unsigned long			check_clocks;
>  	enum tick_nohz_mode		nohz_mode;
> +
> +	unsigned int			inidle		: 1;
> +	unsigned int			tick_stopped	: 1;
> +	unsigned int			idle_active	: 1;
> +	unsigned int			do_timer_last	: 1;
> +	unsigned int			got_idle_tick	: 1;
> +
>  	ktime_t				last_tick;
>  	ktime_t				next_tick;
> -	int				inidle;
> -	int				tick_stopped;
>  	unsigned long			idle_jiffies;
>  	unsigned long			idle_calls;
>  	unsigned long			idle_sleeps;
> -	int				idle_active;
>  	ktime_t				idle_entrytime;
>  	ktime_t				idle_waketime;
>  	ktime_t				idle_exittime;
> @@ -64,7 +69,6 @@ struct tick_sched {
>  	u64				timer_expires_base;
>  	u64				next_timer;
>  	ktime_t				idle_expires;
> -	int				do_timer_last;
>  	atomic_t			tick_dep_mask;
>  };
>  
> Index: linux-pm/kernel/time/tick-sched.c
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.c
> +++ linux-pm/kernel/time/tick-sched.c
> @@ -465,7 +465,9 @@ __setup("nohz=", setup_tick_nohz);
>  
>  bool tick_nohz_tick_stopped(void)
>  {
> -	return __this_cpu_read(tick_cpu_sched.tick_stopped);
> +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	return ts->tick_stopped;
>  }
>  
>  bool tick_nohz_tick_stopped_cpu(int cpu)
> @@ -1014,8 +1016,8 @@ bool tick_nohz_idle_got_tick(void)
>  {
>  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>  
> -	if (ts->inidle > 1) {
> -		ts->inidle = 1;
> +	if (ts->got_idle_tick) {
> +		ts->got_idle_tick = 0;
>  		return true;
>  	}
>  	return false;
> @@ -1161,7 +1163,7 @@ static void tick_nohz_handler(struct clo
>  	ktime_t now = ktime_get();
>  
>  	if (ts->inidle)
> -		ts->inidle = 2;
> +		ts->got_idle_tick = 1;
>  
>  	dev->next_event = KTIME_MAX;
>  
> @@ -1261,7 +1263,7 @@ static enum hrtimer_restart tick_sched_t
>  	ktime_t now = ktime_get();
>  
>  	if (ts->inidle)
> -		ts->inidle = 2;
> +		ts->got_idle_tick = 1;
>  
>  	tick_sched_do_timer(now);
>  

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] nohz: Avoid duplication of code related to got_idle_tick

Move the code setting ts->got_idle_tick into tick_sched_do_timer() to
avoid code duplication.

No intentional changes in functionality.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-sched.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -113,8 +113,7 @@ static ktime_t tick_init_jiffy_update(vo
 	return period;
 }
 
-
-static void tick_sched_do_timer(ktime_t now)
+static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
 
@@ -134,6 +133,9 @@ static void tick_sched_do_timer(ktime_t
 	/* Check, if the jiffies need an update */
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
+
+	if (ts->inidle)
+		ts->got_idle_tick = 1;
 }
 
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
@@ -1162,12 +1164,9 @@ static void tick_nohz_handler(struct clo
 	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
-	if (ts->inidle)
-		ts->got_idle_tick = 1;
-
 	dev->next_event = KTIME_MAX;
 
-	tick_sched_do_timer(now);
+	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
 	/* No need to reprogram if we are running tickless  */
@@ -1262,10 +1261,7 @@ static enum hrtimer_restart tick_sched_t
 	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
-	if (ts->inidle)
-		ts->got_idle_tick = 1;
-
-	tick_sched_do_timer(now);
+	tick_sched_do_timer(ts, now);
 
 	/*
 	 * Do not call, when we are not in irq context and have
