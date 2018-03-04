Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELtV8RQwblYzsRXGAsmHk19M+ZYKWalmBztCvG1yttioErBauwRlDtDIWCLaxLVkyL7jYz/V
ARC-Seal: i=1; a=rsa-sha256; t=1520128192; cv=none;
        d=google.com; s=arc-20160816;
        b=O7aoY7U9v9i3u11zGTSPjmNhA3SPmINfI1kWx6IOCIPcxiiug3QaFrAIhLFIiZaHeF
         DBYcPDBkUovcKGw9Hav9WUfLeLM4K+n2dn/ylG+gbs07uiIj8srOn5xIeCSYxIpHmrsY
         KfLW2hiH60aYgwchMRBEZ5G+bcuFNRztGV5grBqyFXqCmuCKVJVADzqSw+uTWIyNroKq
         4HB2+CMYaL1C8MfTPDFnSKt9Wy/EsBzHUTqi2ITGWQlIh2WTUJoaIvS6mxeH7o73K9kc
         V5UE64GGECVeh7KV0+bnGc3g94Rp/Qgo0DfUI34P1H83g3E83qW4wdsaMYAl1E9vXBmw
         iXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=/c/752vmA5C1xbGTuvG7pJr03LMkIPgPkmKcQXeD/Xk=;
        b=WNtY5W9YUg8lpCsEqGS2PKDPBPffLNT5o9lU4xl7bvMCRH0MDnXQk2GDPPrXaulqIs
         EjHkqWUX0gs5/HfGvruATgfFQdq0/sXAbna6Moi60F5I/Xl8s1czJVy6TMH8LRyjromp
         zi/T1yZo5p+T3gacbX4xmgN5c2nTfISfTDfm/WbcLupD1aZi5twuhqLw6YU2Uc4qWV/S
         W59Tb9ymyS4yInfZAzKSEZcZXMJsuRK9W7JfAGdTnY6sKiYRZult5mlwJMFlSmHWKWZ8
         MvBOv/llG9o55i6sUcmrJvDpyDlKTQII6O+NpkMjKOs6yv2qLmwsuRnfsxnoewLVmrI8
         MJRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=O8wCEJn3;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=O8wCEJn3;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 03/12] staging: iio: tsl2x7x: add common function for reading chip status
Date: Sat,  3 Mar 2018 20:49:33 -0500
Message-Id: <20180304014942.18727-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969939058285980?=
X-GMAIL-MSGID: =?utf-8?q?1593969939058285980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There were three places where the same chunk of code was used to read
the chip status. This patch creates a common function
tsl2x7x_read_status() to reduce duplicate code. This patch also corrects
tsl2x7x_event_handler() to properly check for an error after reading the
chip status.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 40 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index c02db03ef369..6bb622816660 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -293,6 +293,20 @@ static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
 	return ret;
 }
 
+static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(chip->client,
+				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
+	if (ret < 0)
+		dev_err(&chip->client->dev,
+			"%s: failed to read STATUS register: %d\n", __func__,
+			ret);
+
+	return ret;
+}
+
 /**
  * tsl2x7x_get_lux() - Reads and calculates current lux value.
  * @indio_dev:	pointer to IIO device
@@ -332,13 +346,10 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		goto out_unlock;
 	}
 
-	ret = i2c_smbus_read_byte_data(chip->client,
-				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
-	if (ret < 0) {
-		dev_err(&chip->client->dev,
-			"%s: Failed to read STATUS Reg\n", __func__);
+	ret = tsl2x7x_read_status(chip);
+	if (ret < 0)
 		goto out_unlock;
-	}
+
 	/* is data new & valid */
 	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
 		dev_err(&chip->client->dev,
@@ -458,12 +469,9 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 		return -EBUSY;
 	}
 
-	ret = i2c_smbus_read_byte_data(chip->client,
-				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "i2c err=%d\n", ret);
+	ret = tsl2x7x_read_status(chip);
+	if (ret < 0)
 		goto prox_poll_err;
-	}
 
 	switch (chip->id) {
 	case tsl2571:
@@ -1396,13 +1404,13 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
-	u8 value;
 
-	value = i2c_smbus_read_byte_data(chip->client,
-					 TSL2X7X_CMD_REG | TSL2X7X_STATUS);
+	ret = tsl2x7x_read_status(chip);
+	if (ret < 0)
+		return ret;
 
 	/* What type of interrupt do we need to process */
-	if (value & TSL2X7X_STA_PRX_INTR) {
+	if (ret & TSL2X7X_STA_PRX_INTR) {
 		tsl2x7x_get_prox(indio_dev); /* freshen data for ABI */
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
@@ -1412,7 +1420,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 						    timestamp);
 	}
 
-	if (value & TSL2X7X_STA_ALS_INTR) {
+	if (ret & TSL2X7X_STA_ALS_INTR) {
 		tsl2x7x_get_lux(indio_dev); /* freshen data for ABI */
 		iio_push_event(indio_dev,
 			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
-- 
2.14.3
