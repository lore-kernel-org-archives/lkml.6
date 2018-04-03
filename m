Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755519AbeDCMQN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:16:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:16:11 -0400
Date: Tue, 3 Apr 2018 14:16:09 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] time(r) updates for 4.17
Message-ID: <alpine.DEB.2.21.1804031404010.2511@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

A small set of updates for timers and timekeeping:

 - The most interesting change is the consolidation of clock MONOTONIC and
   clock BOOTTIME. Clock MONOTONIC behaves now exactly like clock BOOTTIME
   and does not longer ignore the time spent in suspend. A new clock
   MONOTONIC_ACTIVE is provived which behaves like clock MONOTONIC in
   kernels before this change. This allows applications to
   programmatically check for the clock MONOTONIC behaviour.

   As discussed in the review thread, this has the potential of breaking
   user space and we might have to revert this. Knock on wood that we can
   avoid that exercise.

 - Updates to the NTP mechanism to improve accuracy

 - A new kernel internal data structure to aid the ongoing Y2038 work.

 - Cleanups and simplifications of the clocksource code.

 - Make the alarmtimer code play nicely with debugobjects.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      y2038: Introduce struct __kernel_old_timeval

Baolin Wang (3):
      clocksource: Don't walk the clocksource list for empty override
      clocksource: Use DEVICE_ATTR_RW/RO/WO to define device attributes
      clocksource: Use ATTRIBUTE_GROUPS

Miroslav Lichvar (2):
      timekeeping/ntp: Don't align NTP frequency adjustments to ticks
      timekeeping/ntp: Determine the multiplier directly from NTP tick length

Thomas Gleixner (8):
      timekeeping: Add the new CLOCK_MONOTONIC_ACTIVE clock
      timekeeping: Make the MONOTONIC clock behave like the BOOTTIME clock
      Input: Evdev - unify MONOTONIC and BOOTTIME clock behavior
      timekeeping: Remove boot time specific code
      posix-timers: Unify MONOTONIC and BOOTTIME clock behavior
      hrtimer: Unify MONOTONIC and BOOTTIME clock behavior
      tracing: Unify the "boot" and "mono" tracing clocks
      alarmtimer: Init nanosleep alarm timer on stack


 Documentation/trace/ftrace.txt      |  14 +--
 drivers/input/evdev.c               |   7 +-
 include/linux/hrtimer.h             |   2 -
 include/linux/time32.h              |   1 +
 include/linux/timekeeper_internal.h |   4 +
 include/linux/timekeeping.h         |  37 ++----
 include/uapi/linux/time.h           |  13 +++
 kernel/time/alarmtimer.c            |  34 ++++--
 kernel/time/clocksource.c           |  66 +++++------
 kernel/time/hrtimer.c               |  16 +--
 kernel/time/posix-stubs.c           |   2 +
 kernel/time/posix-timers.c          |  26 ++---
 kernel/time/tick-common.c           |  15 +++
 kernel/time/tick-internal.h         |   6 +
 kernel/time/tick-sched.c            |   9 ++
 kernel/time/time.c                  |  12 ++
 kernel/time/timekeeping.c           | 219 +++++++++++++++---------------------
 kernel/time/timekeeping.h           |   1 -
 kernel/trace/trace.c                |   2 +-
 19 files changed, 234 insertions(+), 252 deletions(-)

diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
index d4601df6e72e..bf89f98bfdb9 100644
--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -449,17 +449,9 @@ of ftrace. Here is a list of some of the key files:
 		which is montonic but is not subject to any rate adjustments
 		and ticks at the same rate as the hardware clocksource.
 
-	  boot: This is the boot clock (CLOCK_BOOTTIME) and is based on the
-		fast monotonic clock, but also accounts for time spent in
-		suspend. Since the clock access is designed for use in
-		tracing in the suspend path, some side effects are possible
-		if clock is accessed after the suspend time is accounted before
-		the fast mono clock is updated. In this case, the clock update
-		appears to happen slightly sooner than it normally would have.
-		Also on 32-bit systems, it's possible that the 64-bit boot offset
-		sees a partial update. These effects are rare and post
-		processing should be able to handle them. See comments in the
-		ktime_get_boot_fast_ns() function for more information.
+	  boot: Same as mono. Used to be a separate clock which accounted
+	  	for the time spent in suspend while CLOCK_MONOTONIC did
+		not.
 
 	To set a clock, simply echo the clock name into this file.
 
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c81c79d01d93..46115a392098 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -31,7 +31,6 @@
 enum evdev_clock_type {
 	EV_CLK_REAL = 0,
 	EV_CLK_MONO,
-	EV_CLK_BOOT,
 	EV_CLK_MAX
 };
 
@@ -198,12 +197,10 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	case CLOCK_REALTIME:
 		clk_type = EV_CLK_REAL;
 		break;
+	case CLOCK_BOOTTIME:
 	case CLOCK_MONOTONIC:
 		clk_type = EV_CLK_MONO;
 		break;
-	case CLOCK_BOOTTIME:
-		clk_type = EV_CLK_BOOT;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -314,8 +311,6 @@ static void evdev_events(struct input_handle *handle,
 
 	ev_time[EV_CLK_MONO] = ktime_get();
 	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
-	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
-						 TK_OFFS_BOOT);
 
 	rcu_read_lock();
 
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c7902ca7c9f4..78f456fcd242 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -161,11 +161,9 @@ struct hrtimer_clock_base {
 enum  hrtimer_base_type {
 	HRTIMER_BASE_MONOTONIC,
 	HRTIMER_BASE_REALTIME,
-	HRTIMER_BASE_BOOTTIME,
 	HRTIMER_BASE_TAI,
 	HRTIMER_BASE_MONOTONIC_SOFT,
 	HRTIMER_BASE_REALTIME_SOFT,
-	HRTIMER_BASE_BOOTTIME_SOFT,
 	HRTIMER_BASE_TAI_SOFT,
 	HRTIMER_MAX_CLOCK_BASES,
 };
diff --git a/include/linux/time32.h b/include/linux/time32.h
index 65b1de25198d..d2bcd4377b56 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -217,5 +217,6 @@ static inline s64 timeval_to_ns(const struct timeval *tv)
  * Returns the timeval representation of the nsec parameter.
  */
 extern struct timeval ns_to_timeval(const s64 nsec);
+extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
 
 #endif
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index d315c3d6725c..4b3dca173e89 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -52,6 +52,7 @@ struct tk_read_base {
  * @offs_real:		Offset clock monotonic -> clock realtime
  * @offs_boot:		Offset clock monotonic -> clock boottime
  * @offs_tai:		Offset clock monotonic -> clock tai
+ * @time_suspended:	Accumulated suspend time
  * @tai_offset:		The current UTC to TAI offset in seconds
  * @clock_was_set_seq:	The sequence number of clock was set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
@@ -94,6 +95,7 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
+	ktime_t			time_suspended;
 	s32			tai_offset;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
@@ -117,6 +119,8 @@ struct timekeeper {
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
+	/* Flag used to avoid updating NTP twice with same second */
+	u32			skip_second_overflow;
 #ifdef CONFIG_DEBUG_TIMEKEEPING
 	long			last_warning;
 	/*
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b17bcce58bc4..82c219dfd3bb 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -32,20 +32,25 @@ extern void getrawmonotonic64(struct timespec64 *ts);
 extern void ktime_get_ts64(struct timespec64 *ts);
 extern time64_t ktime_get_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
+extern void ktime_get_active_ts64(struct timespec64 *ts);
 
 extern int __getnstimeofday64(struct timespec64 *tv);
 extern void getnstimeofday64(struct timespec64 *tv);
 extern void getboottime64(struct timespec64 *ts);
 
-#define ktime_get_real_ts64(ts)	getnstimeofday64(ts)
+#define ktime_get_real_ts64(ts)		getnstimeofday64(ts)
+
+/* Clock BOOTTIME compatibility wrappers */
+static inline void get_monotonic_boottime64(struct timespec64 *ts)
+{
+	ktime_get_ts64(ts);
+}
 
 /*
  * ktime_t based interfaces
  */
-
 enum tk_offsets {
 	TK_OFFS_REAL,
-	TK_OFFS_BOOT,
 	TK_OFFS_TAI,
 	TK_OFFS_MAX,
 };
@@ -56,6 +61,10 @@ extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
 
+/* Clock BOOTTIME compatibility wrappers */
+static inline ktime_t ktime_get_boottime(void) { return ktime_get(); }
+static inline u64 ktime_get_boot_ns(void) { return ktime_get(); }
+
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
  */
@@ -64,17 +73,6 @@ static inline ktime_t ktime_get_real(void)
 	return ktime_get_with_offset(TK_OFFS_REAL);
 }
 
-/**
- * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
- *
- * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
- * time spent in suspend.
- */
-static inline ktime_t ktime_get_boottime(void)
-{
-	return ktime_get_with_offset(TK_OFFS_BOOT);
-}
-
 /**
  * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
  */
@@ -101,11 +99,6 @@ static inline u64 ktime_get_real_ns(void)
 	return ktime_to_ns(ktime_get_real());
 }
 
-static inline u64 ktime_get_boot_ns(void)
-{
-	return ktime_to_ns(ktime_get_boottime());
-}
-
 static inline u64 ktime_get_tai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
@@ -118,17 +111,11 @@ static inline u64 ktime_get_raw_ns(void)
 
 extern u64 ktime_get_mono_fast_ns(void);
 extern u64 ktime_get_raw_fast_ns(void);
-extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
 /*
  * timespec64 interfaces utilizing the ktime based ones
  */
-static inline void get_monotonic_boottime64(struct timespec64 *ts)
-{
-	*ts = ktime_to_timespec64(ktime_get_boottime());
-}
-
 static inline void timekeeping_clocktai64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_clocktai());
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 53f8dd84beb5..16a296612ba4 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,6 +42,18 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
+/*
+ * legacy timeval structure, only embedded in structures that
+ * traditionally used 'timeval' to pass time intervals (not absolute
+ * times). Do not add new users. If user space fails to compile
+ * here, this is probably because it is not y2038 safe and needs to
+ * be changed to use another interface.
+ */
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_long_t tv_usec;
+};
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
@@ -61,6 +73,7 @@ struct itimerval {
  */
 #define CLOCK_SGI_CYCLE			10
 #define CLOCK_TAI			11
+#define CLOCK_MONOTONIC_ACTIVE		12
 
 #define MAX_CLOCKS			16
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ec09ce9a6012..639321bf2e39 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -326,6 +326,17 @@ static int alarmtimer_resume(struct device *dev)
 }
 #endif
 
+static void
+__alarm_init(struct alarm *alarm, enum alarmtimer_type type,
+	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+{
+	timerqueue_init(&alarm->node);
+	alarm->timer.function = alarmtimer_fired;
+	alarm->function = function;
+	alarm->type = type;
+	alarm->state = ALARMTIMER_STATE_INACTIVE;
+}
+
 /**
  * alarm_init - Initialize an alarm structure
  * @alarm: ptr to alarm to be initialized
@@ -335,13 +346,9 @@ static int alarmtimer_resume(struct device *dev)
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
 {
-	timerqueue_init(&alarm->node);
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
-			HRTIMER_MODE_ABS);
-	alarm->timer.function = alarmtimer_fired;
-	alarm->function = function;
-	alarm->type = type;
-	alarm->state = ALARMTIMER_STATE_INACTIVE;
+		     HRTIMER_MODE_ABS);
+	__alarm_init(alarm, type, function);
 }
 EXPORT_SYMBOL_GPL(alarm_init);
 
@@ -719,6 +726,8 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 
 	__set_current_state(TASK_RUNNING);
 
+	destroy_hrtimer_on_stack(&alarm->timer);
+
 	if (!alarm->data)
 		return 0;
 
@@ -740,6 +749,15 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 	return -ERESTART_RESTARTBLOCK;
 }
 
+static void
+alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
+		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+{
+	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
+			      HRTIMER_MODE_ABS);
+	__alarm_init(alarm, type, function);
+}
+
 /**
  * alarm_timer_nsleep_restart - restartblock alarmtimer nsleep
  * @restart: ptr to restart block
@@ -752,7 +770,7 @@ static long __sched alarm_timer_nsleep_restart(struct restart_block *restart)
 	ktime_t exp = restart->nanosleep.expires;
 	struct alarm alarm;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	return alarmtimer_do_nsleep(&alarm, exp, type);
 }
@@ -784,7 +802,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 65f9e3f24dde..0e974cface0b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -594,6 +594,9 @@ static void __clocksource_select(bool skipcur)
 	if (!best)
 		return;
 
+	if (!strlen(override_name))
+		goto found;
+
 	/* Check for the override clocksource. */
 	list_for_each_entry(cs, &clocksource_list, list) {
 		if (skipcur && cs == curr_clocksource)
@@ -625,6 +628,7 @@ static void __clocksource_select(bool skipcur)
 		break;
 	}
 
+found:
 	if (curr_clocksource != best && !timekeeping_notify(best)) {
 		pr_info("Switched to clocksource %s\n", best->name);
 		curr_clocksource = best;
@@ -853,16 +857,16 @@ EXPORT_SYMBOL(clocksource_unregister);
 
 #ifdef CONFIG_SYSFS
 /**
- * sysfs_show_current_clocksources - sysfs interface for current clocksource
+ * current_clocksource_show - sysfs interface for current clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	char buffer to be filled with clocksource list
  *
  * Provides sysfs interface for listing current clocksource.
  */
-static ssize_t
-sysfs_show_current_clocksources(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t current_clocksource_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	ssize_t count = 0;
 
@@ -891,7 +895,7 @@ ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)
 }
 
 /**
- * sysfs_override_clocksource - interface for manually overriding clocksource
+ * current_clocksource_store - interface for manually overriding clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	name of override clocksource
@@ -900,9 +904,9 @@ ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)
  * Takes input from sysfs interface for manually overriding the default
  * clocksource selection.
  */
-static ssize_t sysfs_override_clocksource(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
+static ssize_t current_clocksource_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
 {
 	ssize_t ret;
 
@@ -916,9 +920,10 @@ static ssize_t sysfs_override_clocksource(struct device *dev,
 
 	return ret;
 }
+static DEVICE_ATTR_RW(current_clocksource);
 
 /**
- * sysfs_unbind_current_clocksource - interface for manually unbinding clocksource
+ * unbind_clocksource_store - interface for manually unbinding clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	unused
@@ -926,7 +931,7 @@ static ssize_t sysfs_override_clocksource(struct device *dev,
  *
  * Takes input from sysfs interface for manually unbinding a clocksource.
  */
-static ssize_t sysfs_unbind_clocksource(struct device *dev,
+static ssize_t unbind_clocksource_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -950,19 +955,19 @@ static ssize_t sysfs_unbind_clocksource(struct device *dev,
 
 	return ret ? ret : count;
 }
+static DEVICE_ATTR_WO(unbind_clocksource);
 
 /**
- * sysfs_show_available_clocksources - sysfs interface for listing clocksource
+ * available_clocksource_show - sysfs interface for listing clocksource
  * @dev:	unused
  * @attr:	unused
  * @buf:	char buffer to be filled with clocksource list
  *
  * Provides sysfs interface for listing registered clocksources
  */
-static ssize_t
-sysfs_show_available_clocksources(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+static ssize_t available_clocksource_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct clocksource *src;
 	ssize_t count = 0;
@@ -986,17 +991,15 @@ sysfs_show_available_clocksources(struct device *dev,
 
 	return count;
 }
+static DEVICE_ATTR_RO(available_clocksource);
 
-/*
- * Sysfs setup bits:
- */
-static DEVICE_ATTR(current_clocksource, 0644, sysfs_show_current_clocksources,
-		   sysfs_override_clocksource);
-
-static DEVICE_ATTR(unbind_clocksource, 0200, NULL, sysfs_unbind_clocksource);
-
-static DEVICE_ATTR(available_clocksource, 0444,
-		   sysfs_show_available_clocksources, NULL);
+static struct attribute *clocksource_attrs[] = {
+	&dev_attr_current_clocksource.attr,
+	&dev_attr_unbind_clocksource.attr,
+	&dev_attr_available_clocksource.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(clocksource);
 
 static struct bus_type clocksource_subsys = {
 	.name = "clocksource",
@@ -1006,6 +1009,7 @@ static struct bus_type clocksource_subsys = {
 static struct device device_clocksource = {
 	.id	= 0,
 	.bus	= &clocksource_subsys,
+	.groups	= clocksource_groups,
 };
 
 static int __init init_clocksource_sysfs(void)
@@ -1014,17 +1018,7 @@ static int __init init_clocksource_sysfs(void)
 
 	if (!error)
 		error = device_register(&device_clocksource);
-	if (!error)
-		error = device_create_file(
-				&device_clocksource,
-				&dev_attr_current_clocksource);
-	if (!error)
-		error = device_create_file(&device_clocksource,
-					   &dev_attr_unbind_clocksource);
-	if (!error)
-		error = device_create_file(
-				&device_clocksource,
-				&dev_attr_available_clocksource);
+
 	return error;
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 23788100e214..9b082ce86325 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -90,11 +90,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
 		},
-		{
-			.index = HRTIMER_BASE_BOOTTIME,
-			.clockid = CLOCK_BOOTTIME,
-			.get_time = &ktime_get_boottime,
-		},
 		{
 			.index = HRTIMER_BASE_TAI,
 			.clockid = CLOCK_TAI,
@@ -110,11 +105,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
 		},
-		{
-			.index = HRTIMER_BASE_BOOTTIME_SOFT,
-			.clockid = CLOCK_BOOTTIME,
-			.get_time = &ktime_get_boottime,
-		},
 		{
 			.index = HRTIMER_BASE_TAI_SOFT,
 			.clockid = CLOCK_TAI,
@@ -129,7 +119,7 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 
 	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
 	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
+	[CLOCK_BOOTTIME]	= HRTIMER_BASE_MONOTONIC,
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
@@ -565,14 +555,12 @@ __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_
 static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 {
 	ktime_t *offs_real = &base->clock_base[HRTIMER_BASE_REALTIME].offset;
-	ktime_t *offs_boot = &base->clock_base[HRTIMER_BASE_BOOTTIME].offset;
 	ktime_t *offs_tai = &base->clock_base[HRTIMER_BASE_TAI].offset;
 
 	ktime_t now = ktime_get_update_offsets_now(&base->clock_was_set_seq,
-					    offs_real, offs_boot, offs_tai);
+						   offs_real, offs_tai);
 
 	base->clock_base[HRTIMER_BASE_REALTIME_SOFT].offset = *offs_real;
-	base->clock_base[HRTIMER_BASE_BOOTTIME_SOFT].offset = *offs_boot;
 	base->clock_base[HRTIMER_BASE_TAI_SOFT].offset = *offs_tai;
 
 	return now;
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index b258bee13b02..6259dbc0191a 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -73,6 +73,8 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 	case CLOCK_BOOTTIME:
 		get_monotonic_boottime64(tp);
 		break;
+	case CLOCK_MONOTONIC_ACTIVE:
+		ktime_get_active_ts64(tp);
 	default:
 		return -EINVAL;
 	}
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 75043046914e..8cf95bfee44f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,15 +251,16 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
 {
-	get_monotonic_boottime64(tp);
+	timekeeping_clocktai64(tp);
 	return 0;
 }
 
-static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_monotonic_active(clockid_t which_clock,
+				      struct timespec64 *tp)
 {
-	timekeeping_clocktai64(tp);
+	ktime_get_active_ts64(tp);
 	return 0;
 }
 
@@ -1315,19 +1316,9 @@ static const struct k_clock clock_tai = {
 	.timer_arm		= common_hrtimer_arm,
 };
 
-static const struct k_clock clock_boottime = {
+static const struct k_clock clock_monotonic_active = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_boottime,
-	.nsleep			= common_nsleep,
-	.timer_create		= common_timer_create,
-	.timer_set		= common_timer_set,
-	.timer_get		= common_timer_get,
-	.timer_del		= common_timer_del,
-	.timer_rearm		= common_hrtimer_rearm,
-	.timer_forward		= common_hrtimer_forward,
-	.timer_remaining	= common_hrtimer_remaining,
-	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
-	.timer_arm		= common_hrtimer_arm,
+	.clock_get		= posix_get_monotonic_active,
 };
 
 static const struct k_clock * const posix_clocks[] = {
@@ -1338,10 +1329,11 @@ static const struct k_clock * const posix_clocks[] = {
 	[CLOCK_MONOTONIC_RAW]		= &clock_monotonic_raw,
 	[CLOCK_REALTIME_COARSE]		= &clock_realtime_coarse,
 	[CLOCK_MONOTONIC_COARSE]	= &clock_monotonic_coarse,
-	[CLOCK_BOOTTIME]		= &clock_boottime,
+	[CLOCK_BOOTTIME]		= &clock_monotonic,
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
+	[CLOCK_MONOTONIC_ACTIVE]	= &clock_monotonic_active,
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..099572ca4a8f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -419,6 +419,19 @@ void tick_suspend_local(void)
 	clockevents_shutdown(td->evtdev);
 }
 
+static void tick_forward_next_period(void)
+{
+	ktime_t delta, now = ktime_get();
+	u64 n;
+
+	delta = ktime_sub(now, tick_next_period);
+	n = ktime_divns(delta, tick_period);
+	tick_next_period += n * tick_period;
+	if (tick_next_period < now)
+		tick_next_period += tick_period;
+	tick_sched_forward_next_period();
+}
+
 /**
  * tick_resume_local - Resume the local tick device
  *
@@ -431,6 +444,8 @@ void tick_resume_local(void)
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	bool broadcast = tick_resume_check_broadcast();
 
+	tick_forward_next_period();
+
 	clockevents_tick_resume(td->evtdev);
 	if (!broadcast) {
 		if (td->mode == TICKDEV_MODE_PERIODIC)
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index e277284c2831..21efab7485ca 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -141,6 +141,12 @@ static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
 #endif /* !(BROADCAST && ONESHOT) */
 
+#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
+extern void tick_sched_forward_next_period(void);
+#else
+static inline void tick_sched_forward_next_period(void) { }
+#endif
+
 /* NO_HZ_FULL internal */
 #ifdef CONFIG_NO_HZ_FULL
 extern void tick_nohz_init(void);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 29a5733eff83..f53e37b5d248 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -51,6 +51,15 @@ struct tick_sched *tick_get_tick_sched(int cpu)
  */
 static ktime_t last_jiffies_update;
 
+/*
+ * Called after resume. Make sure that jiffies are not fast forwarded due to
+ * clock monotonic being forwarded by the suspended time.
+ */
+void tick_sched_forward_next_period(void)
+{
+	last_jiffies_update = tick_next_period;
+}
+
 /*
  * Must be called with interrupts disabled !
  */
diff --git a/kernel/time/time.c b/kernel/time/time.c
index bd4e6c7dd689..3044d48ebe56 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -488,6 +488,18 @@ struct timeval ns_to_timeval(const s64 nsec)
 }
 EXPORT_SYMBOL(ns_to_timeval);
 
+struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
+{
+	struct timespec64 ts = ns_to_timespec64(nsec);
+	struct __kernel_old_timeval tv;
+
+	tv.tv_sec = ts.tv_sec;
+	tv.tv_usec = (suseconds_t)ts.tv_nsec / 1000;
+
+	return tv;
+}
+EXPORT_SYMBOL(ns_to_kernel_old_timeval);
+
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cd03317e7b57..ca90219a1e73 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -138,7 +138,12 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	/* Update both bases so mono and raw stay coupled. */
+	tk->tkr_mono.base += delta;
+	tk->tkr_raw.base += delta;
+
+	/* Accumulate time spent in suspend */
+	tk->time_suspended += delta;
 }
 
 /*
@@ -332,6 +337,7 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 	tk->tkr_mono.mult = clock->mult;
 	tk->tkr_raw.mult = clock->mult;
 	tk->ntp_err_mult = 0;
+	tk->skip_second_overflow = 0;
 }
 
 /* Timekeeper helper functions. */
@@ -467,36 +473,6 @@ u64 ktime_get_raw_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
 
-/**
- * ktime_get_boot_fast_ns - NMI safe and fast access to boot clock.
- *
- * To keep it NMI safe since we're accessing from tracing, we're not using a
- * separate timekeeper with updates to monotonic clock and boot offset
- * protected with seqlocks. This has the following minor side effects:
- *
- * (1) Its possible that a timestamp be taken after the boot offset is updated
- * but before the timekeeper is updated. If this happens, the new boot offset
- * is added to the old timekeeping making the clock appear to update slightly
- * earlier:
- *    CPU 0                                        CPU 1
- *    timekeeping_inject_sleeptime64()
- *    __timekeeping_inject_sleeptime(tk, delta);
- *                                                 timestamp();
- *    timekeeping_update(tk, TK_CLEAR_NTP...);
- *
- * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
- * partially updated.  Since the tk->offs_boot update is a rare event, this
- * should be a rare occurrence which postprocessing should be able to handle.
- */
-u64 notrace ktime_get_boot_fast_ns(void)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
-}
-EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
-
-
 /*
  * See comment for __ktime_get_fast_ns() vs. timestamp ordering
  */
@@ -788,7 +764,6 @@ EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
 
 static ktime_t *offsets[TK_OFFS_MAX] = {
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
-	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
 	[TK_OFFS_TAI]	= &tk_core.timekeeper.offs_tai,
 };
 
@@ -885,6 +860,39 @@ void ktime_get_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_ts64);
 
+/**
+ * ktime_get_active_ts64 - Get the active non-suspended monotonic clock
+ * @ts:		pointer to timespec variable
+ *
+ * The function calculates the monotonic clock from the realtime clock and
+ * the wall_to_monotonic offset, subtracts the accumulated suspend time and
+ * stores the result in normalized timespec64 format in the variable
+ * pointed to by @ts.
+ */
+void ktime_get_active_ts64(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timespec64 tomono, tsusp;
+	u64 nsec, nssusp;
+	unsigned int seq;
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		ts->tv_sec = tk->xtime_sec;
+		nsec = timekeeping_get_ns(&tk->tkr_mono);
+		tomono = tk->wall_to_monotonic;
+		nssusp = tk->time_suspended;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	ts->tv_nsec = 0;
+	timespec64_add_ns(ts, nsec + tomono.tv_nsec);
+	tsusp = ns_to_timespec64(nssusp);
+	*ts = timespec64_sub(*ts, tsusp);
+}
+
 /**
  * ktime_get_seconds - Get the seconds portion of CLOCK_MONOTONIC
  *
@@ -1585,7 +1593,6 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 		return;
 	}
 	tk_xtime_add(tk, delta);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
 	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
 	tk_debug_account_sleep_time(delta);
 }
@@ -1799,20 +1806,19 @@ device_initcall(timekeeping_init_ops);
  */
 static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 							 s64 offset,
-							 bool negative,
-							 int adj_scale)
+							 s32 mult_adj)
 {
 	s64 interval = tk->cycle_interval;
-	s32 mult_adj = 1;
 
-	if (negative) {
-		mult_adj = -mult_adj;
+	if (mult_adj == 0) {
+		return;
+	} else if (mult_adj == -1) {
 		interval = -interval;
-		offset  = -offset;
+		offset = -offset;
+	} else if (mult_adj != 1) {
+		interval *= mult_adj;
+		offset *= mult_adj;
 	}
-	mult_adj <<= adj_scale;
-	interval <<= adj_scale;
-	offset <<= adj_scale;
 
 	/*
 	 * So the following can be confusing.
@@ -1860,8 +1866,6 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	 *	xtime_nsec_2 = xtime_nsec_1 - offset
 	 * Which simplfies to:
 	 *	xtime_nsec -= offset
-	 *
-	 * XXX - TODO: Doc ntp_error calculation.
 	 */
 	if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) {
 		/* NTP adjustment caused clocksource mult overflow */
@@ -1872,89 +1876,38 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	tk->tkr_mono.mult += mult_adj;
 	tk->xtime_interval += interval;
 	tk->tkr_mono.xtime_nsec -= offset;
-	tk->ntp_error -= (interval - offset) << tk->ntp_error_shift;
 }
 
 /*
- * Calculate the multiplier adjustment needed to match the frequency
- * specified by NTP
+ * Adjust the timekeeper's multiplier to the correct frequency
+ * and also to reduce the accumulated error value.
  */
-static __always_inline void timekeeping_freqadjust(struct timekeeper *tk,
-							s64 offset)
+static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
-	s64 interval = tk->cycle_interval;
-	s64 xinterval = tk->xtime_interval;
-	u32 base = tk->tkr_mono.clock->mult;
-	u32 max = tk->tkr_mono.clock->maxadj;
-	u32 cur_adj = tk->tkr_mono.mult;
-	s64 tick_error;
-	bool negative;
-	u32 adj_scale;
-
-	/* Remove any current error adj from freq calculation */
-	if (tk->ntp_err_mult)
-		xinterval -= tk->cycle_interval;
-
-	tk->ntp_tick = ntp_tick_length();
-
-	/* Calculate current error per tick */
-	tick_error = ntp_tick_length() >> tk->ntp_error_shift;
-	tick_error -= (xinterval + tk->xtime_remainder);
-
-	/* Don't worry about correcting it if its small */
-	if (likely((tick_error >= 0) && (tick_error <= interval)))
-		return;
-
-	/* preserve the direction of correction */
-	negative = (tick_error < 0);
+	u32 mult;
 
-	/* If any adjustment would pass the max, just return */
-	if (negative && (cur_adj - 1) <= (base - max))
-		return;
-	if (!negative && (cur_adj + 1) >= (base + max))
-		return;
 	/*
-	 * Sort out the magnitude of the correction, but
-	 * avoid making so large a correction that we go
-	 * over the max adjustment.
+	 * Determine the multiplier from the current NTP tick length.
+	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	adj_scale = 0;
-	tick_error = abs(tick_error);
-	while (tick_error > interval) {
-		u32 adj = 1 << (adj_scale + 1);
-
-		/* Check if adjustment gets us within 1 unit from the max */
-		if (negative && (cur_adj - adj) <= (base - max))
-			break;
-		if (!negative && (cur_adj + adj) >= (base + max))
-			break;
-
-		adj_scale++;
-		tick_error >>= 1;
+	if (likely(tk->ntp_tick == ntp_tick_length())) {
+		mult = tk->tkr_mono.mult - tk->ntp_err_mult;
+	} else {
+		tk->ntp_tick = ntp_tick_length();
+		mult = div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
+				 tk->xtime_remainder, tk->cycle_interval);
 	}
 
-	/* scale the corrections */
-	timekeeping_apply_adjustment(tk, offset, negative, adj_scale);
-}
+	/*
+	 * If the clock is behind the NTP time, increase the multiplier by 1
+	 * to catch up with it. If it's ahead and there was a remainder in the
+	 * tick division, the clock will slow down. Otherwise it will stay
+	 * ahead until the tick length changes to a non-divisible value.
+	 */
+	tk->ntp_err_mult = tk->ntp_error > 0 ? 1 : 0;
+	mult += tk->ntp_err_mult;
 
-/*
- * Adjust the timekeeper's multiplier to the correct frequency
- * and also to reduce the accumulated error value.
- */
-static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
-{
-	/* Correct for the current frequency error */
-	timekeeping_freqadjust(tk, offset);
-
-	/* Next make a small adjustment to fix any cumulative error */
-	if (!tk->ntp_err_mult && (tk->ntp_error > 0)) {
-		tk->ntp_err_mult = 1;
-		timekeeping_apply_adjustment(tk, offset, 0, 0);
-	} else if (tk->ntp_err_mult && (tk->ntp_error <= 0)) {
-		/* Undo any existing error adjustment */
-		timekeeping_apply_adjustment(tk, offset, 1, 0);
-		tk->ntp_err_mult = 0;
-	}
+	timekeeping_apply_adjustment(tk, offset, mult - tk->tkr_mono.mult);
 
 	if (unlikely(tk->tkr_mono.clock->maxadj &&
 		(abs(tk->tkr_mono.mult - tk->tkr_mono.clock->mult)
@@ -1971,18 +1924,15 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 	 * in the code above, its possible the required corrective factor to
 	 * xtime_nsec could cause it to underflow.
 	 *
-	 * Now, since we already accumulated the second, cannot simply roll
-	 * the accumulated second back, since the NTP subsystem has been
-	 * notified via second_overflow. So instead we push xtime_nsec forward
-	 * by the amount we underflowed, and add that amount into the error.
-	 *
-	 * We'll correct this error next time through this function, when
-	 * xtime_nsec is not as small.
+	 * Now, since we have already accumulated the second and the NTP
+	 * subsystem has been notified via second_overflow(), we need to skip
+	 * the next update.
 	 */
 	if (unlikely((s64)tk->tkr_mono.xtime_nsec < 0)) {
-		s64 neg = -(s64)tk->tkr_mono.xtime_nsec;
-		tk->tkr_mono.xtime_nsec = 0;
-		tk->ntp_error += neg << tk->ntp_error_shift;
+		tk->tkr_mono.xtime_nsec += (u64)NSEC_PER_SEC <<
+							tk->tkr_mono.shift;
+		tk->xtime_sec--;
+		tk->skip_second_overflow = 1;
 	}
 }
 
@@ -2005,6 +1955,15 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
 		tk->tkr_mono.xtime_nsec -= nsecps;
 		tk->xtime_sec++;
 
+		/*
+		 * Skip NTP update if this second was accumulated before,
+		 * i.e. xtime_nsec underflowed in timekeeping_adjust()
+		 */
+		if (unlikely(tk->skip_second_overflow)) {
+			tk->skip_second_overflow = 0;
+			continue;
+		}
+
 		/* Figure out if its a leap sec and apply if needed */
 		leap = second_overflow(tk->xtime_sec);
 		if (unlikely(leap)) {
@@ -2121,7 +2080,7 @@ void update_wall_time(void)
 			shift--;
 	}
 
-	/* correct the clock when NTP error is too big */
+	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);
 
 	/*
@@ -2166,7 +2125,7 @@ void update_wall_time(void)
 void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
+	ktime_t t = ktime_sub(tk->offs_real, tk->time_suspended);
 
 	*ts = ktime_to_timespec64(t);
 }
@@ -2236,7 +2195,6 @@ void do_timer(unsigned long ticks)
  * ktime_get_update_offsets_now - hrtimer helper
  * @cwsseq:	pointer to check and store the clock was set sequence number
  * @offs_real:	pointer to storage for monotonic -> realtime offset
- * @offs_boot:	pointer to storage for monotonic -> boottime offset
  * @offs_tai:	pointer to storage for monotonic -> clock tai offset
  *
  * Returns current monotonic time and updates the offsets if the
@@ -2246,7 +2204,7 @@ void do_timer(unsigned long ticks)
  * Called from hrtimer_interrupt() or retrigger_next_event()
  */
 ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
-				     ktime_t *offs_boot, ktime_t *offs_tai)
+				     ktime_t *offs_tai)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
@@ -2263,7 +2221,6 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 		if (*cwsseq != tk->clock_was_set_seq) {
 			*cwsseq = tk->clock_was_set_seq;
 			*offs_real = tk->offs_real;
-			*offs_boot = tk->offs_boot;
 			*offs_tai = tk->offs_tai;
 		}
 
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 7a9b4eb7a1d5..79b67f5e0343 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -6,7 +6,6 @@
  */
 extern ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq,
 					    ktime_t *offs_real,
-					    ktime_t *offs_boot,
 					    ktime_t *offs_tai);
 
 extern int timekeeping_valid_for_hres(void);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 20a2300ae4e8..300f4ea39646 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1164,7 +1164,7 @@ static struct {
 	{ trace_clock,			"perf",		1 },
 	{ ktime_get_mono_fast_ns,	"mono",		1 },
 	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
-	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_mono_fast_ns,	"boot",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
