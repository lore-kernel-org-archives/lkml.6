Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeCUQhy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:37:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43375 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCUQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:37:42 -0400
X-Google-Smtp-Source: AG47ELu9RekWnYRJWD2eYcJe8Jr1HpQSMOlirvRfke3a+XaZzMa6jU5HehiZoaBz1ebJsPuuXfQtCA==
From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
To: jdelvare@suse.com, linux@roeck-us.net, lee.jones@linaro.org,
        cphealy@gmail.com, andrew.smirnov@gmail.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Subject: [PATCH v3] hwmon: MC13783: add uid and die temperature sensor inputs
Date: Wed, 21 Mar 2018 19:39:26 +0300
Message-Id: <1521650366-32506-1-git-send-email-andrey.gusakov@cogentembedded.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uid and die temperature can be read out on the ADIN7 using
input mux. Map uid and die temperature sensor to channels 16
and 17.

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
---
Changes in v3:
- comment style fixes
Changes in v2:
- suport both mc13783 and mc13892
- uid_input renamed to in16_input
- style fixes
---
 drivers/hwmon/mc13783-adc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/mc13xxx-core.c  | 15 +++++++++++-
 include/linux/mfd/mc13xxx.h |  2 ++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index 960a1db..840d8fc 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -63,6 +63,10 @@ static int mc13783_adc_read(struct device *dev,
 	if (ret)
 		return ret;
 
+	/* ADIN7 subchannels */
+	if (channel >= 16)
+		channel = 7;
+
 	channel &= 0x7;
 
 	*val = (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
@@ -111,6 +115,56 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
 	return sprintf(buf, "%u\n", val);
 }
 
+static ssize_t mc13783_adc_read_uid(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	unsigned int val;
+	struct platform_device *pdev = to_platform_device(dev);
+	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
+	int ret = mc13783_adc_read(dev, devattr, &val);
+
+	if (ret)
+		return ret;
+
+	if (driver_data & MC13783_ADC_BPDIV2)
+		/* MC13892 have 1/2 divider, input range is [0, 4.800V] */
+		val = DIV_ROUND_CLOSEST(val * 4800, 1024);
+	else
+		/* MC13783 have 0.9 divider, input range is [0, 2.555V] */
+		val = DIV_ROUND_CLOSEST(val * 2555, 1024);
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static ssize_t mc13783_adc_read_temp(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	unsigned int val;
+	struct platform_device *pdev = to_platform_device(dev);
+	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
+	int ret = mc13783_adc_read(dev, devattr, &val);
+
+	if (ret)
+		return ret;
+
+	if (driver_data & MC13783_ADC_BPDIV2) {
+		/*
+		 * MC13892:
+		 * Die Temperature Read Out Code at 25C 680
+		 * Temperature change per LSB +0.4244C
+		 */
+		ret = DIV_ROUND_CLOSEST(-2635920 + val * 4244, 10);
+	} else {
+		/* MC13783:
+		 * Die Temperature Read Out Code at 25C 282
+		 * Temperature change per LSB -1.14C
+		 */
+		ret = 346480 - 1140 * val;
+	}
+
+	return sprintf(buf, "%d\n", ret);
+}
+
 static DEVICE_ATTR_RO(name);
 static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
 static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
@@ -124,6 +178,9 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
 static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, 13);
 static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
 static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);
+static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, mc13783_adc_read_uid, NULL, 16);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+			  mc13783_adc_read_temp, NULL, 17);
 
 static struct attribute *mc13783_attr_base[] = {
 	&dev_attr_name.attr,
@@ -131,6 +188,8 @@ static ssize_t mc13783_adc_read_gp(struct device *dev,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in16_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	NULL
 };
 
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index d7f54e4..c63e331 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -279,8 +279,21 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
 	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
 
-	if (channel > 7)
+	/*
+	 * Channels mapped through ADIN7:
+	 * 7  - General purpose ADIN7
+	 * 16 - UID
+	 * 17 - Die temperature
+	 */
+	if (channel > 7 && channel < 16) {
 		adc1 |= MC13XXX_ADC1_ADSEL;
+	} else if (channel == 16) {
+		adc0 |= MC13XXX_ADC0_ADIN7SEL_UID;
+		channel = 7;
+	} else if (channel == 17) {
+		adc0 |= MC13XXX_ADC0_ADIN7SEL_DIE;
+		channel = 7;
+	}
 
 	switch (mode) {
 	case MC13XXX_ADC_MODE_TS:
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 638222e..54a3cd8 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -243,6 +243,8 @@ struct mc13xxx_platform_data {
 #define MC13XXX_ADC0_LICELLCON		(1 << 0)
 #define MC13XXX_ADC0_CHRGICON		(1 << 1)
 #define MC13XXX_ADC0_BATICON		(1 << 2)
+#define MC13XXX_ADC0_ADIN7SEL_DIE	(1 << 4)
+#define MC13XXX_ADC0_ADIN7SEL_UID	(2 << 4)
 #define MC13XXX_ADC0_ADREFEN		(1 << 10)
 #define MC13XXX_ADC0_TSMOD0		(1 << 12)
 #define MC13XXX_ADC0_TSMOD1		(1 << 13)
-- 
1.9.1
