Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6EC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310F02075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUYyEYf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310F02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeJXXT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:19:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35948 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJXXT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:19:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so2351434plt.3;
        Wed, 24 Oct 2018 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mWejzS4tfiPSW0zer83uPgJ1SMZ4PMy9yb4StfnxnfA=;
        b=hUYyEYf/pKPvTOn/oJAzkNy/YnbHLd0wUaBYL9EjiwOZ3i+8sYjnQoX7XhuRBFo5CE
         /2XDtcLZ5v/lU3Vwb/vQbaZlmsuoU5trihQtzycd+OBmtoOw+EOs0NQbvJvEKnISdnoQ
         mW36GZBqlCH1sA0EMBMeNyPZrVHp05Tj7ydGxIw4Qmoe59HkPIqum9kUXecitXMYzbyR
         KK5PpZLrfSmymH7pSjH93Emea9maMZBjikEh5ghucM/pwFWsffg8Jk5zVsMXyyVF7RpO
         MiK5VQS5nFbf+1Weyhjhw4fUdQKlti+MgXARawhlbtokvuTjlYpUGpPn0KRT6VeEgSUI
         q0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mWejzS4tfiPSW0zer83uPgJ1SMZ4PMy9yb4StfnxnfA=;
        b=kVeUxNtL0qxEdHASPZ2AvWlveXIt0WNEN6DjdB30+3zulNw1n+sg4F8CP6b5rPHpUE
         LR5GKZPfV/YWg/Ur3S7Zhom575GNILdCU3xdIKiMJXBwK2V3wPUwqnh7NaLssFwCs9gP
         deu6SUzjL75q8P9MWQaD7B4pvaBEhlf8/gTeuMfuwSixiJbFEOllvqaFDdpT+9XW5c3R
         DTAcat2hzorCgpmJRZNWV8IMU9zfKvCsMpWBa+lmdhQGWvKETcQTmtZismtoR7Zwu/Lv
         rdINnw8aBFWNTZhd9+6IRYeNL4TAYw574e0oUpX44DZo+FWQTWZWg9FYOpIFZAof/uOD
         BU0Q==
X-Gm-Message-State: AGRZ1gKTazytmtoCsGH932eV1LYN+tw1vIKsqifOuONf8wrRZHalpvtM
        LLp3vjQRHIoU8pVw2TpYPGk=
X-Google-Smtp-Source: AJdET5de9cNDcbrtIohM7nX9oHCPrwXkS6mBygOVXlseaqbg89cu2zNQ7TbT0tXNEOFtezrRz+3V2Q==
X-Received: by 2002:a17:902:76cb:: with SMTP id j11-v6mr2792608plt.258.1540392662544;
        Wed, 24 Oct 2018 07:51:02 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id s13-v6sm13138197pgs.76.2018.10.24.07.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 07:51:01 -0700 (PDT)
Date:   Wed, 24 Oct 2018 20:20:55 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181024145051.GA18490@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.
---
 drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
 drivers/staging/iio/resolver/ad2s1210.h |  3 -
 2 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..93c3c70ce62e 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -69,10 +69,21 @@ enum ad2s1210_mode {
 
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
+struct ad2s1210_gpio {
+	struct gpio_desc **ptr;
+	const char *name;
+	unsigned long flags;
+};
+
 struct ad2s1210_state {
 	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
 	struct spi_device *sdev;
+	struct gpio_desc *sample;
+	struct gpio_desc *a0;
+	struct gpio_desc *a1;
+	struct gpio_desc *res0;
+	struct gpio_desc *res1;
 	unsigned int fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
@@ -91,8 +102,8 @@ static const int ad2s1210_mode_vals[4][2] = {
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
 				     struct ad2s1210_state *st)
 {
-	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
-	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
+	gpiod_set_value(st->a0, ad2s1210_mode_vals[mode][0]);
+	gpiod_set_value(st->a1, ad2s1210_mode_vals[mode][1]);
 	st->mode = mode;
 }
 
@@ -152,8 +163,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 
 static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 {
-	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
-			  gpio_get_value(st->pdata->res[1]);
+	int resolution = (gpiod_get_value(st->res0) << 1) |
+			  gpiod_get_value(st->res1);
 
 	return ad2s1210_resolution_value[resolution];
 }
@@ -164,10 +175,10 @@ static const int ad2s1210_res_pins[4][2] = {
 
 static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
 {
-	gpio_set_value(st->pdata->res[0],
-		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
-	gpio_set_value(st->pdata->res[1],
-		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
+	gpiod_set_value(st->res0,
+			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
+	gpiod_set_value(st->res1,
+			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
 }
 
 static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
@@ -401,15 +412,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
+	gpiod_set_value(st->sample, 0);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->sample, 1);
 	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
 	if (ret < 0)
 		goto error_ret;
-	gpio_set_value(st->pdata->sample, 0);
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->sample, 0);
+	gpiod_set_value(st->sample, 1);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -466,7 +477,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	s16 vel;
 
 	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
+	gpiod_set_value(st->sample, 0);
 	/* delay (6 * tck + 20) nano seconds */
 	udelay(1);
 
@@ -512,7 +523,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	}
 
 error_ret:
-	gpio_set_value(st->pdata->sample, 1);
+	gpiod_set_value(st->sample, 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
 	mutex_unlock(&st->lock);
@@ -630,30 +641,32 @@ static const struct iio_info ad2s1210_info = {
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
-	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
-	struct gpio ad2s1210_gpios[] = {
-		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
-		{ st->pdata->a[0], flags, "a0" },
-		{ st->pdata->a[1], flags, "a1" },
-		{ st->pdata->res[0], flags, "res0" },
-		{ st->pdata->res[0], flags, "res1" },
+	int ret, i;
+	struct spi_device *spi = st->sdev;
+	struct ad2s1210_gpio *pin;
+	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
+
+	struct ad2s1210_gpio gpios[] = {
+		{ .ptr = &st->sample, .name = "sample", .flags = GPIOD_IN },
+		{ .ptr = &st->a0, .name = "a0", .flags = flags },
+		{ .ptr = &st->a1, .name = "a1", .flags = flags },
+		{ .ptr = &st->res0, .name = "res0", .flags = flags },
+		{ .ptr = &st->res1, .name = "res1", .flags = flags },
 	};
 
-	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
-}
-
-static void ad2s1210_free_gpios(struct ad2s1210_state *st)
-{
-	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
-	struct gpio ad2s1210_gpios[] = {
-		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
-		{ st->pdata->a[0], flags, "a0" },
-		{ st->pdata->a[1], flags, "a1" },
-		{ st->pdata->res[0], flags, "res0" },
-		{ st->pdata->res[0], flags, "res1" },
-	};
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		pin = &gpios[i];
+		*pin->ptr = devm_gpiod_get(&spi->dev, pin->name, pin->flags);
+		if (IS_ERR(*pin->ptr)) {
+			ret = PTR_ERR(*pin->ptr);
+			dev_err(&spi->dev,
+				"ad2s1210: failed to request %s GPIO: %d\n",
+				pin->name, ret);
+			return ret;
+		}
+	}
 
-	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
+	return 0;
 }
 
 static int ad2s1210_probe(struct spi_device *spi)
@@ -692,7 +705,7 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_gpios;
+		return ret;
 
 	st->fclkin = spi->max_speed_hz;
 	spi->mode = SPI_MODE_3;
@@ -700,10 +713,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	ad2s1210_initial(st);
 
 	return 0;
-
-error_free_gpios:
-	ad2s1210_free_gpios(st);
-	return ret;
 }
 
 static int ad2s1210_remove(struct spi_device *spi)
@@ -711,7 +720,6 @@ static int ad2s1210_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
-	ad2s1210_free_gpios(iio_priv(indio_dev));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index e9b2147701fc..63d479b20a6c 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -12,9 +12,6 @@
 #define _AD2S1210_H
 
 struct ad2s1210_platform_data {
-	unsigned int		sample;
-	unsigned int		a[2];
-	unsigned int		res[2];
 	bool			gpioin;
 };
 #endif /* _AD2S1210_H */
-- 
2.17.1

