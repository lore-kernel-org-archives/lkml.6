Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeD0NlY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:41:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932678AbeD0Nkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:40:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] timekeeping: Remove timespec64 hack
Date: Fri, 27 Apr 2018 15:40:12 +0200
Message-Id: <20180427134016.2525989-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180427134016.2525989-1-arnd@arndb.de>
References: <20180427134016.2525989-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ta0UUbZTuZ+9MsfOwrA5oLOyLJcPbkv8upcObDV9YL+TJ/AbOW8
 lN7pWpomTmHDhQu2ErEZbBRIbJJ6MbRmRcMy0Ri64J+NqIb0TUJNVdEYVxmSwq+Re/wOVk2
 xosxU10K7tp/X6eNKsJ6ifrJgwm/VwNtaM8PJSXRWpQf9sYjx5E9c/+igZD27hOu9GvfY/f
 /oLxIbeiSw9E/TdYTwELQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HhFSUw9orQo=:yBaNIRaFfoyaRcreqGxyIR
 h6nfdctfS+zJZVedUd2zrEZtQKFA5DW7HXONPDIriG5ItIxUj97I7gbeoBdCERSJ0Qsw3pZ9z
 M1YltIbJIU4LWbSAmJ7MwgcTFRiSr9EvVvdTy7DVkCBCArIgsQGOhDVkA3LHwwOcRtwmiCTFX
 Q7RfFxr5lVN+chAqESHJdTtNecFGwZWy3Y0w300j0/kzTl9ZgyZB5A9SaFBfGhrYA6A2W52pG
 L0QQ+ZELTlCGvxPTSVnEuiFG96Jt0PFQdcG1VbNI4gBqFDuuwlp0qKb4XklyiaSPpPPE/IEPV
 UOIa0k9Be0aL85wFecBcfXAWXNkC6s616WGbmOKTOqRmZ1rFXgE38UqpKfVdtTJs0+aSwVytm
 gHtCU6VpwU9cFbhVnnyZMi0iLx1yVIyTQ6w54qCRpRqolzuL9+4JlhsyiymChrHXh4Si8GGuM
 c38TfaHpVJktCl0dC7/bus67AdBZXlAnzQk4Tl82jYVMUli7hZoWLTSiVX1sld9he2wmEiR9E
 dUwkEXvEfXL8K3d4i6HX38vtEWc3VIecgdx8fWE7bX8Af9w4A0P2gJKiFB6bL2urjcvZ6SNUA
 nPC2eFflJERnmCkQULUpIcgyb7qDK8uZb2bhBJU8+v8B5cbz9rk5lMP/hh5j8uAfOQ6E1ji54
 XmMzf6xEQ/wKoZiiyJWnM271ZQeG8ppHP418++FZGop6TiPxvVkXo12QFTBi1LqONKrc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 3ddf10b6523c..8e4f3fd2f84b 100644
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
-- 
2.9.0
