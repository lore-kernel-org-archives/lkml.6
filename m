Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCYVkq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:40:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49772 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCYVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:40:43 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sun, 25 Mar 2018 23:41:04 +0200
Message-ID: <2526191.VkKmyUxKDp@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0hhrFrPj834pR6COcF_nJ8Xm7qYJeW9oJUQ0Pe9bGTRuw@mail.gmail.com>
References: <001401d3c3d0$2a4623d0$7ed26b70$@net> <CAJZ5v0hhrFrPj834pR6COcF_nJ8Xm7qYJeW9oJUQ0Pe9bGTRuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 25, 2018 1:53:42 PM CEST Rafael J. Wysocki wrote:
> On Sun, Mar 25, 2018 at 1:28 AM, Doug Smythies <dsmythies@telus.net> wrote:
> > On 2018.03.14 07:04 Rafael J. Wysocki wrote:
> >
> >> If poll_idle() is allowed to spin until need_resched() returns 'true',
> >> it may actually spin for a much longer time than expected by the idle
> >> governor, since set_tsk_need_resched() is not always called by the
> >> timer interrupt handler.  If that happens, the CPU may spend much
> >> more time than anticipated in the "polling" state.
> >>
> >> To prevent that from happening, limit the time of the spinning loop
> >> in poll_idle().
> >
> > ...[snip]...
> >
> >> +#define POLL_IDLE_TIME_LIMIT (TICK_NSEC / 16)
> >
> > The other ongoing threads on this aside, potentially, there might
> > be another issue.
> >
> > What if the next available idle state, after 0, has a residency
> > that is greater than TICK_NSEC / 16? Meaning these numbers, for example:
> >
> > /sys/devices/system/cpu/cpu0/cpuidle/state*/residency
> >
> > The suggestion is that upon a timeout exit from idle state 0,
> > the measured_us should maybe be rejected, because the statistics
> > are being biased and it doesn't seem to correct itself.
> 
> OK
> 
> > Up to 1300% (<- not a typo) extra power consumption has been observed.
> >
> > Supporting experimental data:
> >
> > My processor:
> > /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> > /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> > /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:211 <<< Important
> > /sys/devices/system/cpu/cpu0/cpuidle/state4/residency:345
> >
> > A 1000 Hz kernel (TICK_NSEC/16) = 62.5 nsec; idle system:
> 
> nsec or usec?
> 
> > Idle state 0 time: Typically 0 uSec.
> > Processor package power: 3.7 watts (steady)
> >
> > Now, disable idle states 1 and 2:
> >
> > Idle state 0 time (all 8 CPUs): ~~ 430 Seconds / minute
> > Processor package power: ~52 watts (1300% more power, 14X)
> 
> But that's because you have disabled states 1 and 2, isn't it?
> 
> > A 250 Hz kernel (TICK_NSEC/16) = 250 nSec; idle system:
> >
> > Idle state 0 time: Typically < 1 mSec / minute
> > Processor package power: 3.7 to 3.8 watts
> >
> > Now, disable idle states 1 and 2:
> >
> > Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
> > Processor package power: 3.7 to 3.8 watts
> >
> > A 1000 Hz kernel with:
> >
> > +#define POLL_IDLE_TIME_LIMIT   (TICK_NSEC / 4)
> >
> > Note: Just for a test. I am not suggesting this should change.
> >
> > instead. i.e. (TICK_NSEC/4) = 250 nSec.
> >
> > Idle state 0 time: Typically 0 uSec.
> > Processor package power: 3.7 watts (steady)
> >
> > Now, disable idle states 1 and 2:
> >
> > Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
> > Processor package power: ~3.8 watts
> >
> > Note 1: My example is contrived via disabling idle states, so
> > I don't know if it actually needs to be worried about.
> >
> > Note 2: I do not know if there is some processor where
> > cpuidle/state1/residency is > 62.5 nSec.
> 
> If that's usec, I would be quite surprised if there were any. :-)
> 
> > Note 3: I am trying to figure out a way to test rejecting
> > measured_us upon timeout exit, but haven't made much progress.
> 
> Rejecting it has side effects too, because it basically means lost information.
> 
> Reaching the time limit means that the CPU could have been idle much
> longer, even though we can't say how much.  That needs to be recorded
> in the data used for the next-time prediction or that is going to be
> inaccurate too.
> 
> Of course, what number to record is a good question. :-)

Chances are that the appended patch will help.

Instead of trying to figure out what to do with measured_us after the fact it
tries to make the target residency of the next available state sit within the
time limit that's going to be used.

I'm not sure if "tick period / 16" is a sufficient margin, though.  If not, it
may be necessary to take 2 * target_residency + POLL_IDLE_TIME_LIMIT as the
limit or similar.

---
 drivers/cpuidle/poll_state.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -20,7 +20,23 @@ static int __cpuidle poll_idle(struct cp
 	current_enable_polling();
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
+		u64 limit = POLL_IDLE_TIME_LIMIT;
 		unsigned int loop_count = 0;
+		int i;
+
+		/*
+		 * Make sure that the next available state is within the limit
+		 * we are going to use to make it more likely to be selected
+		 * next time.
+		 */
+		for (i = index + 1; i < drv->state_count; i++) {
+			struct cpuidle_state *s = &drv->states[i];
+
+			if (!s->disabled && !dev->states_usage[i].disable) {
+				limit += (u64)s->target_residency * NSEC_PER_USEC;
+				break;
+			}
+		}
 
 		while (!need_resched()) {
 			cpu_relax();
@@ -34,7 +50,7 @@ static int __cpuidle poll_idle(struct cp
 				continue;
 
 			loop_count = 0;
-			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
+			if (local_clock() - time_start > limit)
 				break;
 		}
 	}
