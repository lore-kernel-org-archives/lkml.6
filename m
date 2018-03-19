Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeCSKtX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:49:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754894AbeCSKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:49:15 -0400
Date: Mon, 19 Mar 2018 11:49:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Message-ID: <20180319104900.GH4043@hirez.programming.kicks-ass.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
 <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
 <2043615.lCdO10SMaB@aspire.rjw.lan>
 <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 05:15:22PM +0100, Rafael J. Wysocki wrote:
> On Sun, Mar 18, 2018 at 12:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > @@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
> >         if (latency_req > interactivity_req)
> >                 latency_req = interactivity_req;
> >
> > +       expected_interval = TICK_USEC_HZ;
> >         /*
> >          * Find the idle state with the lowest power while satisfying
> >          * our constraints.
> > @@ -367,17 +374,44 @@ static int menu_select(struct cpuidle_dr
> >                         continue;
> >                 if (idx == -1)
> >                         idx = i; /* first enabled state */
> > -               if (s->target_residency > data->predicted_us)
> > +               if (s->target_residency > data->predicted_us) {
> > +                       /*
> > +                        * Retain the tick if the selected state is shallower
> > +                        * than the deepest available one with target residency
> > +                        * within the tick period range.
> > +                        *
> > +                        * This allows the tick to be stopped even if the
> > +                        * predicted idle duration is within the tick period
> > +                        * range to counter the effect by which the prediction
> > +                        * may be skewed towards lower values due to the tick
> > +                        * bias.
> > +                        */
> > +                       expected_interval = s->target_residency;
> >                         break;
> 
> BTW, I guess I need to explain the motivation here more thoroughly, so
> here it goes.
> 
> The governor predicts idle duration under the assumption that the
> tick will be stopped, so if the result of the prediction is within the tick
> period range and it is not accurate, that needs to be taken into
> account in the governor's statistics.  However, if the tick is allowed
> to run every time the governor predicts idle duration within the tick
> period range, the governor will always see that it was "almost
> right" and the correction factor applied by it to improve the
> prediction next time will not be sufficient.  For this reason, it
> is better to stop the tick at least sometimes when the governor
> predicts idle duration within the tick period range and the idea
> here is to do that when the selected state is the deepest available
> one with the target residency within the tick period range.  This
> allows the opportunity to save more energy to be seized which
> balances the extra overhead of stopping the tick.

My brain is just not willing to understand how that work this morning.
Also it sounds really dodgy.

Should we not look to something like this instead?

---
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -119,6 +119,7 @@ extern void tick_nohz_idle_stop_tick(voi
 extern void tick_nohz_idle_retain_tick(void);
 extern void tick_nohz_idle_restart_tick(void);
 extern void tick_nohz_idle_enter(void);
+extern bool tick_nohz_idle_got_tick(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
@@ -142,6 +143,7 @@ static inline void tick_nohz_idle_stop_t
 static inline void tick_nohz_idle_retain_tick(void) { }
 static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
+static inline bool tick_nohz_idle_got_tick(void) { return false; }
 static inline void tick_nohz_idle_exit(void) { }
 
 static inline ktime_t tick_nohz_get_sleep_length(void)
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -198,10 +198,13 @@ static void cpuidle_idle_call(void)
 		rcu_idle_enter();
 
 		entered_state = call_cpuidle(drv, dev, next_state);
-		/*
-		 * Give the governor an opportunity to reflect on the outcome
-		 */
-		cpuidle_reflect(dev, entered_state);
+
+		if (!tick_nohz_idle_got_tick()) {
+			/*
+			 * Give the governor an opportunity to reflect on the outcome
+			 */
+			cpuidle_reflect(dev, entered_state);
+		}
 	}
 
 exit_idle:
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -996,6 +996,21 @@ void tick_nohz_idle_enter(void)
 	local_irq_enable();
 }
 
+bool tick_nohz_idle_got_tick(void)
+{
+	struct tick_sched *ts;
+	bool got_tick = false;
+
+	ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (ts->inidle == 2) {
+		got_tick = true;
+		ts->inidle = 1;
+	}
+
+	return got_tick;
+}
+
 /**
  * tick_nohz_irq_exit - update next tick event from interrupt exit
  *
@@ -1142,6 +1157,9 @@ static void tick_nohz_handler(struct clo
 	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
+	if (ts->inidle)
+		ts->inidle = 2;
+
 	dev->next_event = KTIME_MAX;
 
 	tick_sched_do_timer(now);
@@ -1239,6 +1257,9 @@ static enum hrtimer_restart tick_sched_t
 	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
+	if (ts->inidle)
+		ts->inidle = 2;
+
 	tick_sched_do_timer(now);
 
 	/*
