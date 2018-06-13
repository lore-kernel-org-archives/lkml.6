Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 532E9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D65208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D65208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935776AbeFMOB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:01:59 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:50544 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeFMOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:01:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id A220F1856D;
        Wed, 13 Jun 2018 16:01:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id F0gJtTWqXE8Q; Wed, 13 Jun 2018 16:01:50 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id E1148189B6;
        Wed, 13 Jun 2018 16:01:49 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9A181A09E;
        Wed, 13 Jun 2018 16:01:49 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB49B1A09D;
        Wed, 13 Jun 2018 16:01:49 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 16:01:49 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
        by seth.se.axis.com (Postfix) with ESMTP id 9D58B56A;
        Wed, 13 Jun 2018 16:01:49 +0200 (CEST)
Received: from lnxborysmn.se.axis.com (10.0.5.60) by XBOX03.axis.com
 (10.0.5.17) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Wed, 13 Jun 2018
 16:01:49 +0200
From:   Borys Movchan <borys.movchan@axis.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Borys Movchan <borysmn@axis.com>, Borys Movchan <borysmn@axis.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] iio: add ISL29033 Ultra-Low Lux ambient-light-sensor
Date:   Wed, 13 Jun 2018 16:00:16 +0200
Message-ID: <20180613140043.5802-2-borys.movchan@axis.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180613140043.5802-1-borys.movchan@axis.com>
References: <20180613140043.5802-1-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borys Movchan <borysmn@axis.com>

Add Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated
Digital Ambient Light Sensor driver.

The ISL29033 is an integrated ambient and infrared
light-to-digital converter. Its advanced, self-calibrated photodiode
array emulates human eye response with excellent IR rejection. The
on-chip 16-bit ADC is capable of rejecting 50Hz and 60Hz
flicker caused by artificial light sources. The lux range select
feature allows users to program the lux range for optimized
counts/lux.

datasheet: https://www.intersil.com/content/dam/intersil/documents/isl2/isl29033.pdf

Signed-off-by: Borys Movchan <borys.movchan@axis.com>
---
 drivers/iio/light/Kconfig    |   9 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/isl29033.c | 755 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 765 insertions(+)
 create mode 100644 drivers/iio/light/isl29033.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index c7ef8d1862d6..ad98a9b24a65 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -182,6 +182,15 @@ config SENSORS_ISL29028
 	 Proximity value via iio. The ISL29028 provides the concurrent sensing
 	 of ambient light and proximity.
 
+config ISL29033
+	tristate "Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated Digital Ambient Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Provides driver for the Intersil's ISL29033 device.
+	 This driver supports the sysfs interface to get the ALS and IR intensity
+	 value via IIO.
+
 config ISL29125
 	tristate "Intersil ISL29125 digital color light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 80943af5d627..4955c2eebcbd 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
 obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
+obj-$(CONFIG_ISL29033)		+= isl29033.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
diff --git a/drivers/iio/light/isl29033.c b/drivers/iio/light/isl29033.c
new file mode 100644
index 000000000000..dacc94ad6d2f
--- /dev/null
+++ b/drivers/iio/light/isl29033.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * isl29033.c: A iio driver for the light sensor ISL 29033.
+ *
+ * IIO driver for monitoring ambient light intensity in lux and infrared
+ * sensing.
+ *
+ * Copyright (c) 2018, Axis Communication AB
+ * Author: Borys Movchan <Borys.Movchan@axis.com>
+ */
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define ISL29033_REG_ADD_COMMAND1	0x00
+#define ISL29033_CMD1_OPMODE_SHIFT	5
+#define ISL29033_CMD1_OPMODE_MASK	(7 << ISL29033_CMD1_OPMODE_SHIFT)
+#define ISL29033_CMD1_OPMODE_POWER_DOWN	0
+#define ISL29033_CMD1_OPMODE_ALS_CONT	5
+#define ISL29033_CMD1_OPMODE_IR_CONT	6
+
+#define ISL29033_REG_ADD_COMMAND2	0x01
+#define ISL29033_CMD2_RESOLUTION_SHIFT	2
+#define ISL29033_CMD2_RESOLUTION_MASK	(0x3 << ISL29033_CMD2_RESOLUTION_SHIFT)
+
+#define ISL29033_CMD2_RANGE_SHIFT	0
+#define ISL29033_CMD2_RANGE_MASK	(0x3 << ISL29033_CMD2_RANGE_SHIFT)
+
+#define ISL29033_CMD2_SCHEME_SHIFT	7
+#define ISL29033_CMD2_SCHEME_MASK	(0x1 << ISL29033_CMD2_SCHEME_SHIFT)
+
+#define ISL29033_REG_ADD_DATA_LSB	0x02
+#define ISL29033_REG_ADD_DATA_MSB	0x03
+
+#define ISL29033_REG_TEST		0x08
+#define ISL29033_TEST_SHIFT		0
+#define ISL29033_TEST_MASK		(0xFF << ISL29033_TEST_SHIFT)
+
+#define ISL29033_REF_REXT		499	/* In kOhm */
+
+#define ISL29033_POWER_OFF_DELAY_MS	5000
+
+#define ISL29033_MICRO			1000000
+
+#define isl29033_int_utime(adcmax) \
+	((unsigned int)(adcmax) * (ISL29033_MICRO / 1000) / 655)
+
+static const unsigned int isl29033_int_utimes[4] = {
+	isl29033_int_utime(65536),
+	isl29033_int_utime(4096),
+	isl29033_int_utime(256),
+	isl29033_int_utime(16)
+};
+
+#define isl29033_mkscale(range, adcmax)				\
+	 { (range) / (adcmax),					\
+	   ((unsigned int)(range) * (ISL29033_MICRO / 10)	\
+			/ (adcmax) * 10) % ISL29033_MICRO }
+
+static const struct isl29033_scale {
+	unsigned int scale;
+	unsigned int uscale;
+} isl29033_scales[4][4] = {
+	{
+	   isl29033_mkscale(125, 65536), isl29033_mkscale(500, 65536),
+	   isl29033_mkscale(2000, 65536), isl29033_mkscale(8000, 65536)
+	},
+	{
+	   isl29033_mkscale(125, 4096), isl29033_mkscale(500, 4096),
+	   isl29033_mkscale(2000, 4096), isl29033_mkscale(8000, 4096)
+	},
+	{
+	   isl29033_mkscale(125, 256), isl29033_mkscale(500, 256),
+	   isl29033_mkscale(2000, 256), isl29033_mkscale(8000, 256)
+	},
+	{
+	   isl29033_mkscale(125, 16), isl29033_mkscale(500, 16),
+	   isl29033_mkscale(2000, 16), isl29033_mkscale(8000, 16)
+	}
+};
+
+struct isl29033_chip {
+	struct regmap		*regmap;
+	struct mutex		lock;
+	unsigned int		int_time;
+	unsigned int		calibscale;
+	unsigned int		ucalibscale;
+	struct isl29033_scale	scale;
+	unsigned int		rext;
+	unsigned int		opmode;
+};
+
+#define isl29033_rext_normalize(chip, val) \
+	((val) * ISL29033_REF_REXT / (chip)->rext)
+
+static unsigned int isl29033_rext_normalize2(struct isl29033_chip *chip,
+				     unsigned int val, unsigned int val2)
+{
+	val = val - isl29033_rext_normalize(chip, val)
+			* chip->rext / ISL29033_REF_REXT;
+	val2 = (val2 + val * ISL29033_MICRO) * ISL29033_REF_REXT / chip->rext;
+	return val2;
+}
+
+static int isl29033_set_integration_time(struct isl29033_chip *chip,
+					 unsigned int utime)
+{
+	unsigned int i;
+	int ret;
+	unsigned int int_time, new_int_time;
+
+	for (i = 0; i < ARRAY_SIZE(isl29033_int_utimes); ++i) {
+		if (utime == isl29033_int_utimes[i]
+				* chip->rext / ISL29033_REF_REXT) {
+			new_int_time = i;
+			break;
+		}
+	}
+
+	if (i >= ARRAY_SIZE(isl29033_int_utimes))
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, ISL29033_REG_ADD_COMMAND2,
+				 ISL29033_CMD2_RESOLUTION_MASK,
+				 i << ISL29033_CMD2_RESOLUTION_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	/* Keep the same range when integration time changes */
+	int_time = chip->int_time;
+	for (i = 0; i < ARRAY_SIZE(isl29033_scales[int_time]); ++i) {
+		if (chip->scale.scale == isl29033_scales[int_time][i].scale &&
+		    chip->scale.uscale == isl29033_scales[int_time][i].uscale) {
+			chip->scale = isl29033_scales[new_int_time][i];
+			break;
+		}
+	}
+	chip->int_time = new_int_time;
+
+	return 0;
+}
+
+static int isl29033_set_scale(struct isl29033_chip *chip, int scale, int uscale)
+{
+	unsigned int i;
+	int ret;
+	struct isl29033_scale new_scale;
+
+	for (i = 0; i < ARRAY_SIZE(isl29033_scales[chip->int_time]); ++i) {
+		if (scale ==
+			isl29033_rext_normalize(chip,
+				isl29033_scales[chip->int_time][i].scale)
+		    && uscale ==
+			isl29033_rext_normalize2(chip,
+				isl29033_scales[chip->int_time][i].scale,
+				isl29033_scales[chip->int_time][i].uscale)) {
+			new_scale = isl29033_scales[chip->int_time][i];
+			break;
+		}
+	}
+
+	if (i >= ARRAY_SIZE(isl29033_scales[chip->int_time]))
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, ISL29033_REG_ADD_COMMAND2,
+				 ISL29033_CMD2_RANGE_MASK,
+				 i << ISL29033_CMD2_RANGE_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	chip->scale = new_scale;
+
+	return 0;
+}
+
+static int isl29033_set_mode(struct isl29033_chip *chip, int mode)
+{
+
+	int ret;
+	unsigned int utime;
+
+	if (chip->opmode == mode)
+		return 0;
+
+	ret = regmap_update_bits(chip->regmap, ISL29033_REG_ADD_COMMAND1,
+				ISL29033_CMD1_OPMODE_MASK,
+				mode << ISL29033_CMD1_OPMODE_SHIFT);
+	if (ret < 0) {
+		struct device *dev = regmap_get_device(chip->regmap);
+
+		dev_err(dev,
+			"Error in setting operating mode with err %d\n", ret);
+		return ret;
+	}
+
+	utime = isl29033_int_utimes[chip->int_time] * chip->rext
+			/ ISL29033_REF_REXT;
+
+	/* Chip needs twice more time while switching between modes */
+	if (chip->opmode != ISL29033_CMD1_OPMODE_POWER_DOWN)
+		utime *= 2;
+
+	if (utime < 20000)
+		usleep_range(utime, utime * 2);
+	else
+		msleep(utime / 1000);
+
+	chip->opmode = mode;
+	return 0;
+}
+
+static int isl29033_read_sensor_input(struct isl29033_chip *chip)
+{
+	int ret;
+	u16 val;
+	struct device *dev = regmap_get_device(chip->regmap);
+
+	ret = regmap_bulk_read(chip->regmap, ISL29033_REG_ADD_DATA_LSB,
+				(u8 *)&val, 2);
+	if (ret < 0) {
+		dev_err(dev,
+			"Data bulk read error %d\n", ret);
+		return ret;
+	}
+
+	val = be16_to_cpu(val);
+	dev_vdbg(dev, "Data read: %x\n", val);
+
+	return val;
+}
+
+static int isl29033_read_lux(struct isl29033_chip *chip, int *lux, int *ulux)
+{
+	int ret;
+	unsigned int tmpres;
+
+	ret = isl29033_set_mode(chip, ISL29033_CMD1_OPMODE_ALS_CONT);
+	if (ret)
+		return ret;
+
+	ret = isl29033_read_sensor_input(chip);
+	if (ret < 0)
+		return ret;
+
+	ret++;
+
+	tmpres = ret * isl29033_rext_normalize2(chip, chip->scale.scale,
+					  chip->scale.uscale);
+	*lux = ret * isl29033_rext_normalize(chip, chip->scale.scale)
+				+ tmpres / ISL29033_MICRO;
+	*ulux = tmpres % ISL29033_MICRO;
+
+	*lux = *lux * chip->calibscale;
+	*ulux = *ulux * chip->calibscale + *lux * chip->ucalibscale
+				+ *ulux * chip->ucalibscale / ISL29033_MICRO;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int isl29033_read_ir(struct isl29033_chip *chip, int *ir)
+{
+	int ret;
+
+	ret = isl29033_set_mode(chip, ISL29033_CMD1_OPMODE_IR_CONT);
+	if (ret)
+		return ret;
+
+	ret = isl29033_read_sensor_input(chip);
+	if (ret < 0)
+		return ret;
+
+	*ir = ret;
+
+	return IIO_VAL_INT;
+}
+
+static ssize_t isl29033_in_illuminance_scale_available
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+	unsigned int i;
+	int len = 0;
+
+	mutex_lock(&chip->lock);
+	for (i = 0; i < ARRAY_SIZE(isl29033_scales[chip->int_time]); ++i)
+		len += sprintf(buf + len, "%d.%06d ",
+			isl29033_rext_normalize(chip,
+				isl29033_scales[chip->int_time][i].scale),
+			isl29033_rext_normalize2(chip,
+				isl29033_scales[chip->int_time][i].scale,
+				isl29033_scales[chip->int_time][i].uscale));
+	mutex_unlock(&chip->lock);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t isl29033_in_illuminance_integration_time_available
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+	unsigned int i;
+	int len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(isl29033_int_utimes); ++i)
+		len += sprintf(buf + len, "0.%06d ",
+				   isl29033_int_utimes[i]
+				   * chip->rext / ISL29033_REF_REXT);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static int isl29033_runtime_pm_get(struct isl29033_chip *chip)
+{
+	int ret;
+	struct device *dev = regmap_get_device(chip->regmap);
+
+	ret = pm_runtime_get(dev);
+	if (ret < 0)
+		pm_runtime_put_noidle(dev);
+
+	return ret;
+}
+
+static void isl29033_runtime_pm_put(struct isl29033_chip *chip)
+{
+	struct device *dev = regmap_get_device(chip->regmap);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+
+static int isl29033_write_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int val,
+				  int val2,
+				  long mask)
+{
+	int ret;
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+
+	ret = isl29033_runtime_pm_get(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = -EINVAL;
+
+	mutex_lock(&chip->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (chan->type == IIO_LIGHT) {
+			chip->calibscale = val;
+			chip->ucalibscale = val2;
+			ret = 0;
+		}
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type == IIO_LIGHT && !val)
+			ret = isl29033_set_integration_time(chip, val2);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_LIGHT)
+			ret = isl29033_set_scale(chip, val, val2);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&chip->lock);
+	isl29033_runtime_pm_put(chip);
+
+	return ret;
+}
+
+static int isl29033_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val,
+				 int *val2,
+				 long mask)
+{
+	int ret;
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+
+	ret = isl29033_runtime_pm_get(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = -EINVAL;
+
+	mutex_lock(&chip->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_INTENSITY)
+			ret = isl29033_read_ir(chip, val);
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		if (chan->type == IIO_LIGHT)
+			ret = isl29033_read_lux(chip, val, val2);
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type == IIO_LIGHT) {
+			*val = 0;
+			*val2 = isl29033_int_utimes[chip->int_time]
+					* chip->rext / ISL29033_REF_REXT;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_LIGHT) {
+			*val = isl29033_rext_normalize(chip, chip->scale.scale);
+			*val2 = isl29033_rext_normalize2(chip,
+					chip->scale.scale, chip->scale.uscale);
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (chan->type == IIO_LIGHT) {
+			*val = chip->calibscale;
+			*val2 = chip->ucalibscale;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&chip->lock);
+	isl29033_runtime_pm_put(chip);
+
+	return ret;
+}
+
+#define ISL29033_LIGHT_CHANNEL {					\
+	.type = IIO_LIGHT,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |		\
+	BIT(IIO_CHAN_INFO_CALIBSCALE) |					\
+	BIT(IIO_CHAN_INFO_SCALE) |					\
+	BIT(IIO_CHAN_INFO_INT_TIME),					\
+}
+
+#define ISL29033_IR_CHANNEL {						\
+	.type = IIO_INTENSITY,						\
+	.modified = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.channel2 = IIO_MOD_LIGHT_IR,					\
+}
+
+static const struct iio_chan_spec isl29033_channels[] = {
+	ISL29033_LIGHT_CHANNEL,
+	ISL29033_IR_CHANNEL,
+};
+
+static IIO_DEVICE_ATTR(in_illuminance_integration_time_available, 0444,
+		isl29033_in_illuminance_integration_time_available, NULL, 0);
+static IIO_DEVICE_ATTR(in_illuminance_scale_available, 0444,
+		isl29033_in_illuminance_scale_available, NULL, 0);
+
+#define ISL29033_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
+
+static struct attribute *isl29033_attributes[] = {
+	ISL29033_DEV_ATTR(in_illuminance_scale_available),
+	ISL29033_DEV_ATTR(in_illuminance_integration_time_available),
+	NULL
+};
+
+static const struct attribute_group isl29033_group = {
+	.attrs = isl29033_attributes,
+};
+
+static int isl29033_chip_init(struct isl29033_chip *chip)
+{
+	int ret;
+	struct device *dev = regmap_get_device(chip->regmap);
+
+	/*
+	 * Code added per Intersil Application Note 1534:
+	 *	 When VDD sinks to approximately 1.8V or below, some of
+	 * the part's registers may change their state. When VDD
+	 * recovers to 2.25V (or greater), the part may thus be in an
+	 * unknown mode of operation. The user can return the part to
+	 * a known mode of operation either by (a) setting VDD = 0V for
+	 * 1 second or more and then powering back up with a slew rate
+	 * of 0.5V/ms or greater, or (b) via I2C disable all ALS/PROX
+	 * conversions, clear the test registers, and then rewrite all
+	 * registers to the desired values.
+	 * ...
+	 * For ISL29033, etc.
+	 * 1. Write 0x00 to register 0x08 (TEST)
+	 * 2. Write 0x00 to register 0x00 (CMD1)
+	 * 3. Rewrite all registers to the desired values
+	 */
+	ret = regmap_write(chip->regmap, ISL29033_REG_TEST, 0x0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to clear isl29033 TEST reg with err %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * See Intersil AN1534 comments above.
+	 * "Operating Mode" (COMMAND1) register is reprogrammed when
+	 * data is read from the device.
+	 */
+	ret = regmap_write(chip->regmap, ISL29033_REG_ADD_COMMAND1, 0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to clear isl29033 CMD1 reg with err %d\n",
+			ret);
+		return ret;
+	}
+
+	usleep_range(1000, 2000);	/* per data sheet, page 10 */
+
+	/* Set defaults */
+	ret = isl29033_set_scale(chip,
+			isl29033_rext_normalize(chip, chip->scale.scale),
+			isl29033_rext_normalize2(chip, chip->scale.scale,
+					chip->scale.uscale));
+	if (ret) {
+		dev_err(dev,
+			"Init of isl29033 fails (scale) with err %d\n", ret);
+		return ret;
+	}
+
+	ret = isl29033_set_integration_time(chip,
+			isl29033_int_utimes[chip->int_time]
+			* chip->rext / ISL29033_REF_REXT);
+	if (ret) {
+		dev_err(dev,
+			"Init of isl29033 fails (integration) with err %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = isl29033_set_mode(chip, chip->opmode);
+	if (ret)
+		dev_err(dev,
+			"Init of isl29033 fails (opmode) with err %d\n", ret);
+
+	return ret;
+}
+
+static const struct iio_info isl29033_info = {
+	.attrs = &isl29033_group,
+	.read_raw = isl29033_read_raw,
+	.write_raw = isl29033_write_raw,
+};
+
+static bool isl29033_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL29033_REG_ADD_DATA_LSB:
+	case ISL29033_REG_ADD_DATA_MSB:
+	case ISL29033_REG_ADD_COMMAND1:
+	case ISL29033_REG_ADD_COMMAND2:
+	case ISL29033_REG_TEST:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config isl29033_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_reg = isl29033_is_volatile_reg,
+	.max_register = ISL29033_REG_TEST,
+	.num_reg_defaults_raw = ISL29033_REG_TEST + 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const char *isl29033_match_acpi_device(struct device *dev, int *data)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+
+	if (!id)
+		return NULL;
+
+	*data = (int)id->driver_data;
+
+	return dev_name(dev);
+}
+
+static int isl29033_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct isl29033_chip *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+	const char *name = NULL;
+	int dev_id = 0;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	if (id) {
+		name = id->name;
+		dev_id = id->driver_data;
+	}
+
+	if (ACPI_HANDLE(&client->dev))
+		name = isl29033_match_acpi_device(&client->dev, &dev_id);
+
+	mutex_init(&chip->lock);
+
+	chip->calibscale = 1;
+	chip->ucalibscale = 0;
+	chip->int_time = 0;
+	chip->scale = isl29033_scales[chip->int_time][0];
+
+#ifdef CONFIG_OF
+	ret = device_property_read_u32(&client->dev, "isil,rext-kohms",
+					&chip->rext);
+	if (ret != 0)
+		chip->rext =  ISL29033_REF_REXT;
+#else
+	chip->rext = ISL29033_REF_REXT;
+#endif /* CONFIG_OF */
+
+	chip->regmap = devm_regmap_init_i2c(client, &isl29033_regmap_config);
+
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev,
+			"regmap initialization fails with err %d\n", ret);
+		return ret;
+	}
+
+	ret = isl29033_chip_init(chip);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &isl29033_info;
+	indio_dev->channels = isl29033_channels;
+	indio_dev->num_channels = ARRAY_SIZE(isl29033_channels);
+	indio_dev->name = name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev,
+			ISL29033_POWER_OFF_DELAY_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+
+
+	return iio_device_register(indio_dev);
+}
+
+static int isl29033_suspend(struct device *dev)
+{
+	struct isl29033_chip *chip = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	ret = isl29033_set_mode(chip, ISL29033_CMD1_OPMODE_POWER_DOWN);
+
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int __maybe_unused isl29033_resume(struct device *dev)
+{
+	struct isl29033_chip *chip = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	ret = isl29033_chip_init(chip);
+
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int isl29033_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+
+	isl29033_suspend(&client->dev);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
+	devm_iio_device_free(&client->dev, indio_dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops isl29033_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(isl29033_suspend, isl29033_resume, NULL)
+};
+
+static const struct acpi_device_id isl29033_acpi_match[] = {
+	{"ISL29033", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, isl29033_acpi_match);
+
+static const struct i2c_device_id isl29033_id[] = {
+	{"isl29033", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, isl29033_id);
+
+static const struct of_device_id isl29033_of_match[] = {
+	{ .compatible = "isil,isl29033", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, isl29033_of_match);
+
+static struct i2c_driver isl29033_driver = {
+	.driver	 = {
+		.name = "isl29033",
+		.acpi_match_table = ACPI_PTR(isl29033_acpi_match),
+		.pm = &isl29033_dev_pm_ops,
+		.of_match_table = isl29033_of_match,
+	},
+	.probe	 = isl29033_probe,
+	.remove  = isl29033_remove,
+	.id_table = isl29033_id,
+};
+module_i2c_driver(isl29033_driver);
+
+MODULE_DESCRIPTION("ISL29033 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

