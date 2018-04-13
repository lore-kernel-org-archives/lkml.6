Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeDMF2c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:28:32 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43677 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeDMF2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:28:31 -0400
X-Google-Smtp-Source: AIpwx4+Szc63Zcr3wiILMnkz8AxsP9ZauhIkYE1D2sPoMkQ2P3bNyO2JP/o6ZvIElCNhCNI8cxxD5w==
From: Baolin Wang <baolin.wang@linaro.org>
To: john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc: arnd@arndb.de, broonie@kernel.org, baolin.wang@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] timekeeping: Remove __current_kernel_time()
Date: Fri, 13 Apr 2018 13:27:58 +0800
Message-Id: <1a9dbea7ee2cda7efe9ed330874075cf17fdbff6.1523596316.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __current_kernel_time() function based on 'struct timespec' is no
longer recommended for new code, and the only user of this function
has been replaced by commit 6909e29fdefb ("kdb: use
__ktime_get_real_seconds instead of __current_kernel_time"). So now we
can remove this obsolete interface.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/timekeeping32.h |    3 ---
 kernel/time/timekeeping.c     |    7 -------
 2 files changed, 10 deletions(-)

diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index af4114d..3616b4b 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -9,9 +9,6 @@
 extern void do_gettimeofday(struct timeval *tv);
 unsigned long get_seconds(void);
 
-/* does not take xtime_lock */
-struct timespec __current_kernel_time(void);
-
 static inline struct timespec current_kernel_time(void)
 {
 	struct timespec64 now = current_kernel_time64();
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca90219..dcf7f20 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2139,13 +2139,6 @@ unsigned long get_seconds(void)
 }
 EXPORT_SYMBOL(get_seconds);
 
-struct timespec __current_kernel_time(void)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	return timespec64_to_timespec(tk_xtime(tk));
-}
-
 struct timespec64 current_kernel_time64(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-- 
1.7.9.5
