Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27A0208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="vUZM2a0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27A0208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeGKBTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:19:13 -0400
Received: from onstation.org ([52.200.56.107]:37616 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGKBSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:18:55 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 384C398D;
        Wed, 11 Jul 2018 01:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531271385;
        bh=cwN6nSeSnmw1cG9tdDLbynB6HzATa7CgxEHiY6lr8xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUZM2a0rBbimgmrerdDfqyerBNgqeFyw8emB4AV6IfMqalSl6xofNNU5TS1hYhXH1
         as7FsXHGoOktxT4kblHharwIgXh3Wp3YwzPhr+RsedZGbnlJo9X32QA5O5fIyUO8Gx
         to+bBF0myge89dgEDG4mwuIVk+3hXitYrRB4XN7E=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        masneyb@onstation.org
Subject: [PATCH 2/3] iio: imu: mpu6050: add support for regulator framework
Date:   Tue, 10 Jul 2018 21:09:31 -0400
Message-Id: <20180711010932.20313-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711010932.20313-1-masneyb@onstation.org>
References: <20180711010932.20313-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the regulator framework to the mpu6050
driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
This is a variation of Jonathan Marek's patch from postmarketOS
https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
with the following changes:

- Stripped out 6515 variant code. (See my previous patch in this series)
- Add the regulator to the mpu core instead of only the i2c variant.
- Add error handling.
- Release the regulator on suspend, device remove, etc.
- Device tree documentation.

 .../bindings/iio/imu/inv_mpu6050.txt          |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 57 +++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  9 +++
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index b7def51c8ad9..d39907b12a46 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -21,6 +21,7 @@ Required properties:
   bindings.
 
 Optional properties:
+ - vddio-supply: regulator phandle for VDDIO supply
  - mount-matrix: an optional 3x3 mounting rotation matrix
  - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
    simple enough to be described using the i2c-gate binding. See
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 12c1b9507007..ec276b7bcc69 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -23,6 +23,7 @@
 #include <linux/iio/iio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -926,6 +927,19 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	return result;
 }
 
+static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
+{
+	int result;
+
+	result = regulator_enable(st->vddio_supply);
+	if (result == 0) {
+		/* Give the device a little bit of time to start up. */
+		usleep_range(35000, 70000);
+	}
+
+	return result;
+}
+
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -990,15 +1004,28 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return -EINVAL;
 	}
 
+	st->vddio_supply = devm_regulator_get_optional(dev, "vddio");
+	if (IS_ERR(st->vddio_supply)) {
+		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vddio regulator %d\n",
+				(int)PTR_ERR(st->vddio_supply));
+
+		return PTR_ERR(st->vddio_supply);
+	}
+
+	result = inv_mpu_core_enable_regulator(st);
+	if (result)
+		return result;
+
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st);
 	if (result)
-		return result;
+		goto out_disable_regulator;
 
 	result = inv_mpu6050_init_config(indio_dev);
 	if (result) {
 		dev_err(dev, "Could not initialize device.\n");
-		return result;
+		goto out_disable_regulator;
 	}
 
 	if (inv_mpu_bus_setup)
@@ -1023,24 +1050,34 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 						 NULL);
 	if (result) {
 		dev_err(dev, "configure buffer fail %d\n", result);
-		return result;
+		goto out_disable_regulator;
 	}
 	result = inv_mpu6050_probe_trigger(indio_dev, irq_type);
 	if (result) {
 		dev_err(dev, "trigger probe fail %d\n", result);
-		return result;
+		goto out_disable_regulator;
 	}
 
 	result = devm_iio_device_register(dev, indio_dev);
 	if (result) {
 		dev_err(dev, "IIO register fail %d\n", result);
-		return result;
+		goto out_disable_regulator;
 	}
 
 	return 0;
+
+out_disable_regulator:
+	regulator_disable(st->vddio_supply);
+	return result;
+
 }
 EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
 
+int inv_mpu_core_remove(struct inv_mpu6050_state *st)
+{
+	return regulator_disable(st->vddio_supply);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 static int inv_mpu_resume(struct device *dev)
@@ -1050,6 +1087,11 @@ static int inv_mpu_resume(struct device *dev)
 
 	mutex_lock(&st->lock);
 	result = inv_mpu6050_set_power_itg(st, true);
+	if (result)
+		goto out_unlock;
+
+	result = inv_mpu_core_enable_regulator(st);
+out_unlock:
 	mutex_unlock(&st->lock);
 
 	return result;
@@ -1062,6 +1104,11 @@ static int inv_mpu_suspend(struct device *dev)
 
 	mutex_lock(&st->lock);
 	result = inv_mpu6050_set_power_itg(st, false);
+	if (result)
+		goto out_unlock;
+
+	result = regulator_disable(st->vddio_supply);
+out_unlock:
 	mutex_unlock(&st->lock);
 
 	return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index dd758e3d403d..ce227038c61c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -164,7 +164,7 @@ static int inv_mpu_remove(struct i2c_client *client)
 		i2c_mux_del_adapters(st->muxc);
 	}
 
-	return 0;
+	return inv_mpu_core_remove(st);
 }
 
 /*
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e69a59659dbc..0289615a6135 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
  *  @chip_period:	chip internal period estimation (~1kHz).
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
+ *  @vddio_supply	voltage regulator for the chip.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -149,6 +150,7 @@ struct inv_mpu6050_state {
 	s64 chip_period;
 	s64 it_timestamp;
 	s64 data_timestamp;
+	struct regulator *vddio_supply;
 };
 
 /*register and associated bit definition*/
@@ -321,4 +323,5 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
+int inv_mpu_core_remove(struct inv_mpu6050_state *st);
 extern const struct dev_pm_ops inv_mpu_pmops;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 227f50afff22..fce935f8f1e4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -70,6 +70,14 @@ static int inv_mpu_probe(struct spi_device *spi)
 				  inv_mpu_i2c_disable, chip_type);
 }
 
+static int inv_mpu_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	return inv_mpu_core_remove(st);
+}
+
 /*
  * device id table is used to identify what device can be
  * supported by this driver
@@ -94,6 +102,7 @@ MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
 
 static struct spi_driver inv_mpu_driver = {
 	.probe		=	inv_mpu_probe,
+	.remove		=	inv_mpu_remove,
 	.id_table	=	inv_mpu_id,
 	.driver = {
 		.acpi_match_table = ACPI_PTR(inv_acpi_match),
-- 
2.17.1

