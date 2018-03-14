Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeCNEHd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 00:07:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37412 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCNEGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 00:06:24 -0400
X-Google-Smtp-Source: AG47ELsddOOJdATrlfy+061Ned6wMofLdLPIWjZub92ZrotXYPbmuZCE2vIsHRZzQ2Xq+VBQWpPRrg==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH v5 08/10] fix get_timespec64() for y2038 safe compat interfaces
Date: Tue, 13 Mar 2018 21:03:31 -0700
Message-Id: <20180314040333.3291-9-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get/put_timespec64() interfaces will eventually be used for
conversions between the new y2038 safe struct __kernel_timespec
and struct timespec64.

The new y2038 safe syscalls have a common entry for native
and compat interfaces.
On compat interfaces, the high order bits of nanoseconds
should be zeroed out. This is because the application code
or the libc do not guarantee zeroing of these. If used without
zeroing, kernel might be at risk of using timespec values
incorrectly.

Note that clearing of bits is dependent on CONFIG_64BIT_TIME
for now. This is until COMPAT_USE_64BIT_TIME has been handled
correctly. x86 will be the first architecture that will use the
CONFIG_64BIT_TIME.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/time.h |  4 ++--
 kernel/time/time.c   | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 4b62a2c0a661..aed74463592d 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -10,9 +10,9 @@
 extern struct timezone sys_tz;
 
 int get_timespec64(struct timespec64 *ts,
-		const struct timespec __user *uts);
+		const struct __kernel_timespec __user *uts);
 int put_timespec64(const struct timespec64 *ts,
-		struct timespec __user *uts);
+		struct __kernel_timespec __user *uts);
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct itimerspec __user *uit);
 int put_itimerspec64(const struct itimerspec64 *it,
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 02367a381f44..05121aec6897 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -841,9 +841,9 @@ struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
 }
 
 int get_timespec64(struct timespec64 *ts,
-		   const struct timespec __user *uts)
+		   const struct __kernel_timespec __user *uts)
 {
-	struct timespec kts;
+	struct __kernel_timespec kts;
 	int ret;
 
 	ret = copy_from_user(&kts, uts, sizeof(kts));
@@ -851,6 +851,11 @@ int get_timespec64(struct timespec64 *ts,
 		return -EFAULT;
 
 	ts->tv_sec = kts.tv_sec;
+
+	/* Zero out the padding for 32 bit systems or in compat mode */
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()))
+		kts.tv_nsec &= 0xFFFFFFFFUL;
+
 	ts->tv_nsec = kts.tv_nsec;
 
 	return 0;
@@ -858,12 +863,13 @@ int get_timespec64(struct timespec64 *ts,
 EXPORT_SYMBOL_GPL(get_timespec64);
 
 int put_timespec64(const struct timespec64 *ts,
-		   struct timespec __user *uts)
+		   struct __kernel_timespec __user *uts)
 {
-	struct timespec kts = {
+	struct __kernel_timespec kts = {
 		.tv_sec = ts->tv_sec,
 		.tv_nsec = ts->tv_nsec
 	};
+
 	return copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
 }
 EXPORT_SYMBOL_GPL(put_timespec64);
-- 
2.14.1
