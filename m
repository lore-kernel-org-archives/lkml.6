Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BFC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927992146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927992146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeKOX6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:58:21 -0500
Received: from ms.tdt.de ([195.243.126.94]:34341 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387989AbeKOX6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:58:21 -0500
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 97A0A21A6C;
        Thu, 15 Nov 2018 13:50:22 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v3 2/2] hwmon: (adcxx) Add device tree support
Date:   Thu, 15 Nov 2018 14:50:13 +0100
Message-Id: <20181115135013.30723-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181115135013.30723-1-fe@dev.tdt.de>
References: <20181115135013.30723-1-fe@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree supoort for this driver.
Set reference voltage of ADC with the regulator device tree property.
If not set use default 3300000uV (3.3V).

- vref-supply

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/hwmon/adcxx.c | 62 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index 69e0bb97e597..6f3e7d65b5b8 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -4,6 +4,7 @@
  * The adcxx4s is an AD converter family from National Semiconductor (NS).
  *
  * Copyright (c) 2008 Marc Pignat <marc.pignat@hevs.ch>
+ * Copyright (c) 2017 Florian Eckert <fe@dev.tdt.de>
  *
  * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
  * interface. This driver supports the whole family of devices with name
@@ -46,9 +47,16 @@
 #include <linux/mutex.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
 
 #define DRVNAME		"adcxx"
 
+#define ADCXX1S  1
+#define ADCXX2S  2
+#define ADCXX4S  4
+#define ADCXX8S  8
+
 struct adcxx {
 	struct device *hwmon_dev;
 	struct mutex lock;
@@ -159,21 +167,60 @@ static struct sensor_device_attribute ad_input[] = {
 	SENSOR_ATTR(in7_input, S_IRUGO, adcxx_read, NULL, 7),
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id adcxx_of_ids[] = {
+	{
+		.compatible = "national,adcxx1s",
+		.data = (void *) ADCXX1S,
+	},
+	{
+		.compatible = "national,adcxx2s",
+		.data = (void *) ADCXX2S,
+	},
+	{
+		.compatible = "national,adcxx4s",
+		.data = (void *) ADCXX4S,
+	},
+	{
+		.compatible = "national,adcxx8s",
+	.	data = (void *) ADCXX8S,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, adcxx_of_ids);
+#endif
+
 /*----------------------------------------------------------------------*/
 
 static int adcxx_probe(struct spi_device *spi)
 {
-	int channels = spi_get_device_id(spi)->driver_data;
+	const struct of_device_id *match;
+	struct regulator *vref;
+	int vref_uv;
+	int channels;
 	struct adcxx *adc;
 	int status;
 	int i;
 
+	match = of_match_device(adcxx_of_ids, &spi->dev);
+	if (match)
+		channels = (int)(uintptr_t)match->data;
+	else
+		channels = spi_get_device_id(spi)->driver_data;
+
 	adc = devm_kzalloc(&spi->dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return -ENOMEM;
 
-	/* set a default value for the reference */
-	adc->reference = 3300;
+	vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(vref)) {
+		vref_uv = regulator_get_voltage(vref);
+		adc->reference = DIV_ROUND_CLOSEST(vref_uv, 1000);
+	}
+	if (!adc->reference)
+		adc->reference = 3300;
+	dev_dbg(&spi->dev, "Reference voltage set to %dmV\n", adc->reference);
+
 	adc->channels = channels;
 	mutex_init(&adc->lock);
 
@@ -223,10 +270,10 @@ static int adcxx_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id adcxx_ids[] = {
-	{ "adcxx1s", 1 },
-	{ "adcxx2s", 2 },
-	{ "adcxx4s", 4 },
-	{ "adcxx8s", 8 },
+	{ "adcxx1s", ADCXX1S },
+	{ "adcxx2s", ADCXX2S },
+	{ "adcxx4s", ADCXX4S },
+	{ "adcxx8s", ADCXX8S },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, adcxx_ids);
@@ -234,6 +281,7 @@ MODULE_DEVICE_TABLE(spi, adcxx_ids);
 static struct spi_driver adcxx_driver = {
 	.driver = {
 		.name	= "adcxx",
+		.of_match_table = of_match_ptr(adcxx_of_ids),
 	},
 	.id_table = adcxx_ids,
 	.probe	= adcxx_probe,
-- 
2.11.0

