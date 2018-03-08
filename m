Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935911AbeCHRA0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeCHRAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:00:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0840208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 8 Mar 2018 18:00:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 1/6] time: tick-sched: Reorganize idle tick
 management code
Message-ID: <20180308170018.GB11118@lerouge>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan>
 <4136227.b9g9WnMbNJ@aspire.rjw.lan>
 <20180307231827.GA9367@lerouge>
 <1938066.lrFpnYERYl@aspire.rjw.lan>
 <20180308151407.GA11118@lerouge>
 <CAJZ5v0gGzBY2YGLeY-jqRghoDJ_Ao+HxhZkttC-_hS6atrwC1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gGzBY2YGLeY-jqRghoDJ_Ao+HxhZkttC-_hS6atrwC1Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:34:20PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 8, 2018 at 4:14 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > On Thu, Mar 08, 2018 at 10:22:26AM +0100, Rafael J. Wysocki wrote:
> >> On Thursday, March 8, 2018 12:18:29 AM CET Frederic Weisbecker wrote:
> >> > On Tue, Mar 06, 2018 at 10:02:01AM +0100, Rafael J. Wysocki wrote:
> >> > > Index: linux-pm/kernel/time/tick-sched.c
> >> > > ===================================================================
> >> > > --- linux-pm.orig/kernel/time/tick-sched.c
> >> > > +++ linux-pm/kernel/time/tick-sched.c
> >> > > +
> >> > > +/**
> >> > > + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
> >> > > + *
> >> > > + * Called when we start the idle loop.
> >> > > + */
> >> > > +void tick_nohz_idle_prepare(void)
> >> > > +{
> >> > > + struct tick_sched *ts;
> >> > > +
> >> > > + __tick_nohz_idle_prepare();
> >> > > +
> >> > > + local_irq_disable();
> >> > > +
> >> > > + ts = this_cpu_ptr(&tick_cpu_sched);
> >> > > + ts->inidle = 1;
> >> > > +
> >> > > + local_irq_enable();
> >> > > +}
> >> >
> >> > Why not calling tick_nohz_start_idle() from there? This is going to
> >> > simplify the rest, you won't need to call tick_nohz_idle_go_idle()
> >> > from places that don't want to stop the tick and you can then remove
> >> > the stop_tick argument.
> >>
> >> So I guess I would then use ts->idle_entrytime as "now" in the
> >> tick_nohz_get_sleep_length() computation, right?
> >
> > Ah right, I missed the need for ktime_get().
> >
> > You can't use ts->idle_entrytime in tick_nohz_get_sleep_length() because
> > full dynticks doesn't rely on it.
> >
> > But I think you can just do the following, with a comment explaining that
> > idle_entrytime is expected to be fresh enough at this point:
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 57b3de4..8e61796 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -923,7 +923,7 @@ static void __tick_nohz_idle_enter(struct tick_sched *ts, bool stop_tick)
> >
> >                 ts->idle_calls++;
> >
> > -               expires = tick_nohz_stop_sched_tick(ts, now, cpu);
> > +               expires = tick_nohz_stop_sched_tick(ts, ts->idle_entrytime, cpu);
> >                 if (expires > 0LL) {
> >                         ts->idle_sleeps++;
> >                         ts->idle_expires = expires;
> >
> 
> That's what I was thinking about, but ktime_get() seems to be working too.

Well, ktime_get() has its share of overhead, so if we can avoid a call and use
a cache...
