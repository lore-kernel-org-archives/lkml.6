Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D38C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFC924181
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFC924181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeGEJeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:34:25 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:59120 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeGEJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:34:23 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 4DB2843FC9; Thu,  5 Jul 2018 11:34:14 +0200 (CEST)
Message-Id: <954eea265614f551e1c32b02a71578cc80a32020.1530782560.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Tue, 3 Jul 2018 07:41:00 +0200
Subject: [PATCH v4 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_get_match_data API to simplify access to driver data.
Let acpi_device_id table entries point to the same driver data as
of_device_id table entries and uniquify access to driver data by using
device_get_match_data API. Remove unused i2c_device_id .driver_data
fields.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 59 ++++++++++++++------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 056dddb27236..d02298f0256c 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -14,8 +14,8 @@
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_accel.h"
 
@@ -107,8 +107,8 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
-	{"SMO8840", LNG2DM},
-	{"SMO8A90", LNG2DM},
+	{"SMO8840", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
+	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
@@ -117,24 +117,24 @@ MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
 #endif
 
 static const struct i2c_device_id st_accel_id_table[] = {
-	{ LSM303DLH_ACCEL_DEV_NAME, LSM303DLH },
-	{ LSM303DLHC_ACCEL_DEV_NAME, LSM303DLHC },
-	{ LIS3DH_ACCEL_DEV_NAME, LIS3DH },
-	{ LSM330D_ACCEL_DEV_NAME, LSM330D },
-	{ LSM330DL_ACCEL_DEV_NAME, LSM330DL },
-	{ LSM330DLC_ACCEL_DEV_NAME, LSM330DLC },
-	{ LIS331DLH_ACCEL_DEV_NAME, LIS331DLH },
-	{ LSM303DL_ACCEL_DEV_NAME, LSM303DL },
-	{ LSM303DLM_ACCEL_DEV_NAME, LSM303DLM },
-	{ LSM330_ACCEL_DEV_NAME, LSM330 },
-	{ LSM303AGR_ACCEL_DEV_NAME, LSM303AGR },
-	{ LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
-	{ LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
-	{ LNG2DM_ACCEL_DEV_NAME, LNG2DM },
-	{ H3LIS331DL_ACCEL_DEV_NAME, H3LIS331DL },
-	{ LIS331DL_ACCEL_DEV_NAME, LIS331DL },
-	{ LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
-	{ LIS2DW12_ACCEL_DEV_NAME, LIS2DW12 },
+	{ LSM303DLH_ACCEL_DEV_NAME },
+	{ LSM303DLHC_ACCEL_DEV_NAME },
+	{ LIS3DH_ACCEL_DEV_NAME },
+	{ LSM330D_ACCEL_DEV_NAME },
+	{ LSM330DL_ACCEL_DEV_NAME },
+	{ LSM330DLC_ACCEL_DEV_NAME },
+	{ LIS331DLH_ACCEL_DEV_NAME },
+	{ LSM303DL_ACCEL_DEV_NAME },
+	{ LSM303DLM_ACCEL_DEV_NAME },
+	{ LSM330_ACCEL_DEV_NAME },
+	{ LSM303AGR_ACCEL_DEV_NAME },
+	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LIS3L02DQ_ACCEL_DEV_NAME },
+	{ LNG2DM_ACCEL_DEV_NAME },
+	{ H3LIS331DL_ACCEL_DEV_NAME },
+	{ LIS331DL_ACCEL_DEV_NAME },
+	{ LIS3LV02DL_ACCEL_DEV_NAME },
+	{ LIS2DW12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
@@ -144,6 +144,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
+	const char *match;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
@@ -152,19 +153,9 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	adata = iio_priv(indio_dev);
 
-	if (client->dev.of_node) {
-		st_sensors_of_name_probe(&client->dev, st_accel_of_match,
-					 client->name, sizeof(client->name));
-	} else if (ACPI_HANDLE(&client->dev)) {
-		ret = st_sensors_match_acpi_device(&client->dev);
-		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
-			return -ENODEV;
-
-		strlcpy(client->name, st_accel_id_table[ret].name,
-				sizeof(client->name));
-	} else if (!id)
-		return -ENODEV;
-
+	match = device_get_match_data(&client->dev);
+	if (match)
+		strlcpy(client->name, match, sizeof(client->name));
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
-- 
2.17.1

