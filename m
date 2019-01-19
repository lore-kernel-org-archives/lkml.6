Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC60C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24B2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUxO2dFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfASSkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:40:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfASSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:39:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so7598571pgs.2;
        Sat, 19 Jan 2019 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=2EPO+fM/mTjeHsrEISnyS4ADN2UH/JfRGv8iwdIWb+o=;
        b=fUxO2dFla85GMlOqfFkQcI/xqJtnKKEk1wnhADIwli0MFBCmqDnhiGxtCrhAucSSAl
         870wXSeAXJaY3WI2XI1luZT6E6AyHfMMLU6jeyZwCf/crGG7XSlHzQzs2xmYRkN46FIc
         qj/iiiaOmaA1pVFCV2fD68HeoNj5rTgrmHObliUvjBfiGkhE/VzGdIaJr0FqO9r1Nluc
         4LhmqarzrrbnBQzQdyd08QHTwgOzpVBwS567jet7FyRjmQiguTvbfMGVlWS4Obh7+VOy
         JDwqYagikmw7/pTuEpRgJDeu7k7U5A39INN8xUHv06WO4jDC0/DTcddoc5RpQVAXwvPS
         8d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=2EPO+fM/mTjeHsrEISnyS4ADN2UH/JfRGv8iwdIWb+o=;
        b=azEO5ORZQ5V7dh6goMZ6IyybXMMn+1JAHKFX/FTFPzrxV/E52e+58ymP2OJPxLeosZ
         LrA/ifzO1qd/LB/91qgJJCNXVoPTZOQ2nEq/GZfavGi2R005GWPW6X28KOjiAM4d0u98
         QPG0432CxJrW7qeMm+f6tKilMgMzVvZ4BzuwUhHsnxkJGGkesBi68wWrqzWr7xNKMNqu
         wEfxqLrzHZKPB5yjerrVKplSdo6MbZeve20ACrDkLn46pRjw8ggJ98i3xZJpo5rLWR+O
         Hfq/DkS5X63giAIhuB6eP21FZNEw+cicopkQen4WO7Tj8A1X2IuojDC2kmayY0ozNBxT
         K7ng==
X-Gm-Message-State: AJcUukeSbrg+3rrNSPndICap6tBYGe7zSbn4VYzDc687/g1xzJ/9vsgy
        TtPcLgbs0Ll4kvAFbj8SszQ=
X-Google-Smtp-Source: ALg8bN6gxswg8/J4z3QJsBZJdgI5fQOVr8nO/Hg7HckqYpeNJpqNdxWaXag1qk1ASs+Tf28y6/5CHQ==
X-Received: by 2002:a63:4745:: with SMTP id w5mr22778618pgk.377.1547923195926;
        Sat, 19 Jan 2019 10:39:55 -0800 (PST)
Received: from localhost.localdomain ([49.33.214.52])
        by smtp.gmail.com with ESMTPSA id m20sm10127471pgb.56.2019.01.19.10.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:39:55 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v2 3/3] Staging: iio: adt7316: Add regmap support
Date:   Sun, 20 Jan 2019 00:09:32 +0530
Message-Id: <20190119183932.14321-4-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
References: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both i2c and spi drivers have functions for reading and writing
to/from registers. Remove this redundant and common code by using
regmap API.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c |  60 +++--------
 drivers/staging/iio/addac/adt7316-spi.c |  74 +++----------
 drivers/staging/iio/addac/adt7316.c     | 132 ++++++++++++------------
 drivers/staging/iio/addac/adt7316.h     |  10 +-
 4 files changed, 94 insertions(+), 182 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 40aa9e2f1966..435b65845174 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -12,64 +12,28 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include "adt7316.h"
 
-/*
- * adt7316 register access by I2C
- */
-static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
-{
-	struct i2c_client *cl = client;
-	int ret;
-
-	ret = i2c_smbus_write_byte(cl, reg);
-	if (ret < 0) {
-		dev_err(&cl->dev, "I2C fail to select reg\n");
-		return ret;
-	}
-
-	ret = i2c_smbus_read_byte(client);
-
-	if (!ret)
-		return -EIO;
-
-	if (ret < 0) {
-		dev_err(&cl->dev, "I2C read error\n");
-		return ret;
-	}
-
-	*data = ret;
-
-	return 0;
-}
-
-static int adt7316_i2c_write(void *client, u8 reg, u8 data)
-{
-	struct i2c_client *cl = client;
-	int ret = 0;
-
-	ret = i2c_smbus_write_byte_data(cl, reg, data);
-	if (ret < 0)
-		dev_err(&cl->dev, "I2C write error\n");
-
-	return ret;
-}
-
 /*
  * device probe and remove
  */
-
 static int adt7316_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
-	struct adt7316_bus bus = {
-		.client = client,
-		.read = adt7316_i2c_read,
-		.write = adt7316_i2c_write,
-	};
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &adt7316_regmap_config);
+
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
 
-	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
+	return adt7316_probe(&client->dev, regmap, id ? id->name : NULL,
+			     client->irq);
 }
 
 static const struct i2c_device_id adt7316_i2c_id[] = {
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 1a78dc1e2840..203b5c3ada6e 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -11,74 +11,19 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
 #include "adt7316.h"
 
 #define ADT7316_SPI_MAX_FREQ_HZ		5000000
-#define ADT7316_SPI_CMD_READ		0x91
-#define ADT7316_SPI_CMD_WRITE		0x90
-
-/*
- * adt7316 register access by SPI
- */
-
-static int adt7316_spi_read(void *client, u8 reg, u8 *data)
-{
-	struct spi_device *spi_dev = client;
-	u8 cmd[2];
-	int ret = 0;
-
-	cmd[0] = ADT7316_SPI_CMD_WRITE;
-	cmd[1] = reg;
-
-	ret = spi_write(spi_dev, cmd, 2);
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI fail to select reg\n");
-		return ret;
-	}
-
-	cmd[0] = ADT7316_SPI_CMD_READ;
-
-	ret = spi_write_then_read(spi_dev, cmd, 1, data, 1);
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI read data error\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int adt7316_spi_write(void *client, u8 reg, u8 val)
-{
-	struct spi_device *spi_dev = client;
-	u8 buf[ADT7316_REG_MAX_ADDR + 2];
-	int ret = 0;
-
-	buf[0] = ADT7316_SPI_CMD_WRITE;
-	buf[1] = reg;
-	buf[2] = val;
-
-	ret = spi_write(spi_dev, buf, 3);
-	if (ret < 0) {
-		dev_err(&spi_dev->dev, "SPI write error\n");
-		return ret;
-	}
-
-	return ret;
-}
 
 /*
  * device probe and remove
  */
-
 static int adt7316_spi_probe(struct spi_device *spi_dev)
 {
-	struct adt7316_bus bus = {
-		.client = spi_dev,
-		.read = adt7316_spi_read,
-		.write = adt7316_spi_write,
-	};
+	struct regmap *regmap;
 
 	/* don't exceed max specified SPI CLK frequency */
 	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
@@ -87,12 +32,19 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
+	regmap = devm_regmap_init_spi(spi_dev, &adt7316_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi_dev->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
 	/* switch from default I2C protocol to SPI protocol */
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
+	regmap_write(regmap, 0, 0);
+	regmap_write(regmap, 0, 0);
+	regmap_write(regmap, 0, 0);
 
-	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias,
+	return adt7316_probe(&spi_dev->dev, regmap, spi_dev->modalias,
 			     spi_dev->irq);
 }
 
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 6b4b80fd80cc..301920f64a57 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/i2c.h>
 #include <linux/rtc.h>
+#include <linux/regmap.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -176,7 +177,7 @@
  */
 
 struct adt7316_chip_info {
-	struct adt7316_bus	bus;
+	struct regmap *regmap;
 	struct gpio_desc	*ldac_pin;
 	u16			int_mask;	/* 0x2f */
 	u8			config1;
@@ -237,7 +238,7 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
 	else
 		config1 = chip->config1 & ~ADT7316_EN;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
 	if (ret)
 		return -EIO;
 
@@ -301,7 +302,7 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
 	if (buf[0] == '1')
 		config1 |= ADT7516_SEL_EX_TEMP;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
 	if (ret)
 		return -EIO;
 
@@ -342,7 +343,7 @@ static ssize_t adt7316_store_mode(struct device *dev,
 	if (!memcmp(buf, "single_channel", 14))
 		config2 |= ADT7316_AD_SINGLE_CH_MODE;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
 	if (ret)
 		return -EIO;
 
@@ -435,7 +436,7 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 
 	config2 |= data;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
 	if (ret)
 		return -EIO;
 
@@ -495,7 +496,7 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
 	if (buf[0] == '1')
 		config2 |= ADT7316_DISABLE_AVERAGING;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
 	if (ret)
 		return -EIO;
 
@@ -534,7 +535,7 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
 	if (buf[0] == '1')
 		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG2, config2);
 	if (ret)
 		return -EIO;
 
@@ -572,7 +573,7 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
 	if (buf[0] == '1')
 		config1 |= ADT7316_PD;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
 	if (ret)
 		return -EIO;
 
@@ -610,7 +611,7 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
 	if (buf[0] == '1')
 		config3 |= ADT7316_ADCLK_22_5;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
 	if (ret)
 		return -EIO;
 
@@ -663,7 +664,7 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
 	}
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
 	if (ret)
 		return -EIO;
 
@@ -709,7 +710,7 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 	else
 		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
 	if (ret)
 		return -EIO;
 
@@ -748,7 +749,7 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
 	if (buf[0] == '1')
 		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
 	if (ret)
 		return -EIO;
 
@@ -787,7 +788,7 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
 	if (buf[0] == '1')
 		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, config3);
 	if (ret)
 		return -EIO;
 
@@ -830,7 +831,7 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 	dac_config = chip->dac_config & (~ADT7316_DA_2VREF_CH_MASK);
 	dac_config |= data;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
+	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
 		return -EIO;
 
@@ -890,7 +891,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
 	dac_config |= data;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
+	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
 		return -EIO;
 
@@ -945,8 +946,8 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 		ldac_config = chip->ldac_config & (~ADT7316_LDAC_EN_DA_MASK);
 		ldac_config |= data;
 
-		ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
-			ldac_config);
+		ret = regmap_write(chip->regmap, ADT7316_LDAC_CONFIG,
+				   ldac_config);
 		if (ret)
 			return -EIO;
 	} else {
@@ -993,7 +994,7 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	if (buf[0] == '1')
 		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
+	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
 		return -EIO;
 
@@ -1038,7 +1039,7 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	if (buf[0] == '1')
 		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
+	ret = regmap_write(chip->regmap, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
 		return -EIO;
 
@@ -1098,8 +1099,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 			ldac_config = chip->ldac_config | ADT7316_DAC_IN_VREF;
 	}
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
-			ldac_config);
+	ret = regmap_write(chip->regmap, ADT7316_LDAC_CONFIG, ldac_config);
 	if (ret)
 		return -EIO;
 
@@ -1117,7 +1117,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		int channel, char *buf)
 {
 	u16 data;
-	u8 msb, lsb;
+	unsigned int msb, lsb;
 	char sign = ' ';
 	int ret;
 
@@ -1127,13 +1127,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 
 	switch (channel) {
 	case ADT7316_AD_SINGLE_CH_IN:
-		ret = chip->bus.read(chip->bus.client,
-			ADT7316_LSB_IN_TEMP_VDD, &lsb);
+		ret = regmap_read(chip->regmap, ADT7316_LSB_IN_TEMP_VDD, &lsb);
 		if (ret)
 			return -EIO;
 
-		ret = chip->bus.read(chip->bus.client,
-			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
+		ret = regmap_read(chip->regmap,
+				  ADT7316_AD_MSB_DATA_BASE + channel, &msb);
 		if (ret)
 			return -EIO;
 
@@ -1141,14 +1140,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
 		break;
 	case ADT7316_AD_SINGLE_CH_VDD:
-		ret = chip->bus.read(chip->bus.client,
-			ADT7316_LSB_IN_TEMP_VDD, &lsb);
+		ret = regmap_read(chip->regmap, ADT7316_LSB_IN_TEMP_VDD, &lsb);
 		if (ret)
 			return -EIO;
 
-		ret = chip->bus.read(chip->bus.client,
-
-			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
+		ret = regmap_read(chip->regmap,
+				  ADT7316_AD_MSB_DATA_BASE + channel, &msb);
 		if (ret)
 			return -EIO;
 
@@ -1156,13 +1153,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		data |= (lsb & ADT7316_LSB_VDD_MASK) >> ADT7316_LSB_VDD_OFFSET;
 		return sprintf(buf, "%d\n", data);
 	default: /* ex_temp and ain */
-		ret = chip->bus.read(chip->bus.client,
-			ADT7316_LSB_EX_TEMP_AIN, &lsb);
+		ret = regmap_read(chip->regmap, ADT7316_LSB_EX_TEMP_AIN, &lsb);
 		if (ret)
 			return -EIO;
 
-		ret = chip->bus.read(chip->bus.client,
-			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
+		ret = regmap_read(chip->regmap,
+				  ADT7316_AD_MSB_DATA_BASE + channel, &msb);
 		if (ret)
 			return -EIO;
 
@@ -1262,10 +1258,10 @@ static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
 		int offset_addr, char *buf)
 {
 	int data;
-	u8 val;
+	unsigned int val;
 	int ret;
 
-	ret = chip->bus.read(chip->bus.client, offset_addr, &val);
+	ret = regmap_read(chip->regmap, offset_addr, &val);
 	if (ret)
 		return -EIO;
 
@@ -1292,7 +1288,7 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
 
 	val = (u8)data;
 
-	ret = chip->bus.write(chip->bus.client, offset_addr, val);
+	ret = regmap_write(chip->regmap, offset_addr, val);
 	if (ret)
 		return -EIO;
 
@@ -1409,7 +1405,7 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 		int channel, char *buf)
 {
 	u16 data;
-	u8 msb, lsb, offset;
+	unsigned int msb, lsb, offset;
 	int ret;
 
 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
@@ -1422,14 +1418,14 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 	offset = chip->dac_bits - 8;
 
 	if (chip->dac_bits > 8) {
-		ret = chip->bus.read(chip->bus.client,
-			ADT7316_DA_DATA_BASE + channel * 2, &lsb);
+		ret = regmap_read(chip->regmap,
+				  ADT7316_DA_DATA_BASE + channel * 2, &lsb);
 		if (ret)
 			return -EIO;
 	}
 
-	ret = chip->bus.read(chip->bus.client,
-		ADT7316_DA_DATA_BASE + 1 + channel * 2, &msb);
+	ret = regmap_read(chip->regmap, ADT7316_DA_DATA_BASE + 1 + channel * 2,
+			  &msb);
 	if (ret)
 		return -EIO;
 
@@ -1460,15 +1456,15 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 
 	if (chip->dac_bits > 8) {
 		lsb = data & (1 << offset);
-		ret = chip->bus.write(chip->bus.client,
-			ADT7316_DA_DATA_BASE + channel * 2, lsb);
+		ret = regmap_write(chip->regmap,
+				   ADT7316_DA_DATA_BASE + channel * 2, lsb);
 		if (ret)
 			return -EIO;
 	}
 
 	msb = data >> offset;
-	ret = chip->bus.write(chip->bus.client,
-		ADT7316_DA_DATA_BASE + 1 + channel * 2, msb);
+	ret = regmap_write(chip->regmap, ADT7316_DA_DATA_BASE + 1 + channel * 2,
+			   msb);
 	if (ret)
 		return -EIO;
 
@@ -1577,10 +1573,10 @@ static ssize_t adt7316_show_device_id(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	u8 id;
+	unsigned int id;
 	int ret;
 
-	ret = chip->bus.read(chip->bus.client, ADT7316_DEVICE_ID, &id);
+	ret = regmap_read(chip->regmap, ADT7316_DEVICE_ID, &id);
 	if (ret)
 		return -EIO;
 
@@ -1595,10 +1591,10 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	u8 id;
+	unsigned int id;
 	int ret;
 
-	ret = chip->bus.read(chip->bus.client, ADT7316_MANUFACTURE_ID, &id);
+	ret = regmap_read(chip->regmap, ADT7316_MANUFACTURE_ID, &id);
 	if (ret)
 		return -EIO;
 
@@ -1614,10 +1610,10 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	u8 rev;
+	unsigned int rev;
 	int ret;
 
-	ret = chip->bus.read(chip->bus.client, ADT7316_DEVICE_REV, &rev);
+	ret = regmap_read(chip->regmap, ADT7316_DEVICE_REV, &rev);
 	if (ret)
 		return -EIO;
 
@@ -1632,10 +1628,10 @@ static ssize_t adt7316_show_bus_type(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	u8 stat;
+	unsigned int stat;
 	int ret;
 
-	ret = chip->bus.read(chip->bus.client, ADT7316_SPI_LOCK_STAT, &stat);
+	ret = regmap_read(chip->regmap, ADT7316_SPI_LOCK_STAT, &stat);
 	if (ret)
 		return -EIO;
 
@@ -1740,11 +1736,11 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
-	u8 stat1, stat2;
+	unsigned int stat1, stat2;
 	int ret;
 	s64 time;
 
-	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT1, &stat1);
+	ret = regmap_read(chip->regmap, ADT7316_INT_STAT1, &stat1);
 	if (!ret) {
 		if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 			stat1 &= 0x1F;
@@ -1793,7 +1789,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 							    IIO_EV_DIR_EITHER),
 				       time);
 		}
-	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
+	ret = regmap_read(chip->regmap, ADT7316_INT_STAT2, &stat2);
 	if (!ret) {
 		if (stat2 & ADT7316_INT_MASK2_VDD)
 			iio_push_event(indio_dev,
@@ -1879,7 +1875,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 	else
 		mask = ADT7316_INT_MASK2_VDD;	/* disable vdd int */
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_INT_MASK2, mask);
+	ret = regmap_write(chip->regmap, ADT7316_INT_MASK2, mask);
 	if (!ret) {
 		chip->int_mask &= ~ADT7316_VDD_INT_MASK;
 		chip->int_mask |= data & ADT7316_VDD_INT_MASK;
@@ -1893,7 +1889,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 			/* mask in reg is opposite, set 1 to disable */
 			mask = (~data) & ADT7316_TEMP_AIN_INT_MASK;
 	}
-	ret = chip->bus.write(chip->bus.client, ADT7316_INT_MASK1, mask);
+	ret = regmap_write(chip->regmap, ADT7316_INT_MASK1, mask);
 
 	chip->int_mask = mask;
 
@@ -1907,7 +1903,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	u8 val;
+	unsigned int val;
 	int data;
 	int ret;
 
@@ -1915,7 +1911,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 		this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;
 
-	ret = chip->bus.read(chip->bus.client, this_attr->address, &val);
+	ret = regmap_read(chip->regmap, this_attr->address, &val);
 	if (ret)
 		return -EIO;
 
@@ -1964,7 +1960,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 
 	val = (u8)data;
 
-	ret = chip->bus.write(chip->bus.client, this_attr->address, val);
+	ret = regmap_write(chip->regmap, this_attr->address, val);
 	if (ret)
 		return -EIO;
 
@@ -1995,7 +1991,7 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
 	if (buf[0] == '1')
 		config1 |= ADT7316_INT_EN;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, config1);
 	if (ret)
 		return -EIO;
 
@@ -2132,7 +2128,7 @@ static const struct iio_info adt7516_info = {
 /*
  * device probe and remove
  */
-int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
+int adt7316_probe(struct device *dev, struct regmap *regmap,
 		  const char *name, int irq)
 {
 	struct adt7316_chip_info *chip;
@@ -2146,7 +2142,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	/* this is only used for device removal purposes */
 	dev_set_drvdata(dev, indio_dev);
 
-	chip->bus = *bus;
+	chip->regmap = regmap;
 
 	if (name[4] == '3')
 		chip->id = ID_ADT7316 + (name[6] - '6');
@@ -2185,11 +2181,11 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 			return ret;
 	}
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG1, chip->config1);
 	if (ret)
 		return -EIO;
 
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, chip->config3);
+	ret = regmap_write(chip->regmap, ADT7316_CONFIG3, chip->config3);
 	if (ret)
 		return -EIO;
 
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index e9f288420234..0162d4026e88 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -11,13 +11,13 @@
 
 #include <linux/types.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 
 #define ADT7316_REG_MAX_ADDR		0x3F
 
-struct adt7316_bus {
-	void *client;
-	int (*read)(void *client, u8 reg, u8 *data);
-	int (*write)(void *client, u8 reg, u8 val);
+static const struct regmap_config adt7316_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -26,7 +26,7 @@ extern const struct dev_pm_ops adt7316_pm_ops;
 #else
 #define ADT7316_PM_OPS NULL
 #endif
-int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
+int adt7316_probe(struct device *dev, struct regmap *regmap,
 		  const char *name, int irq);
 
 #endif
-- 
2.17.1

