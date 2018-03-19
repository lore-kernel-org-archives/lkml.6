Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbeCSMbf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:31:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeCSMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:31:34 -0400
Date: Mon, 19 Mar 2018 13:31:17 +0100
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
Message-ID: <20180319123117.GI4043@hirez.programming.kicks-ass.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
 <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
 <2043615.lCdO10SMaB@aspire.rjw.lan>
 <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
 <20180319104900.GH4043@hirez.programming.kicks-ass.net>
 <CAJZ5v0iE-LZ9TyahT7rsJW8zBnKfgnx6C-=SYJrpzspTQXV4zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iE-LZ9TyahT7rsJW8zBnKfgnx6C-=SYJrpzspTQXV4zg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:36:52PM +0100, Rafael J. Wysocki wrote:

> > My brain is just not willing to understand how that work this morning.
> > Also it sounds really dodgy.
> 
> Well, I guess I can't really explain it better. :-)

I'll try again once my brain decides to wake up.

> The reason why this works better than the original v5 is because of
> how menu_update() works AFAICS.

I'll have to go read that first then.

> > +               if (!tick_nohz_idle_got_tick()) {
> > +                       /*
> > +                        * Give the governor an opportunity to reflect on the outcome
> > +                        */
> > +                       cpuidle_reflect(dev, entered_state);
> > +               }
> 
> So I guess the idea is to only invoke menu_update() if the CPU was not
> woken up by the tick, right?
> 
> I would check that in menu_reflect() (as the problem is really with
> the menu governor and not general).
> 
> Also, do we really want to always disregard wakeups from the tick?
> 
> Say, if the governor predicted idle duration of a few microseconds and
> the CPU is woken up by the tick, we want it to realize that it was way
> off, don't we?

The way I look at it is that we should always disregard the tick for
wakeups. Such that we can make an unbiased decision on disabling it.

If the above simple method is the best way to achieve that, probably
not. Because now we 'loose' the idle time, instead of accumulating it.

> >         }
> >
> >  exit_idle:
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -996,6 +996,21 @@ void tick_nohz_idle_enter(void)
> >         local_irq_enable();
> >  }
> >
> > +bool tick_nohz_idle_got_tick(void)
> > +{
> > +       struct tick_sched *ts;
> > +       bool got_tick = false;
> > +
> > +       ts = this_cpu_ptr(&tick_cpu_sched);
> > +
> > +       if (ts->inidle == 2) {
> > +               got_tick = true;
> > +               ts->inidle = 1;
> > +       }
> > +
> > +       return got_tick;
> > +}
> 
> Looks simple enough. :-)

Yes, the obvious fail is that it will not be able to tell if it was the
only wakeup source. Suppose two interrupts fire, the tick and something
else, the above will disregard the idle time, even though it maybe
should not have.

> > +
> >  /**
> >   * tick_nohz_irq_exit - update next tick event from interrupt exit
> >   *
> > @@ -1142,6 +1157,9 @@ static void tick_nohz_handler(struct clo
> >         struct pt_regs *regs = get_irq_regs();
> >         ktime_t now = ktime_get();
> >
> > +       if (ts->inidle)
> > +               ts->inidle = 2;
> > +
> >         dev->next_event = KTIME_MAX;
> >
> >         tick_sched_do_timer(now);
> > @@ -1239,6 +1257,9 @@ static enum hrtimer_restart tick_sched_t
> >         struct pt_regs *regs = get_irq_regs();
> >         ktime_t now = ktime_get();
> >
> > +       if (ts->inidle)
> > +               ts->inidle = 2;
> > +
> 
> Why do we need to do it here?
> 
> >         tick_sched_do_timer(now);
> >
> >         /*

Both are tick handlers, one low-res one high-res. The idea it that the
tick flips the ts->inidle thing from 1->2, which then allows *got_tick()
to detect if we had a tick for wakeup.
