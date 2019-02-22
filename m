Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C201DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708B620663
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PDEKjQ+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfBVXMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:12:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37729 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfBVXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:12:20 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so3141734iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3jQSJkfUZkjPUW0WcwgX/JGc0ZuiQtFgZXxDjhbvMc=;
        b=PDEKjQ+2dZ+Sz8Nzn7NWJYXV/AI9XNr8TAmnO2/hy6CSL9AF8/+CWlZuVeVIkWIIWp
         qHeQY2R1trefvrclg0XVRWTdYCQuBp3ARkTpPm6y5r5ggkYktopK+7/nnpgVievejn0F
         16pluevZqMRJQ4hjQ49Af5uCiyo/o0Bo77L3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3jQSJkfUZkjPUW0WcwgX/JGc0ZuiQtFgZXxDjhbvMc=;
        b=U/5MapBjgA0kAs60+8eaG9326kuDSpjbMbE/7OIcyiiKtedY9JrDsrPObKe7cpq6Sd
         /Sewi5L4CVKdopFV75HIxA9LZOiiI8pyTltPGRm+MRx3QOE0txtdCvoSYnZg7O72VIBA
         YS6HNKaGas72BA56MS9bJgsmlyMvcF3tgIq+PMNraHce9w7Z7n0xnwP+erA4utiid1N9
         Kq/mEy1RUS+esf+XW0q3N5PL+i9ksAQF2zFO9+sU+dKbu19lxcYZ78y4FG7jbgWXtSpo
         lMlAjSFHbTppt9tFTSxq2tdiLmLuw1Hd9eyUpgV2t83SjZf3/mTCMvWNhwwg/tQB123/
         J7hA==
X-Gm-Message-State: AHQUAuYrUfTZyb3a3noYpX6Jre8h4MuciqFFlaI5oCj5IkNr861djPdR
        Aa0v4PNJ41fDejuy+35nXfRM+g==
X-Google-Smtp-Source: AHgI3IaGlv+o791xYHDkCETCp69AYD3o1Og3nQ9xG8OZNe9UIsUIdCpHsyzsBTTdzgijIsuQ81+FCA==
X-Received: by 2002:a6b:ef02:: with SMTP id k2mr3389388ioh.95.1550877138652;
        Fri, 22 Feb 2019 15:12:18 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id g74sm1363868itg.29.2019.02.22.15.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Feb 2019 15:12:18 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [RFC power_supply 2/2] platform/chrome: Add Peak Shift and Adv Batt Charging for Wilco EC
Date:   Fri, 22 Feb 2019 16:10:36 -0700
Message-Id: <20190222231033.102337-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222231033.102337-1-ncrews@chromium.org>
References: <20190222231033.102337-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an example driver that uses the proposed Peak Shift and
Adv Batt Charging support in the main power supply subsystem.

At this point, there is no actual communication with the EC,
the point of this is to show the interface that usespace would see,
and to show the use case for the added properties to the power
supply susbsystem. To see the location of where the properties
would appear in userspace, see the Documentation file.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 .../ABI/testing/sysfs-class-power-wilco       |  81 +++++++
 drivers/platform/chrome/wilco_ec/Kconfig      |  14 ++
 drivers/platform/chrome/wilco_ec/Makefile     |   2 +
 .../platform/chrome/wilco_ec/advanced_power.c | 199 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/core.c       |  14 ++
 include/linux/platform_data/wilco-ec.h        |   2 +
 6 files changed, 312 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
 create mode 100644 drivers/platform/chrome/wilco_ec/advanced_power.c

diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
new file mode 100644
index 000000000000..5c96b28aa597
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -0,0 +1,81 @@
+What:		/sys/class/power_supply/wilco_adv_power/peak_shift_sched_<day of week>
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		For each weekday a start and end time to run in Peak Shift mode
+		can be set. During these times the system will run from the
+		battery even if the AC is attached as long as the battery stays
+		above the threshold specified. After the end time specified the
+		system will run from AC if attached but will not charge the
+		battery. The system will again function normally using AC and
+		recharging the battery after the specified Charge Start time.
+
+		The input buffer must have the format "start_hr start_min end_hr
+		end_min charge_start_hr charge_start_min" The hour fields must
+		be in the range [0-23], and the minutes must be one of (0, 15,
+		30, 45). The string must be parseable by sscanf() using the
+		format string "%d %d %d %d %d %d". An example valid input is
+		"6 15   009 45 23 0", which corresponds to 6:15, 9:45, and 23:00
+
+		The output buffer will be filled with the format "start_hr
+		start_min end_hr end_min charge_start_hr charge_start_min" The
+		hour fields will be in the range [0-23], and the minutes will be
+		one of (0, 15, 30, 45). Each number will be zero padded to two
+		characters. An example output is "06 15 09 45 23 00", which
+		corresponds to 6:15, 9:45, and 23:00
+
+What:		/sys/class/power_supply/wilco_adv_power/peak_shift_enable
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Enable/disable the peakshift power management policy.
+
+		Input should be parseable by kstrtou8().
+		Output will be either "0\n" or "1\n".
+
+What:		/sys/class/power_supply/wilco_adv_power/peak_shift_batt_threshold
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Read/write the battery percentage threshold for which the
+		peakshift policy is used. The valid range is [15, 50].
+
+		Input should be parseable to range [15,50] by kstrtou8().
+		Output will be two-digit ascii number in range [15, 50].
+
+What:          /sys/class/power_supply/wilco_adv_power/adv_batt_charging_sched_<day of week>
+Date:          January 2019
+KernelVersion: 4.19
+Description:
+		Advanced Charging Mode allows the user to maximize the battery
+		health. In Advanced Charging Mode the system will use standard
+		charging algorithm and other techniques during non-work hours to
+		maximize battery health. During work hours, an express charge is
+		used. This express charge allows the battery to be charged
+		faster; therefore, the battery is at full charge sooner. For
+		each day the time in which the system will be most heavily used
+		is specified by the start time and the duration.
+
+		The input buffer must have the format "start_hr start_min
+		duration_hr duration_min" The hour fields must be in the range
+		[0-23], and the minutes must be one of (0, 15, 30, 45). The
+		string must be parseable by sscanf() using the format string
+		"%d %d %d %d %d %d". An example valid input is "0006 15  23 45",
+		which corresponds to a start time of 6:15 and a duration of
+		23:45.
+
+		The output buffer will be filled with the format "start_hr
+		start_min duration_hr duration_min" The hour fields will be in
+		the range [0-23], and the minutes will be one of (0, 15, 30,
+		45). Each number will be zero padded to two characters. An
+		example output is "06 15 23 45", which corresponds to a start
+		time of 6:15 and a duration of 23:45
+
+What:          /sys/class/power_supply/wilco_adv_power/adv_batt_charging_enable
++Date:          January 2019
++KernelVersion: 4.19
++Description:
+		Enable/disable the Advanced Battery Charging policy.
+
+		Input should be parseable by kstrtou8().
+		Output will be either "0\n" or "1\n".
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index 4a119ced4d0c..0e172076b14e 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -18,3 +18,17 @@ config WILCO_EC_DEBUGFS
 	  manipulation and allow for testing arbitrary commands.  This
 	  interface is intended for debug only and will not be present
 	  on production devices.
+
+config WILCO_EC_ADV_POWER
+	tristate "Enable Peak Shift and Adv Batt Charging power policies"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support to control two power policies
+	  managed by the EC:
+
+	  Peak Shift is power saving policy that minimizes AC usage during
+	  the peak usage times during the day.
+
+	  In Advanced Charging Mode the system will use standard
+	  charging algorithms and other techniques during non-work
+	  hours to maximize battery health.
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..b7e8df5d3806 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -4,3 +4,5 @@ wilco_ec-objs				:= core.o mailbox.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
+wilco_ec_adv_power-objs			:= advanced_power.o
+obj-$(CONFIG_WILCO_EC_ADV_POWER)	+= wilco_ec_adv_power.o
diff --git a/drivers/platform/chrome/wilco_ec/advanced_power.c b/drivers/platform/chrome/wilco_ec/advanced_power.c
new file mode 100644
index 000000000000..d53c8d60f523
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/advanced_power.c
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Peak Shift and Advanced Battery Charging Power Policies
+ *
+ * Copyright 2018 Google LLC
+ *
+ * Peak Shift is power saving policy that minimizes AC usage during the
+ * peak usage times during the day. For each weekday a start and end time
+ * to run in Peak Shift mode can be set. During these times the system will
+ * run from the battery even if the AC is attached as long as the battery
+ * stays above the threshold specified. After the end time specified the
+ * system will run from AC if attached but will not charge the battery. The
+ * system will again function normally using AC and recharging the battery
+ * after the specified Charge Start time.
+ *
+ * Advanced Charging Mode allows the user to maximize the battery health.
+ * In Advanced Charging Mode the system will use standard charging
+ * algorithm and other techniques during non-work hours to maximize battery
+ * health. During work hours, an express charge is used. This express
+ * charge allows the battery to be charged faster; therefore, the battery
+ * is at full charge sooner. For each day the time in which the system will
+ * be most heavily used is specified by the start time and the duration.
+
+ */
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/module.h>
+#include <linux/platform_data/wilco-ec.h>
+
+#define DRV_NAME "wilco_adv_power"
+
+static enum power_supply_property wilco_adv_power_props[] = {
+	POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_MONDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_TUESDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_WEDNESDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_THURSDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_FRIDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY,
+
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_MONDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_TUESDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_WEDNESDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_THURSDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_FRIDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY,
+};
+
+struct wilco_adv_power_data {
+	struct wilco_ec_device *ec;
+	struct power_supply *psy;
+};
+
+static int wilco_adv_power_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	// struct wilco_adv_power_data *data = power_supply_get_drvdata(psy);
+	// This is a stub, really will use mailbox() on data->ec...
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD:
+		val->intval = 42;
+		break;
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY:
+		val->psval.start_hours = 23;
+		val->psval.start_minutes = 0;
+		val->psval.end_hours = 75;
+		val->psval.end_minutes = 1;
+		val->psval.charge_start_hours = 0;
+		val->psval.charge_start_minutes = 59;
+		break;
+	case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE:
+		val->intval = 0;
+		break;
+	case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY:
+		val->abcval.start_hours = 67;
+		val->abcval.start_minutes = 13;
+		val->abcval.duration_hours = 0;
+		val->abcval.duration_minutes = 88;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int wilco_adv_power_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	// struct wilco_adv_power_data *data = power_supply_get_drvdata(psy);
+	// This is a stub, really will use mailbox() on data->ec...
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE:
+		dev_err(&psy->dev, "peak_shift_enable=%d", val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD:
+		dev_err(&psy->dev, "peak_shift_batt_thresh=%d", val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY:
+		dev_err(&psy->dev, "peak_shift_sched_%d=%d %d %d %d %d %d", psp,
+			val->psval.start_hours,
+			val->psval.start_minutes,
+			val->psval.end_hours,
+			val->psval.end_minutes,
+			val->psval.charge_start_hours,
+			val->psval.charge_start_minutes);
+		break;
+	case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE:
+		dev_err(&psy->dev, "adv_batt_charging_enable=%d", val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY:
+		dev_err(&psy->dev, "adv_batt_charging_sched_%d=%d %d %d %d", psp,
+			val->abcval.start_hours,
+			val->abcval.start_minutes,
+			val->abcval.duration_hours,
+			val->abcval.duration_minutes);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int wilco_adv_power_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp)
+{
+	return 1;
+}
+
+static const struct power_supply_desc wps_desc = {
+	.properties	= wilco_adv_power_props,
+	.num_properties	= ARRAY_SIZE(wilco_adv_power_props),
+	.get_property	= wilco_adv_power_get_property,
+	.set_property	= wilco_adv_power_set_property,
+	.property_is_writeable = wilco_adv_power_property_is_writeable,
+	.name		= DRV_NAME,
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+};
+
+static int wilco_adv_power_probe(struct platform_device *pdev)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
+	struct wilco_adv_power_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data->ec = ec;
+	psy_cfg.drv_data = data;
+	platform_set_drvdata(pdev, data);
+
+	data->psy = power_supply_register(&pdev->dev, &wps_desc, &psy_cfg);
+	if (IS_ERR(data->psy))
+		return PTR_ERR(data->psy);
+
+	return 0;
+}
+
+static int wilco_adv_power_remove(struct platform_device *pdev)
+{
+	struct wilco_adv_power_data *data = platform_get_drvdata(pdev);
+
+	power_supply_unregister(data->psy);
+	return 0;
+}
+
+static struct platform_driver wilco_adv_power_driver = {
+	.probe		= wilco_adv_power_probe,
+	.remove		= wilco_adv_power_remove,
+	.driver = {
+		.name = DRV_NAME
+	}
+};
+module_platform_driver(wilco_adv_power_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco Peak Shift and Advanced Battery Charging driver");
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..8f53214cbb1e 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,21 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child device that will be found by the peak shift driver. */
+	ec->adv_power_pdev = platform_device_register_data(dev,
+							   "wilco_adv_power",
+							   PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	if (IS_ERR(ec->adv_power_pdev)) {
+		dev_err(dev, "Failed to create adv power platform device\n");
+		ret = PTR_ERR(ec->adv_power_pdev);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +115,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->adv_power_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 446473a46b88..84e9aacd3759 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -36,6 +36,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @adv_power_pdev: Child platform_device used by the advanced power sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -47,6 +48,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *adv_power_pdev;
 };
 
 /**
-- 
2.20.1

