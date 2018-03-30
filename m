Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeC3JkU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:40:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51590 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeC3JjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:39:00 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v7.3 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Fri, 30 Mar 2018 11:39:16 +0200
Message-ID: <24561274.DadG5k7Qxl@aspire.rjw.lan>
In-Reply-To: <8197de8d-db1f-107e-e224-2b9600bf8a87@tu-dresden.de>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <7336733.EjMJpVF2xN@aspire.rjw.lan> <8197de8d-db1f-107e-e224-2b9600bf8a87@tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 28, 2018 11:14:36 AM CEST Thomas Ilsche wrote:
> On 2018-03-22 18:40, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Add a new pointer argument to cpuidle_select() and to the ->select
> > cpuidle governor callback to allow a boolean value indicating
> > whether or not the tick should be stopped before entering the
> > selected state to be returned from there.
> > 
> > Make the ladder governor ignore that pointer (to preserve its
> > current behavior) and make the menu governor return 'false" through
> > it if:
> >   (1) the idle exit latency is constrained at 0, or
> >   (2) the selected state is a polling one, or
> >   (3) the expected idle period duration is within the tick period
> >       range.
> > 
> > In addition to that, the correction factor computations in the menu
> > governor need to take the possibility that the tick may not be
> > stopped into account to avoid artificially small correction factor
> > values.  To that end, add a mechanism to record tick wakeups, as
> > suggested by Peter Zijlstra, and use it to modify the menu_update()
> > behavior when tick wakeup occurs.  Namely, if the CPU is woken up by
> > the tick and the return value of tick_nohz_get_sleep_length() is not
> > within the tick boundary, the predicted idle duration is likely too
> > short, so make menu_update() try to compensate for that by updating
> > the governor statistics as though the CPU was idle for a long time.
> > 
> > Since the value returned through the new argument pointer of
> > cpuidle_select() is not used by its caller yet, this change by
> > itself is not expected to alter the functionality of the code.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > One more revision here.
> > 
> >  From the Thomas Ilsche's testing on the Skylake server it looks like
> > data->intervals[] need to be updated along with the correction factor
> > on tick wakeups that occur when next_timer_us is above the tick boundary.
> > 
> > The difference between this and the original v7 (of patch [5/8]) is
> > what happens in menu_update().  This time next_timer_us is checked
> > properly and if that is above the tick boundary and a tick wakeup occurs,
> > the function simply sets mesured_us to a large constant and uses that to
> > update both the correction factor and data->intervals[] (the particular
> > value used in this patch was found through a bit of experimentation).
> > 
> > Let's see how this works for Thomas and Doug.
> > 
> > For easier testing there is a git branch containing this patch (and the
> > rest of the series) at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >   idle-loop-v7.3
> > 
> > Thanks!
> 
> Besides the other issue with tick_nohz_get_sleep_length, v7.3
> generally works well in idle.

Great, thanks!

> So far I don't see anything
> statistically noticeable, but I saw one peculiar anomaly. After all
> cores woke up simultaneously to schedule some kworker task, some of
> them kept the sched tick up, even stayed in shallow sleep state for a
> while, without having any tasks scheduled. Gradually they chose deeper
> sleep states and stopped their sched ticks. After 23 ms (1000 Hz
> kernel), they all went back to deep sleep.
> 
> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_3_skl_sp_anomaly.png
> 
> I have only seen this once so far and can't reproduce it yet, so this
> particular instance may not be an issue in practice.

OK

> However my fundamental concerns about the policy whether to disable the sched
> tick remain:
> 
> Mixing the precise timer and vague heuristic for the decision is
> dangerous. The timer should not be wrong, heuristic may be.

Well, I wouldn't say "dangerous".  It may be suboptimal, but even that is not
a given.  Besides ->

> Decisions should use actual time points rather than the generic tick
> duration and residency time. e.g.
>        expected_interval < delta_next_us
> vs
>        expected_interval < TICK_USEC

-> the role of this check is to justify taking the overhead of stopping the
tick and it certainly is justifiable if the governor doesn't anticipate any
wakeups (timer or not) in the TICK_USEC range.  It may be justifiable in
other cases too, but that's a matter of some more complex checks and may not
be worth the extra complexity at all.

> For some cases the unmodified sched tick is not efficient as fallback.
> Is it feasible to
> 1) enable the sched tick when it's currently disabled instead of
> blindly choosing a different C state?

It is not "blindly" if you will.  It is very much "consciously". :-)

Restarting the tick from within menu_select() wouldn't work IMO and
restarting it from cpuidle_idle_call() every time it was stopped might
be wasteful.

It could be done, but AFAICS if the CPU in deep idle is woken up by an
occasional interrupt that doesn't set need_resched, it is more likely
to go into deep idle again than to go into shallow idle at that point.

> 2) modify the next upcoming sched tick to be better suitable as
> fallback timer?

Im not sure what you mean.

> I think with the infrastructure changes it should be possible to
> implement the policy I envisioned previously
> (https://marc.info/?l=linux-pm&m=151384941425947&w=2), which is based
> on the ordering of timers and the heuristically predicted idle time.
> If the sleep_length issue is fixed and I have some mechanism for a
> modifiable fallback timer, I'll try to demonstrate that on top of your
> changes.

Sure.  I'm not against adding more complexity to this in principle, but there
needs to be a good enough justification for it.

As I said in one of the previous messages, if simple code gets the job done,
the extra complexity may just not be worth it.  That's why I went for very
simple code here.  Still, if there is a clear case for making it more complex,
that can be done.

Thanks!
