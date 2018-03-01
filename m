Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033338AbeCAQxs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:53:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033021AbeCAQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:03 -0500
Message-Id: <20180301165150.236279497@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:35 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC/RFT patch 4/7] timekeeping: Remove boot time specific code
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=timekeeping--Remove-boot-time-specific-code.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clock MONOTONIC and clock BOOTTIME are the same, remove all the
special handling from timekeeping. Keep wrappers for the existing users of
the *boot* timekeeper interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeping.h |   42 +++++++++++++++++-------------------------
 kernel/time/timekeeping.c   |   31 -------------------------------
 2 files changed, 17 insertions(+), 56 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -38,15 +38,19 @@ extern int __getnstimeofday64(struct tim
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
@@ -57,6 +61,10 @@ extern ktime_t ktime_mono_to_any(ktime_t
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
 
+/* Clock BOOTTIME compatibility wrappers */
+static inline ktime_t ktime_get_boottime(void) { return ktime_get(); }
+static inline u64 ktime_get_boot_ns(void) { return ktime_get(); }
+
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
  */
@@ -66,17 +74,6 @@ static inline ktime_t ktime_get_real(voi
 }
 
 /**
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
-/**
  * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
  */
 static inline ktime_t ktime_get_clocktai(void)
@@ -102,11 +99,6 @@ static inline u64 ktime_get_real_ns(void
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
@@ -119,17 +111,17 @@ static inline u64 ktime_get_raw_ns(void)
 
 extern u64 ktime_get_mono_fast_ns(void);
 extern u64 ktime_get_raw_fast_ns(void);
-extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
-/*
- * timespec64 interfaces utilizing the ktime based ones
- */
-static inline void get_monotonic_boottime64(struct timespec64 *ts)
+/* Clock BOOTTIME compatibility wrappers */
+static inline u64 ktime_get_boot_fast_ns(void)
 {
-	*ts = ktime_to_timespec64(ktime_get_boottime());
+	return ktime_get_mono_fast_ns();
 }
 
+/*
+ * timespec64 interfaces utilizing the ktime based ones
+ */
 static inline void timekeeping_clocktai64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_clocktai());
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -472,36 +472,6 @@ u64 ktime_get_raw_fast_ns(void)
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
@@ -793,7 +763,6 @@ EXPORT_SYMBOL_GPL(ktime_get_resolution_n
 
 static ktime_t *offsets[TK_OFFS_MAX] = {
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
-	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
 	[TK_OFFS_TAI]	= &tk_core.timekeeper.offs_tai,
 };
 
