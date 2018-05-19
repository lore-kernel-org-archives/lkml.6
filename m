Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeESMBa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:01:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeESMB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:01:26 -0400
Date: Sat, 19 May 2018 05:01:18 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-edca71fecb77e2697337d192cbfe96f513407761@git.kernel.org>
Cc: arnd@arndb.de, sboyd@kernel.org, john.stultz@linaro.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: arnd@arndb.de, mingo@kernel.org, sboyd@kernel.org,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180427134016.2525989-3-arnd@arndb.de>
References: <20180427134016.2525989-3-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/2038] timekeeping: Clean up ktime_get_real_ts64
Git-Commit-ID: edca71fecb77e2697337d192cbfe96f513407761
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

Commit-ID:  edca71fecb77e2697337d192cbfe96f513407761
Gitweb:     https://git.kernel.org/tip/edca71fecb77e2697337d192cbfe96f513407761
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 27 Apr 2018 15:40:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:57:32 +0200

timekeeping: Clean up ktime_get_real_ts64

In a move to make ktime_get_*() the preferred driver interface into the
timekeeping code, sanitizes ktime_get_real_ts64() to be a proper exported
symbol rather than an alias for getnstimeofday64().

The internal __getnstimeofday64() is no longer used, so remove that
and merge it into ktime_get_real_ts64().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: y2038@lists.linaro.org
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180427134016.2525989-3-arnd@arndb.de

---
 include/linux/timekeeping.h   |  8 +++++---
 include/linux/timekeeping32.h | 13 ++-----------
 kernel/time/timekeeping.c     | 31 ++++++-------------------------
 3 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 588a0e4b1ab9..415dae6bf1f5 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -30,15 +30,13 @@ struct timespec64 current_kernel_time64(void);
 struct timespec64 get_monotonic_coarse64(void);
 extern void getrawmonotonic64(struct timespec64 *ts);
 extern void ktime_get_ts64(struct timespec64 *ts);
+extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern time64_t ktime_get_seconds(void);
 extern time64_t __ktime_get_real_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
 
-extern int __getnstimeofday64(struct timespec64 *tv);
-extern void getnstimeofday64(struct timespec64 *tv);
 extern void getboottime64(struct timespec64 *ts);
 
-#define ktime_get_real_ts64(ts)	getnstimeofday64(ts)
 
 /*
  * ktime_t based interfaces
@@ -210,5 +208,9 @@ extern void read_persistent_clock64(struct timespec64 *ts);
 extern void read_boot_clock64(struct timespec64 *ts);
 extern int update_persistent_clock64(struct timespec64 now);
 
+/*
+ * deprecated aliases, don't use in new code
+ */
+#define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
 
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 4ea45d0df1d4..5abff52d07fd 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -27,20 +27,11 @@ static inline int do_settimeofday(const struct timespec *ts)
 	return do_settimeofday64(&ts64);
 }
 
-static inline int __getnstimeofday(struct timespec *ts)
-{
-	struct timespec64 ts64;
-	int ret = __getnstimeofday64(&ts64);
-
-	*ts = timespec64_to_timespec(ts64);
-	return ret;
-}
-
 static inline void getnstimeofday(struct timespec *ts)
 {
 	struct timespec64 ts64;
 
-	getnstimeofday64(&ts64);
+	ktime_get_real_ts64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
 
@@ -56,7 +47,7 @@ static inline void ktime_get_real_ts(struct timespec *ts)
 {
 	struct timespec64 ts64;
 
-	getnstimeofday64(&ts64);
+	ktime_get_real_ts64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbceef5deb..7bbc7a6e6095 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -705,18 +705,19 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 }
 
 /**
- * __getnstimeofday64 - Returns the time of day in a timespec64.
+ * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
  *
- * Updates the time of day in the timespec.
- * Returns 0 on success, or -ve when suspended (timespec will be undefined).
+ * Returns the time of day in a timespec64 (WARN if suspended).
  */
-int __getnstimeofday64(struct timespec64 *ts)
+void ktime_get_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long seq;
 	u64 nsecs;
 
+	WARN_ON(timekeeping_suspended);
+
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
@@ -727,28 +728,8 @@ int __getnstimeofday64(struct timespec64 *ts)
 
 	ts->tv_nsec = 0;
 	timespec64_add_ns(ts, nsecs);
-
-	/*
-	 * Do not bail out early, in case there were callers still using
-	 * the value, even in the face of the WARN_ON.
-	 */
-	if (unlikely(timekeeping_suspended))
-		return -EAGAIN;
-	return 0;
-}
-EXPORT_SYMBOL(__getnstimeofday64);
-
-/**
- * getnstimeofday64 - Returns the time of day in a timespec64.
- * @ts:		pointer to the timespec64 to be set
- *
- * Returns the time of day in a timespec64 (WARN if suspended).
- */
-void getnstimeofday64(struct timespec64 *ts)
-{
-	WARN_ON(__getnstimeofday64(ts));
 }
-EXPORT_SYMBOL(getnstimeofday64);
+EXPORT_SYMBOL(ktime_get_real_ts64);
 
 ktime_t ktime_get(void)
 {
