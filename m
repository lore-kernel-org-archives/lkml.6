Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeCJXyn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 18:54:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63427 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeCJXym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 18:54:42 -0500
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
Date: Sun, 11 Mar 2018 00:55:19 +0100
Message-ID: <2205735.WjUm7ivWkF@aspire.rjw.lan>
In-Reply-To: <000701d3b889$eadd5340$c097f9c0$@net>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <007c01d3b843$3d825e70$b8871b50$@net> <000701d3b889$eadd5340$c097f9c0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
> > On Saturday, March 10, 2018 8:41:39 AM CET Doug Smythies wrote:
> >> 
> >> With apologies to those that do not like the term "PowerNightmares",
> >
> > OK, and what exactly do you count as "PowerNightmares"?
> 
> I'll snip some below and then explain:
> 
> ...[snip]...
> 
> >> 
> >> Kernel 4.16-rc4: Summary: Average processor package power 27.41 watts
> >> 
> >> Idle State 0: Total Entries: 9096 : PowerNightmares: 6540 : Not PN time (seconds): 0.051532 : PN time: 7886.309553 : Ratio:
> 153037.133492
> >> Idle State 1: Total Entries: 28731 : PowerNightmares: 215 : Not PN time (seconds): 0.211999 : PN time: 77.395467 : Ratio:
> 365.074679
> >> Idle State 2: Total Entries: 4474 : PowerNightmares: 97 : Not PN time (seconds): 1.959059 : PN time: 0.874112 : Ratio: 0.446190
> >> Idle State 3: Total Entries: 2319 : PowerNightmares: 0 : Not PN time (seconds): 1.663376 : PN time: 0.000000 : Ratio: 0.000000
> 
> O.K. let's go deeper than the summary, and focus on idle state 0, which has been my area of interest in this saga.
> 
> Idle State 0:
> CPU: 0: Entries: 2093 : PowerNightmares: 1136 : Not PN time (seconds): 0.024840 : PN time: 1874.417840 : Ratio: 75459.655439
> CPU: 1: Entries: 1051 : PowerNightmares: 721 : Not PN time (seconds): 0.004668 : PN time: 198.845193 : Ratio: 42597.513425
> CPU: 2: Entries: 759 : PowerNightmares: 583 : Not PN time (seconds): 0.003299 : PN time: 1099.069256 : Ratio: 333152.246028
> CPU: 3: Entries: 1033 : PowerNightmares: 1008 : Not PN time (seconds): 0.000361 : PN time: 1930.340683 : Ratio: 5347203.995237
> CPU: 4: Entries: 1310 : PowerNightmares: 1025 : Not PN time (seconds): 0.006214 : PN time: 1332.497114 : Ratio: 214434.682950
> CPU: 5: Entries: 1097 : PowerNightmares: 848 : Not PN time (seconds): 0.005029 : PN time: 785.366864 : Ratio: 156167.601340
> CPU: 6: Entries: 1753 : PowerNightmares: 1219 : Not PN time (seconds): 0.007121 : PN time: 665.772603 : Ratio: 93494.256958
> 
> Note: CPU 7 is busy and doesn't go into idle at all.
> 
> And also look at the histograms of the times spent in idle state 0:
> CPU 3 might be the most interesting:
> 
> Idle State: 0  CPU: 3:
> 4 1
> 5 3
> 7 2
> 11 1
> 12 1
> 13 2
> 14 3
> 15 3
> 17 4
> 18 1
> 19 2
> 28 2
> 7563 1
> 8012 1
> 9999 1006
> 
> Where:
> Column 1 is the time in microseconds it was in that idle state
> up to 9999 microseconds, which includes anything more.
> Column 2 is the number of occurrences of that time.
> 
> Notice that 1008 times out of the 1033, it spent an excessive amount
> of time in idle state 0, leading to excessive power consumption.
> I adopted Thomas Ilsche's "Powernightmare" term for this several
> months ago.
> 
> This CPU 3 example was pretty clear, but sometimes it is not so
> obvious. I admit that my thresholds for is it a "powernigthmare" or
> not are somewhat arbitrary, and I'll change them to whatever anybody
> wants. Currently:
> 
> #define THRESHOLD_0 100       /* Idle state 0 PowerNightmare threshold in microseconds */
> #define THRESHOLD_1 1000      /* Idle state 1 PowerNightmare threshold in microseconds */
> #define THRESHOLD_2 2000      /* Idle state 2 PowerNightmare threshold in microseconds */
> #define THRESHOLD_3 4000      /* Idle state 3 PowerNightmare threshold in microseconds */

That's clear, thanks!

Well, the main reason why I have a problem with the "powernigthmare" term is
because it is somewhat arbitrary overall.  After all, you ended up having to
explain what you meant in detail even though you have used it in the
previous message, so it doesn't appear all that useful to me. :-)

Also, the current work isn't even concerned about idle times below the
length of the tick period, so the information that some CPUs spent over
100 us in state 0 for a certain number of times during the test is not that
relevant here.  The information that they often spend more time than a tick
period in state 0 in one go *is* relevant, though.

The $subject patch series, on the one hand, is about adding a safety net for
possible governor mispredictions using the existing tick infrastructure,
along with avoiding unnecessary timer manipulation overhead related to the
stopping and starting of the tick, on the other hand.  Of course, the safety
net will not improve the accuracy of governor predictions anyway, it may only
reduce their impact.

That said, it doesn't catch one case which turns out to be quite significant
and which is when the tick is stopped already and the governor predicts short
idle.  That, again, may cause the CPU to spend a long time in a shallow idle
state which then will qualify as a "powernightmare" I suppose.  If I'm reading
your data correctly, that is the main reason for the majority of cases in which
CPUs spend 9999 us and more in state 0 on your system.

That issue can be dealt with in a couple of ways and the patch below is a
rather straightforward attempt to do that.  The idea, basically, is to discard
the result of governor prediction if the tick has been stopped alread and
the predicted idle duration is within the tick range.

Please try it on top of the v3 and tell me if you see an improvement.

Thanks!

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
 drivers/cpuidle/governors/menu.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

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
@@ -354,6 +356,17 @@ static int menu_select(struct cpuidle_dr
 	data->predicted_us = min(data->predicted_us, expected_interval);
 
 	/*
+	 * If the tick is already stopped, the cost of possible misprediction is
+	 * much higher, because the CPU may be stuck in a shallow idle state for
+	 * a long time as a result of it.  For this reason, if that happens say
+	 * we might mispredict and try to force the CPU into a state for which
+	 * we would have stopped the tick, unless the tick timer is going to
+	 * expire really soon anyway.
+	 */
+	if (tick_nohz_tick_stopped() && data->predicted_us < TICK_USEC_HZ)
+		data->predicted_us = min_t(unsigned int, TICK_USEC_HZ, tick_us);
+
+	/*
 	 * Use the performance multiplier and the user-configurable
 	 * latency_req to determine the maximum exit latency.
 	 */
@@ -403,8 +416,6 @@ static int menu_select(struct cpuidle_dr
 		 */
 		if (first_idx > idx &&
 		    drv->states[first_idx].target_residency < TICK_USEC_HZ) {
-			unsigned int tick_us = ktime_to_us(tick_time);
-
 			/*
 			 * Find a state with target residency less than the
 			 * time to the next timer event including the tick.
