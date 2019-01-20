Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9988FC676ED
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3872087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B50WsK8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfATPgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:36:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41552 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfATPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:36:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so8924068pfi.8;
        Sun, 20 Jan 2019 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=luiTtLku6rFGD30juk1JWga+vC4vJLmnPDX3ii8J7Ew=;
        b=B50WsK8aaJzGk/0z/aTJZai92P4JPZakBFyBOeJntmRXj8MHspcumNFKT4qxmTgCEh
         Dcl2/AQ1TnMsoO07GTz28A1D/wB0w7xgoACPVjMOSP/qqduO48vAWpOBe4rY119l2GzA
         7+3v+IZQGfwi4yprmVg98+D/CnA1l5l3owzzjt4KYOaKVkQqwHExm5cD1OucFY1ZHvMV
         THrBOT/uUNwrGncg1ztmHFlYTM7/izMiPbz/fC2CpeAqvoScz7A148KSkW43kcWkl+Du
         2hjf7K4hQF3nJMRU1/8aYnt1I/YTxEDIAd7X5CdGw3FJRLrCbJhPVx9HpvK15r/KgAfz
         OeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=luiTtLku6rFGD30juk1JWga+vC4vJLmnPDX3ii8J7Ew=;
        b=Wz+1moJWlXVf+vK6DKlC6FPCMkvKfBTeYYY+HAU6BXb8Dqbh9klCVReImXwOLeDAKE
         LNMIqiMsa/HXFD8bkb7Og3tCxRyjc6zoHndZdWh9aLLJy3xwIt6F+AhbACcyyWGlRrMo
         FViacwaqB8TuXT13Siv1VWiJ0n1U+gH4jyarml33752eNj1R3UEez+GKd/mOpcrfqIiP
         gMEAm19jefO0WYHDHhjYQvZqAF+mxM68+hP84PevY/5YY3Ml5SRSPeDfW7CDMAoJcAZA
         VD9HPGD0PIywbUIf9OjLOLJvmF9V4Tr5rttPwX7fxa9P7qGO6T1kQMhLBg6rE6ZNAEC7
         GmYQ==
X-Gm-Message-State: AJcUukcL43p1OJm/wvwPuw9dAzJjXefBIfv7CdiJIDTBx7QqpGA/aEYv
        KEBtInyZoxlh3OgOaNI4xQ4=
X-Google-Smtp-Source: ALg8bN4cJX6/wqiIMaYkGA/5HsXbhr1FXDBFgmM0jhLKMUoe1XaLx69jyR3nIBKsbRRnM/4V7BBEnQ==
X-Received: by 2002:a62:5658:: with SMTP id k85mr26450690pfb.231.1547998609813;
        Sun, 20 Jan 2019 07:36:49 -0800 (PST)
Received: from localhost.localdomain ([223.189.18.171])
        by smtp.gmail.com with ESMTPSA id o8sm21451376pfa.42.2019.01.20.07.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 07:36:49 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, jeremyfertic@gmail.com,
        shreeya.patel23498@gmail.com
Subject: [PATCH v3 2/3] Staging: iio: adt7316: Remove multi read and write functions
Date:   Sun, 20 Jan 2019 21:06:32 +0530
Message-Id: <20190120153633.18231-3-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
References: <20190120153633.18231-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, adt7316 doesn't use multi read and multi write
functions hence remove the redundant code and make the
necessary changes in the code.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 40 -------------------------
 drivers/staging/iio/addac/adt7316-spi.c | 31 ++++---------------
 drivers/staging/iio/addac/adt7316.h     |  2 --
 3 files changed, 6 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index b6571db2e8d8..c7f82c3fe27c 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -52,44 +52,6 @@ static int adt7316_i2c_write(void *client, u8 reg, u8 data)
 	return ret;
 }
 
-static int adt7316_i2c_multi_read(void *client, u8 reg, u8 count, u8 *data)
-{
-	struct i2c_client *cl = client;
-	int i, ret = 0;
-
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
-
-	for (i = 0; i < count; i++) {
-		ret = adt7316_i2c_read(cl, reg, &data[i]);
-		if (ret < 0) {
-			dev_err(&cl->dev, "I2C multi read error\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
-{
-	struct i2c_client *cl = client;
-	int i, ret = 0;
-
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
-
-	for (i = 0; i < count; i++) {
-		ret = adt7316_i2c_write(cl, reg, data[i]);
-		if (ret < 0) {
-			dev_err(&cl->dev, "I2C multi write error\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * device probe and remove
  */
@@ -101,8 +63,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 		.client = client,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
-		.multi_read = adt7316_i2c_multi_read,
-		.multi_write = adt7316_i2c_multi_write,
 	};
 
 	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index adaaa3eecd04..1a78dc1e2840 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -23,15 +23,12 @@
  * adt7316 register access by SPI
  */
 
-static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
+static int adt7316_spi_read(void *client, u8 reg, u8 *data)
 {
 	struct spi_device *spi_dev = client;
 	u8 cmd[2];
 	int ret = 0;
 
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
-
 	cmd[0] = ADT7316_SPI_CMD_WRITE;
 	cmd[1] = reg;
 
@@ -43,7 +40,7 @@ static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
 
 	cmd[0] = ADT7316_SPI_CMD_READ;
 
-	ret = spi_write_then_read(spi_dev, cmd, 1, data, count);
+	ret = spi_write_then_read(spi_dev, cmd, 1, data, 1);
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI read data error\n");
 		return ret;
@@ -52,21 +49,17 @@ static int adt7316_spi_multi_read(void *client, u8 reg, u8 count, u8 *data)
 	return 0;
 }
 
-static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
+static int adt7316_spi_write(void *client, u8 reg, u8 val)
 {
 	struct spi_device *spi_dev = client;
 	u8 buf[ADT7316_REG_MAX_ADDR + 2];
-	int i, ret = 0;
-
-	if (count > ADT7316_REG_MAX_ADDR)
-		count = ADT7316_REG_MAX_ADDR;
+	int ret = 0;
 
 	buf[0] = ADT7316_SPI_CMD_WRITE;
 	buf[1] = reg;
-	for (i = 0; i < count; i++)
-		buf[i + 2] = data[i];
+	buf[2] = val;
 
-	ret = spi_write(spi_dev, buf, count + 2);
+	ret = spi_write(spi_dev, buf, 3);
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI write error\n");
 		return ret;
@@ -75,16 +68,6 @@ static int adt7316_spi_multi_write(void *client, u8 reg, u8 count, u8 *data)
 	return ret;
 }
 
-static int adt7316_spi_read(void *client, u8 reg, u8 *data)
-{
-	return adt7316_spi_multi_read(client, reg, 1, data);
-}
-
-static int adt7316_spi_write(void *client, u8 reg, u8 val)
-{
-	return adt7316_spi_multi_write(client, reg, 1, &val);
-}
-
 /*
  * device probe and remove
  */
@@ -95,8 +78,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		.client = spi_dev,
 		.read = adt7316_spi_read,
 		.write = adt7316_spi_write,
-		.multi_read = adt7316_spi_multi_read,
-		.multi_write = adt7316_spi_multi_write,
 	};
 
 	/* don't exceed max specified SPI CLK frequency */
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 03d5300a98cd..e9f288420234 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -18,8 +18,6 @@ struct adt7316_bus {
 	void *client;
 	int (*read)(void *client, u8 reg, u8 *data);
 	int (*write)(void *client, u8 reg, u8 val);
-	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
-	int (*multi_write)(void *client, u8 first_reg, u8 count, u8 *data);
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.1

