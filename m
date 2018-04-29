Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeD2O7W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 10:59:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34034 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbeD2O7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 10:59:20 -0400
Date: Sun, 29 Apr 2018 16:59:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer updates for 4.17
Message-ID: <alpine.DEB.2.21.1804291656160.1595@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

Two fixes from the timer departement:

 - Fix a long standing issue in the NOHZ tick code which causes RB tree
   corruption, delayed timers and other malfunctions. The cause for this is
   code which modifies the expiry time of an enqueued hrtimer.

 - Revert the CLOCK_MONOTONIC/CLOCK_BOOTTIME unification due to regression
   reports. Seems userspace _is_ relying on the documented behaviour
   despite our hope that it wont.

Thanks,

	tglx

------------------>
Thomas Gleixner (2):
      tick/sched: Do not mess with an enqueued hrtimer
      Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME


 Documentation/trace/ftrace.rst      | 14 +++++--
 drivers/input/evdev.c               |  7 +++-
 include/linux/hrtimer.h             |  2 +
 include/linux/timekeeper_internal.h |  2 -
 include/linux/timekeeping.h         | 37 ++++++++++++------
 include/uapi/linux/time.h           |  1 -
 kernel/time/hrtimer.c               | 16 +++++++-
 kernel/time/posix-stubs.c           |  2 -
 kernel/time/posix-timers.c          | 26 ++++++++-----
 kernel/time/tick-common.c           | 15 -------
 kernel/time/tick-internal.h         |  6 ---
 kernel/time/tick-sched.c            | 19 +++------
 kernel/time/timekeeping.c           | 78 ++++++++++++++++++-------------------
 kernel/time/timekeeping.h           |  1 +
 kernel/trace/trace.c                |  2 +-
 15 files changed, 119 insertions(+), 109 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index e45f0786f3f9..67d9c38e95eb 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -461,9 +461,17 @@ of ftrace. Here is a list of some of the key files:
 		and ticks at the same rate as the hardware clocksource.
 
 	boot:
-		Same as mono. Used to be a separate clock which accounted
-		for the time spent in suspend while CLOCK_MONOTONIC did
-		not.
+		This is the boot clock (CLOCK_BOOTTIME) and is based on the
+		fast monotonic clock, but also accounts for time spent in
+		suspend. Since the clock access is designed for use in
+		tracing in the suspend path, some side effects are possible
+		if clock is accessed after the suspend time is accounted before
+		the fast mono clock is updated. In this case, the clock update
+		appears to happen slightly sooner than it normally would have.
+		Also on 32-bit systems, it's possible that the 64-bit boot offset
+		sees a partial update. These effects are rare and post
+		processing should be able to handle them. See comments in the
+		ktime_get_boot_fast_ns() function for more information.
 
 	To set a clock, simply echo the clock name into this file::
 
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 46115a392098..c81c79d01d93 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -31,6 +31,7 @@
 enum evdev_clock_type {
 	EV_CLK_REAL = 0,
 	EV_CLK_MONO,
+	EV_CLK_BOOT,
 	EV_CLK_MAX
 };
 
@@ -197,10 +198,12 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
 	case CLOCK_REALTIME:
 		clk_type = EV_CLK_REAL;
 		break;
-	case CLOCK_BOOTTIME:
 	case CLOCK_MONOTONIC:
 		clk_type = EV_CLK_MONO;
 		break;
+	case CLOCK_BOOTTIME:
+		clk_type = EV_CLK_BOOT;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -311,6 +314,8 @@ static void evdev_events(struct input_handle *handle,
 
 	ev_time[EV_CLK_MONO] = ktime_get();
 	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
+	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
+						 TK_OFFS_BOOT);
 
 	rcu_read_lock();
 
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index a2656c3ebe81..3892e9c8b2de 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -161,9 +161,11 @@ struct hrtimer_clock_base {
 enum  hrtimer_base_type {
 	HRTIMER_BASE_MONOTONIC,
 	HRTIMER_BASE_REALTIME,
+	HRTIMER_BASE_BOOTTIME,
 	HRTIMER_BASE_TAI,
 	HRTIMER_BASE_MONOTONIC_SOFT,
 	HRTIMER_BASE_REALTIME_SOFT,
+	HRTIMER_BASE_BOOTTIME_SOFT,
 	HRTIMER_BASE_TAI_SOFT,
 	HRTIMER_MAX_CLOCK_BASES,
 };
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 4b3dca173e89..7acb953298a7 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -52,7 +52,6 @@ struct tk_read_base {
  * @offs_real:		Offset clock monotonic -> clock realtime
  * @offs_boot:		Offset clock monotonic -> clock boottime
  * @offs_tai:		Offset clock monotonic -> clock tai
- * @time_suspended:	Accumulated suspend time
  * @tai_offset:		The current UTC to TAI offset in seconds
  * @clock_was_set_seq:	The sequence number of clock was set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
@@ -95,7 +94,6 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
-	ktime_t			time_suspended;
 	s32			tai_offset;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 9737fbec7019..588a0e4b1ab9 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -33,25 +33,20 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern time64_t ktime_get_seconds(void);
 extern time64_t __ktime_get_real_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
-extern void ktime_get_active_ts64(struct timespec64 *ts);
 
 extern int __getnstimeofday64(struct timespec64 *tv);
 extern void getnstimeofday64(struct timespec64 *tv);
 extern void getboottime64(struct timespec64 *ts);
 
-#define ktime_get_real_ts64(ts)		getnstimeofday64(ts)
-
-/* Clock BOOTTIME compatibility wrappers */
-static inline void get_monotonic_boottime64(struct timespec64 *ts)
-{
-	ktime_get_ts64(ts);
-}
+#define ktime_get_real_ts64(ts)	getnstimeofday64(ts)
 
 /*
  * ktime_t based interfaces
  */
+
 enum tk_offsets {
 	TK_OFFS_REAL,
+	TK_OFFS_BOOT,
 	TK_OFFS_TAI,
 	TK_OFFS_MAX,
 };
@@ -62,10 +57,6 @@ extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
 
-/* Clock BOOTTIME compatibility wrappers */
-static inline ktime_t ktime_get_boottime(void) { return ktime_get(); }
-static inline u64 ktime_get_boot_ns(void) { return ktime_get(); }
-
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
  */
@@ -74,6 +65,17 @@ static inline ktime_t ktime_get_real(void)
 	return ktime_get_with_offset(TK_OFFS_REAL);
 }
 
+/**
+ * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
+ *
+ * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
+ * time spent in suspend.
+ */
+static inline ktime_t ktime_get_boottime(void)
+{
+	return ktime_get_with_offset(TK_OFFS_BOOT);
+}
+
 /**
  * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
  */
@@ -100,6 +102,11 @@ static inline u64 ktime_get_real_ns(void)
 	return ktime_to_ns(ktime_get_real());
 }
 
+static inline u64 ktime_get_boot_ns(void)
+{
+	return ktime_to_ns(ktime_get_boottime());
+}
+
 static inline u64 ktime_get_tai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
@@ -112,11 +119,17 @@ static inline u64 ktime_get_raw_ns(void)
 
 extern u64 ktime_get_mono_fast_ns(void);
 extern u64 ktime_get_raw_fast_ns(void);
+extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
 /*
  * timespec64 interfaces utilizing the ktime based ones
  */
+static inline void get_monotonic_boottime64(struct timespec64 *ts)
+{
+	*ts = ktime_to_timespec64(ktime_get_boottime());
+}
+
 static inline void timekeeping_clocktai64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_clocktai());
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 16a296612ba4..4c0338ea308a 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -73,7 +73,6 @@ struct __kernel_old_timeval {
  */
 #define CLOCK_SGI_CYCLE			10
 #define CLOCK_TAI			11
-#define CLOCK_MONOTONIC_ACTIVE		12
 
 #define MAX_CLOCKS			16
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index eda1210ce50f..14e858753d76 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -90,6 +90,11 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
 		},
+		{
+			.index = HRTIMER_BASE_BOOTTIME,
+			.clockid = CLOCK_BOOTTIME,
+			.get_time = &ktime_get_boottime,
+		},
 		{
 			.index = HRTIMER_BASE_TAI,
 			.clockid = CLOCK_TAI,
@@ -105,6 +110,11 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_REALTIME,
 			.get_time = &ktime_get_real,
 		},
+		{
+			.index = HRTIMER_BASE_BOOTTIME_SOFT,
+			.clockid = CLOCK_BOOTTIME,
+			.get_time = &ktime_get_boottime,
+		},
 		{
 			.index = HRTIMER_BASE_TAI_SOFT,
 			.clockid = CLOCK_TAI,
@@ -119,7 +129,7 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 
 	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
 	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_MONOTONIC,
+	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
@@ -571,12 +581,14 @@ __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_
 static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 {
 	ktime_t *offs_real = &base->clock_base[HRTIMER_BASE_REALTIME].offset;
+	ktime_t *offs_boot = &base->clock_base[HRTIMER_BASE_BOOTTIME].offset;
 	ktime_t *offs_tai = &base->clock_base[HRTIMER_BASE_TAI].offset;
 
 	ktime_t now = ktime_get_update_offsets_now(&base->clock_was_set_seq,
-						   offs_real, offs_tai);
+					    offs_real, offs_boot, offs_tai);
 
 	base->clock_base[HRTIMER_BASE_REALTIME_SOFT].offset = *offs_real;
+	base->clock_base[HRTIMER_BASE_BOOTTIME_SOFT].offset = *offs_boot;
 	base->clock_base[HRTIMER_BASE_TAI_SOFT].offset = *offs_tai;
 
 	return now;
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index e0dbae98db9d..69a937c3cd81 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -83,8 +83,6 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 	case CLOCK_BOOTTIME:
 		get_monotonic_boottime64(tp);
 		break;
-	case CLOCK_MONOTONIC_ACTIVE:
-		ktime_get_active_ts64(tp);
 	default:
 		return -EINVAL;
 	}
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b6899b5060bd..10b7186d0638 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -252,16 +252,15 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
 {
-	timekeeping_clocktai64(tp);
+	get_monotonic_boottime64(tp);
 	return 0;
 }
 
-static int posix_get_monotonic_active(clockid_t which_clock,
-				      struct timespec64 *tp)
+static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
 {
-	ktime_get_active_ts64(tp);
+	timekeeping_clocktai64(tp);
 	return 0;
 }
 
@@ -1317,9 +1316,19 @@ static const struct k_clock clock_tai = {
 	.timer_arm		= common_hrtimer_arm,
 };
 
-static const struct k_clock clock_monotonic_active = {
+static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_monotonic_active,
+	.clock_get		= posix_get_boottime,
+	.nsleep			= common_nsleep,
+	.timer_create		= common_timer_create,
+	.timer_set		= common_timer_set,
+	.timer_get		= common_timer_get,
+	.timer_del		= common_timer_del,
+	.timer_rearm		= common_hrtimer_rearm,
+	.timer_forward		= common_hrtimer_forward,
+	.timer_remaining	= common_hrtimer_remaining,
+	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_arm		= common_hrtimer_arm,
 };
 
 static const struct k_clock * const posix_clocks[] = {
@@ -1330,11 +1339,10 @@ static const struct k_clock * const posix_clocks[] = {
 	[CLOCK_MONOTONIC_RAW]		= &clock_monotonic_raw,
 	[CLOCK_REALTIME_COARSE]		= &clock_realtime_coarse,
 	[CLOCK_MONOTONIC_COARSE]	= &clock_monotonic_coarse,
-	[CLOCK_BOOTTIME]		= &clock_monotonic,
+	[CLOCK_BOOTTIME]		= &clock_boottime,
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
-	[CLOCK_MONOTONIC_ACTIVE]	= &clock_monotonic_active,
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 099572ca4a8f..49edc1c4f3e6 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -419,19 +419,6 @@ void tick_suspend_local(void)
 	clockevents_shutdown(td->evtdev);
 }
 
-static void tick_forward_next_period(void)
-{
-	ktime_t delta, now = ktime_get();
-	u64 n;
-
-	delta = ktime_sub(now, tick_next_period);
-	n = ktime_divns(delta, tick_period);
-	tick_next_period += n * tick_period;
-	if (tick_next_period < now)
-		tick_next_period += tick_period;
-	tick_sched_forward_next_period();
-}
-
 /**
  * tick_resume_local - Resume the local tick device
  *
@@ -444,8 +431,6 @@ void tick_resume_local(void)
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	bool broadcast = tick_resume_check_broadcast();
 
-	tick_forward_next_period();
-
 	clockevents_tick_resume(td->evtdev);
 	if (!broadcast) {
 		if (td->mode == TICKDEV_MODE_PERIODIC)
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 21efab7485ca..e277284c2831 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -141,12 +141,6 @@ static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
 #endif /* !(BROADCAST && ONESHOT) */
 
-#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
-extern void tick_sched_forward_next_period(void);
-#else
-static inline void tick_sched_forward_next_period(void) { }
-#endif
-
 /* NO_HZ_FULL internal */
 #ifdef CONFIG_NO_HZ_FULL
 extern void tick_nohz_init(void);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 646645e981f9..da9455a6b42b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -51,15 +51,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
  */
 static ktime_t last_jiffies_update;
 
-/*
- * Called after resume. Make sure that jiffies are not fast forwarded due to
- * clock monotonic being forwarded by the suspended time.
- */
-void tick_sched_forward_next_period(void)
-{
-	last_jiffies_update = tick_next_period;
-}
-
 /*
  * Must be called with interrupts disabled !
  */
@@ -804,12 +795,12 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		return;
 	}
 
-	hrtimer_set_expires(&ts->sched_timer, tick);
-
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
-		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
-	else
+	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
+	} else {
+		hrtimer_set_expires(&ts->sched_timer, tick);
 		tick_program_event(tick, 1);
+	}
 }
 
 static void tick_nohz_retain_tick(struct tick_sched *ts)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcf7f20fcd12..49cbceef5deb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -138,12 +138,7 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	/* Update both bases so mono and raw stay coupled. */
-	tk->tkr_mono.base += delta;
-	tk->tkr_raw.base += delta;
-
-	/* Accumulate time spent in suspend */
-	tk->time_suspended += delta;
+	tk->offs_boot = ktime_add(tk->offs_boot, delta);
 }
 
 /*
@@ -473,6 +468,36 @@ u64 ktime_get_raw_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
 
+/**
+ * ktime_get_boot_fast_ns - NMI safe and fast access to boot clock.
+ *
+ * To keep it NMI safe since we're accessing from tracing, we're not using a
+ * separate timekeeper with updates to monotonic clock and boot offset
+ * protected with seqlocks. This has the following minor side effects:
+ *
+ * (1) Its possible that a timestamp be taken after the boot offset is updated
+ * but before the timekeeper is updated. If this happens, the new boot offset
+ * is added to the old timekeeping making the clock appear to update slightly
+ * earlier:
+ *    CPU 0                                        CPU 1
+ *    timekeeping_inject_sleeptime64()
+ *    __timekeeping_inject_sleeptime(tk, delta);
+ *                                                 timestamp();
+ *    timekeeping_update(tk, TK_CLEAR_NTP...);
+ *
+ * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
+ * partially updated.  Since the tk->offs_boot update is a rare event, this
+ * should be a rare occurrence which postprocessing should be able to handle.
+ */
+u64 notrace ktime_get_boot_fast_ns(void)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
+}
+EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
+
+
 /*
  * See comment for __ktime_get_fast_ns() vs. timestamp ordering
  */
@@ -764,6 +789,7 @@ EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
 
 static ktime_t *offsets[TK_OFFS_MAX] = {
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
+	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
 	[TK_OFFS_TAI]	= &tk_core.timekeeper.offs_tai,
 };
 
@@ -860,39 +886,6 @@ void ktime_get_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_ts64);
 
-/**
- * ktime_get_active_ts64 - Get the active non-suspended monotonic clock
- * @ts:		pointer to timespec variable
- *
- * The function calculates the monotonic clock from the realtime clock and
- * the wall_to_monotonic offset, subtracts the accumulated suspend time and
- * stores the result in normalized timespec64 format in the variable
- * pointed to by @ts.
- */
-void ktime_get_active_ts64(struct timespec64 *ts)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-	struct timespec64 tomono, tsusp;
-	u64 nsec, nssusp;
-	unsigned int seq;
-
-	WARN_ON(timekeeping_suspended);
-
-	do {
-		seq = read_seqcount_begin(&tk_core.seq);
-		ts->tv_sec = tk->xtime_sec;
-		nsec = timekeeping_get_ns(&tk->tkr_mono);
-		tomono = tk->wall_to_monotonic;
-		nssusp = tk->time_suspended;
-	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	ts->tv_sec += tomono.tv_sec;
-	ts->tv_nsec = 0;
-	timespec64_add_ns(ts, nsec + tomono.tv_nsec);
-	tsusp = ns_to_timespec64(nssusp);
-	*ts = timespec64_sub(*ts, tsusp);
-}
-
 /**
  * ktime_get_seconds - Get the seconds portion of CLOCK_MONOTONIC
  *
@@ -1593,6 +1586,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 		return;
 	}
 	tk_xtime_add(tk, delta);
+	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
 	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
 	tk_debug_account_sleep_time(delta);
 }
@@ -2125,7 +2119,7 @@ void update_wall_time(void)
 void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	ktime_t t = ktime_sub(tk->offs_real, tk->time_suspended);
+	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
 
 	*ts = ktime_to_timespec64(t);
 }
@@ -2188,6 +2182,7 @@ void do_timer(unsigned long ticks)
  * ktime_get_update_offsets_now - hrtimer helper
  * @cwsseq:	pointer to check and store the clock was set sequence number
  * @offs_real:	pointer to storage for monotonic -> realtime offset
+ * @offs_boot:	pointer to storage for monotonic -> boottime offset
  * @offs_tai:	pointer to storage for monotonic -> clock tai offset
  *
  * Returns current monotonic time and updates the offsets if the
@@ -2197,7 +2192,7 @@ void do_timer(unsigned long ticks)
  * Called from hrtimer_interrupt() or retrigger_next_event()
  */
 ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
-				     ktime_t *offs_tai)
+				     ktime_t *offs_boot, ktime_t *offs_tai)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
@@ -2214,6 +2209,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 		if (*cwsseq != tk->clock_was_set_seq) {
 			*cwsseq = tk->clock_was_set_seq;
 			*offs_real = tk->offs_real;
+			*offs_boot = tk->offs_boot;
 			*offs_tai = tk->offs_tai;
 		}
 
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 79b67f5e0343..7a9b4eb7a1d5 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -6,6 +6,7 @@
  */
 extern ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq,
 					    ktime_t *offs_real,
+					    ktime_t *offs_boot,
 					    ktime_t *offs_tai);
 
 extern int timekeeping_valid_for_hres(void);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dfbcf9ee1447..414d7210b2ec 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1165,7 +1165,7 @@ static struct {
 	{ trace_clock,			"perf",		1 },
 	{ ktime_get_mono_fast_ns,	"mono",		1 },
 	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
-	{ ktime_get_mono_fast_ns,	"boot",		1 },
+	{ ktime_get_boot_fast_ns,	"boot",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
