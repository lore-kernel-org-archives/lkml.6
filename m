Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADC420896
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADC420896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeKHBQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:16:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45518 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbeKHBQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:16:39 -0500
Received: from wd0416.dip.tu-dresden.de ([141.76.109.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gKQ1S-0006kG-Rd; Wed, 07 Nov 2018 16:45:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH] iio: st-accel: add support for lis3de
Date:   Wed,  7 Nov 2018 16:45:21 +0100
Message-Id: <20181107154521.32761-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

This commit add support for STMicroelectronics lis3de accelerometer.
Datasheet for this device can be found here:

https://www.st.com/resource/en/datasheet/lis3de.pdf

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 drivers/iio/accel/Kconfig                            | 2 +-
 drivers/iio/accel/st_accel.h                         | 1 +
 drivers/iio/accel/st_accel_core.c                    | 1 +
 drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
 drivers/iio/accel/st_accel_spi.c                     | 5 +++++
 include/linux/iio/common/st_sensors.h                | 2 +-
 7 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 6f626f73417e..01c986b84bd4 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -48,6 +48,7 @@ Accelerometers:
 - st,lis3l02dq
 - st,lis2dw12
 - st,lis3dhh
+- st,lis3de
 
 Gyroscopes:
 - st,l3g4200d-gyro
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 7993a67bd351..898839ca164a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -223,7 +223,7 @@ config IIO_ST_ACCEL_3AXIS
 	  Say yes here to build support for STMicroelectronics accelerometers:
 	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
 	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
-	  LNG2DM
+	  LNG2DM, LIS3DE
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 2f931e4837e5..fd53258656ca 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -56,6 +56,7 @@ enum st_accel_type {
 #define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
 #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
 #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
+#define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 3e6fd5a8ac5b..f7b471121508 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -103,6 +103,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			[4] = LSM330DLC_ACCEL_DEV_NAME,
 			[5] = LSM303AGR_ACCEL_DEV_NAME,
 			[6] = LIS2DH12_ACCEL_DEV_NAME,
+			[7] = LIS3DE_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 2ca5d1f6ade0..de8ae4327094 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -98,6 +98,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2dw12",
 		.data = LIS2DW12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis3de",
+		.data = LIS3DE_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -135,6 +139,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS331DL_ACCEL_DEV_NAME },
 	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{ LIS2DW12_ACCEL_DEV_NAME },
+	{ LIS3DE_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index dcc9bd243a52..73bfb5d04e2b 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -90,6 +90,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis3dhh",
 		.data = LIS3DHH_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis3de",
+		.data = LIS3DE_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -143,6 +147,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS3LV02DL_ACCEL_DEV_NAME },
 	{ LIS2DW12_ACCEL_DEV_NAME },
 	{ LIS3DHH_ACCEL_DEV_NAME },
+	{ LIS3DE_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index f9bd6e8ab138..8092b8e7f37e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -40,7 +40,7 @@
 #define ST_SENSORS_DEFAULT_STAT_ADDR		0x27
 
 #define ST_SENSORS_MAX_NAME			17
-#define ST_SENSORS_MAX_4WAI			7
+#define ST_SENSORS_MAX_4WAI			8
 
 #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
 					ch2, s, endian, rbits, sbits, addr) \
-- 
2.18.0

