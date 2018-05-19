Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeESMBA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:01:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeESMA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:00:58 -0400
Date: Sat, 19 May 2018 05:00:45 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-4f0fad9a603aee91a374e8411c23953894a77479@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, arnd@arndb.de, mingo@kernel.org, hpa@zytor.com,
        sboyd@kernel.org
Reply-To: arnd@arndb.de, hpa@zytor.com, mingo@kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
In-Reply-To: <20180427134016.2525989-2-arnd@arndb.de>
References: <20180427134016.2525989-2-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/2038] timekeeping: Remove timespec64 hack
Git-Commit-ID: 4f0fad9a603aee91a374e8411c23953894a77479
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

Commit-ID:  4f0fad9a603aee91a374e8411c23953894a77479
Gitweb:     https://git.kernel.org/tip/4f0fad9a603aee91a374e8411c23953894a77479
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 27 Apr 2018 15:40:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:57:31 +0200

timekeeping: Remove timespec64 hack

At this point, we have converted most of the kernel to use timespec64
consistently in place of timespec, so it seems it's time to make
timespec64 the native structure and define timespec in terms of that
one on 64-bit architectures.

Starting with gcc-5, the compiler can completely optimize away the
timespec_to_timespec64 and timespec64_to_timespec functions on 64-bit
architectures. With older compilers, we introduce a couple of extra
copies of local variables, but those are easily avoided by using
the timespec64 based interfaces consistently, as we do in most of the
important code paths already.

The main upside of removing the hack is that printing the tv_sec
field of a timespec64 structure can now use the %lld format
string on all architectures without a cast to time64_t. Without
this patch, the field is a 'long' type and would have to be printed
using %ld on 64-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: y2038@lists.linaro.org
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180427134016.2525989-2-arnd@arndb.de

---
 include/linux/time32.h        | 18 +++--------------
 include/linux/time64.h        |  7 -------
 include/linux/timekeeping32.h | 45 -------------------------------------------
 kernel/time/time.c            |  2 --
 4 files changed, 3 insertions(+), 69 deletions(-)

diff --git a/include/linux/time32.h b/include/linux/time32.h
index d2bcd4377b56..0b14f936100a 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -18,25 +18,14 @@
 /* timespec64 is defined as timespec here */
 static inline struct timespec timespec64_to_timespec(const struct timespec64 ts64)
 {
-	return ts64;
+	return *(const struct timespec *)&ts64;
 }
 
 static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
 {
-	return ts;
+	return *(const struct timespec64 *)&ts;
 }
 
-# define timespec_equal			timespec64_equal
-# define timespec_compare		timespec64_compare
-# define set_normalized_timespec	set_normalized_timespec64
-# define timespec_add			timespec64_add
-# define timespec_sub			timespec64_sub
-# define timespec_valid			timespec64_valid
-# define timespec_valid_strict		timespec64_valid_strict
-# define timespec_to_ns			timespec64_to_ns
-# define ns_to_timespec			ns_to_timespec64
-# define timespec_add_ns		timespec64_add_ns
-
 #else
 static inline struct timespec timespec64_to_timespec(const struct timespec64 ts64)
 {
@@ -55,6 +44,7 @@ static inline struct timespec64 timespec_to_timespec64(const struct timespec ts)
 	ret.tv_nsec = ts.tv_nsec;
 	return ret;
 }
+#endif
 
 static inline int timespec_equal(const struct timespec *a,
 				 const struct timespec *b)
@@ -159,8 +149,6 @@ static __always_inline void timespec_add_ns(struct timespec *a, u64 ns)
 	a->tv_nsec = ns;
 }
 
-#endif
-
 /**
  * time_to_tm - converts the calendar time to local broken-down time
  *
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 0d96887ba4e0..0a7b2f79cec7 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -16,11 +16,6 @@ typedef __u64 timeu64_t;
 
 #include <uapi/linux/time.h>
 
-#if __BITS_PER_LONG == 64
-/* this trick allows us to optimize out timespec64_to_timespec */
-# define timespec64 timespec
-#define itimerspec64 itimerspec
-#else
 struct timespec64 {
 	time64_t	tv_sec;			/* seconds */
 	long		tv_nsec;		/* nanoseconds */
@@ -31,8 +26,6 @@ struct itimerspec64 {
 	struct timespec64 it_value;
 };
 
-#endif
-
 /* Parameters used to convert the timespec values: */
 #define MSEC_PER_SEC	1000L
 #define USEC_PER_MSEC	1000L
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 3616b4becb59..4ea45d0df1d4 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -16,50 +16,6 @@ static inline struct timespec current_kernel_time(void)
 	return timespec64_to_timespec(now);
 }
 
-#if BITS_PER_LONG == 64
-/**
- * Deprecated. Use do_settimeofday64().
- */
-static inline int do_settimeofday(const struct timespec *ts)
-{
-	return do_settimeofday64(ts);
-}
-
-static inline int __getnstimeofday(struct timespec *ts)
-{
-	return __getnstimeofday64(ts);
-}
-
-static inline void getnstimeofday(struct timespec *ts)
-{
-	getnstimeofday64(ts);
-}
-
-static inline void ktime_get_ts(struct timespec *ts)
-{
-	ktime_get_ts64(ts);
-}
-
-static inline void ktime_get_real_ts(struct timespec *ts)
-{
-	getnstimeofday64(ts);
-}
-
-static inline void getrawmonotonic(struct timespec *ts)
-{
-	getrawmonotonic64(ts);
-}
-
-static inline struct timespec get_monotonic_coarse(void)
-{
-	return get_monotonic_coarse64();
-}
-
-static inline void getboottime(struct timespec *ts)
-{
-	return getboottime64(ts);
-}
-#else
 /**
  * Deprecated. Use do_settimeofday64().
  */
@@ -124,7 +80,6 @@ static inline void getboottime(struct timespec *ts)
 	getboottime64(&ts64);
 	*ts = timespec64_to_timespec(ts64);
 }
-#endif
 
 /*
  * Timespec interfaces utilizing the ktime based ones
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ccd751e95fcb..6fa99213fc72 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -407,7 +407,6 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-#if __BITS_PER_LONG == 32
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *
@@ -468,7 +467,6 @@ struct timespec ns_to_timespec(const s64 nsec)
 	return ts;
 }
 EXPORT_SYMBOL(ns_to_timespec);
-#endif
 
 /**
  * ns_to_timeval - Convert nanoseconds to timeval
