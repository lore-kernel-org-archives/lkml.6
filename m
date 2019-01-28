Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E8C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8C2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gaireg.de header.i=@gaireg.de header.b="NyNlEmIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfA1Sug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:50:36 -0500
Received: from gaireg.de ([37.221.197.43]:36780 "EHLO gaireg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1Sug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:50:36 -0500
Received: from me.gaireg.de (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id B72C03C8CE8B;
        Mon, 28 Jan 2019 19:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1548701432; bh=D3yZ0FNHu9dReKLxPlFBbPwCTik+k/UyeKDlovkbTRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NyNlEmIuKgjpuWTaV22dxlOn3Vqy+DqygsX688QRXqhGlDJ9rbU4U4S6jteZq5AQt
         tck2kPXwTwvVzf+X+RjtwvqebZUytYdjTNV5k/rJMsqyqdRzb8WEWyLZGsuWePYYF1
         8uB+lZwB5DnRoIqyrUHvOIInmzBRf45c9q6BMlvY=
From:   =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
To:     gaireg@gaireg.de
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: imu: mpu6050: Add support for the ICM 20602 IMU
Date:   Mon, 28 Jan 2019 19:50:03 +0100
Message-Id: <20190128185010.8275-2-gaireg@gaireg.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190128185010.8275-1-gaireg@gaireg.de>
References: <20190128185010.8275-1-gaireg@gaireg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Invensense ICM-20602 is a 6-axis MotionTracking device that
combines a 3-axis gyroscope and an 3-axis accelerometer. It is very
similar to the ICM-20608 imu which is already supported by the mpu6050
driver. The main difference is that the ICM-20602 has the i2c bus
disable bit in a separate register.

Signed-off-by: Randolph Maaßen <gaireg@gaireg.de>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        |  8 ++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 31 ++++++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 12 +++++++++---
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 5483b2ea754d..d2fe9dbddda7 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -13,8 +13,8 @@ config INV_MPU6050_I2C
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-	  This driver supports the Invensense MPU6050/6500/9150 and ICM20608
-	  motion tracking devices over I2C.
+	  This driver supports the Invensense MPU6050/6500/9150 and
+	  ICM20608/20602 motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
 
@@ -24,7 +24,7 @@ config INV_MPU6050_SPI
 	select INV_MPU6050_IIO
 	select REGMAP_SPI
 	help
-	  This driver supports the Invensense MPU6050/6500/9150 and ICM20608
-	  motion tracking devices over SPI.
+	  This driver supports the Invensense MPU6050/6500/9150 and
+	  ICM20608/20602 motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 1e428c196a82..650de0fefb7b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -38,6 +38,29 @@ static const int gyro_scale_6050[] = {133090, 266181, 532362, 1064724};
  */
 static const int accel_scale[] = {598, 1196, 2392, 4785};
 
+static const struct inv_mpu6050_reg_map reg_set_icm20602 = {
+	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
+	.lpf                    = INV_MPU6050_REG_CONFIG,
+	.accel_lpf              = INV_MPU6500_REG_ACCEL_CONFIG_2,
+	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
+	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
+	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
+	.accl_config            = INV_MPU6050_REG_ACCEL_CONFIG,
+	.fifo_count_h           = INV_MPU6050_REG_FIFO_COUNT_H,
+	.fifo_r_w               = INV_MPU6050_REG_FIFO_R_W,
+	.raw_gyro               = INV_MPU6050_REG_RAW_GYRO,
+	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
+	.temperature            = INV_MPU6050_REG_TEMPERATURE,
+	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
+	.int_status             = INV_MPU6050_REG_INT_STATUS,
+	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
+	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
+	.int_pin_cfg            = INV_MPU6050_REG_INT_PIN_CFG,
+	.accl_offset            = INV_MPU6500_REG_ACCEL_OFFSET,
+	.gyro_offset            = INV_MPU6050_REG_GYRO_OFFSET,
+	.i2c_if                 = INV_ICM20602_REG_I2C_IF,
+};
+
 static const struct inv_mpu6050_reg_map reg_set_6500 = {
 	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
 	.lpf                    = INV_MPU6050_REG_CONFIG,
@@ -58,6 +81,7 @@ static const struct inv_mpu6050_reg_map reg_set_6500 = {
 	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
 	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
 	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
+	.i2c_if                 = 0,
 };
 
 static const struct inv_mpu6050_reg_map reg_set_6050 = {
@@ -78,6 +102,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
 	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
 	.accl_offset		= INV_MPU6050_REG_ACCEL_OFFSET,
 	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
+	.i2c_if                 = 0,
 };
 
 static const struct inv_mpu6050_chip_config chip_config_6050 = {
@@ -140,6 +165,12 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6050,
 	},
+	{
+		.whoami = INV_ICM20602_WHOAMI_VALUE,
+		.name = "ICM20602",
+		.reg = &reg_set_icm20602,
+		.config = &chip_config_6050,
+	},
 };
 
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index dd758e3d403d..e46eb4ddea21 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -127,6 +127,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	st = iio_priv(dev_get_drvdata(&client->dev));
 	switch (st->chip_type) {
 	case INV_ICM20608:
+	case INV_ICM20602:
 		/* no i2c auxiliary bus on the chip */
 		break;
 	default:
@@ -179,6 +180,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20602", INV_ICM20602},
 	{}
 };
 
@@ -213,6 +215,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
+	{
+		.compatible = "invensense,icm20602",
+		.data = (void *)INV_ICM20602
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 6bcc11fc1b88..325afd9f5f61 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -44,6 +44,7 @@
  *  @int_pin_cfg;	Controls interrupt pin configuration.
  *  @accl_offset:	Controls the accelerometer calibration offset.
  *  @gyro_offset:	Controls the gyroscope calibration offset.
+ *  @i2c_if:		Controls the i2c interface
  */
 struct inv_mpu6050_reg_map {
 	u8 sample_rate_div;
@@ -65,6 +66,7 @@ struct inv_mpu6050_reg_map {
 	u8 int_pin_cfg;
 	u8 accl_offset;
 	u8 gyro_offset;
+	u8 i2c_if;
 };
 
 /*device enum */
@@ -77,6 +79,7 @@ enum inv_devices {
 	INV_MPU9250,
 	INV_MPU9255,
 	INV_ICM20608,
+	INV_ICM20602,
 	INV_NUM_PARTS
 };
 
@@ -195,6 +198,10 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
 #define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
 
+/* ICM20602 register */
+#define INV_ICM20602_REG_I2C_IF             0x70
+#define INV_ICM20602_BIT_I2C_IF_DIS         0x40
+
 #define INV_MPU6050_REG_FIFO_COUNT_H        0x72
 #define INV_MPU6050_REG_FIFO_R_W            0x74
 
@@ -261,6 +268,7 @@ struct inv_mpu6050_state {
 #define INV_MPU9255_WHOAMI_VALUE		0x73
 #define INV_MPU6515_WHOAMI_VALUE		0x74
 #define INV_ICM20608_WHOAMI_VALUE		0xAF
+#define INV_ICM20602_WHOAMI_VALUE		0x12
 
 /* scan element definition */
 enum inv_mpu6050_scan {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 227f50afff22..a112c3f45f74 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -31,9 +31,14 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	st->chip_config.user_ctrl |= INV_MPU6050_BIT_I2C_IF_DIS;
-	ret = regmap_write(st->map, st->reg->user_ctrl,
-			   st->chip_config.user_ctrl);
+	if (st->reg->i2c_if) {
+		ret = regmap_write(st->map, st->reg->i2c_if,
+				   INV_ICM20602_BIT_I2C_IF_DIS);
+	} else {
+		st->chip_config.user_ctrl |= INV_MPU6050_BIT_I2C_IF_DIS;
+		ret = regmap_write(st->map, st->reg->user_ctrl,
+				   st->chip_config.user_ctrl);
+	}
 	if (ret) {
 		inv_mpu6050_set_power_itg(st, false);
 		return ret;
@@ -81,6 +86,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20602", INV_ICM20602},
 	{}
 };
 
-- 
2.11.0

