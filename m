Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeCRLAR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 07:00:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57320 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeCRLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 07:00:15 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Sun, 18 Mar 2018 12:00:44 +0100
Message-ID: <2043615.lCdO10SMaB@aspire.rjw.lan>
In-Reply-To: <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 17, 2018 5:11:53 PM CET Doug Smythies wrote:
> On 2018.03.17 Thomas Ilsche wrote:
> 
> > Over the last week I tested v4+pollv2 and now v5+pollv3. With v5, I
> > observe a particular idle behavior, that I have not seen before with
> > v4. On a dual-socket Skylake system the idle power increases from
> > 74.1 W (system total) to 85.5 W with a 300 HZ build and even to
> > 138.3 W with a 1000 HZ build. A similar Haswell-EP system is also
> > affected.
> 
> I confirm your idle findings. There is a regression between V4 and V5.
> The differences on my test computer are much less than on yours,
> probably because I have only 8 CPUs.
> 
> http://fast.smythies.com/rjw_idle.png
> 
> 1000 Hz kernel only.

Doug, Thomas,

Thank you both for the reports, much appreciated!

Below is a drop-in v6 replacement for patch [4/7].

With this new patch applied instead of the [4/7] the behavior should be much
more in line with the v4 behavior, so please try it if you can and let me know
if that really is the case on your systems.

Patches [5-7/7] from the original v5 apply on top of it right away for me,
but I've also created a git branch you can use to pull all of the series
with the below included:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 idle-loop

Thanks!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v6] cpuidle: Return nohz hint from cpuidle_select()

Add a new pointer argument to cpuidle_select() and to the ->select
cpuidle governor callback to allow a boolean value indicating
whether or not the tick should be stopped before entering the
selected state to be returned from there.

Make the ladder governor ignore that pointer (to preserve its
current behavior) and make the menu governor return 'false" through
it if:
 (1) the idle exit latency is constrained at 0,
 (2) the selected state is a polling one, or
 (3) the selected state is not deep enough.

Since the value returned through the new argument pointer is not
used yet, this change is not expected to alter the functionality of
the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v5 -> v6: Change tick stopping conditions in the menu governor to
  be more in line with the v4 behavior.

---
 drivers/cpuidle/cpuidle.c          |   10 ++++++--
 drivers/cpuidle/governors/ladder.c |    3 +-
 drivers/cpuidle/governors/menu.c   |   44 ++++++++++++++++++++++++++++++++-----
 include/linux/cpuidle.h            |    8 ++++--
 kernel/sched/idle.c                |    4 ++-
 5 files changed, 57 insertions(+), 12 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -135,7 +135,8 @@ extern bool cpuidle_not_available(struct
 				  struct cpuidle_device *dev);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
-			  struct cpuidle_device *dev);
+			  struct cpuidle_device *dev,
+			  bool *nohz_ret);
 extern int cpuidle_enter(struct cpuidle_driver *drv,
 			 struct cpuidle_device *dev, int index);
 extern void cpuidle_reflect(struct cpuidle_device *dev, int index);
@@ -167,7 +168,7 @@ static inline bool cpuidle_not_available
 					 struct cpuidle_device *dev)
 {return true; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
-				 struct cpuidle_device *dev)
+				 struct cpuidle_device *dev, bool *nohz_ret)
 {return -ENODEV; }
 static inline int cpuidle_enter(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
@@ -250,7 +251,8 @@ struct cpuidle_governor {
 					struct cpuidle_device *dev);
 
 	int  (*select)		(struct cpuidle_driver *drv,
-					struct cpuidle_device *dev);
+					struct cpuidle_device *dev,
+					bool *nohz_ret);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
 };
 
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -188,13 +188,15 @@ static void cpuidle_idle_call(void)
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		bool nohz = true;
+
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-		next_state = cpuidle_select(drv, dev);
+		next_state = cpuidle_select(drv, dev, &nohz);
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -272,12 +272,18 @@ int cpuidle_enter_state(struct cpuidle_d
  *
  * @drv: the cpuidle driver
  * @dev: the cpuidle device
+ * @nohz_ret: indication on whether or not to stop the tick
  *
  * Returns the index of the idle state.  The return value must not be negative.
+ *
+ * The memory location pointed to by @nohz_ret is expected to be written the
+ * 'false' boolean value if the scheduler tick should not be stopped before
+ * entering the returned state.
  */
-int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		   bool *nohz_ret)
 {
-	return cpuidle_curr_governor->select(drv, dev);
+	return cpuidle_curr_governor->select(drv, dev, nohz_ret);
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -63,9 +63,10 @@ static inline void ladder_do_selection(s
  * ladder_select_state - selects the next state to enter
  * @drv: cpuidle driver
  * @dev: the CPU
+ * @dummy: not used
  */
 static int ladder_select_state(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev)
+			       struct cpuidle_device *dev, bool *dummy)
 {
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct device *device = get_cpu_device(dev->cpu);
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -275,12 +275,16 @@ again:
 	goto again;
 }
 
+#define TICK_USEC_HZ   ((USEC_PER_SEC + HZ/2) / HZ)
+
 /**
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
  * @dev: the CPU
+ * @nohz_ret: indication on whether or not to stop the tick
  */
-static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       bool *nohz_ret)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	struct device *device = get_cpu_device(dev->cpu);
@@ -303,8 +307,10 @@ static int menu_select(struct cpuidle_dr
 		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0))
+	if (unlikely(latency_req == 0)) {
+		*nohz_ret = false;
 		return 0;
+	}
 
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
@@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
 	if (latency_req > interactivity_req)
 		latency_req = interactivity_req;
 
+	expected_interval = TICK_USEC_HZ;
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
@@ -367,17 +374,44 @@ static int menu_select(struct cpuidle_dr
 			continue;
 		if (idx == -1)
 			idx = i; /* first enabled state */
-		if (s->target_residency > data->predicted_us)
+		if (s->target_residency > data->predicted_us) {
+			/*
+			 * Retain the tick if the selected state is shallower
+			 * than the deepest available one with target residency
+			 * within the tick period range.
+			 *
+			 * This allows the tick to be stopped even if the
+			 * predicted idle duration is within the tick period
+			 * range to counter the effect by which the prediction
+			 * may be skewed towards lower values due to the tick
+			 * bias.
+			 */
+			expected_interval = s->target_residency;
 			break;
-		if (s->exit_latency > latency_req)
+		}
+		if (s->exit_latency > latency_req) {
+			/*
+			 * If we break out of the loop for latency reasons,
+			 * retain the tick unless the target residency of the
+			 * selected state is too high.
+			 */
+			expected_interval = drv->states[idx].target_residency;
 			break;
-
+		}
 		idx = i;
 	}
 
 	if (idx == -1)
 		idx = 0; /* No states enabled. Must use 0. */
 
+	/*
+	 * Don't stop the tick if the selected state is a polling one or it is
+	 * not deep enough.
+	 */
+	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	    expected_interval < TICK_USEC_HZ)
+		*nohz_ret = false;
+
 	data->last_state_idx = idx;
 
 	return data->last_state_idx;
