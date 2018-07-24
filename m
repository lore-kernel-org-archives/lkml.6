Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC2C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3AF20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3AF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbeGXWpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:45:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeGXWpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:45:17 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M6c40-1fu61m1O20-00wZ4X; Tue, 24 Jul 2018 23:36:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     dalias@libc.org
Cc:     ysato@users.sourceforge.jp, baolin.wang@linaro.org,
        y2038@lists.linaro.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/4] sh: sh03: rtc: push down rtc class ops into driver
Date:   Tue, 24 Jul 2018 23:36:22 +0200
Message-Id: <20180724213624.3899336-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724213624.3899336-1-arnd@arndb.de>
References: <20180724213624.3899336-1-arnd@arndb.de>
X-Provags-ID: V03:K1:h963X9dmY9XTY2HqhC8hVhLcssisxD3pNLw3/Z1KnrlUy2xfwqf
 /81GD4arejQ3ih11VUinqWphDhbcZGv3LE7NVdsPo5XXsaAa0LEjtSeeWbl7DvET6334ZeP
 5w3VUW7INLYClFc7ByJ4/TJimwBljVk0/1sMFOV9LRp48WnWfinD1k32hOXVfsZ35jLZRVh
 b+TAqKAvWW+2HJTMh7CLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D3mAgpKTJCs=:6W0Q2F/TtPgUr8aWgYXJtW
 x1wfxvql6U1wwsmiZwNpIWeAA7Z41u/ajSoK09E4A8FEj1X0qouXLF53PDVadF722lr2XGMMH
 8mcT7TPx1o2H0uoEnEDBSC2523OaeneF80lexQEcDGL2qt60m90FqKRE6y2hJthKtV0j5QSWS
 QygE4nLjRRE/ja0w9dWqGtTp9F9R+PY9GfxAK0TFi/eAYZZbaombCSk9yU3dBljh911bHbd+q
 4QuP0QzXys0zxjdzfrfND4dZv7z9cYkZAhlfnT2lgv9TYsDM7Y/WoYoaKx+QRGlzcKyQszUR7
 6sTgWM9XzVJXcIn5SjDhM0mAsSp3g2EDY+7pGRp1m1+i0OWywVdxgXRgwnmzpbz9eFO3bQx7O
 kpgc5xZBS8+nzMMTbQt/N+aN7N/+h8S4ebtbb3tLgJRqJhR3qqiQBI6lfF7g6kGmRXsn1sjHq
 GdgCMdNVC0JA1wFmaKRBNXAy8Kmpgn+ol2lF0+rR/YGmtmW0IBcO87qMYla8A2PkmoudGKIfY
 0DCrsw8Vm8u6nicDgVra6oMxa6oQxDHQJ7oR20gbeSkgOCqGr5J2WqCz0V6PGdDn0395wMdfI
 dE1NPeTEx592vfdu89chIwSfgwIJWuHegp+vqcYzJD/cDcEtqYwZUvPaOyv4RkT32DeUBKZr+
 OdW03SponwZg3RLrRbvcuvJyzTgomO1cITKRbIIvrFXLG8FbomexUptJ5NJ/TabFdkew=
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

