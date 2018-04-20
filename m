Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755874AbeDTPt7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:49:59 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755849AbeDTPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:49:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rich Felker <dalias@libc.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sh: dreamcast: rtc: push down rtc class ops into driver
Date: Fri, 20 Apr 2018 17:48:53 +0200
Message-Id: <20180420154933.3235131-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:BO28J4T9sfoTD3A/5F9+J6y+qVnhQctspbP9B8h2lLDhesVLGOO
 NfPZKpxZjMJPuxw6YsCxvIssopQfX06TeEDpxNoPS1k8aF+UABXmM9Gij3ODCfgRfj9/GHg
 oUmYqYRJiKrvS4ps8ifSpf3DXx4fl+nc9ZKY8VLuCircKzDcTjApS30J2RFDvdhCxgTLZoj
 QX2kNUCwKBfWQmma/+u2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:imd5xLKD8yw=:FjSs905GC/hm6SC7YMxOrz
 AxZxbqA2L3/RpqxSe51KdwUA0m/Zr2H6pZFzErVLzdGaRAULC0lweflSumcDLEcU0LDMTRSKx
 lWg5l2k4WSS8jb/KqczhOwtsQALC0hKW462JRqgnzKAhcO6UFZTkg9VkW+V3/o/GH5rQmHqWI
 IQfgyIacVEkbP4LxkWHp+CtSOKYG15AubC5NeAEnr3rLi73RRnKWocqxm2kUs+/0EvWS6i7B4
 n1oCJ4VC+SlVj1S28jcVpMnQJ5xj7seDi8s68PWUV7hNzcx+zQZSgJ92y7dtiZsAQA2dKctBB
 KqxEjuXf0iGmmg3thd630tnBUC9t7mcjbYwy0Z+85UOJmIpzUmIj1FR69z0Hp3B9LTbZsGnsg
 xBh9gxt4d0+PBECUyF+1zBRjhTOh//k3nDFiylNknpSeqMggrVqwP2OC4qXutjVZ/mVx+BTno
 sGyqvG6TJZOZmN7CmriGoIct6na8sPGd4HO/62rtsJeJyjZ4AOrnnOVjGbNexeHekkrubRoxM
 gu3MIoPceUegSy9nF0cvsmEsJ1p3DvWjijOM1yIcPfJTjRJCKy6sYTIae+upNMW3hWT3o33pi
 SKZ4hZ8st0MKfgawQCSzX4rPZM/8B1bg3XKKtkPTTj7/iP5P/xz/cdctvku6fK4gBFZinH8Kt
 57XmJFNeXqHZqJd5AfmgkbvAOzhJClpFnEW+GHG7l02QAjNuklO/SruQE6aKVeNlgGarm/S6y
 3KBjqOJ1GrcYsVVfuMM0+4TljfJ0RzXYfitgQA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dreamcast RTC support has an extra level of indirection to
provide either the old read_persistent_clock/update_persistent_clock
interface or the rtc-generic device for hctosys/systohc.

Both do the same thing here, so we can do away with the abstraction
and simply enable the RTC core code to take care of it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/boards/mach-dreamcast/Makefile        |  4 +--
 arch/sh/boards/mach-dreamcast/rtc.c           | 39 ++++++++++++++++++---------
 arch/sh/boards/mach-dreamcast/setup.c         |  1 -
 arch/sh/configs/dreamcast_defconfig           |  2 ++
 arch/sh/include/mach-dreamcast/mach/sysasic.h |  1 -
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/sh/boards/mach-dreamcast/Makefile b/arch/sh/boards/mach-dreamcast/Makefile
index 7b97546c7e5f..62b024bc2a3e 100644
--- a/arch/sh/boards/mach-dreamcast/Makefile
+++ b/arch/sh/boards/mach-dreamcast/Makefile
@@ -2,5 +2,5 @@
 # Makefile for the Sega Dreamcast specific parts of the kernel
 #
 
-obj-y	 := setup.o irq.o rtc.o
-
+obj-y	 := setup.o irq.o
+obj-$(CONFIG_RTC_DRV_GENERIC) += rtc.o
diff --git a/arch/sh/boards/mach-dreamcast/rtc.c b/arch/sh/boards/mach-dreamcast/rtc.c
index 061d65714fcc..4f168d8d2951 100644
--- a/arch/sh/boards/mach-dreamcast/rtc.c
+++ b/arch/sh/boards/mach-dreamcast/rtc.c
@@ -11,8 +11,9 @@
  */
 
 #include <linux/time.h>
-#include <asm/rtc.h>
-#include <asm/io.h>
+#include <linux/rtc.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
 
 /* The AICA RTC has an Epoch of 1/1/1950, so we must subtract 20 years (in
    seconds) to get the standard Unix Epoch when getting the time, and add
@@ -30,9 +31,10 @@
  *
  * Grabs the current RTC seconds counter and adjusts it to the Unix Epoch.
  */
-static void aica_rtc_gettimeofday(struct timespec *ts)
+static int aica_rtc_gettimeofday(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long val1, val2;
+	time64_t t;
 
 	do {
 		val1 = ((__raw_readl(AICA_RTC_SECS_H) & 0xffff) << 16) |
@@ -42,10 +44,12 @@ static void aica_rtc_gettimeofday(struct timespec *ts)
 			(__raw_readl(AICA_RTC_SECS_L) & 0xffff);
 	} while (val1 != val2);
 
-	ts->tv_sec = val1 - TWENTY_YEARS;
+	/* normalize to 1970..2106 time range */
+	t = (u32)(val1 - TWENTY_YEARS);
 
-	/* Can't get nanoseconds with just a seconds counter. */
-	ts->tv_nsec = 0;
+	rtc_time64_to_tm(t, tm);
+
+	return 0;
 }
 
 /**
@@ -54,10 +58,11 @@ static void aica_rtc_gettimeofday(struct timespec *ts)
  *
  * Adjusts the given @tv to the AICA Epoch and sets the RTC seconds counter.
  */
-static int aica_rtc_settimeofday(const time_t secs)
+static int aica_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long val1, val2;
-	unsigned long adj = secs + TWENTY_YEARS;
+	time64_t secs = rtc_tm_to_time64(tm);
+	u32 adj = secs + TWENTY_YEARS;
 
 	do {
 		__raw_writel((adj & 0xffff0000) >> 16, AICA_RTC_SECS_H);
@@ -73,9 +78,19 @@ static int aica_rtc_settimeofday(const time_t secs)
 	return 0;
 }
 
-void aica_time_init(void)
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = aica_rtc_gettimeofday,
+	.set_time = aica_rtc_settimeofday,
+};
+
+static int __init aica_time_init(void)
 {
-	rtc_sh_get_time = aica_rtc_gettimeofday;
-	rtc_sh_set_time = aica_rtc_settimeofday;
-}
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
 
+	return PTR_ERR_OR_ZERO(pdev);
+}
+arch_initcall(aica_time_init);
diff --git a/arch/sh/boards/mach-dreamcast/setup.c b/arch/sh/boards/mach-dreamcast/setup.c
index ad1a4db72e04..672c2ad8f8d5 100644
--- a/arch/sh/boards/mach-dreamcast/setup.c
+++ b/arch/sh/boards/mach-dreamcast/setup.c
@@ -30,7 +30,6 @@
 
 static void __init dreamcast_setup(char **cmdline_p)
 {
-	board_time_init = aica_time_init;
 }
 
 static struct sh_machine_vector mv_dreamcast __initmv = {
diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index 3f08dc54480b..1d27666c029f 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -70,3 +70,5 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index 58f710e1ebc2..59effd1ed3e1 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -42,7 +42,6 @@
 /* arch/sh/boards/mach-dreamcast/irq.c */
 extern int systemasic_irq_demux(int);
 extern void systemasic_irq_init(void);
-extern void aica_time_init(void);
 
 #endif /* __ASM_SH_DREAMCAST_SYSASIC_H */
 
-- 
2.9.0
