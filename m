Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF69ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098712082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj+18g+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098712082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeJ1QhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:37:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37698 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeJ1QhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:37:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh10-v6so2357375plb.4;
        Sun, 28 Oct 2018 00:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8y0O3OECRakgF6U92KTpyKmli03v5f+vs380fG93zRI=;
        b=Lj+18g+Fpei1AUnU3UsbrZcBpfEsoOnITzSTQXpgPiswcCMrX+FnT6gNltrol9+p0N
         BOcLgaZBJXCPKnMYFcfVyU2iraWpnTubwN/2k47hl042BRi73VNoWb5VTwQ/DWblL29B
         mFNcsRxX0Q4ZIk6/vY1FltZ9L2wLW3pykAFsWdPjGV/z30RCyu+F+R5+0AxZ1dFMK6F+
         SK9+wDouE3ylgbj6EVCsXA8OCWpNEVIz/0I9269SDh4ffbllFK4cUnubPGF8aOX/NCsE
         Pr6hVss1b/yF8klVlzpJjtBH6kkE6Rf+eTw6C+lmKE0Bb8BwlGBMAAGJa80guctjQvni
         njtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8y0O3OECRakgF6U92KTpyKmli03v5f+vs380fG93zRI=;
        b=VEAjbfJzSM4Ui5lu0rVAfat0vt/cFkGh+5EBFZ3/yjBfAFNNBol/nmxFt0gGwA6tG/
         JMn9Jnp9mPzNWH8qlnfipeyI06cnSzpPvjXzJ5eDjwKelu2luVmh5SeNaDvU2h27kCNZ
         kOiDA+ynldfHojJQi47xTiosERxOwUJixsau3jjE2amZJUzXlzcr16sGs68JvbwTeL69
         O2F8CHUREvmVG3y5m8ijRsqKcUjdkdAElBn5HnCuOi1FIkxy5f0LDk9vjUnlMVMsEkuX
         kH345y2eWbd+k1l/XAuJGtGNtte2sTwamGCcouMuuwhwN7MUmouTYWKo+RlCGxswxrii
         rweg==
X-Gm-Message-State: AGRZ1gLX4ZNsghoxsBlwOA7kLL93OBHeV7TxpcXzYcaTbO0yhxb9AuTv
        7zxS8h1mOZnGmGfbPxKrEVo=
X-Google-Smtp-Source: AJdET5fuQxjcS5fbaWSfjycK+ITfzJFiCvCL50Op24m4vhNjXJneTXCRZAGaH1wh6s0oG+b+2nr5kA==
X-Received: by 2002:a17:902:8202:: with SMTP id x2-v6mr9707115pln.192.1540713211280;
        Sun, 28 Oct 2018 00:53:31 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l26-v6sm28543310pfg.161.2018.10.28.00.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 00:53:30 -0700 (PDT)
Date:   Sun, 28 Oct 2018 13:23:23 +0530
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
Subject: [PATCH v6 3/3] staging: iio: ad2s1210: Add device tree support.
Message-ID: <473e6abfe959e1ac78fe65bf8dc53ad25ad3b358.1540712249.git.nishadkamdar@gmail.com>
References: <cover.1540712249.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540712249.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace platform data with device tree support.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/Kconfig    |  1 +
 drivers/staging/iio/resolver/ad2s1210.c | 17 ++++++++---------
 drivers/staging/iio/resolver/ad2s1210.h | 17 -----------------
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 6a469ee6101f..cc1202ff813d 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -15,6 +15,7 @@ config AD2S90
 
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
+	depends on OF
 	depends on SPI
 	depends on GPIOLIB || COMPILE_TEST
 	help
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0234869e9d74..5ecdb5785132 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -76,7 +77,6 @@ struct ad2s1210_gpio {
 };
 
 struct ad2s1210_state {
-	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *sample;
@@ -84,6 +84,7 @@ struct ad2s1210_state {
 	struct gpio_desc *a1;
 	struct gpio_desc *res0;
 	struct gpio_desc *res1;
+	bool gpioin;
 	unsigned int fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
@@ -314,7 +315,7 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 	}
 	st->resolution
 		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
-	if (st->pdata->gpioin) {
+	if (st->gpioin) {
 		data = ad2s1210_read_resolution_pin(st);
 		if (data != st->resolution)
 			dev_warn(dev, "ad2s1210: resolution settings not match\n");
@@ -376,7 +377,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 	}
 	st->resolution
 		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
-	if (st->pdata->gpioin) {
+	if (st->gpioin) {
 		data = ad2s1210_read_resolution_pin(st);
 		if (data != st->resolution)
 			dev_warn(dev, "ad2s1210: resolution settings not match\n");
@@ -603,7 +604,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	if (st->pdata->gpioin)
+	if (st->gpioin)
 		st->resolution = ad2s1210_read_resolution_pin(st);
 	else
 		ad2s1210_set_resolution_pin(st);
@@ -644,7 +645,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 	int ret, i;
 	struct spi_device *spi = st->sdev;
 	struct ad2s1210_gpio *pin;
-	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
+	unsigned long flags = st->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
 
 	struct ad2s1210_gpio gpios[] = {
 		{ .ptr = &st->sample, .name = "sample", .flags = GPIOD_IN },
@@ -673,16 +674,14 @@ static int ad2s1210_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s1210_state *st;
+	struct device_node *np = spi->dev.of_node;
 	int ret;
 
-	if (!spi->dev.platform_data)
-		return -EINVAL;
-
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	st->pdata = spi->dev.platform_data;
+	st->gpioin = of_property_read_bool(np, "gpioin");
 	ret = ad2s1210_setup_gpios(st);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index 63d479b20a6c..e69de29bb2d1 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -1,17 +0,0 @@
-/*
- * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
- * AD2S1210
- *
- * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef _AD2S1210_H
-#define _AD2S1210_H
-
-struct ad2s1210_platform_data {
-	bool			gpioin;
-};
-#endif /* _AD2S1210_H */
-- 
2.17.1

