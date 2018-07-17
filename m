Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D6EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFCA20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgbzAvea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFCA20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeGQL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:57:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34822 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbeGQL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:57:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so319544pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k3jKW0sCb0rK8PdrGlYTdRe+q05sdvywcfGkw5Lbutg=;
        b=HgbzAveaSKoFkhJeJuYv38MCDkH8abJSq1TpKAP4jPut74BL6aFBLoUrAGAEnrO2cY
         nMxgwjwlMS3EPjDNLUHnyoCJpECeH4DrJx7MNdyKg9A80OqkcmjRrGPGHw5vhXxvXeCm
         3yAgPIp3dBD4Wk1ehWJNSr6GmoJx47zF79w78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k3jKW0sCb0rK8PdrGlYTdRe+q05sdvywcfGkw5Lbutg=;
        b=IIDue6x/GLvMwPy2sen+1nG31o55Rt9sMlcYnCPMGKY/xug+5VBAIGmtZ9aRHdqlCJ
         Hy1OtEYJUt91oXDgdfXjQ1IiXUe3FG43VvYLRNQvVVoS0yKLcNMEkvb/rTLOWcY9xcK+
         wKjEy6fa848G2PpWCRuzWglm8SMV5DcxhGg24zs41kz9QHuAClaBmU/mXXojzxhN3QuO
         4ZAYMs6m0H/d2GayvmAPewajjMA7WlfbOSSgvdhifHDPiEiMEqI+JO4lUYQFLQnNuZUk
         u/bz98t/AqDxNCixrCXuznshJB5Rv67L5muZiqNE+QHn4S0UZhmAmckJQFrAyWYXTAW7
         lY0g==
X-Gm-Message-State: AOUpUlFEsk9ZwJWmEvQkEJFaYB/9I3AknvwYlh9WmZbzZm4xNN85kN0o
        MJJpKkmclqDSn7F4ejPHHDQ8Pw==
X-Google-Smtp-Source: AAOMgpfc5ApwLLzY+NcxAMroV0XITJqvh3KrxhQY5KHExdoy+lDtrvgWqiiVCb68iXLLE4pYJrkpHA==
X-Received: by 2002:a63:c80e:: with SMTP id z14-v6mr1172426pgg.77.1531826710885;
        Tue, 17 Jul 2018 04:25:10 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y3-v6sm1391207pge.29.2018.07.17.04.25.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 04:25:10 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org, corbet@lwn.net
Cc:     baolin.wang@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/4] sh: dreamcast: rtc: push down rtc class ops into driver
Date:   Tue, 17 Jul 2018 19:24:24 +0800
Message-Id: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dreamcast RTC support has an extra level of indirection to
provide either the old read_persistent_clock/update_persistent_clock
interface or the rtc-generic device for hctosys/systohc.

Both do the same thing here, so we can do away with the abstraction
and simply enable the RTC core code to take care of it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/sh/boards/mach-dreamcast/Makefile        |    4 +--
 arch/sh/boards/mach-dreamcast/rtc.c           |   39 +++++++++++++++++--------
 arch/sh/boards/mach-dreamcast/setup.c         |    1 -
 arch/sh/configs/dreamcast_defconfig           |    2 ++
 arch/sh/include/mach-dreamcast/mach/sysasic.h |    1 -
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/sh/boards/mach-dreamcast/Makefile b/arch/sh/boards/mach-dreamcast/Makefile
index 7b97546..62b024b 100644
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
index 061d657..4f168d8 100644
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
index ad1a4db..672c2ad8 100644
--- a/arch/sh/boards/mach-dreamcast/setup.c
+++ b/arch/sh/boards/mach-dreamcast/setup.c
@@ -30,7 +30,6 @@
 
 static void __init dreamcast_setup(char **cmdline_p)
 {
-	board_time_init = aica_time_init;
 }
 
 static struct sh_machine_vector mv_dreamcast __initmv = {
diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index 3f08dc5..1d27666 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -70,3 +70,5 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index 58f710e..59effd1 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -42,7 +42,6 @@
 /* arch/sh/boards/mach-dreamcast/irq.c */
 extern int systemasic_irq_demux(int);
 extern void systemasic_irq_init(void);
-extern void aica_time_init(void);
 
 #endif /* __ASM_SH_DREAMCAST_SYSASIC_H */
 
-- 
1.7.9.5

