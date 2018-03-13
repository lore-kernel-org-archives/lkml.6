Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCMHIx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:08:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeCMHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:08:51 -0400
Date: Tue, 13 Mar 2018 00:08:13 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d6c7270e913db75ca5fdc79915ba780e97ae2857@git.kernel.org>
Cc: salyzyn@android.com, mtk.manpages@gmail.com,
        sergey.senozhatsky@gmail.com, dmitry.torokhov@gmail.com,
        torvalds@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        pmladek@suse.com, hpa@zytor.com, peterz@infradead.org,
        john.stultz@linaro.org, tglx@linutronix.de, kevin@guarana.org,
        prarit@redhat.com
Reply-To: hpa@zytor.com, pmladek@suse.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, john.stultz@linaro.org,
        prarit@redhat.com, kevin@guarana.org, mtk.manpages@gmail.com,
        dmitry.torokhov@gmail.com, sergey.senozhatsky@gmail.com,
        salyzyn@android.com, torvalds@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
In-Reply-To: <20180301165150.236279497@linutronix.de>
References: <20180301165150.236279497@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Remove boot time specific code
Git-Commit-ID: d6c7270e913db75ca5fdc79915ba780e97ae2857
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d6c7270e913db75ca5fdc79915ba780e97ae2857
Gitweb:     https://git.kernel.org/tip/d6c7270e913db75ca5fdc79915ba780e97ae2857
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:35 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:22 +0100

timekeeping: Remove boot time specific code

Now that the MONOTONIC and BOOTTIME clocks are the same, remove all the
special handling from timekeeping. Keep wrappers for the existing users of
the *boot* timekeeper interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20180301165150.236279497@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/timekeeping.h | 42 +++++++++++++++++-------------------------
 kernel/time/timekeeping.c   | 31 -------------------------------
 2 files changed, 17 insertions(+), 56 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 440b1935d3a5..abb396731332 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -38,15 +38,19 @@ extern int __getnstimeofday64(struct timespec64 *tv);
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
@@ -57,6 +61,10 @@ extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
 
+/* Clock BOOTTIME compatibility wrappers */
+static inline ktime_t ktime_get_boottime(void) { return ktime_get(); }
+static inline u64 ktime_get_boot_ns(void) { return ktime_get(); }
+
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
  */
@@ -65,17 +73,6 @@ static inline ktime_t ktime_get_real(void)
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
@@ -102,11 +99,6 @@ static inline u64 ktime_get_real_ns(void)
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
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b509fe7acd64..8355c8803282 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -473,36 +473,6 @@ u64 ktime_get_raw_fast_ns(void)
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
@@ -794,7 +764,6 @@ EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
 
 static ktime_t *offsets[TK_OFFS_MAX] = {
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
-	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
 	[TK_OFFS_TAI]	= &tk_core.timekeeper.offs_tai,
 };
 
