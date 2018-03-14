Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCNL0u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:26:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41082 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCNL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:26:48 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: cpuidle/suspend: Add s2idle usage and time state attributes
Date: Wed, 14 Mar 2018 12:27:21 +0100
Message-ID: <56347346.ABr7PmucuU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new attribute group called "s2idle" under the sysfs directory
of each cpuidle state that supports the ->enter_s2idle callback
and put two new attributes, "usage" and "time", into that group to
represent the number of times the given state was requested for
suspend-to-idle and the total time spent in suspend-to-idle after
requesting that state, respectively.

That will allow diagnostic information related to suspend-to-idle
to be collected without enabling advanced debug features and
analyzing dmesg output.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |   25 +++++++++
 drivers/cpuidle/cpuidle.c                          |    9 +++
 drivers/cpuidle/sysfs.c                            |   54 +++++++++++++++++++++
 include/linux/cpuidle.h                            |    4 +
 4 files changed, 92 insertions(+)

Index: linux-pm/drivers/cpuidle/sysfs.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/sysfs.c
+++ linux-pm/drivers/cpuidle/sysfs.c
@@ -330,6 +330,58 @@ struct cpuidle_state_kobj {
 	struct kobject kobj;
 };
 
+#ifdef CONFIG_SUSPEND
+#define define_show_state_s2idle_ull_function(_name) \
+static ssize_t show_state_s2idle_##_name(struct cpuidle_state *state, \
+					 struct cpuidle_state_usage *state_usage, \
+					 char *buf)				\
+{ \
+	return sprintf(buf, "%llu\n", state_usage->s2idle_##_name);\
+}
+
+define_show_state_s2idle_ull_function(usage);
+define_show_state_s2idle_ull_function(time);
+
+#define define_one_state_s2idle_ro(_name, show) \
+static struct cpuidle_state_attr attr_s2idle_##_name = \
+	__ATTR(_name, 0444, show, NULL)
+
+define_one_state_s2idle_ro(usage, show_state_s2idle_usage);
+define_one_state_s2idle_ro(time, show_state_s2idle_time);
+
+static struct attribute *cpuidle_state_s2idle_attrs[] = {
+	&attr_s2idle_usage.attr,
+	&attr_s2idle_time.attr,
+	NULL
+};
+
+static const struct attribute_group cpuidle_state_s2idle_group = {
+	.name	= "s2idle",
+	.attrs	= cpuidle_state_s2idle_attrs,
+};
+
+static void cpuidle_add_s2idle_attr_group(struct cpuidle_state_kobj *kobj)
+{
+	int ret;
+
+	if (!kobj->state->enter_s2idle)
+		return;
+
+	ret = sysfs_create_group(&kobj->kobj, &cpuidle_state_s2idle_group);
+	if (ret)
+		pr_debug("%s: sysfs attribute group not created\n", __func__);
+}
+
+static void cpuidle_remove_s2idle_attr_group(struct cpuidle_state_kobj *kobj)
+{
+	if (kobj->state->enter_s2idle)
+		sysfs_remove_group(&kobj->kobj, &cpuidle_state_s2idle_group);
+}
+#else
+static inline void cpuidle_add_s2idle_attr_group(struct cpuidle_state_kobj *kobj) { }
+static inline void cpuidle_remove_s2idle_attr_group(struct cpuidle_state_kobj *kobj) { }
+#endif /* CONFIG_SUSPEND */
+
 #define kobj_to_state_obj(k) container_of(k, struct cpuidle_state_kobj, kobj)
 #define kobj_to_state(k) (kobj_to_state_obj(k)->state)
 #define kobj_to_state_usage(k) (kobj_to_state_obj(k)->state_usage)
@@ -383,6 +435,7 @@ static struct kobj_type ktype_state_cpui
 
 static inline void cpuidle_free_state_kobj(struct cpuidle_device *device, int i)
 {
+	cpuidle_remove_s2idle_attr_group(device->kobjs[i]);
 	kobject_put(&device->kobjs[i]->kobj);
 	wait_for_completion(&device->kobjs[i]->kobj_unregister);
 	kfree(device->kobjs[i]);
@@ -417,6 +470,7 @@ static int cpuidle_add_state_sysfs(struc
 			kfree(kobj);
 			goto error_state;
 		}
+		cpuidle_add_s2idle_attr_group(kobj);
 		kobject_uevent(&kobj->kobj, KOBJ_ADD);
 		device->kobjs[i] = kobj;
 	}
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -33,6 +33,10 @@ struct cpuidle_state_usage {
 	unsigned long long	disable;
 	unsigned long long	usage;
 	unsigned long long	time; /* in US */
+#ifdef CONFIG_SUSPEND
+	unsigned long long	s2idle_usage;
+	unsigned long long	s2idle_time; /* in US */
+#endif
 };
 
 struct cpuidle_state {
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -131,6 +131,10 @@ int cpuidle_find_deepest_state(struct cp
 static void enter_s2idle_proper(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
 {
+	ktime_t time_start, time_end;
+
+	time_start = ns_to_ktime(local_clock());
+
 	/*
 	 * trace_suspend_resume() called by tick_freeze() for the last CPU
 	 * executing it contains RCU usage regarded as invalid in the idle
@@ -152,6 +156,11 @@ static void enter_s2idle_proper(struct c
 	 */
 	RCU_NONIDLE(tick_unfreeze());
 	start_critical_timings();
+
+	time_end = ns_to_ktime(local_clock());
+
+	dev->states_usage[index].s2idle_time += ktime_us_delta(time_end, time_start);
+	dev->states_usage[index].s2idle_usage++;
 }
 
 /**
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -198,6 +198,31 @@ Description:
 		time (in microseconds) this cpu should spend in this idle state
 		to make the transition worth the effort.
 
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/s2idle/
+Date:		March 2018
+KernelVersion:	v4.17
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		Idle state usage statistics related to suspend-to-idle.
+
+		This attribute group is only present for states that can be
+		used in suspend-to-idle with suspended timekeeping.
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/s2idle/time
+Date:		March 2018
+KernelVersion:	v4.17
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		Total time spent by the CPU in suspend-to-idle (with scheduler
+		tick suspended) after requesting this state.
+
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/s2idle/usage
+Date:		March 2018
+KernelVersion:	v4.17
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		Total number of times this state has been requested by the CPU
+		while entering suspend-to-idle.
 
 What:		/sys/devices/system/cpu/cpu#/cpufreq/*
 Date:		pre-git history
