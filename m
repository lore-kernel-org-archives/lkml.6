Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35686C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF673208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF673208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLGNtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:32 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:49273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeLGNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:28 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTRAS-1guSKU31dE-00TkSU; Fri, 07 Dec 2018 14:48:58 +0100
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
Subject: [PATCH 1/8] sh: dreamcast: rtc: push down rtc class ops into driver
Date:   Fri,  7 Dec 2018 14:48:17 +0100
Message-Id: <20181207134824.300024-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:iMOMQODGfxdkXkIiy3bpmWxGlvGkMgbchhdvPBw5kYhBgtYI+N1
 esf5jxvn10dz8Z/kV6SkBDIvX+rhSPTO9pyF50LC9P6cVdhs8+DZSKMAmhzWMzbRm30dmn2
 bWWWmOyFM+pZ8BNnQJvXLHANHYyyypsgvJY2sj1bfE8xx5YQPjcGbbCNLUjJwSTb2Kl1EGP
 gJ36oGH/SPVze5pFK8ThQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H5CSwJcgbyU=:/Vk3o9HFH7jmv1Sz9gsGN7
 /ekn6jJO7Xc+/R5e/ws3mQJQZw8dnUurIbuMruCvyAuofagfgSPYIg69v1ljQQKHMDswPmklD
 fqVx4gVQXZIum6ESZC5YY95Xs/ZLoz3GsBGsFc/Fbu8tyKNBfLfclYVj+C1jzu0Vozpid5pTh
 TKXPZ//TG7BggB4VQs+A7kUrs6G2xgPSXFI50snDkfSXF4z06GiL9oZp3eFZjeKfm/ejvKuZM
 BNFq5GICebEP+QtcCDYnpMM9m4fpOGKtzswOPWWcb3ncYh1Lwp/qaT/HCwO31rdDE+gItlTWJ
 +YFyfRgk1h6SauZBH8s4IAdknErOnxoN6MVVbU1cbCEuDzYDlJLmTL7/ufS1xPdJz0IuRmhV4
 5VWUUncWpeS5lZYsJDZAzrr2tkWOd8efwgnevT4XrMX42zRyUqrNWdwQtndiCPvy6UkB21aPN
 3Y/Cpp0p5x8y+UIlZkRqf8p2vIM+LhN3yg/3NXrkct+l0/YCTe2yT7xLqfrUBX12b0agKkkD1
 Q6QQL8/yMb29Ocll7D7fNwr3hL/n0Ak5kU//GNQGC9On3XwDZwq5SeXWJFLUyP51rxjvhyF/Q
 NV5n0fR5RJuUz5gmJ/FkphoxIGNGLnxGwBIl+pwg4/hxgy14LtF6ohhDmTJGL0ztkaDFmCOSG
 MI5n27zUCx8eWhh0D9pYGsosHnnItHHq61fgWPk8SezQ0eBOASxUiA5BWe2cb14cNTclxMmBu
 auiPX+YKGwXry9zXi32DVC2Fz6pxFHzhXSsM6w==
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

