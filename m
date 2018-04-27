Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeD0Nke (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:40:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932613AbeD0Nkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:40:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/5] timekeeping: Clean up ktime_get_real_ts64
Date: Fri, 27 Apr 2018 15:40:13 +0200
Message-Id: <20180427134016.2525989-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180427134016.2525989-1-arnd@arndb.de>
References: <20180427134016.2525989-1-arnd@arndb.de>
X-Provags-ID: V03:K1:CUjooTKXS2gtWcdDmypDT2d412ozPmM7npSccz7hzQ+nE6sj2qN
 KGXw1YliY1G9K4Ce9409D34tJ8uPH//3cwg6zJL5QQ1wMeMtU4qK+dhD5Aa7zztPjUJZwXk
 EI6NJAcIkfy0qtdSgq5MDPKMYAf+Yl8Yziv7034yxehD7Qamfm9ermdf3JChJaLJAyiuW4e
 naEUNyw+di5Z4NRWLC0cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I054Y2QP0Ds=:iY17+7Q7f6k6es3JmLjTzF
 SzLSipvY/LoIfRCUmdpYNS2VKkH9c3LK94U+sau5yVVm/IEjjrbitszkhJHoYxBzrQpJFXLpq
 68PTy9UAzwL6+M66Nk3o2sjYU+zkJyEjNCXPTnmbYODKQ3BnmW5sfroaSBa2hxeCVvNP9AAaA
 djVWK5Uqm9CUNmKS7wwwPPmnR8uvgzIebiKYKOJbbhmGyMVgWHvZyyWqVrZkbSCf/7hyT9/B9
 yAAPo0SupMJTa/pCsRW2OiAttKuH8jU4uSM9a8c+lV681zy1/94sDwGUb2MxbN6eZ2YIF/jCh
 Lke0BC2O73Ux6DTr+5mPL7ydurC7IWFLvDsHQVlncKbFqDmv/cOp7KdChq/Mtfkui5bWfPeGl
 g6NFcxB+asuK6AlBBRCQkUzj9XSF6EHR9mhD3DrQh4HDENf7QCT1c/WxqQ8zSvpolOR3t7piS
 vjawCzLHGbUGcG54SHDJ4d6f8XCbhaKSm9xh0PLyC2WASvhOMzqZFd68fHJsRU0wrtwYlaY2+
 rW8O7VPrJHlk/Z9k6OeGncp51gSWP5dqwgCxUZhbfG9dqVHzdav7UXCtbMZbenuqHUoShKgYu
 NC4OzeBbj7Jp3hU0qEWmfw+EJnTYBkczLrKiVsK65ZRiBaU3zWZEZ76hrkpRDyvDWCjgCzTP/
 ukNCANSjeXovoG4sSTRWLKBUmRVOlv/29O7txNlaQb8pBPqG3IOExar5AvHII/DuK3JA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a move to make ktime_get_*() the preferred driver interface into the
timekeeping code, sanitizes ktime_get_real_ts64() to be a proper exported
symbol rather than an alias for getnstimeofday64().

The internal __getnstimeofday64() is no longer used, so remove that
and merge it into ktime_get_real_ts64().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
-- 
2.9.0
