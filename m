Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08142C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FF220685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FF220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbeGXWpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:45:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57848 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388608AbeGXWpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:45:21 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LthuT-1g74Rb04mr-011BmG; Tue, 24 Jul 2018 23:36:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     dalias@libc.org
Cc:     ysato@users.sourceforge.jp, baolin.wang@linaro.org,
        y2038@lists.linaro.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/4] sh: dreamcast: rtc: push down rtc class ops into driver
Date:   Tue, 24 Jul 2018 23:36:21 +0200
Message-Id: <20180724213624.3899336-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:7Uh8AsYkJMOjFM01VrXgDnXSbrDNz+LOZatv9aU/vPLtBX9TRwU
 E/uK2f+Hi7/H/2Uz3mJ9xlDK+IVFjfE6Z++qQbUs9KYqRtp18PO6DMqjCMBj8RjfkAp9fPC
 5R730vBo6IYzv5xb9X6LS10ZqcGg60SznjdImIaivpkAfqB8IpWRHzog3kLhpqih6C7Qblm
 hu1HIJHr5+7NmNEDR+fYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zl42cKfB+Fg=:HJ61kPAGgHqO2PzTjPVUo+
 8Bnw2GE00aDnMlWsMM1rax08uLJu2J1ilkfDlCkthlEGiCcAHhjcwcFbGPZ3fz8F4THiswT7P
 TWH4VJvtWUlF31JJ+jWfCS4lcSNv1VRkaik2pikmjO/o+IlpdJKToXJPSzqULYoZB8WeIreEK
 TLCl9Ix+IZX5R1Ioc8IfgctoEhfnpUrHdqq40qoiLGhEecMuk/RSuQ85dghzgqV4uU4Ulth84
 dLb4oZ72WYLlHW+QNYbz177EmKC1qh73iy+UVaeBTwz81jSX8MIfASRD3uoR3TedRfrERK9J4
 2XuugufzB8lWGMUffcqsPunQ3XiWzIZbun+eSBjB2lHris42IYcefamrs6l2JXwRvvIb17j2Y
 RX7cUZ+D75LGsd7Wg5UhWyqXWdJ+QcDDEmmi392wJicLsqpoZaTkNJWbLWbPKllCd6KNi6Vc6
 acqD71Eh9NANXyaCbWi0ntPoEiYj6Bx8oioEyH2nRaXrYDRUFZT7cureF3ge27kP8EGQSnKuz
 m3GWz7yr33RlDGvHo4OPverg7YrWFrXbG6pCzG6I2L4HhWa/TK47v4mGK/eXzgZCjmsRq/0T0
 inWOZHdGK0Fo48XHYfsnLffxGZ/cp3RnJ8/v0zoBw8cct9RcfAqQR79XhyprmqulQowy7a1Pm
 lkoU82zO6uUM1kckG1YP2zJYLuQNlseWz8tI9S1KPJRhT+ZbLEIoDCqnfFoaKqRdlA08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dreamcast RTC support has an extra level of indirection to
provide either the old read_persistent_clock/update_persistent_clock
interface or the rtc-generic device for hctosys/systohc.

Both do the same thing here, so we can do away with the abstraction
and simply enable the RTC core code to take care of it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/boards/mach-dreamcast/Makefile        |  4 +-
 arch/sh/boards/mach-dreamcast/rtc.c           | 39 +++++++++++++------
 arch/sh/boards/mach-dreamcast/setup.c         |  1 -
 arch/sh/configs/dreamcast_defconfig           |  2 +
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
2.18.0

