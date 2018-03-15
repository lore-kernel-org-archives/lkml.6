Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCOWU5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:20:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45817 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeCOWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:20:55 -0400
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
Subject: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Thu, 15 Mar 2018 23:19:37 +0100
Message-ID: <2148754.TY7qXgFyZy@aspire.rjw.lan>
In-Reply-To: <2142751.3U6XgWyF8u@aspire.rjw.lan>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the scheduler tick has been stopped already and the governor
selects a shallow idle state, the CPU can spend a long time in that
state if the selection is based on an inaccurate prediction of idle
time.  That effect turns out to be noticeable, so it needs to be
mitigated.

To that end, modify the menu governor to discard the result of the
idle time prediction if the tick is stopped and the predicted idle
time is less than the tick period length, unless the tick timer is
going to expire soon.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5:
  * Rebase on top of the new [1-6/7].
  * Never use the interactivity factor when the tick is stopped.

---
 drivers/cpuidle/governors/menu.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -353,13 +353,28 @@ static int menu_select(struct cpuidle_dr
 	 */
 	data->predicted_us = min(data->predicted_us, expected_interval);
 
-	/*
-	 * Use the performance multiplier and the user-configurable
-	 * latency_req to determine the maximum exit latency.
-	 */
-	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
-	if (latency_req > interactivity_req)
-		latency_req = interactivity_req;
+	if (tick_nohz_tick_stopped()) {
+		/*
+		 * If the tick is already stopped, the cost of possible short
+		 * idle duration misprediction is much higher, because the CPU
+		 * may be stuck in a shallow idle state for a long time as a
+		 * result of it.  In that case say we might mispredict and try
+		 * to force the CPU into a state for which we would have stopped
+		 * the tick, unless the tick timer is going to expire really
+		 * soon anyway.
+		 */
+		if (data->predicted_us < TICK_USEC_HZ)
+			data->predicted_us = min_t(unsigned int, TICK_USEC_HZ,
+						   ktime_to_us(tick_time));
+	} else {
+		/*
+		 * Use the performance multiplier and the user-configurable
+		 * latency_req to determine the maximum exit latency.
+		 */
+		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		if (latency_req > interactivity_req)
+			latency_req = interactivity_req;
+	}
 
 	expected_interval = data->predicted_us;
 	/*
