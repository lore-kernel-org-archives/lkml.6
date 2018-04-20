Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755913AbeDTPvJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:51:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755472AbeDTPvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:51:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rich Felker <dalias@libc.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sh: sh03: rtc: push down rtc class ops into driver
Date: Fri, 20 Apr 2018 17:48:54 +0200
Message-Id: <20180420154933.3235131-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180420154933.3235131-1-arnd@arndb.de>
References: <20180420154933.3235131-1-arnd@arndb.de>
X-Provags-ID: V03:K1:1xeHnmiXMDG2DTaWNflZwqpgh543RPem6gKyN8LmpPBjRBn7EzH
 /gN++41156NmEPTyqkSWp3+TFLATbUJ0em9Gy415v+zji5vf6glGIncF85pl5brwKMTSPDZ
 KpELVTt9RM3b4ux1MvpoAY7K70IIxXX9Q5i6VYGWveTXORUwFjOh1RxdtbRcLK5NkXkuR13
 6hAAdLZzqMa1RF03uJKZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vMx0ryBC2ls=:48s+U6voPXjmOWlQZOFwh2
 hxkIpquGhB8Z9rO9USwEjdNN86btNQAgEVNFLmCSizVhd8dxL+nN2tkAyflOu+OXTjTxj2GQf
 ZUlYrvlKZNf4LWGMjzqs2R0PhZkNVgh7hwwnS8ckpA5V2X8SibiZcAu/h9UEeQ0qn4mI03yLp
 8zcgJDWVIlKM67kmR7IcAUa3v3PNFLTshLnxFa69g33EkK+lvyYn0X5/BTNSl62+V5NURvxwD
 emKkzMT+he48WYORvVZsoy0t34rhcXTK6OXlaazEg1Jf6sFbmUqDaKp5wkyXwl0BI1Ku4V2pz
 3tgasT8/vUWjoHprLhuIn10KPDaRVhckNmryvxhVDggvrj0pwz3CdX98gtfgDU7r/kbu4ttFv
 SHKi7TP4Ea2TEzwlOvyx8YVkCZ+QsD/0qCgtisYVEsf5oJBMPnIz9lTab/JntgUZv/Mn06wJR
 H/wA68fB5s18BWq/J8myhYa9LIq6Gt5YfcSBPs0hzuQFHSuhbul9EsuLDJG6hmsf7WGkfB6dy
 ot0wHHZ3FoWUly3Faw9G0NkI/yeE+rLaTcwaK+ljAstxwFxQrNPzNTBYw+EXHV/O5GubABjim
 B+uW8JB0tM8uRQ0LgbFlYCK9CJwoqvYpLoiy0sk6YSl7UOnxA9c6eAXOQKDGhjqIBBoNmTDn1
 Sz96TQpYhA1O+uWvSbPQpPg9anW897T3BW7rbb2ZiWgq4Q6WDTnsbNMI+L9qniGUksqH2RjUj
 c0IncDigGRDIHecBOgszCTOwquQr7qRhjHPqug==
Sender: linux-kernel-owner@vger.kernel.org
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
 arch/sh/boards/mach-sh03/Makefile |  3 ++-
 arch/sh/boards/mach-sh03/rtc.c    | 51 ++++++++++++++++++++++++---------------
 arch/sh/boards/mach-sh03/setup.c  |  9 -------
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
2.9.0
