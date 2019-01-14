Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19837C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23CC205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfANWEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:40 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37901 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfANWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:39 -0500
Received: by mail-io1-f72.google.com with SMTP id q18so454545ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rySSR2KDMZkETr4V4BQFEx4ktKifj7vZUBfqiMKizs0=;
        b=dhDcUDPgVLvyfzPoT6KpT3hR1wrn6haLpsiXBfo4s0wCX6Xp+35wRInJ0jd8Kv1xcV
         XIR+ZXQCHld1nlFDOpXq6+zJF6BRZb981f9Ou9+Jxdj6lARHgOTTmi3imeLQ38dhY7RZ
         Ha3I1IWdUW+KYSOgwrvVYWMKxLZYmDDjR+0tv1Ru/zC8v9vrVMdLfPU8zS3ir1iy1x0u
         n+ngGaSaQMll/qGs7l03HM9rek0rloue7jz0ev1EjbptSzJ5kOGzItZezFeqLSGcSxC+
         +ckNjfNolpDV4NWRNMLK2JO6q/n/9zxDzXk90/x/VOFze2uKYGwi+oMyu1SlDXGbeYWb
         5AVQ==
X-Gm-Message-State: AJcUukewr2QUylA1gFN/rpbt8ducvlgqWdl0ry6cWMkc+w0jK6IDIi69
        XLSmiV4w6V4tlo7YLv8nHY7fsud7/m+DA7WNnktwBc19UbwSv8bQRmGGQK50iMtZrHm68MtzOg5
        DR9mOJuxnPdhni6OjYG5J+KxkL+qYD1qWWv1Ga8Prk49wYoH0sPH7rdNOqSaFTXcnnrAazVFUdh
        I=
X-Google-Smtp-Source: ALg8bN4Y3o8vqqWGkw2e1ZZUsSKeSEyUiracaTyAFtCt9VlAuDurEchZIZ55zB2Y6X/8KbUsbwr7KcLa8dIS9q4j
X-Received: by 2002:a24:7d55:: with SMTP id b82mr831086itc.0.1547503477403;
 Mon, 14 Jan 2019 14:04:37 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:03:52 -0700
In-Reply-To: <20190114220356.108916-1-ncrews@google.com>
Message-Id: <20190114220356.108916-6-ncrews@google.com>
Mime-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 5/9] platform/chrome: rtc: Add RTC driver for Wilco EC
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

This Embedded Controller has an internal RTC that is exposed
as a standard RTC class driver with read/write functionality.

The driver is added to the drivers/rtc/ so that the maintainer of that
directory will be able to comment on this change, as that maintainer is
the expert on this system. In addition, the driver code is called
indirectly after a corresponding device is registered from core.c,
as opposed to core.c registering the driver callbacks directly.

> hwclock --show --rtc /dev/rtc1
2007-12-31 16:01:20.460959-08:00
> hwclock --systohc --rtc /dev/rtc1
> hwclock --show --rtc /dev/rtc1
2018-11-29 17:08:00.780793-08:00

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

Changes in v2:
- rm license boiler plate
- rm "wilco_ec_rtc -" prefix in docstring
- Make rtc driver its own module within the drivers/rtc/ directory
- Register a rtc device from core.c that is picked up by this driver
- rm unused rtc_sync() function

 drivers/platform/chrome/wilco_ec/core.c |  18 +++
 drivers/rtc/Kconfig                     |  11 ++
 drivers/rtc/Makefile                    |   1 +
 drivers/rtc/rtc-wilco-ec.c              | 178 ++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 drivers/rtc/rtc-wilco-ec.c

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 3193e8b2ec91..61dacd582582 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -37,6 +37,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct wilco_ec_device *ec;
+	struct platform_device *child_pdev;
 	int ret;
 
 	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
@@ -70,8 +71,25 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to create sysfs attributes\n");
 		goto destroy_lpc_mec;
 	}
+
+	/*
+	 * Register a RTC platform device that will get picked up by the RTC
+	 * subsystem. This platform device will get freed when its parent device
+	 * dev is unregistered.
+	 */
+	child_pdev = platform_device_register_data(dev, "rtc-wilco-ec",
+						   PLATFORM_DEVID_AUTO,
+						   NULL, 0);
+	if (IS_ERR(child_pdev)) {
+		dev_err(dev, "Failed to create RTC platform device\n");
+		ret = PTR_ERR(child_pdev);
+		goto remove_sysfs;
+	}
+
 	return 0;
 
+remove_sysfs:
+	wilco_ec_sysfs_remove(ec);
 destroy_lpc_mec:
 	cros_ec_lpc_mec_destroy();
 	return ret;
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b8516f3..d5063c791515 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1814,4 +1814,15 @@ config RTC_DRV_GOLDFISH
 	  Goldfish is a code name for the virtual platform developed by Google
 	  for Android emulation.
 
+config RTC_DRV_WILCO_EC
+	tristate "Wilco EC RTC"
+	depends on WILCO_EC
+	default m
+	help
+	  If you say yes here, you get read/write support for the Real Time
+	  Clock on the Wilco Embedded Controller (Wilco is a kind of Chromebook)
+
+	  This can also be built as a module. If so, the module will
+	  be named "rtc_wilco_ec".
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index df022d820bee..6255ea78da25 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -172,6 +172,7 @@ obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
 obj-$(CONFIG_RTC_DRV_VRTC)	+= rtc-mrst.o
 obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
+obj-$(CONFIG_RTC_DRV_WILCO_EC)	+= rtc-wilco-ec.o
 obj-$(CONFIG_RTC_DRV_WM831X)	+= rtc-wm831x.o
 obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
new file mode 100644
index 000000000000..d8ed791da82d
--- /dev/null
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RTC interface for Wilco Embedded Controller with R/W abilities
+ *
+ * Copyright 2018 Google LLC
+ *
+ * The corresponding platform device is typically registered in
+ * drivers/platform/chrome/wilco_ec/core.c
+ */
+
+#include <linux/bcd.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/rtc.h>
+#include <linux/timekeeping.h>
+
+#define DRV_NAME "rtc-wilco-ec"
+
+#define EC_COMMAND_CMOS			0x7c
+#define EC_CMOS_TOD_WRITE		0x02
+#define EC_CMOS_TOD_READ		0x08
+
+/**
+ * struct ec_rtc_read - Format of RTC returned by EC.
+ * @second: Second value (0..59)
+ * @minute: Minute value (0..59)
+ * @hour: Hour value (0..23)
+ * @day: Day value (1..31)
+ * @month: Month value (1..12)
+ * @year: Year value (full year % 100)
+ * @century: Century value (full year / 100)
+ *
+ * All values are presented in binary (not BCD).
+ */
+struct ec_rtc_read {
+	u8 second;
+	u8 minute;
+	u8 hour;
+	u8 day;
+	u8 month;
+	u8 year;
+	u8 century;
+} __packed;
+
+/**
+ * struct ec_rtc_write - Format of RTC sent to the EC.
+ * @param: EC_CMOS_TOD_WRITE
+ * @century: Century value (full year / 100)
+ * @year: Year value (full year % 100)
+ * @month: Month value (1..12)
+ * @day: Day value (1..31)
+ * @hour: Hour value (0..23)
+ * @minute: Minute value (0..59)
+ * @second: Second value (0..59)
+ * @weekday: Day of the week (0=Saturday)
+ *
+ * All values are presented in BCD.
+ */
+struct ec_rtc_write {
+	u8 param;
+	u8 century;
+	u8 year;
+	u8 month;
+	u8 day;
+	u8 hour;
+	u8 minute;
+	u8 second;
+	u8 weekday;
+} __packed;
+
+int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
+	u8 param = EC_CMOS_TOD_READ;
+	struct ec_rtc_read rtc;
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.flags = WILCO_EC_FLAG_RAW_RESPONSE,
+		.command = EC_COMMAND_CMOS,
+		.request_data = &param,
+		.request_size = sizeof(param),
+		.response_data = &rtc,
+		.response_size = sizeof(rtc),
+	};
+	struct rtc_time calc_tm;
+	unsigned long time;
+	int ret;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	tm->tm_sec	= rtc.second;
+	tm->tm_min	= rtc.minute;
+	tm->tm_hour	= rtc.hour;
+	tm->tm_mday	= rtc.day;
+	/*
+	 * The RTC stores the month value as 1-12 but the kernel expects 0-11,
+	 * so ensure invalid/zero month value from RTC is not converted to -1.
+	 */
+	tm->tm_mon	= rtc.month ? rtc.month - 1 : 0;
+	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
+	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+
+	/* Compute day of week */
+	rtc_tm_to_time(tm, &time);
+	rtc_time_to_tm(time, &calc_tm);
+	tm->tm_wday = calc_tm.tm_wday;
+
+	return 0;
+}
+
+int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
+	struct ec_rtc_write rtc;
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.flags = WILCO_EC_FLAG_RAW_RESPONSE,
+		.command = EC_COMMAND_CMOS,
+		.request_data = &rtc,
+		.request_size = sizeof(rtc),
+	};
+	int year = tm->tm_year + 1900;
+	/* Convert from 0=Sunday to 0=Saturday for the EC */
+	int wday = tm->tm_wday == 6 ? 0 : tm->tm_wday + 1;
+	int ret;
+
+	rtc.param	= EC_CMOS_TOD_WRITE;
+	rtc.century	= bin2bcd(year / 100);
+	rtc.year	= bin2bcd(year % 100);
+	rtc.month	= bin2bcd(tm->tm_mon + 1);
+	rtc.day		= bin2bcd(tm->tm_mday);
+	rtc.hour	= bin2bcd(tm->tm_hour);
+	rtc.minute	= bin2bcd(tm->tm_min);
+	rtc.second	= bin2bcd(tm->tm_sec);
+	rtc.weekday	= bin2bcd(wday);
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct rtc_class_ops wilco_ec_rtc_ops = {
+	.read_time = wilco_ec_rtc_read,
+	.set_time = wilco_ec_rtc_write,
+};
+
+static int wilco_ec_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc = devm_rtc_device_register(&pdev->dev,
+							  DRV_NAME,
+							  &wilco_ec_rtc_ops,
+							  THIS_MODULE);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	return 0;
+}
+
+static struct platform_driver wilco_ec_rtc_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = wilco_ec_rtc_probe,
+};
+
+module_platform_driver(wilco_ec_rtc_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Nick Crews <ncrews@google.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco EC RTC driver");
-- 
2.20.1.97.g81188d93c3-goog

