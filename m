Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1299C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3E72087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q8g2CYvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfASAPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:15:10 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39865 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfASAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:14:38 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so8138916itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4/11qBya9eW0TJulgY+pL3W8mKOzagyoDohcwhv/7A=;
        b=Q8g2CYvFZ2UYeUj77LcTL3vkxcfxEPoIB439S9+EqUmuDAbzYtgWiQ3jf05hkXWD/6
         3tY1MKyy89MkZIZkVM3yrADfnvnVYnMglnZp65eslvKy3dEhH0v1NNjVOy9uOrinJfOG
         5uHQArlFqJFNUefh4kwNC9K9gefzHtxXA15hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4/11qBya9eW0TJulgY+pL3W8mKOzagyoDohcwhv/7A=;
        b=uHT08N2s7U1RawYRTFHD07z0Yd7wwY2BmaS+RjNpW7dLRaNxz9z8b7qv2gjQSZtSpf
         +u9UQfqJfeRuACik7pkqsiIKdb2G/9OewZTLGQCMoODG/FxS8UBuZwq3LOBnFGXLOpZa
         7cSsVSPEDy+/qaJ5j723NBP/n4vPySYrKqIBu52cO24+V6nWaGZsrOanlR3TK9vqMLEL
         PEtmPoMmCQu5VT79pX82UR4XJpd/LW9dAHWVM8DDOQAQkdE6qehjoDYZxalwxB5tzRkv
         HFLQjMDtQ2+H9V/2InjAnAn+6AodBFz1tYle16EuEH5s9g/wiS1meEtjEy/GyPFQ7MiN
         nvmQ==
X-Gm-Message-State: AJcUukeoS9n1WNCm1QwMw0J16VBKfAo9AR2zKbHX08Y9BvL+Tx5sNEU9
        PLJqG3QRGz2DHRvse5urm1+gWva1Gv8=
X-Google-Smtp-Source: ALg8bN5OLnie6P7lkZw7Wk3ioFnDPCuK3kz7rz69+eDYmQ1WCsYXa3i1dJLSCYctkAXGhzsS6brFug==
X-Received: by 2002:a24:9a01:: with SMTP id l1mr1265823ite.113.1547856876495;
        Fri, 18 Jan 2019 16:14:36 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id e22sm2382062iod.47.2019.01.18.16.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:14:35 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, djkurtz@google.com,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Nick Crews <ncrews@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 5/9] platform/chrome: rtc: Add RTC driver
Date:   Fri, 18 Jan 2019 17:14:18 -0700
Message-Id: <20190119001422.48186-6-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190119001422.48186-1-ncrews@chromium.org>
References: <20190119001422.48186-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v3:
- rm #define for driver name
- Don't compute weekday when reading from RTC.
  Still set weekday when writing, as RTC needs this
  to control advanced power scheduling
- rm check for invalid month data
- Set range_min and range_max on rtc_device

Changes in v2:
- rm license boiler plate
- rm "wilco_ec_rtc -" prefix in docstring
- Make rtc driver its own module within the drivers/rtc/ directory
- Register a rtc device from core.c that is picked up by this driver

 drivers/platform/chrome/wilco_ec/core.c |  17 +++
 drivers/rtc/Kconfig                     |  11 ++
 drivers/rtc/Makefile                    |   1 +
 drivers/rtc/rtc-wilco-ec.c              | 177 ++++++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/rtc/rtc-wilco-ec.c

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 9b4a25e63b56..dd8b896b3833 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -34,6 +34,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct wilco_ec_device *ec;
+	struct platform_device *child_pdev;
 	int ret;
 
 	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
@@ -76,8 +77,24 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto rm_debugfs;
 	}
 
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
 rm_debugfs:
 	wilco_ec_debugfs_remove(ec);
 destroy_mec:
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
index 000000000000..b721cc3f17f0
--- /dev/null
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -0,0 +1,177 @@
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
+	tm->tm_mon	= rtc.month - 1;
+	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
+	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+
+	/* Don't compute day of week, we don't need it. */
+	tm->tm_wday = -1;
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
+	/*
+	 * Convert from 0=Sunday to 0=Saturday for the EC
+	 * We DO need to set weekday because the EC controls battery charging
+	 * schedules that depend on the day of the week.
+	 */
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
+	struct rtc_device *rtc;
+
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->ops = &wilco_ec_rtc_ops;
+	/* EC only supports this century */
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->owner = THIS_MODULE;
+
+	return rtc_register_device(rtc);
+}
+
+static struct platform_driver wilco_ec_rtc_driver = {
+	.driver = {
+		.name = "rtc-wilco-ec",
+	},
+	.probe = wilco_ec_rtc_probe,
+};
+
+module_platform_driver(wilco_ec_rtc_driver);
+
+MODULE_ALIAS("platform:rtc-wilco-ec");
+MODULE_AUTHOR("Nick Crews <ncrews@google.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco EC RTC driver");
-- 
2.20.1.321.g9e740568ce-goog

