Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54201C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F59208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F59208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLGNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:50:07 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:54789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MjjOl-1hAsiW0a0R-00lGqH; Fri, 07 Dec 2018 14:48:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/8] sh: sh03: rtc: push down rtc class ops into driver
Date:   Fri,  7 Dec 2018 14:48:18 +0100
Message-Id: <20181207134824.300024-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:tJmSj16kgzkEh+PiEE6u2e5OJ6CVxUnOP9y0L0ftlO7hoGjRl5J
 lf/sG53Ec1SwTov/pEjsL3u6qgtvkD1SFhPo6ri7XKDMsj06AsZiJ6YMGrjKwGjNY6OAkJu
 PxCT6gxO16XV57bdcY3hquOkAr3Noc+zqviCKZ3eU1x1y51X5ZbGMsuYjmsKJeqRj8gt/tR
 4YuQQwatbWiqUQGVZQGUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WhaprctODx8=:U06puf8uqc/q8hnSWJZQYt
 ksDyox36bYVHeRLWq3hfejrWhAsKsqFn83jZvOOoK0UYDdvegewkBtRiw8yZOBVrlXV1NPsvO
 nPrMlTRcoMQjPbXJ1dQtXLdos+t7vj7FhcJl9EpFiHA/eigLqyjBInO1dV8MUqZZKaXLmFrbw
 nOTWKj/ZMAdoPd4cdRE+7+5cUelk1MqpAnu/pk+QxSgOJITh1Zmt4dkLE0+kAKSn5pj1XGQBI
 cO9VHYdBKuvkeznpfnVAOrr288FwiMoQPImHO2vW6FcTNpp9Aw372/Kiyndu/tMcNbfySKGep
 /2v2UPSZc/ESCvgt4csy5m5wJs4vNPLcPaEFuIJIIDiAs+dnvuP/BGrZMwui5md9EIttQkPV/
 kjUXPN+25YVmen7ssDz0Q0VVN6xs7kjyu/y0vFqgXnoTVG63yuk0PrGiQpyMbazUEan6AflEM
 rBOzBH5J3wdaDsVSafBnvWTb1yHY29fGowP0r+2HblwfPTCoOG2h1jpTPOy12ZeHNju8gJhN4
 tcdpeHLvJy0uxazyQCd2XzgHTXgWC3NAuLznr/lM5MyAORjOJxhdtQa20gVGQcHzCXTJ8W4Av
 N5LwEi1PfzdAbDfLeK6/1bbutdOw0N+TWCxBmnK/VAYXSQXkRa+YqcykbUZ/KiscYF+ZNjoRo
 ycMLhOCAfXv+AFnwmpKoesZZLnM7m4YVgbsWh0U3x1tMwc65Iz+WowYGePr53OBkP3BnC5su7
 BH54wpCGHUbbSP0mbHHkUHYlURkud9SgOnM0pA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dreamcast RTC support has an extra level of indirection to
provide either the old read_persistent_clock/update_persistent_clock
interface or the rtc-generic device for hctosys/systohc.

By removing the indirection and always using the RTC_CLASS interface,
we can avoid the lossy double conversion between rtc_time and timespec,
so we end up supporting the entire range of 'year' values, and clarifying
the rtc_set_time callback.

I did not change the behavior of sh03_rtc_settimeofday(), which keeps
just updating the seconds/minutes by calling set_rtc_mmss(), this
could be improved if anyone cares. Also, the file should ideally be
moved into drivers/rtc and not use rtc-generic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/boards/mach-sh03/Makefile |  3 +-
 arch/sh/boards/mach-sh03/rtc.c    | 51 +++++++++++++++++++------------
 arch/sh/boards/mach-sh03/setup.c  |  9 ------
 arch/sh/configs/sh03_defconfig    |  2 ++
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/sh/boards/mach-sh03/Makefile b/arch/sh/boards/mach-sh03/Makefile
index 400306a796ec..47007a3a2fc8 100644
--- a/arch/sh/boards/mach-sh03/Makefile
+++ b/arch/sh/boards/mach-sh03/Makefile
@@ -2,4 +2,5 @@
 # Makefile for the Interface (CTP/PCI-SH03) specific parts of the kernel
 #
 
-obj-y	 := setup.o rtc.o
+obj-y	 := setup.o
+obj-$(CONFIG_RTC_DRV_GENERIC) += rtc.o
diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index dc3d50e3b7a2..8b23ed7c201c 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -13,8 +13,9 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
-#include <asm/io.h>
-#include <asm/rtc.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
 
 #define RTC_BASE	0xb0000000
 #define RTC_SEC1	(RTC_BASE + 0)
@@ -38,7 +39,7 @@
 
 static DEFINE_SPINLOCK(sh03_rtc_lock);
 
-unsigned long get_cmos_time(void)
+static int sh03_rtc_gettimeofday(struct device *dev, struct rtc_time *tm)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -75,17 +76,18 @@ unsigned long get_cmos_time(void)
 	}
 
 	spin_unlock(&sh03_rtc_lock);
-	return mktime(year, mon, day, hour, min, sec);
-}
 
-void sh03_rtc_gettimeofday(struct timespec *tv)
-{
+	tm->tm_sec  = sec;
+	tm->tm_min  = min;
+	tm->tm_hour = hour;
+	tm->tm_mday = day;
+	tm->tm_mon  = mon;
+	tm->tm_year = year - 1900;
 
-	tv->tv_sec = get_cmos_time();
-	tv->tv_nsec = 0;
+	return 0;
 }
 
-static int set_rtc_mmss(unsigned long nowtime)
+static int set_rtc_mmss(struct rtc_time *tm)
 {
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
@@ -97,8 +99,8 @@ static int set_rtc_mmss(unsigned long nowtime)
 		if (!(__raw_readb(RTC_CTL) & RTC_BUSY))
 			break;
 	cmos_minutes = (__raw_readb(RTC_MIN1) & 0xf) + (__raw_readb(RTC_MIN10) & 0xf) * 10;
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
+	real_seconds = tm->tm_sec;
+	real_minutes = tm->tm_min;
 	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
 		real_minutes += 30;		/* correct for half hour time zone */
 	real_minutes %= 60;
@@ -112,22 +114,31 @@ static int set_rtc_mmss(unsigned long nowtime)
 		printk_once(KERN_NOTICE
 		       "set_rtc_mmss: can't update from %d to %d\n",
 		       cmos_minutes, real_minutes);
-		retval = -1;
+		retval = -EINVAL;
 	}
 	spin_unlock(&sh03_rtc_lock);
 
 	return retval;
 }
 
-int sh03_rtc_settimeofday(const time_t secs)
+int sh03_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long nowtime = secs;
-
-	return set_rtc_mmss(nowtime);
+	return set_rtc_mmss(tm);
 }
 
-void sh03_time_init(void)
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = sh03_rtc_gettimeofday,
+	.set_time = sh03_rtc_settimeofday,
+};
+
+static int __init sh03_time_init(void)
 {
-	rtc_sh_get_time = sh03_rtc_gettimeofday;
-	rtc_sh_set_time = sh03_rtc_settimeofday;
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
+
+	return PTR_ERR_OR_ZERO(pdev);
 }
+arch_initcall(sh03_time_init);
diff --git a/arch/sh/boards/mach-sh03/setup.c b/arch/sh/boards/mach-sh03/setup.c
index 85e7059a77e9..3901b6031ad5 100644
--- a/arch/sh/boards/mach-sh03/setup.c
+++ b/arch/sh/boards/mach-sh03/setup.c
@@ -22,14 +22,6 @@ static void __init init_sh03_IRQ(void)
 	plat_irq_setup_pins(IRQ_MODE_IRQ);
 }
 
-/* arch/sh/boards/sh03/rtc.c */
-void sh03_time_init(void);
-
-static void __init sh03_setup(char **cmdline_p)
-{
-	board_time_init = sh03_time_init;
-}
-
 static struct resource cf_ide_resources[] = {
 	[0] = {
 		.start  = 0x1f0,
@@ -101,6 +93,5 @@ device_initcall(sh03_devices_setup);
 
 static struct sh_machine_vector mv_sh03 __initmv = {
 	.mv_name		= "Interface (CTP/PCI-SH03)",
-	.mv_setup		= sh03_setup,
 	.mv_init_irq		= init_sh03_IRQ,
 };
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 2156223405a1..489ffdfb1517 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -130,3 +130,5 @@ CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_DEFLATE=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
-- 
2.18.0

