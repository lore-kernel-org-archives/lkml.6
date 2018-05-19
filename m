Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeESMCz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:02:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56861 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeESMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:02:52 -0400
Date: Sat, 19 May 2018 05:02:44 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-06aa376903b6e8c8741395a4702d78d47c7c27c6@git.kernel.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org, arnd@arndb.de,
        mingo@kernel.org
In-Reply-To: <20180427134016.2525989-6-arnd@arndb.de>
References: <20180427134016.2525989-6-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/2038] timekeeping: Add more coarse clocktai/boottime
 interfaces
Git-Commit-ID: 06aa376903b6e8c8741395a4702d78d47c7c27c6
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

Commit-ID:  06aa376903b6e8c8741395a4702d78d47c7c27c6
Gitweb:     https://git.kernel.org/tip/06aa376903b6e8c8741395a4702d78d47c7c27c6
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 27 Apr 2018 15:40:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:57:33 +0200

timekeeping: Add more coarse clocktai/boottime interfaces

The set of APIs we provide has a few holes for coarse times, e.g. we
provide ktime_get_coarse_boottime() and ktime_get_boottime_ts64(),
but not the combination of the two.

This adds four new functions:

ktime_get_coarse_boottime_ts64()
ktime_get_boottime_seconds()
ktime_get_coarse_clocktai_ts64()
ktime_get_clocktai_seconds()

to fill in some of the missing pieces. I have missed only the
ktime_get_boottime_seconds() accessor in a few occasions in
the past, but it seems better to just provide all four together,
as there is very little cost to having them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: y2038@lists.linaro.org
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180427134016.2525989-6-arnd@arndb.de

---
 include/linux/timekeeping.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 42f71f4b658a..86bc2026efce 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -137,18 +137,40 @@ extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
 /*
- * timespec64 interfaces utilizing the ktime based ones
+ * timespec64/time64_t interfaces utilizing the ktime based ones
+ * for API completeness, these could be implemented more efficiently
+ * if needed.
  */
 static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_boottime());
 }
 
+static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
+{
+	*ts = ktime_to_timespec64(ktime_get_coarse_boottime());
+}
+
+static inline time64_t ktime_get_boottime_seconds(void)
+{
+	return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
+}
+
 static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
 {
 	*ts = ktime_to_timespec64(ktime_get_clocktai());
 }
 
+static inline void ktime_get_coarse_clocktai_ts64(struct timespec64 *ts)
+{
+	*ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
+}
+
+static inline time64_t ktime_get_clocktai_seconds(void)
+{
+	return ktime_divns(ktime_get_coarse_clocktai(), NSEC_PER_SEC);
+}
+
 /*
  * RTC specific
  */
