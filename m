Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeCKKd0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:33:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43191 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbeCKKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:33:24 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rik van Riel'" <riel@surriel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
Subject: Re: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sun, 11 Mar 2018 11:34:02 +0100
Message-ID: <9753539.XXhq7nys8q@aspire.rjw.lan>
In-Reply-To: <1773378.CTekz94moy@aspire.rjw.lan>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <001801d3b90c$99232600$cb697200$@net> <1773378.CTekz94moy@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 11, 2018 11:21:36 AM CET Rafael J. Wysocki wrote:
> On Sunday, March 11, 2018 8:43:02 AM CET Doug Smythies wrote:
> > On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
> > >On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
> > >> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
> > >
> > ... [snip] ...
> > 
> > > The information that they often spend more time than a tick
> > > period in state 0 in one go *is* relevant, though.
> > >
> > >
> > > That issue can be dealt with in a couple of ways and the patch below is a
> > > rather straightforward attempt to do that.  The idea, basically, is to discard
> > > the result of governor prediction if the tick has been stopped alread and
> > > the predicted idle duration is within the tick range.
> > >
> > > Please try it on top of the v3 and tell me if you see an improvement.
> > 
> > It seems pretty good so far.
> > See a new line added to the previous graph, "rjwv3plus".
> > 
> > http://fast.smythies.com/rjwv3plus_100.png
> 
> OK, cool!
> 
> Below is a respin of the last patch which also prevents shallow states from
> being chosen due to interactivity_req when the tick is stopped.

Actually appending the patch this time, sorry.

> You may also add a poll_idle() fix I've just posted:
> 
> https://patchwork.kernel.org/patch/10274595/
> 
> on top of this.  It makes quite a bit of a difference for me. :-)
> 
> > I'll do another 100% load on one CPU test overnight, this time with
> > a trace.
> 
> Thanks!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpuidle: menu: Avoid selecting shallow states with stopped tick

If the scheduler tick has been stopped already and the governor
selects a shallow idle state, the CPU can spend a long time in that
state if the selection is based on an inaccurate prediction of idle
period duration.  That effect turns out to occur relatively often,
so it needs to be mitigated.

To that end, modify the menu governor to discard the result of the
idle period duration prediction if it is less than the tick period
duration and the tick is stopped, unless the tick timer is going to
expire soon.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -297,6 +297,7 @@ static int menu_select(struct cpuidle_dr
 	unsigned long nr_iowaiters, cpu_load;
 	int resume_latency = dev_pm_qos_raw_read_value(device);
 	ktime_t tick_time;
+	unsigned int tick_us;
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -315,6 +316,7 @@ static int menu_select(struct cpuidle_dr
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&tick_time));
+	tick_us = ktime_to_us(tick_time);
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
@@ -354,12 +356,24 @@ static int menu_select(struct cpuidle_dr
 	data->predicted_us = min(data->predicted_us, expected_interval);
 
 	/*
-	 * Use the performance multiplier and the user-configurable
-	 * latency_req to determine the maximum exit latency.
+	 * If the tick is already stopped, the cost of possible misprediction is
+	 * much higher, because the CPU may be stuck in a shallow idle state for
+	 * a long time as a result of it.  For this reason, if that happens say
+	 * we might mispredict and try to force the CPU into a state for which
+	 * we would have stopped the tick, unless the tick timer is going to
+	 * expire really soon anyway.
 	 */
-	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
-	if (latency_req > interactivity_req)
-		latency_req = interactivity_req;
+	if (tick_nohz_tick_stopped() && data->predicted_us < TICK_USEC_HZ) {
+		data->predicted_us = min_t(unsigned int, TICK_USEC_HZ, tick_us);
+	} else {
+		/*
+		 * Use the performance multiplier and the user-configurable
+		 * latency_req to determine the maximum exit latency.
+		 */
+		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		if (latency_req > interactivity_req)
+			latency_req = interactivity_req;
+	}
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
@@ -403,8 +417,6 @@ static int menu_select(struct cpuidle_dr
 		 */
 		if (first_idx > idx &&
 		    drv->states[first_idx].target_residency < TICK_USEC_HZ) {
-			unsigned int tick_us = ktime_to_us(tick_time);
-
 			/*
 			 * Find a state with target residency less than the
 			 * time to the next timer event including the tick.
