Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91598C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4552B21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfBONsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:48:04 -0500
Received: from jax4mhob14.registeredsite.com ([64.69.218.102]:36404 "EHLO
        jax4mhob14.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728867AbfBONsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:48:04 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob14.registeredsite.com (8.14.4/8.14.4) with ESMTP id x1FDm0xi078356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:48:00 -0500
Received: (qmail 31469 invoked by uid 0); 15 Feb 2019 13:48:00 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 15 Feb 2019 13:47:59 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org, himanshujha199640@gmail.com
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, dpfrey@gmail.com,
        colin.king@canonical.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] iio/chemical/bme680: Fix SPI read interface
Date:   Fri, 15 Feb 2019 14:47:55 +0100
Message-Id: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI interface implementation was completely broken.

When using the SPI interface, there are only 7 address bits, the upper bit
is controlled by a page select register. The core needs access to both
ranges, so implement register read/write for both regions. The regmap
paging functionality didn't agree with a register that needs to be read
and modified, so I implemented a custom paging algorithm.

This fixes that the device wouldn't even probe in SPI mode.

The SPI interface then isn't different from I2C, merged them into the core,
and the I2C/SPI named registers are no longer needed.

Implemented register value caching for the registers to reduce the I2C/SPI
data transfers considerably.

The calibration set reads as all zeroes until some undefined point in time,
and I couldn't determine what makes it valid. The datasheet mentions these
registers but does not provide any hints on when they become valid, and they
aren't even enumerated in the memory map. So check the calibration and
retry reading it from the device after each measurement until it provides
something valid.

Report temperature in millidegrees Celcius instead of degrees.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/chemical/bme680.h      |   6 +-
 drivers/iio/chemical/bme680_core.c |  54 ++++++++++++++---
 drivers/iio/chemical/bme680_i2c.c  |  21 -------
 drivers/iio/chemical/bme680_spi.c  | 116 +++++++++++++++++++++++++------------
 4 files changed, 126 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 0ae89b87..4edc5d21 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -2,11 +2,9 @@
 #ifndef BME680_H_
 #define BME680_H_
 
-#define BME680_REG_CHIP_I2C_ID			0xD0
-#define BME680_REG_CHIP_SPI_ID			0x50
+#define BME680_REG_CHIP_ID			0xD0
 #define   BME680_CHIP_ID_VAL			0x61
-#define BME680_REG_SOFT_RESET_I2C		0xE0
-#define BME680_REG_SOFT_RESET_SPI		0x60
+#define BME680_REG_SOFT_RESET			0xE0
 #define   BME680_CMD_SOFTRESET			0xB6
 #define BME680_REG_STATUS			0x73
 #define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70c1fe4..ccde4c6 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -63,9 +63,23 @@ struct bme680_data {
 	s32 t_fine;
 };
 
+static const struct regmap_range bme680_volatile_ranges[] = {
+	regmap_reg_range(BME680_REG_MEAS_STAT_0, BME680_REG_GAS_R_LSB),
+	regmap_reg_range(BME680_REG_STATUS, BME680_REG_STATUS),
+	regmap_reg_range(BME680_T2_LSB_REG, BME680_GH3_REG),
+};
+
+static const struct regmap_access_table bme680_volatile_table = {
+	.yes_ranges	= bme680_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(bme680_volatile_ranges),
+};
+
 const struct regmap_config bme680_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.max_register = 0xef,
+	.volatile_table = &bme680_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
 };
 EXPORT_SYMBOL(bme680_regmap_config);
 
@@ -316,6 +330,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	s64 var1, var2, var3;
 	s16 calc_temp;
 
+	/* If the calibration is invalid, attempt to reload it */
+	if (!calib->par_t2)
+		bme680_read_calib(data, calib);
+
 	var1 = (adc_temp >> 3) - (calib->par_t1 << 1);
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
@@ -583,8 +601,7 @@ static int bme680_gas_config(struct bme680_data *data)
 	return ret;
 }
 
-static int bme680_read_temp(struct bme680_data *data,
-			    int *val, int *val2)
+static int bme680_read_temp(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -617,10 +634,9 @@ static int bme680_read_temp(struct bme680_data *data,
 	 * compensate_press/compensate_humid to get compensated
 	 * pressure/humidity readings.
 	 */
-	if (val && val2) {
-		*val = comp_temp;
-		*val2 = 100;
-		return IIO_VAL_FRACTIONAL;
+	if (val) {
+		*val = comp_temp * 10; /* Centidegrees to millidegrees */
+		return IIO_VAL_INT;
 	}
 
 	return ret;
@@ -635,7 +651,7 @@ static int bme680_read_press(struct bme680_data *data,
 	s32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL, NULL);
+	ret = bme680_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -668,7 +684,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	u32 comp_humidity;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL, NULL);
+	ret = bme680_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -761,7 +777,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_TEMP:
-			return bme680_read_temp(data, val, val2);
+			return bme680_read_temp(data, val);
 		case IIO_PRESSURE:
 			return bme680_read_press(data, val, val2);
 		case IIO_HUMIDITYRELATIVE:
@@ -867,8 +883,28 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 {
 	struct iio_dev *indio_dev;
 	struct bme680_data *data;
+	unsigned int val;
 	int ret;
 
+	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
+			   BME680_CMD_SOFTRESET);
+	if (ret < 0) {
+		dev_err(dev, "Failed to reset chip\n");
+		return ret;
+	}
+
+	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
+	if (ret < 0) {
+		dev_err(dev, "Error reading chip ID\n");
+		return ret;
+	}
+
+	if (val != BME680_CHIP_ID_VAL) {
+		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
+				val, BME680_CHIP_ID_VAL);
+		return -ENODEV;
+	}
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 06d4be5..cfc4449 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -23,8 +23,6 @@ static int bme680_i2c_probe(struct i2c_client *client,
 {
 	struct regmap *regmap;
 	const char *name = NULL;
-	unsigned int val;
-	int ret;
 
 	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -33,25 +31,6 @@ static int bme680_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(regmap);
 	}
 
-	ret = regmap_write(regmap, BME680_REG_SOFT_RESET_I2C,
-			   BME680_CMD_SOFTRESET);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to reset chip\n");
-		return ret;
-	}
-
-	ret = regmap_read(regmap, BME680_REG_CHIP_I2C_ID, &val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading I2C chip ID\n");
-		return ret;
-	}
-
-	if (val != BME680_CHIP_ID_VAL) {
-		dev_err(&client->dev, "Wrong chip ID, got %x expected %x\n",
-				val, BME680_CHIP_ID_VAL);
-		return -ENODEV;
-	}
-
 	if (id)
 		name = id->name;
 
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index c9fb05e..e130715 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -11,28 +11,94 @@
 
 #include "bme680.h"
 
+struct bme680_spi_bus_context {
+	struct spi_device *spi;
+	u8 current_page;
+};
+
+/*
+ * In SPI mode there are only 7 address bits, a "page" register determines
+ * which part of the 8-bit range is active. This function looks at the address
+ * and writes the page selection bit if needed
+ */
+static int bme680_regmap_spi_select_page(
+	struct bme680_spi_bus_context *ctx, u8 reg)
+{
+	struct spi_device *spi = ctx->spi;
+	int ret;
+	u8 buf[2];
+	u8 page = (reg & 0x80) ? 0 : 1; /* Page "1" is low range */
+
+	if (page == ctx->current_page)
+		return 0;
+
+	/*
+	 * Data sheet claims we're only allowed to change bit 4, so we must do
+	 * a read-modify-write on each and every page select
+	 */
+	buf[0] = BME680_REG_STATUS;
+	ret = spi_write_then_read(spi, buf, 1, buf + 1, 1);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to set page %u\n", page);
+		return ret;
+	}
+
+	buf[0] = BME680_REG_STATUS;
+	if (page)
+		buf[1] |= BME680_SPI_MEM_PAGE_BIT;
+	else
+		buf[1] &= ~BME680_SPI_MEM_PAGE_BIT;
+
+	ret = spi_write(spi, buf, 2);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to set page %u\n", page);
+		return ret;
+	}
+
+	ctx->current_page = page;
+
+	return 0;
+}
+
 static int bme680_regmap_spi_write(void *context, const void *data,
 				   size_t count)
 {
-	struct spi_device *spi = context;
+	struct bme680_spi_bus_context *ctx = context;
+	struct spi_device *spi = ctx->spi;
+	int ret;
 	u8 buf[2];
 
 	memcpy(buf, data, 2);
+
+	ret = bme680_regmap_spi_select_page(ctx, buf[0]);
+	if (ret)
+		return ret;
+
 	/*
 	 * The SPI register address (= full register address without bit 7)
 	 * and the write command (bit7 = RW = '0')
 	 */
 	buf[0] &= ~0x80;
 
-	return spi_write_then_read(spi, buf, 2, NULL, 0);
+	return spi_write(spi, buf, 2);
 }
 
 static int bme680_regmap_spi_read(void *context, const void *reg,
 				  size_t reg_size, void *val, size_t val_size)
 {
-	struct spi_device *spi = context;
+	struct bme680_spi_bus_context *ctx = context;
+	struct spi_device *spi = ctx->spi;
+	int ret;
+	u8 addr = *(const u8 *)reg;
+	u8 addr7;
+
+	ret = bme680_regmap_spi_select_page(ctx, addr);
+	if (ret)
+		return ret;
 
-	return spi_write_then_read(spi, reg, reg_size, val, val_size);
+	addr |= 0x80; /* bit7 = RW = '1' */
+
+	return spi_write_then_read(spi, &addr, 1, val, val_size);
 }
 
 static struct regmap_bus bme680_regmap_bus = {
@@ -45,8 +111,8 @@ static int bme680_regmap_spi_read(void *context, const void *reg,
 static int bme680_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct bme680_spi_bus_context *bus_context;
 	struct regmap *regmap;
-	unsigned int val;
 	int ret;
 
 	spi->bits_per_word = 8;
@@ -56,45 +122,21 @@ static int bme680_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	bus_context = devm_kzalloc(&spi->dev, sizeof(*bus_context), GFP_KERNEL);
+	if (!bus_context)
+		return -ENOMEM;
+
+	bus_context->spi = spi;
+	bus_context->current_page = 0xff; /* Undefined on warm boot */
+
 	regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
-				  &spi->dev, &bme680_regmap_config);
+				  bus_context, &bme680_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
 				(int)PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-	ret = regmap_write(regmap, BME680_REG_SOFT_RESET_SPI,
-			   BME680_CMD_SOFTRESET);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to reset chip\n");
-		return ret;
-	}
-
-	/* after power-on reset, Page 0(0x80-0xFF) of spi_mem_page is active */
-	ret = regmap_read(regmap, BME680_REG_CHIP_SPI_ID, &val);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Error reading SPI chip ID\n");
-		return ret;
-	}
-
-	if (val != BME680_CHIP_ID_VAL) {
-		dev_err(&spi->dev, "Wrong chip ID, got %x expected %x\n",
-				val, BME680_CHIP_ID_VAL);
-		return -ENODEV;
-	}
-	/*
-	 * select Page 1 of spi_mem_page to enable access to
-	 * to registers from address 0x00 to 0x7F.
-	 */
-	ret = regmap_write_bits(regmap, BME680_REG_STATUS,
-				BME680_SPI_MEM_PAGE_BIT,
-				BME680_SPI_MEM_PAGE_1_VAL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "failed to set page 1 of spi_mem_page\n");
-		return ret;
-	}
-
 	return bme680_core_probe(&spi->dev, regmap, id->name);
 }
 
-- 
1.9.1

