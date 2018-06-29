Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98B8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7D327D9F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7D327D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964984AbeF2LPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:15:39 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:51598 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935740AbeF2LPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:15:33 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id D4DC941BD8; Fri, 29 Jun 2018 13:05:29 +0200 (CEST)
Message-Id: <a84243a1a15d11511061eeae2f09c0ad8154d093.1530268235.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Fri, 29 Jun 2018 10:10:10 +0200
Subject: [PATCH 1/3] IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum failed
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver bails out if not explicitly referred to in
DT or ACPI tables. This prevents fallback mechanisms from coming
into effect, e.g. I2C device ID table match via DT or ACPI
PRP0001 HID. However DT/ACPI enum should take precedence over
the fallback, so evaluate that first.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel_i2c.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 6bdec8c451e0..e360da407027 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
-static int st_accel_i2c_probe(struct i2c_client *client,
-						const struct i2c_device_id *id)
+static int st_accel_i2c_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct st_sensor_data *adata;
@@ -156,14 +155,18 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 					 client->name, sizeof(client->name));
 	} else if (ACPI_HANDLE(&client->dev)) {
 		ret = st_sensors_match_acpi_device(&client->dev);
-		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
-			return -ENODEV;
-
-		strlcpy(client->name, st_accel_id_table[ret].name,
+		if ((ret >= 0) && (ret < ST_ACCEL_MAX))
+			strlcpy(client->name, st_accel_id_table[ret].name,
 				sizeof(client->name));
-	} else if (!id)
-		return -ENODEV;
+	}
 
+	/*
+	 * If OF and ACPI enumeration failed, there could still be platform
+	 * information via fallback enumeration or explicit instantiation, so
+	 * check if id table has been matched via client->name.
+	 */
+	if (!client->name)
+		return -ENODEV;
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
@@ -187,7 +190,7 @@ static struct i2c_driver st_accel_driver = {
 		.of_match_table = of_match_ptr(st_accel_of_match),
 		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
 	},
-	.probe = st_accel_i2c_probe,
+	.probe_new = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
 	.id_table = st_accel_id_table,
 };
-- 
2.17.1

