Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D6C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A32218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJTz27X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfAZReU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:34:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34051 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:34:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so5948583plz.1;
        Sat, 26 Jan 2019 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=2dxEL6dV0ZDce8tRbxit7cjqI9FDoXF1XNivCFZ0gPg=;
        b=aJTz27X392KXMqkMOGikGpAFmvUV4YF/m8hmR/92vfW4nwe8lO56bshqSf2mvDHc6y
         yUUCm+bLkJf1GuwygRPi4scJcAM900j+CdIyD4k7eIcPQSpjBYwnCBygHULokX0MITjm
         rwUCi4a0FIHbSN/tiVV+yu+g9tm+Xj7oenteEcKX1Osmo7tT9AYAjK6fiiph9y4aQVyM
         xTACqEZa9ElBDeM9LyL6L4boIwhZKmlS/QL/GrhkT/oQTebf3EkZFPR5GVrGWW6UXgNW
         3iRJJ4SHW3tTnewT4nk6KK0mshXMfCeEMGXPcWD7+KtyxEnclU0WJfr00UtM1UxIgvXA
         KLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=2dxEL6dV0ZDce8tRbxit7cjqI9FDoXF1XNivCFZ0gPg=;
        b=jYnQuM1kBuxBjvULC0cCJsnJ/eKHsntqu7E3Zcr6TpNqtHRttZN6oYWlrHL64ZIwv0
         S3Cfsxm3x9BZeZE2C1egla9g2lq0nq5jvcElB2SMqkTIILgyE10hgfPkNGkwvxpnVBUL
         6wQsxMa+4cONGtuiJNic/5vvT5memT9eGnIc/dt0htbAAEryHJOQZQQlMKdE72sVg9SB
         WpGaVI+qPvpihdTOau8d/YofsQrssF3H65NrV30r934K6Q8gslpguxFGExGgUEzldRLN
         GPZ+jbjPDE016bg7WBp5COZDUmIHwaxDBLqPVtzSds4ApNLxOjsTGznqrni7cUHu/vto
         Er7A==
X-Gm-Message-State: AJcUukc67MB8TBpXuD3e77T/ELXEDnVB7ZW41lcj2vPVxnha0UeBku/S
        ZG1mqRXcplsF9Fm3w4xdX6g=
X-Google-Smtp-Source: ALg8bN6NLErLNkY8Aw+NokGk6wY9CdCwpHtGS+Lqf/760mY/doPYPEAOuE7vRjYu/hNjHas4hAOtpg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr15211155pls.322.1548524057860;
        Sat, 26 Jan 2019 09:34:17 -0800 (PST)
Received: from localhost.localdomain ([49.32.227.18])
        by smtp.gmail.com with ESMTPSA id a65sm28745690pge.65.2019.01.26.09.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 09:34:17 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, jeremyfertic@gmail.com,
        shreeya.patel23498@gmail.com
Subject: [PATCH v4 1/3] Staging: iio: adt7316: Remove irq from bus structure
Date:   Sat, 26 Jan 2019 23:04:00 +0530
Message-Id: <20190126173402.12428-2-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126173402.12428-1-shreeya.patel23498@gmail.com>
References: <20190126173402.12428-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt request is not needed to be present in the bus
structure. It is a good option to pass it as a parameter
in the probe function instead of having it in the bus structure.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c |  3 +--
 drivers/staging/iio/addac/adt7316-spi.c |  4 ++--
 drivers/staging/iio/addac/adt7316.c     | 15 +++++++--------
 drivers/staging/iio/addac/adt7316.h     |  3 +--
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 0f26bc38edc6..9dfe3be21849 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -99,14 +99,13 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 {
 	struct adt7316_bus bus = {
 		.client = client,
-		.irq = client->irq,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
 		.multi_read = adt7316_i2c_multi_read,
 		.multi_write = adt7316_i2c_multi_write,
 	};
 
-	return adt7316_probe(&client->dev, &bus, id->name);
+	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
 }
 
 static const struct i2c_device_id adt7316_i2c_id[] = {
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 8294b9c1e3c2..ec4848acec9f 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -93,7 +93,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 {
 	struct adt7316_bus bus = {
 		.client = spi_dev,
-		.irq = spi_dev->irq,
 		.read = adt7316_spi_read,
 		.write = adt7316_spi_write,
 		.multi_read = adt7316_spi_multi_read,
@@ -112,7 +111,8 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
 
-	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
+	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias,
+			     spi_dev->irq);
 }
 
 static const struct spi_device_id adt7316_spi_id[] = {
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 6f7891b567b9..7c4f84822c18 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1799,12 +1799,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int adt7316_setup_irq(struct iio_dev *indio_dev)
+static int adt7316_setup_irq(struct iio_dev *indio_dev, int irq)
 {
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 	int irq_type, ret;
 
-	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
@@ -1820,13 +1820,12 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
 		break;
 	}
 
-	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
+	ret = devm_request_threaded_irq(&indio_dev->dev, irq,
 					NULL, adt7316_event_handler,
 					irq_type | IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
 	if (ret) {
-		dev_err(&indio_dev->dev, "failed to request irq %d\n",
-			chip->bus.irq);
+		dev_err(&indio_dev->dev, "failed to request irq %d\n", irq);
 		return ret;
 	}
 
@@ -2126,7 +2125,7 @@ static const struct iio_info adt7516_info = {
  * device probe and remove
  */
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		  const char *name)
+		  const char *name, int irq)
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
@@ -2179,8 +2178,8 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (chip->bus.irq > 0) {
-		ret = adt7316_setup_irq(indio_dev);
+	if (irq > 0) {
+		ret = adt7316_setup_irq(indio_dev, irq);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 84ca4f6c88f5..03d5300a98cd 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -16,7 +16,6 @@
 
 struct adt7316_bus {
 	void *client;
-	int irq;
 	int (*read)(void *client, u8 reg, u8 *data);
 	int (*write)(void *client, u8 reg, u8 val);
 	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
@@ -30,6 +29,6 @@ extern const struct dev_pm_ops adt7316_pm_ops;
 #define ADT7316_PM_OPS NULL
 #endif
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		  const char *name);
+		  const char *name, int irq);
 
 #endif
-- 
2.17.1

