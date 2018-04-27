Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758453AbeD0Nk7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:40:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeD0Nkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:40:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/5] timekeeping: Standardize on ktime_get_*() naming
Date: Fri, 27 Apr 2018 15:40:14 +0200
Message-Id: <20180427134016.2525989-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180427134016.2525989-1-arnd@arndb.de>
References: <20180427134016.2525989-1-arnd@arndb.de>
X-Provags-ID: V03:K1:l8yFmMGyxNrpnpcCuR0HaaKEo/1YgcJlEmIN48mbDRDQFmXKSd9
 jDP3bnGRItMBHwS/lcVdv9o+Ii7vyAV1NfYsiyYbAK7bgCg4gOhcuxkBlyDef56a6P5JDTB
 C+v5v2I/bd50DEbmB1r/Y+V7TmASxqEeqOgstgF0w9NPt5e3O9JRbqXjWrD86xVcs1QtznJ
 Vrs/KRilqsJfDxLyd0grA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HZOMufFobjQ=:IU8qrnDRTORZ9kG6rMJt61
 LFDvMRJ+LR4KKraTD2VKYjNwE8yYydEBU1eW6vVq329yQzPtPuEaWNkgbSIoqQYiiQf1Dr1H0
 cdiNzC+zBwt0OMhJsbMN93mVuRckr8rRixep+ISVv3a969HvqKmUYQG+dph1uH2HxGuLeTkr/
 7OvIzZctzOfFcXGi1gbOLV3EiyW7j79XWo74JelXoZXgZrXqBXuB8oLWLE6YtkKwqw1/xoFGV
 /Uk0flwX3pYabuu6iJ5DNf5qeoxi7OY7zundqNrgaOLQsF2A6a+zvICExK6uI3rTkjwM/wXT/
 a9AiGqZzT7exDEYjbBcKSYCB4T9a0p/F4rE7W5YTyMhJ+hFmjTPoX/Hx1GdlAxiYM6xvNF0Wq
 XHREdMnKYOxYnwFWdGj/xaF19atlIrPWwXktmD8uuboKPZ80WUxOcuYT459GG3I6d122RieZO
 j9d1iFNrDxkUTDfavMbHB+ijzBfDDJFaJjmS63D7SKO9pD4p5N7Ql+pPABw5F9W8E5OpwwrOG
 bMJ8q05YY1Ms65w/wx8dHllSU7nNvHf3WtClg64CN/Zw5PgNzH9pTnO5+I//Pgntp5xG5F4Cu
 5N78UADX7uJwSp9JOb08XwgZO++64W+/RwYa5FYLBUx+A2aNbTH0eES7SkrdJaLBJErUL8V1n
 xDt/3OqCyTXiCghVLps3erT5U61aw2+uvBj/tTuZ4Pdbrq4wU2A8A1WaqosVwLZbts4Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current_kernel_time64, get_monotonic_coarse64, getrawmonotonic64,
get_monotonic_boottime64 and timekeeping_clocktai64 interfaces have
rather inconsistent naming, and they differ in the calling conventions
by passing the output either by reference or as a return value.

Rename them to ktime_get_coarse_real_ts64, ktime_get_coarse_ts64,
ktime_get_raw_ts64, ktime_get_boottime_ts64 and ktime_get_clocktai_ts64
respectively, and provide the interfaces with macros or inline
functions as needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping.h   | 43 ++++++++++++++++++++++++++++++++-----------
 include/linux/timekeeping32.h | 14 ++++++++++----
 kernel/time/timekeeping.c     | 23 +++++++++--------------
 3 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 415dae6bf1f5..3ef9791d7d75 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -19,25 +19,25 @@ extern void xtime_update(unsigned long ticks);
 extern int do_settimeofday64(const struct timespec64 *ts);
 extern int do_sys_settimeofday64(const struct timespec64 *tv,
 				 const struct timezone *tz);
-/*
- * Kernel time accessors
- */
-struct timespec64 current_kernel_time64(void);
 
 /*
  * timespec64 based interfaces
  */
-struct timespec64 get_monotonic_coarse64(void);
-extern void getrawmonotonic64(struct timespec64 *ts);
+extern void ktime_get_raw_ts64(struct timespec64 *ts);
 extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
+extern void ktime_get_coarse_ts64(struct timespec64 *ts);
+extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+
+void getboottime64(struct timespec64 *ts);
+
+/*
+ * time64_t base interfaces
+ */
 extern time64_t ktime_get_seconds(void);
 extern time64_t __ktime_get_real_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
 
-extern void getboottime64(struct timespec64 *ts);
-
-
 /*
  * ktime_t based interfaces
  */
@@ -123,12 +123,12 @@ extern u64 ktime_get_real_fast_ns(void);
 /*
  * timespec64 interfaces utilizing the ktime based ones
  */
-static inline void get_monotonic_boottime64(struct timespec64 *ts)
+static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_boottime());
 }
 
-static inline void timekeeping_clocktai64(struct timespec64 *ts)
+static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_clocktai());
 }
@@ -212,5 +212,26 @@ extern int update_persistent_clock64(struct timespec64 now);
  * deprecated aliases, don't use in new code
  */
 #define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
+#define get_monotonic_boottime64(ts)	ktime_get_boottime_ts64(ts)
+#define getrawmonotonic64(ts)		ktime_get_raw_ts64(ts)
+#define timekeeping_clocktai64(ts)	ktime_get_clocktai_ts64(ts)
+
+static inline struct timespec64 current_kernel_time64(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_coarse_real_ts64(&ts);
+
+	return ts;
+}
+
+static inline struct timespec64 get_monotonic_coarse64(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_coarse_ts64(&ts);
+
+	return ts;
+}
 
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 5abff52d07fd..8762c2f45f8b 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -11,9 +11,11 @@ unsigned long get_seconds(void);
 
 static inline struct timespec current_kernel_time(void)
 {
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 ts64;
+
+	ktime_get_coarse_real_ts64(&ts64);
 
-	return timespec64_to_timespec(now);
+	return timespec64_to_timespec(ts64);
 }
 
 /**
@@ -55,13 +57,17 @@ static inline void getrawmonotonic(struct timespec *ts)
 {
 	struct timespec64 ts64;
 
-	getrawmonotonic64(&ts64);
+	ktime_get_raw_ts64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
 
 static inline struct timespec get_monotonic_coarse(void)
 {
-	return timespec64_to_timespec(get_monotonic_coarse64());
+	struct timespec64 ts64;
+
+	ktime_get_coarse_ts64(&ts64);
+
+	return timespec64_to_timespec(ts64);
 }
 
 static inline void getboottime(struct timespec *ts)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7bbc7a6e6095..ed9b74ec9c0b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1391,12 +1391,12 @@ int timekeeping_notify(struct clocksource *clock)
 }
 
 /**
- * getrawmonotonic64 - Returns the raw monotonic time in a timespec
+ * ktime_get_raw_ts64 - Returns the raw monotonic time in a timespec
  * @ts:		pointer to the timespec64 to be set
  *
  * Returns the raw monotonic time (completely un-modified by ntp)
  */
-void getrawmonotonic64(struct timespec64 *ts)
+void ktime_get_raw_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long seq;
@@ -1412,7 +1412,7 @@ void getrawmonotonic64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 	timespec64_add_ns(ts, nsecs);
 }
-EXPORT_SYMBOL(getrawmonotonic64);
+EXPORT_SYMBOL(ktime_get_raw_ts64);
 
 
 /**
@@ -2114,23 +2114,20 @@ unsigned long get_seconds(void)
 }
 EXPORT_SYMBOL(get_seconds);
 
-struct timespec64 current_kernel_time64(void)
+void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	struct timespec64 now;
 	unsigned long seq;
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		now = tk_xtime(tk);
+		*ts = tk_xtime(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	return now;
 }
-EXPORT_SYMBOL(current_kernel_time64);
+EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
-struct timespec64 get_monotonic_coarse64(void)
+void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 now, mono;
@@ -2143,12 +2140,10 @@ struct timespec64 get_monotonic_coarse64(void)
 		mono = tk->wall_to_monotonic;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	set_normalized_timespec64(&now, now.tv_sec + mono.tv_sec,
+	set_normalized_timespec64(ts, now.tv_sec + mono.tv_sec,
 				now.tv_nsec + mono.tv_nsec);
-
-	return now;
 }
-EXPORT_SYMBOL(get_monotonic_coarse64);
+EXPORT_SYMBOL(ktime_get_coarse_ts64);
 
 /*
  * Must hold jiffies_lock
-- 
2.9.0
