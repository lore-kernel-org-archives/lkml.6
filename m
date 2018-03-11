Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeCKKPN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:15:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41952 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932116AbeCKKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:15:12 -0400
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
Subject: [PATCH] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sun, 11 Mar 2018 11:15:49 +0100
Message-ID: <6734090.QOs8nIFVJO@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If poll_idle() is allowed to spin until need_resched() returns 'true',
it may actually spin for a much longer time than expected by the idle
governor, since set_tsk_need_resched() is not always called by the
timer interrupt handler.  If that happens, the CPU may spend much
more time than anticipated in the "polling" state.

To prevent that from happening, limit the time of the spinning loop
in poll_idle().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/poll_state.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -5,16 +5,31 @@
  */
 
 #include <linux/cpuidle.h>
+#include <linux/ktime.h>
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 
+#define POLL_IDLE_TIME_CHECK_COUNT	10000
+#define POLL_IDLE_TIME_LIMIT		(TICK_NSEC / 16)
+
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
+	ktime_t start = ktime_get();
+
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		while (!need_resched())
+		unsigned int time_check_counter = 0;
+
+		while (!need_resched()) {
 			cpu_relax();
+			if (time_check_counter++ < POLL_IDLE_TIME_CHECK_COUNT)
+				continue;
+
+			time_check_counter = 0;
+			if (ktime_sub(ktime_get(), start) > POLL_IDLE_TIME_LIMIT)
+				break;
+		}
 	}
 	current_clr_polling();
 
