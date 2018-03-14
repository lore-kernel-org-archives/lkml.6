Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeCNEF0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:05:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42064 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeCNEFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:05:25 -0400
X-Google-Smtp-Source: AG47ELvkXvlSD+j4W8pocHoQKYya/sgN7ijezjlerCIHIaRZc/EsbnLU0m0JcufMx7ka1dYTavbv6A==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH v5 03/10] compat: enable compat_get/put_timespec64 always
Date: Tue, 13 Mar 2018 21:03:26 -0700
Message-Id: <20180314040333.3291-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are used in the repurposed compat syscalls
to provide backward compatibility for using 32 bit time_t
on 32 bit systems.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/compat.h      |  2 --
 include/linux/compat_time.h |  4 ++++
 kernel/compat.c             | 52 +++++++--------------------------------------
 kernel/time/time.c          | 44 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 0eb4a3a8f62e..e4f64080ac97 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -267,8 +267,6 @@ extern int compat_get_timespec(struct timespec *, const void __user *);
 extern int compat_put_timespec(const struct timespec *, void __user *);
 extern int compat_get_timeval(struct timeval *, const void __user *);
 extern int compat_put_timeval(const struct timeval *, void __user *);
-extern int compat_get_timespec64(struct timespec64 *, const void __user *);
-extern int compat_put_timespec64(const struct timespec64 *, void __user *);
 extern int get_compat_itimerspec64(struct itimerspec64 *its,
 			const struct compat_itimerspec __user *uits);
 extern int put_compat_itimerspec64(const struct itimerspec64 *its,
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
index 56a54a1e4355..31f2774f1994 100644
--- a/include/linux/compat_time.h
+++ b/include/linux/compat_time.h
@@ -3,6 +3,7 @@
 #define _LINUX_COMPAT_TIME_H
 
 #include <linux/types.h>
+#include <linux/time64.h>
 
 typedef s32		compat_time_t;
 
@@ -16,4 +17,7 @@ struct compat_timeval {
 	s32		tv_usec;
 };
 
+extern int compat_get_timespec64(struct timespec64 *, const void __user *);
+extern int compat_put_timespec64(const struct timespec64 *, void __user *);
+
 #endif /* _LINUX_COMPAT_TIME_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index 3f5fa8902e7d..dabe15d11894 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -120,50 +120,6 @@ static int __compat_put_timespec(const struct timespec *ts, struct compat_timesp
 			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-static int __compat_get_timespec64(struct timespec64 *ts64,
-				   const struct compat_timespec __user *cts)
-{
-	struct compat_timespec ts;
-	int ret;
-
-	ret = copy_from_user(&ts, cts, sizeof(ts));
-	if (ret)
-		return -EFAULT;
-
-	ts64->tv_sec = ts.tv_sec;
-	ts64->tv_nsec = ts.tv_nsec;
-
-	return 0;
-}
-
-static int __compat_put_timespec64(const struct timespec64 *ts64,
-				   struct compat_timespec __user *cts)
-{
-	struct compat_timespec ts = {
-		.tv_sec = ts64->tv_sec,
-		.tv_nsec = ts64->tv_nsec
-	};
-	return copy_to_user(cts, &ts, sizeof(ts)) ? -EFAULT : 0;
-}
-
-int compat_get_timespec64(struct timespec64 *ts, const void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_from_user(ts, uts, sizeof(*ts)) ? -EFAULT : 0;
-	else
-		return __compat_get_timespec64(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_get_timespec64);
-
-int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
-{
-	if (COMPAT_USE_64BIT_TIME)
-		return copy_to_user(uts, ts, sizeof(*ts)) ? -EFAULT : 0;
-	else
-		return __compat_put_timespec64(ts, uts);
-}
-EXPORT_SYMBOL_GPL(compat_put_timespec64);
-
 int compat_get_timeval(struct timeval *tv, const void __user *utv)
 {
 	if (COMPAT_USE_64BIT_TIME)
@@ -367,6 +323,14 @@ COMPAT_SYSCALL_DEFINE3(sched_getaffinity, compat_pid_t,  pid, unsigned int, len,
 	return ret;
 }
 
+/* Todo: Delete these extern declarations when get/put_compat_itimerspec64()
+ * are moved to kernel/time/time.c .
+ */
+extern int __compat_get_timespec64(struct timespec64 *ts64,
+				   const struct compat_timespec __user *cts);
+extern int __compat_put_timespec64(const struct timespec64 *ts64,
+				   struct compat_timespec __user *cts);
+
 int get_compat_itimerspec64(struct itimerspec64 *its,
 			const struct compat_itimerspec __user *uits)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index bd4e6c7dd689..02367a381f44 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -868,6 +868,50 @@ int put_timespec64(const struct timespec64 *ts,
 }
 EXPORT_SYMBOL_GPL(put_timespec64);
 
+int __compat_get_timespec64(struct timespec64 *ts64,
+				   const struct compat_timespec __user *cts)
+{
+	struct compat_timespec ts;
+	int ret;
+
+	ret = copy_from_user(&ts, cts, sizeof(ts));
+	if (ret)
+		return -EFAULT;
+
+	ts64->tv_sec = ts.tv_sec;
+	ts64->tv_nsec = ts.tv_nsec;
+
+	return 0;
+}
+
+int __compat_put_timespec64(const struct timespec64 *ts64,
+				   struct compat_timespec __user *cts)
+{
+	struct compat_timespec ts = {
+		.tv_sec = ts64->tv_sec,
+		.tv_nsec = ts64->tv_nsec
+	};
+	return copy_to_user(cts, &ts, sizeof(ts)) ? -EFAULT : 0;
+}
+
+int compat_get_timespec64(struct timespec64 *ts, const void __user *uts)
+{
+	if (COMPAT_USE_64BIT_TIME)
+		return copy_from_user(ts, uts, sizeof(*ts)) ? -EFAULT : 0;
+	else
+		return __compat_get_timespec64(ts, uts);
+}
+EXPORT_SYMBOL_GPL(compat_get_timespec64);
+
+int compat_put_timespec64(const struct timespec64 *ts, void __user *uts)
+{
+	if (COMPAT_USE_64BIT_TIME)
+		return copy_to_user(uts, ts, sizeof(*ts)) ? -EFAULT : 0;
+	else
+		return __compat_put_timespec64(ts, uts);
+}
+EXPORT_SYMBOL_GPL(compat_put_timespec64);
+
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct itimerspec __user *uit)
 {
-- 
2.14.1
