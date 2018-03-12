Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeCLKHh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:07:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64466 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeCLKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:07:33 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH v4 7/7] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Mon, 12 Mar 2018 11:07:45 +0100
Message-ID: <1830879.SVjpsft0sO@aspire.rjw.lan>
In-Reply-To: <2352117.3UUoYAu18A@aspire.rjw.lan>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the scheduler tick has been stopped already and the governor
selects a shallow idle state, the CPU may spend a long time in that
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
