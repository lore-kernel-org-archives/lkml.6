Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeD0NlZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:41:25 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbeD0Nkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:40:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] timekeeping: Add more coarse clocktai/boottime interfaces
Date: Fri, 27 Apr 2018 15:40:16 +0200
Message-Id: <20180427134016.2525989-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180427134016.2525989-1-arnd@arndb.de>
References: <20180427134016.2525989-1-arnd@arndb.de>
X-Provags-ID: V03:K1:uonBy91dvbuMWIj/ldRXQtdvkjZzO/hIlRcXmhW1mUizriMiMPA
 GFsdZ7d4EMf/2MWspTb99iulTlDts7EAqBQYgEbo7VrDShmyr+jNOJYEuJuJh3AwbRKmOs9
 1h46DT+S4NaDauOmh/WnSZclNm43XaM+JD7dpImAIx+vmS4ZBYocfrUhcPTAPBWdGgx5Lm+
 mkLppwOtklC6aLNHGK6Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EF0DKsAPUBM=:thJXz+QNOYMTDmMuZx3Ge/
 NCqH1OMDohWDyJdJvD/gXnn7ELSV6Yg8puy1IchZERkuzsfaWY1mQYCQoZOtiy1LhOmxLcry4
 0B9Cgc+IwBpqocePQ1JKtRp3V0id58jBRuSTeK0iR6B7ZHzLDyyfJAJSrbskJwE4boe+/qmEl
 5nXeRqS2GBtNXxY9+rieDCunF4Lkz1H9DMD+kqvPIy3A4SOfsaT6g8J/GbxaJ87EA61JUlTpA
 hg+HWPzW4oa7C2dCy7+d16Dr00ezcvTdTn3hjVD/hBc4n71j9KU3t8bhehgb0JKusdbuPLIzl
 WOCr5MJTMFNC3CRloou5Ac8MtFy1VDbHpbFKlGf0zzrL8tPsraGXZCHnxPPSse3WdH35gKLzK
 cauuGqQolCk5hK1axoOv1FumRQ8OYjUDMR7Vip2pm38bFCRlGgNCx8UlsrkpRdT5M+PPMHmBZ
 gCg+AntKA//2qcZW0qO8E0HpVmWehhetIFxkQIdlnoR2Bn3TyIrEY+MWv4kShrGs/gbWvx2Bv
 qWMsQPWm1Z93e1yuf2PeE0sXBVn8iO7qpzYobe1hdLcU9TBCT/4kpOAiFBvpiSF2YL3/4D/ew
 uhvd2146gjNg1FnyICxRVv56GPjUMcooNSaQkfQ8fP4YaKkykTDCCUa7lOSAOIjGRNdmfWc1N
 G94Pxc4J8DQpROd6LGTcA1QBU4TPicYCjAseeZaQIzcHyYwWJm1oL2KUGFnylciFw4vI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
-- 
2.9.0
