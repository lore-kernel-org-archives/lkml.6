Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbeDBK4l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:56:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42277 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754262AbeDBK4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:56:38 -0400
X-Google-Smtp-Source: AIpwx48EIe76lrbOPHFt2cSQpPviESO1/z+/9fFWqocMqR0yvImzfy/qHZCSqlFerOLN9NxIuuHdJw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH V5] thermal: Add cooling device's statistics in sysfs
Date: Mon,  2 Apr 2018 16:26:25 +0530
Message-Id: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the sysfs interface for thermal cooling devices and exposes
some pretty useful statistics. These statistics have proven to be quite
useful specially while doing benchmarks related to the task scheduler,
where we want to make sure that nothing has disrupted the test,
specially the cooling device which may have put constraints on the CPUs.
The information exposed here tells us to what extent the CPUs were
constrained by the thermal framework.

The write-only "reset" file is used to reset the statistics.

The read-only "time_in_state_ms" file shows the time (in msec) spent by the
device in the respective cooling states, and it prints one line per
cooling state.

The read-only "total_trans" file shows single positive integer value
showing the total number of cooling state transitions the device has
gone through since the time the cooling device is registered or the time
when statistics were reset last.

The read-only "trans_table" file shows a two dimensional matrix, where
an entry <i,j> (row i, column j) represents the number of transitions
from State_i to State_j.

This is how the directory structure looks like for a single cooling
device:

$ ls -R /sys/class/thermal/cooling_device0/
/sys/class/thermal/cooling_device0/:
cur_state  max_state  power  stats  subsystem  type  uevent

/sys/class/thermal/cooling_device0/power:
autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
control               runtime_status

/sys/class/thermal/cooling_device0/stats:
reset  time_in_state_ms  total_trans  trans_table

This is tested on ARM 64-bit Hisilicon hikey620 board running Ubuntu and
ARM 64-bit Hisilicon hikey960 board running Android.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V4->V5:
- time_in_state's unit is msec now instead of clock_t.
- Remove double setting of ->stats pointer.

V3->V4:
- Added CONFIG_THERMAL_STATISTICS
- Added transition table file in sysfs
- Updated documentation for new sysfs files
- The unit of time in time_in_state is clock_t now
- Separate routines for cooling device stat setup/destroy

V2->V3:
- Total number of states is max_level + 1. The earlier version didn't
  take that into account and so the stats for the highest state were
  missing.

V1->V2:
- Move to sysfs from debugfs

 Documentation/thermal/sysfs-api.txt |  31 +++++
 drivers/thermal/Kconfig             |   7 ++
 drivers/thermal/thermal_core.c      |   3 +-
 drivers/thermal/thermal_core.h      |  10 ++
 drivers/thermal/thermal_helpers.c   |   5 +-
 drivers/thermal/thermal_sysfs.c     | 225 ++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h             |   1 +
 7 files changed, 280 insertions(+), 2 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index bb9a0a53e76b..911399730c1c 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -255,6 +255,7 @@ temperature) and throttle appropriate devices.
 2. sysfs attributes structure
 
 RO	read only value
+WO	write only value
 RW	read/write value
 
 Thermal sysfs attributes will be represented under /sys/class/thermal.
@@ -286,6 +287,11 @@ if hwmon is compiled in or built as a module.
     |---type:			Type of the cooling device(processor/fan/...)
     |---max_state:		Maximum cooling state of the cooling device
     |---cur_state:		Current cooling state of the cooling device
+    |---stats:			Directory containing cooling device's statistics
+    |---stats/reset:		Writing any value resets the statistics
+    |---stats/time_in_state_ms:	Time (msec) spent in various cooling states
+    |---stats/total_trans:	Total number of times cooling state is changed
+    |---stats/trans_table:	Cooing state transition table
 
 
 Then next two dynamic attributes are created/removed in pairs. They represent
@@ -490,6 +496,31 @@ cur_state
 	- cur_state == max_state means the maximum cooling.
 	RW, Required
 
+stats/reset
+	Writing any value resets the cooling device's statistics.
+	WO, Required
+
+stats/time_in_state_ms:
+	The amount of time spent by the cooling device in various cooling
+	states. The output will have "<state> <time>" pair in each line, which
+	will mean this cooling device spent <time> msec of time at <state>.
+	Output will have one line for each of the supported states.  usertime
+	units here is 10mS (similar to other time exported in /proc).
+	RO, Required
+
+stats/total_trans:
+	A single positive value showing the total number of times the state of a
+	cooling device is changed.
+	RO, Required
+
+stats/trans_table:
+	This gives fine grained information about all the cooling state
+	transitions. The cat output here is a two dimensional matrix, where an
+	entry <i,j> (row i, column j) represents the number of transitions from
+	State_i to State_j. If the transition table is bigger than PAGE_SIZE,
+	reading this will return an -EFBIG error.
+	RO, Required
+
 3. A simple implementation
 
 ACPI thermal zone may support multiple trip points like critical, hot,
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b6adc54b96f1..82979880f985 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -15,6 +15,13 @@ menuconfig THERMAL
 
 if THERMAL
 
+config THERMAL_STATISTICS
+	bool "Thermal state transition statistics"
+	help
+	  Export thermal state transition statistics information through sysfs.
+
+	  If in doubt, say N.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	depends on THERMAL
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2b1b0ba393a4..d64325e078db 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -972,8 +972,8 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
-	thermal_cooling_device_setup_sysfs(cdev);
 	cdev->devdata = devdata;
+	thermal_cooling_device_setup_sysfs(cdev);
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
 	if (result) {
@@ -1106,6 +1106,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_unregister(&cdev->device);
+	thermal_cooling_device_destroy_sysfs(cdev);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 27e3b1df7360..5e4150261500 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -73,6 +73,7 @@ int thermal_build_list_of_policies(char *buf);
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
+void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
 /* used only at binding time */
 ssize_t
 thermal_cooling_device_trip_point_show(struct device *,
@@ -84,6 +85,15 @@ ssize_t thermal_cooling_device_weight_store(struct device *,
 					    struct device_attribute *,
 					    const char *, size_t);
 
+#ifdef CONFIG_THERMAL_STATISTICS
+void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+					 unsigned long new_state);
+#else
+static inline void
+thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+				    unsigned long new_state) {}
+#endif /* CONFIG_THERMAL_STATISTICS */
+
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
 void thermal_gov_step_wise_unregister(void);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8cdf75adcce1..eb03d7e099bb 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -187,7 +187,10 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 		if (instance->target > target)
 			target = instance->target;
 	}
-	cdev->ops->set_cur_state(cdev, target);
+
+	if (!cdev->ops->set_cur_state(cdev, target))
+		thermal_cooling_device_stats_update(cdev, target);
+
 	cdev->updated = true;
 	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ba81c9080f6e..23b5e0a709b0 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 
 #include "thermal_core.h"
 
@@ -721,6 +722,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	result = cdev->ops->set_cur_state(cdev, state);
 	if (result)
 		return result;
+	thermal_cooling_device_stats_update(cdev, state);
 	return count;
 }
 
@@ -745,14 +747,237 @@ static const struct attribute_group cooling_device_attr_group = {
 
 static const struct attribute_group *cooling_device_attr_groups[] = {
 	&cooling_device_attr_group,
+	NULL, /* Space allocated for cooling_device_stats_attr_group */
 	NULL,
 };
 
+#ifdef CONFIG_THERMAL_STATISTICS
+struct cooling_dev_stats {
+	spinlock_t lock;
+	unsigned int total_trans;
+	unsigned long state;
+	unsigned long max_states;
+	ktime_t last_time;
+	ktime_t *time_in_state;
+	unsigned int *trans_table;
+};
+
+static void update_time_in_state(struct cooling_dev_stats *stats)
+{
+	ktime_t now = ktime_get(), delta;
+
+	delta = ktime_sub(now, stats->last_time);
+	stats->time_in_state[stats->state] =
+		ktime_add(stats->time_in_state[stats->state], delta);
+	stats->last_time = now;
+}
+
+void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+					 unsigned long new_state)
+{
+	struct cooling_dev_stats *stats = cdev->stats;
+
+	spin_lock(&stats->lock);
+
+	if (stats->state == new_state)
+		goto unlock;
+
+	update_time_in_state(stats);
+	stats->trans_table[stats->state * stats->max_states + new_state]++;
+	stats->state = new_state;
+	stats->total_trans++;
+
+unlock:
+	spin_unlock(&stats->lock);
+}
+
+static ssize_t
+thermal_cooling_device_total_trans_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	int ret;
+
+	spin_lock(&stats->lock);
+	ret = sprintf(buf, "%u\n", stats->total_trans);
+	spin_unlock(&stats->lock);
+
+	return ret;
+}
+
+static ssize_t
+thermal_cooling_device_time_in_state_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	ssize_t len = 0;
+	int i;
+
+	spin_lock(&stats->lock);
+	update_time_in_state(stats);
+
+	for (i = 0; i < stats->max_states; i++) {
+		len += sprintf(buf + len, "state%u\t%llu\n", i,
+			       ktime_to_ms(stats->time_in_state[i]));
+	}
+	spin_unlock(&stats->lock);
+
+	return len;
+}
+
+static ssize_t
+thermal_cooling_device_reset_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	int i, states = stats->max_states;
+
+	spin_lock(&stats->lock);
+
+	stats->total_trans = 0;
+	stats->last_time = ktime_get();
+	memset(stats->trans_table, 0,
+	       states * states * sizeof(*stats->trans_table));
+
+	for (i = 0; i < stats->max_states; i++)
+		stats->time_in_state[i] = ktime_set(0, 0);
+
+	spin_unlock(&stats->lock);
+
+	return count;
+}
+
+static ssize_t
+thermal_cooling_device_trans_table_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	ssize_t len = 0;
+	int i, j;
+
+	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
+	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
+	for (i = 0; i < stats->max_states; i++) {
+		if (len >= PAGE_SIZE)
+			break;
+		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
+	}
+	if (len >= PAGE_SIZE)
+		return PAGE_SIZE;
+
+	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+
+	for (i = 0; i < stats->max_states; i++) {
+		if (len >= PAGE_SIZE)
+			break;
+
+		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
+
+		for (j = 0; j < stats->max_states; j++) {
+			if (len >= PAGE_SIZE)
+				break;
+			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
+				stats->trans_table[i * stats->max_states + j]);
+		}
+		if (len >= PAGE_SIZE)
+			break;
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	}
+
+	if (len >= PAGE_SIZE) {
+		pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
+	}
+	return len;
+}
+
+static DEVICE_ATTR(total_trans, 0444, thermal_cooling_device_total_trans_show,
+		   NULL);
+static DEVICE_ATTR(time_in_state_ms, 0444,
+		   thermal_cooling_device_time_in_state_show, NULL);
+static DEVICE_ATTR(reset, 0200, NULL, thermal_cooling_device_reset_store);
+static DEVICE_ATTR(trans_table, 0444,
+		   thermal_cooling_device_trans_table_show, NULL);
+
+static struct attribute *cooling_device_stats_attrs[] = {
+	&dev_attr_total_trans.attr,
+	&dev_attr_time_in_state_ms.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_trans_table.attr,
+	NULL
+};
+
+static const struct attribute_group cooling_device_stats_attr_group = {
+	.attrs = cooling_device_stats_attrs,
+	.name = "stats"
+};
+
+static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
+{
+	struct cooling_dev_stats *stats;
+	unsigned long states;
+	int var;
+
+	if (cdev->ops->get_max_state(cdev, &states))
+		return;
+
+	states++; /* Total number of states is highest state + 1 */
+
+	var = sizeof(*stats);
+	var += sizeof(*stats->time_in_state) * states;
+	var += sizeof(*stats->trans_table) * states * states;
+
+	stats = kzalloc(var, GFP_KERNEL);
+	if (!stats)
+		return;
+
+	stats->time_in_state = (ktime_t *)(stats + 1);
+	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
+	cdev->stats = stats;
+	stats->last_time = ktime_get();
+	stats->max_states = states;
+
+	spin_lock_init(&stats->lock);
+
+	/* Fill the empty slot left in cooling_device_attr_groups */
+	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
+	cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
+}
+
+static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
+{
+	kfree(cdev->stats);
+	cdev->stats = NULL;
+}
+
+#else
+
+static inline void
+cooling_device_stats_setup(struct thermal_cooling_device *cdev) {}
+static inline void
+cooling_device_stats_destroy(struct thermal_cooling_device *cdev) {}
+
+#endif /* CONFIG_THERMAL_STATISTICS */
+
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *cdev)
 {
+	cooling_device_stats_setup(cdev);
 	cdev->device.groups = cooling_device_attr_groups;
 }
 
+void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev)
+{
+	cooling_device_stats_destroy(cdev);
+}
+
 /* these helper will be used only at the time of bindig */
 ssize_t
 thermal_cooling_device_trip_point_show(struct device *dev,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8c5302374eaa..7834be668d80 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -148,6 +148,7 @@ struct thermal_cooling_device {
 	struct device device;
 	struct device_node *np;
 	void *devdata;
+	void *stats;
 	const struct thermal_cooling_device_ops *ops;
 	bool updated; /* true if the cooling device does not need update */
 	struct mutex lock; /* protect thermal_instances list */
-- 
2.15.0.194.g9af6a3dea062
