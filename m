Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E250C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CD1208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeLOATp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:45 -0500
Received: from mail-qt1-f198.google.com ([209.85.160.198]:46922 "EHLO
        mail-qt1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeLOATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:43 -0500
Received: by mail-qt1-f198.google.com with SMTP id w19so7375271qto.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/WOIn+BduOdpO3Ty7AekXHGbFHqTUjpF4oGPNXDSokg=;
        b=Tlm4n6TEz0WkFGqNKTpaZlPugUkc0zLyXipeh2KABu3Tmn3R/X6dOTJnZewM854ulB
         KnAUxIGGQPHSVeEybmwaocPpsU/swG3FHjZOxQW2n2UWPRkAZbZSM5tO48UUz6TKNmU/
         uLsI609vB0++Ef8OhQPXnIvXs8WfqlHJUJmlLBeSegs99e34PPWyy6ydIoLzdc7BabTY
         hqW4UeNmfsDejBE4HVyb8X7R7KXojz1QLMqoxlR4028GU6E6MS/yX8fiIdwlpICjOuRn
         xqF9Qs5XGklkpVO4jMrVQW9cAtCAcVX+SkGNDiR9HeniBS9zhFRzsMasLj0K0fk2M3c2
         8gYg==
X-Gm-Message-State: AA+aEWap71MPKoGwVeW8QhQsKamS6bd2JzvWbzLUF6N86O+SHxgfbMw5
        luL8RAO671kstxRIq5Lts62ZgWpqQM13vXqA3n6iYH9HrSTtUdBJP8pK3X68wb1lcy47L4D8QCz
        MXF8pjovCU1yaGpfRL2OBPLaQxZEtlUHFqpvBRrF7iVdRoPEAi22x/mAhM/buE7J/uODPjk2pDB
        M=
X-Google-Smtp-Source: AFSGD/Wfm/9Qn+KrUQUfBUQY5vBNTsEgXQZt8Vj+yNmy6WO84tj3CCYU3q+1v91TFgcc/Tc/JkOSfZQ3KAHeX/Jt
X-Received: by 2002:a0c:93ec:: with SMTP id g41mr5007699qvg.30.1544833181907;
 Fri, 14 Dec 2018 16:19:41 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:38 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-6-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 05/10] CHROMIUM: wilco_ec: Add RTC class driver
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@google.com>, Nick Crews <ncrews@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

This Embedded Controller has an internal RTC that is exposed
as a standard RTC class driver with read/write functionality.

> hwclock --show --rtc /dev/rtc1
2007-12-31 16:01:20.460959-08:00
> hwclock --systohc --rtc /dev/rtc1
> hwclock --show --rtc /dev/rtc1
2018-11-29 17:08:00.780793-08:00

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Makefile           |   3 +-
 drivers/platform/chrome/wilco_ec.h         |  29 ++++
 drivers/platform/chrome/wilco_ec_mailbox.c |  15 ++
 drivers/platform/chrome/wilco_ec_rtc.c     | 163 +++++++++++++++++++++
 4 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec_rtc.c

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index e8603bc5b095..5ca484c2d0d7 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -13,5 +13,6 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 
-wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_sysfs.o
+wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_rtc.o \
+					   wilco_ec_sysfs.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome/wilco_ec.h
index 0b3dec4e2830..eee5c514e720 100644
--- a/drivers/platform/chrome/wilco_ec.h
+++ b/drivers/platform/chrome/wilco_ec.h
@@ -19,6 +19,7 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/rtc.h>
 
 /* Normal commands have a maximum 32 bytes of data */
 #define EC_MAILBOX_DATA_SIZE		32
@@ -55,6 +56,7 @@ enum wilco_ec_msg_type {
  * @data_buffer: Buffer used for EC communication.  The same buffer
  *               is used to hold the request and the response.
  * @data_size: Size of the data buffer used for EC communication.
+ * @rtc: RTC device handler.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -64,6 +66,7 @@ struct wilco_ec_device {
 	struct resource *io_packet;
 	void *data_buffer;
 	size_t data_size;
+	struct rtc_device *rtc;
 };
 
 /**
@@ -114,4 +117,30 @@ int wilco_ec_sysfs_init(struct wilco_ec_device *ec);
  */
 void wilco_ec_sysfs_remove(struct wilco_ec_device *ec);
 
+/**
+ * wilco_ec_rtc_read() - Fill RTC time structure with values from the EC.
+ * @dev: EC device.
+ * @tm: Returns RTC time from EC.
+ *
+ * Return: 0 for success or negative error code on failure.
+ */
+int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm);
+
+/**
+ * wilco_ec_rtc_write() - Write EC time/date from RTC time structure.
+ * @dev: EC device.
+ * @tm: RTC time to write to EC.
+ *
+ * Return: 0 for success or negative error code on failure.
+ */
+int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm);
+
+/**
+ * wilco_ec_rtc_sync() - Write EC time/date from system time.
+ * @dev: EC device.
+ *
+ * Return: 0 for success or negative error code on failure.
+ */
+int wilco_ec_rtc_sync(struct device *dev);
+
 #endif /* WILCO_EC_H */
diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platform/chrome/wilco_ec_mailbox.c
index 1cb34b7280fd..2f093a281a30 100644
--- a/drivers/platform/chrome/wilco_ec_mailbox.c
+++ b/drivers/platform/chrome/wilco_ec_mailbox.c
@@ -33,6 +33,7 @@
 #include <linux/mfd/cros_ec_lpc_mec.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/rtc.h>
 #include "wilco_ec.h"
 
 /* Version of mailbox interface */
@@ -325,6 +326,11 @@ static struct resource *wilco_get_resource(struct platform_device *pdev,
 	return res;
 }
 
+static const struct rtc_class_ops wilco_ec_rtc_ops = {
+	.read_time = wilco_ec_rtc_read,
+	.set_time = wilco_ec_rtc_write,
+};
+
 static int wilco_ec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -355,6 +361,15 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	cros_ec_lpc_mec_init(ec->io_packet->start,
 			     ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
 
+	/* Install RTC driver */
+	ec->rtc = devm_rtc_device_register(ec->dev, "wilco_ec",
+					   &wilco_ec_rtc_ops, THIS_MODULE);
+	if (IS_ERR(ec->rtc)) {
+		dev_err(dev, "Failed to install RTC driver\n");
+		cros_ec_lpc_mec_destroy();
+		return PTR_ERR(ec->rtc);
+	}
+
 	/* Create sysfs attributes for userspace interaction */
 	if (wilco_ec_sysfs_init(ec) < 0) {
 		dev_err(dev, "Failed to create sysfs attributes\n");
diff --git a/drivers/platform/chrome/wilco_ec_rtc.c b/drivers/platform/chrome/wilco_ec_rtc.c
new file mode 100644
index 000000000000..3e36403d0cb8
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_rtc.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_rtc - RTC interface for Wilco Embedded Controller
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bcd.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/timekeeping.h>
+#include "wilco_ec.h"
+
+#define EC_COMMAND_CMOS			0x7c
+#define  EC_CMOS_TOD_WRITE		0x02
+#define  EC_CMOS_TOD_READ		0x08
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
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
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
+	if (ret < 0) {
+		dev_err(dev, "Failed to read EC RTC\n");
+		return ret;
+	}
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
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
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
+	if (ret < 0) {
+		dev_err(dev, "Failed to write EC RTC\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int wilco_ec_rtc_sync(struct device *dev)
+{
+	struct rtc_time tm;
+
+	rtc_time64_to_tm(ktime_get_real_seconds(), &tm);
+
+	return wilco_ec_rtc_write(dev, &tm);
+}
-- 
2.20.0.405.gbc1bbc6f85-goog

