Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CD22173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfADLVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:21:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfADLVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:21:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F04BAE5F;
        Fri,  4 Jan 2019 11:21:44 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH lora-next 1/5] net: lora: sx130x: Factor out SPI specific parts
Date:   Fri,  4 Jan 2019 12:21:27 +0100
Message-Id: <20190104112131.14451-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104112131.14451-1-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the picoGW by factoring code out into helpers using device
rather than spi_device.

While touching those lines, clean up the error output.

Split the probe function in two, to allow derived drivers to insert code
before the common probing code. This may need some more work.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c   | 139 +++++++++++++++++++++++++++-----------------
 include/linux/lora/sx130x.h |   7 +++
 2 files changed, 92 insertions(+), 54 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 9cae9cea195f..840052955874 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -133,7 +133,7 @@ static bool sx130x_readable_noinc_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config sx130x_regmap_config = {
+const struct regmap_config sx130x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -151,6 +151,7 @@ static struct regmap_config sx130x_regmap_config = {
 	.num_ranges = ARRAY_SIZE(sx130x_regmap_ranges),
 	.max_register = SX1301_MAX_REGISTER,
 };
+EXPORT_SYMBOL_GPL(sx130x_regmap_config);
 
 static int sx130x_field_write(struct sx130x_priv *priv,
 		enum sx130x_fields field_id, u8 val)
@@ -537,110 +538,98 @@ static const struct net_device_ops sx130x_net_device_ops = {
 	.ndo_start_xmit = sx130x_loradev_start_xmit,
 };
 
-static int sx130x_probe(struct spi_device *spi)
+int sx130x_early_probe(struct regmap *regmap, struct gpio_desc *rst)
 {
+	struct device *dev = regmap_get_device(regmap);
 	struct net_device *netdev;
 	struct sx130x_priv *priv;
-	struct gpio_desc *rst;
 	int ret;
 	int i;
-	unsigned int ver;
-	unsigned int val;
-
-	rst = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(rst)) {
-		if (PTR_ERR(rst) != -EPROBE_DEFER)
-			dev_err(&spi->dev, "Failed to obtain reset GPIO\n");
-		return PTR_ERR(rst);
-	}
-
-	gpiod_set_value_cansleep(rst, 1);
-	msleep(100);
-	gpiod_set_value_cansleep(rst, 0);
-	msleep(100);
-
-	spi->bits_per_word = 8;
-	spi_setup(spi);
 
-	netdev = devm_alloc_loradev(&spi->dev, sizeof(*priv));
+	netdev = devm_alloc_loradev(dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;
 
 	netdev->netdev_ops = &sx130x_net_device_ops;
-	SET_NETDEV_DEV(netdev, &spi->dev);
+	SET_NETDEV_DEV(netdev, dev);
 
 	priv = netdev_priv(netdev);
+	priv->regmap = regmap;
 	priv->rst_gpio = rst;
 
 	mutex_init(&priv->io_lock);
 
-	spi_set_drvdata(spi, netdev);
-	priv->dev = &spi->dev;
-
-	priv->regmap = devm_regmap_init_spi(spi, &sx130x_regmap_config);
-	if (IS_ERR(priv->regmap)) {
-		ret = PTR_ERR(priv->regmap);
-		dev_err(&spi->dev, "Regmap allocation failed: %d\n", ret);
-		return ret;
-	}
+	dev_set_drvdata(dev, netdev);
+	priv->dev = dev;
 
 	for (i = 0; i < ARRAY_SIZE(sx130x_regmap_fields); i++) {
 		const struct reg_field *reg_fields = sx130x_regmap_fields;
 
-		priv->regmap_fields[i] = devm_regmap_field_alloc(&spi->dev,
+		priv->regmap_fields[i] = devm_regmap_field_alloc(dev,
 				priv->regmap,
 				reg_fields[i]);
 		if (IS_ERR(priv->regmap_fields[i])) {
 			ret = PTR_ERR(priv->regmap_fields[i]);
-			dev_err(&spi->dev, "Cannot allocate regmap field: %d\n", ret);
+			dev_err(dev, "Cannot allocate regmap field (%d)\n", ret);
 			return ret;
 		}
 	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sx130x_early_probe);
+
+int sx130x_probe(struct device *dev)
+{
+	struct net_device *netdev = dev_get_drvdata(dev);
+	struct sx130x_priv *priv = netdev_priv(netdev);
+	unsigned int ver;
+	unsigned int val;
+	int ret;
 
 	ret = regmap_read(priv->regmap, SX1301_VER, &ver);
 	if (ret) {
-		dev_err(&spi->dev, "version read failed\n");
+		dev_err(dev, "version read failed (%d)\n", ret);
 		return ret;
 	}
 
 	if (ver != SX1301_CHIP_VERSION) {
-		dev_err(&spi->dev, "unexpected version: %u\n", ver);
+		dev_err(dev, "unexpected version: %u\n", ver);
 		return -ENXIO;
 	}
 
 	ret = regmap_write(priv->regmap, SX1301_PAGE, 0);
 	if (ret) {
-		dev_err(&spi->dev, "page/reset write failed\n");
+		dev_err(dev, "page/reset write failed (%d)\n", ret);
 		return ret;
 	}
 
 	ret = sx130x_field_write(priv, F_SOFT_RESET, 1);
 	if (ret) {
-		dev_err(&spi->dev, "soft reset failed\n");
+		dev_err(dev, "soft reset failed (%d)\n", ret);
 		return ret;
 	}
 
 	ret = sx130x_field_write(priv, F_GLOBAL_EN, 0);
 	if (ret) {
-		dev_err(&spi->dev, "gate global clocks failed\n");
+		dev_err(dev, "gate global clocks failed (%d)\n", ret);
 		return ret;
 	}
 
 	ret = sx130x_field_write(priv, F_CLK32M_EN, 0);
 	if (ret) {
-		dev_err(&spi->dev, "gate 32M clock failed\n");
+		dev_err(dev, "gate 32M clock failed (%d)\n", ret);
 		return ret;
 	}
 
 	ret = sx130x_field_write(priv, F_RADIO_A_EN, 1);
 	if (ret) {
-		dev_err(&spi->dev, "radio a enable failed\n");
+		dev_err(dev, "radio A enable failed (%d)\n", ret);
 		return ret;
 	}
 
 	ret = sx130x_field_write(priv, F_RADIO_B_EN, 1);
 	if (ret) {
-		dev_err(&spi->dev, "radio b enable failed\n");
+		dev_err(dev, "radio B enable failed (%d)\n", ret);
 		return ret;
 	}
 
@@ -648,7 +637,7 @@ static int sx130x_probe(struct spi_device *spi)
 
 	ret = sx130x_field_write(priv, F_RADIO_RST, 1);
 	if (ret) {
-		dev_err(&spi->dev, "radio asert reset failed\n");
+		dev_err(dev, "radio assert reset failed (%d)\n", ret);
 		return ret;
 	}
 
@@ -656,13 +645,13 @@ static int sx130x_probe(struct spi_device *spi)
 
 	ret = sx130x_field_write(priv, F_RADIO_RST, 0);
 	if (ret) {
-		dev_err(&spi->dev, "radio deasert reset failed\n");
+		dev_err(dev, "radio deassert reset failed (%d)\n", ret);
 		return ret;
 	}
 
 	/* radio */
 
-	ret = devm_sx130x_register_radio_devices(&spi->dev);
+	ret = devm_sx130x_register_radio_devices(dev);
 	if (ret)
 		return ret;
 
@@ -672,7 +661,7 @@ static int sx130x_probe(struct spi_device *spi)
 
 	ret = regmap_read(priv->regmap, SX1301_GPMODE, &val);
 	if (ret) {
-		dev_err(&spi->dev, "GPIO mode read failed\n");
+		dev_err(dev, "GPIO mode read failed (%d)\n", ret);
 		goto out;
 	}
 
@@ -680,13 +669,13 @@ static int sx130x_probe(struct spi_device *spi)
 
 	ret = regmap_write(priv->regmap, SX1301_GPMODE, val);
 	if (ret) {
-		dev_err(&spi->dev, "GPIO mode write failed\n");
+		dev_err(dev, "GPIO mode write failed (%d)\n", ret);
 		goto out;
 	}
 
 	ret = regmap_read(priv->regmap, SX1301_GPSO, &val);
 	if (ret) {
-		dev_err(&spi->dev, "GPIO select output read failed\n");
+		dev_err(dev, "GPIO select output read failed (%d)\n", ret);
 		goto out;
 	}
 
@@ -695,7 +684,7 @@ static int sx130x_probe(struct spi_device *spi)
 
 	ret = regmap_write(priv->regmap, SX1301_GPSO, val);
 	if (ret) {
-		dev_err(&spi->dev, "GPIO select output write failed\n");
+		dev_err(dev, "GPIO select output write failed (%d)\n", ret);
 		goto out;
 	}
 
@@ -705,24 +694,66 @@ static int sx130x_probe(struct spi_device *spi)
 	if (ret)
 		goto out;
 
-	dev_info(&spi->dev, "SX1301 module probed\n");
+	dev_info(dev, "SX1301 module probed\n");
 
 out:
 	mutex_unlock(&priv->io_lock);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sx130x_probe);
 
-static int sx130x_remove(struct spi_device *spi)
+int sx130x_remove(struct device *dev)
 {
-	struct net_device *netdev = spi_get_drvdata(spi);
+	struct net_device *netdev = dev_get_drvdata(dev);
 
 	unregister_loradev(netdev);
 
-	dev_info(&spi->dev, "SX1301 module removed\n");
+	dev_info(dev, "SX1301 module removed\n");
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sx130x_remove);
+
+static int sx130x_spi_probe(struct spi_device *spi)
+{
+	struct gpio_desc *rst;
+	struct regmap *regmap;
+	int ret;
+
+	rst = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(rst)) {
+		if (PTR_ERR(rst) != -EPROBE_DEFER)
+			dev_err(&spi->dev, "Failed to obtain reset GPIO\n");
+		return PTR_ERR(rst);
+	}
+
+	gpiod_set_value_cansleep(rst, 1);
+	msleep(100);
+	gpiod_set_value_cansleep(rst, 0);
+	msleep(100);
+
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+
+	regmap = devm_regmap_init_spi(spi, &sx130x_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&spi->dev, "Regmap allocation failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = sx130x_early_probe(regmap, rst);
+	if (ret)
+		return ret;
+
+	return sx130x_probe(&spi->dev);
+}
+
+static int sx130x_spi_remove(struct spi_device *spi)
+{
+	return sx130x_remove(&spi->dev);;
+}
 
 #ifdef CONFIG_OF
 static const struct of_device_id sx130x_dt_ids[] = {
@@ -737,8 +768,8 @@ static struct spi_driver sx130x_spi_driver = {
 		.name = "sx130x",
 		.of_match_table = of_match_ptr(sx130x_dt_ids),
 	},
-	.probe = sx130x_probe,
-	.remove = sx130x_remove,
+	.probe = sx130x_spi_probe,
+	.remove = sx130x_spi_remove,
 };
 
 static int __init sx130x_init(void)
diff --git a/include/linux/lora/sx130x.h b/include/linux/lora/sx130x.h
index ac4e2e7ae18a..d6f027ef283f 100644
--- a/include/linux/lora/sx130x.h
+++ b/include/linux/lora/sx130x.h
@@ -9,9 +9,16 @@
 #define LORA_SX130X_H
 
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+extern const struct regmap_config sx130x_regmap_config;
+int sx130x_early_probe(struct regmap *regmap, struct gpio_desc *rst);
+int sx130x_probe(struct device *dev);
+int sx130x_remove(struct device *dev);
+
+
 struct sx130x_radio_device {
 	struct device dev;
 	struct device *concentrator;
-- 
2.16.4

