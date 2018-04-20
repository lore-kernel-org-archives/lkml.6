Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755781AbeDTPvb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:51:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbeDTPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:51:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rich Felker <dalias@libc.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sh: remove unused rtc_sh_get/set_time infrastructure
Date: Fri, 20 Apr 2018 17:48:55 +0200
Message-Id: <20180420154933.3235131-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180420154933.3235131-1-arnd@arndb.de>
References: <20180420154933.3235131-1-arnd@arndb.de>
X-Provags-ID: V03:K1:0p2jbzaKK86D9LBfxKuJsFlRNChEero7sqL8EGIydd+q3C6j1Va
 bLs3qQ5wQa1IZWmiJGVqQjVh5pLh1jfQD/nah2jhby1BDQeI0Qgd6Oz9A7XaOMYIzhBW2M1
 pqnyivoRRXVYKt8l7q9uSWqD3+MwQs5ifpcumth14R8LocJVwanSpf/474QGAWS3ftIWn6L
 rHXdTGUihaH1d5zT4Ps2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:74k1vNT1t9I=:E6fIL2ZdQC4ELA6Jr3LSEP
 dsoju3wmLg6y9qbQ6t7dDAxrj99VZI3k6eCmAyfTB7fGjDkkdNVc+yyr4I+N/2OAy/wU0ek1C
 vNf3NvAg12mCWsVEE0IhemRprHIrzaFzZN8Shf7bTBNlux4kgP5TpAxvMieo8hG0AM64ZfRZv
 qAaqmiMUMmroasdNXxwNBBdprojybibFixUTKbeUjHnebOsG8M7f0avNOMzslwTzO5+oaonhx
 FiOl3XR58E9FjKCVSMeYYEDSLaaUz7OJCPEAtdRZ5vnrKwXRzgyskMy755Nfdkb7dDPT823+f
 nKyYfw9T71bmmXRwYfemb+mILExxASbNMFq0DQwSRSNKf2zxQapxFfVCKgGpcHnuxsmUcAmlg
 W7oO71v8epwUwa54+k76gM+LdIKb/klQ4fIFvNwCMvelUXX0Lrp4SCVNK5fQWaxt4QgZJLIPN
 QoJEXabGSmZH0bo1u1prU1qM5OFZQQskNfyF/k3IdNdrYvTaejD3pTijS2wGafMfYmNhM+GTQ
 dIkye7m4sXh3JNOGDaPq4wvVHu7y5KvwqrriUWTMz3FPqCsaRWBtnhPGFisyJ+jelV9hrCJIJ
 FbSYWxPaXQoHi39xEXvPkXUJwCt+WOw+utIqJvSHGbj/6X+CQvIZMZf9/YlLC0RbWluLscmZb
 oFdRXZih+wRPUFUi/b40huYg7FT4Wxx91yYMIUnNmy2B3U9jRFDxaq71TUsAtlwAd+Jly7yh1
 M72ZQJbQ6DXfIOuavMnGT2X2TFWfQKbyX5nmzA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platforms are now converted to RTC drivers, so this has become
obsolete. The board_time_init() callback still has one caller, but
could otherwise also get killed.

This removes one more usage of the deprecated timespec structure,
which overflows in y2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/rtc.h |  2 --
 arch/sh/kernel/time.c     | 69 -----------------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index c63555ee1255..fe55fbb181aa 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -4,8 +4,6 @@
 
 void time_init(void);
 extern void (*board_time_init)(void);
-extern void (*rtc_sh_get_time)(struct timespec *);
-extern int (*rtc_sh_set_time)(const time_t);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41977d1..eb0a91270499 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,75 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-/* Dummy RTC ops */
-static void null_rtc_get_time(struct timespec *tv)
-{
-	tv->tv_sec = mktime(2000, 1, 1, 0, 0, 0);
-	tv->tv_nsec = 0;
-}
-
-static int null_rtc_set_time(const time_t secs)
-{
-	return 0;
-}
-
-void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
-int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
-
-void read_persistent_clock(struct timespec *ts)
-{
-	rtc_sh_get_time(ts);
-}
-
-#ifdef CONFIG_GENERIC_CMOS_UPDATE
-int update_persistent_clock(struct timespec now)
-{
-	return rtc_sh_set_time(now.tv_sec);
-}
-#endif
-
-static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
-{
-	struct timespec tv;
-
-	rtc_sh_get_time(&tv);
-	rtc_time_to_tm(tv.tv_sec, tm);
-	return 0;
-}
-
-static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-{
-	unsigned long secs;
-
-	rtc_tm_to_time(tm, &secs);
-	if ((rtc_sh_set_time == null_rtc_set_time) ||
-	    (rtc_sh_set_time(secs) < 0))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static const struct rtc_class_ops rtc_generic_ops = {
-	.read_time = rtc_generic_get_time,
-	.set_time = rtc_generic_set_time,
-};
-
-static int __init rtc_generic_init(void)
-{
-	struct platform_device *pdev;
-
-	if (rtc_sh_get_time == null_rtc_get_time)
-		return -ENODEV;
-
-	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
-					     &rtc_generic_ops,
-					     sizeof(rtc_generic_ops));
-
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(rtc_generic_init);
-
 void (*board_time_init)(void);
 
 static void __init sh_late_time_init(void)
-- 
2.9.0
