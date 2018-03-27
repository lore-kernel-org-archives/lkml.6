Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeC0V62 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:58:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65513 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeC0V60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:58:26 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuidle: poll_state: Avoid invoking local_clock() too often
Date: Tue, 27 Mar 2018 23:58:45 +0200
Message-ID: <2095821.OCbkRpinqI@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rik reports that he sees an increase in CPU use in one benchmark
due to commit 612f1a22f067 "cpuidle: poll_state: Add time limit to
poll_idle()" that caused poll_idle() to call local_clock() in every
iteration of the loop.  Utilization increase generally means more
non-idle time with respect to total CPU time (on the average) which
implies reduced CPU frequency.

Doug reports that limiting the rate of local_clock() invocations
in there causes much less power to be drawn during a CPU-intensive
parallel workload (with idle states 1 and 2 disabled to enforce more
state 0 residency).

These two reports together suggest that executing local_clock() on
multiple CPUs in parallel at a high rate may cause chips to get hot
and trigger thermal/power limits on them to kick in, so reduce the
rate of local_clock() invocations in poll_idle() to avoid that issue.

Fixes: 612f1a22f067 "cpuidle: poll_state: Add time limit to poll_idle()"
Reported-by: Rik van Riel <riel@surriel.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I've settled for POLL_IDLE_RELAX_COUNT = 200 after quite a bit of
back-and-forth and a number of test runs.

It may need to be refined going forward if somebody has a problem with
the current one.

---
 drivers/cpuidle/poll_state.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -10,6 +10,7 @@
 #include <linux/sched/idle.h>
 
 #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
+#define POLL_IDLE_RELAX_COUNT	200
 
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
@@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
 
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
+		unsigned int loop_count = 0;
+
 		while (!need_resched()) {
 			cpu_relax();
+			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
+				continue;
 
+			loop_count = 0;
 			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
 				break;
 		}
