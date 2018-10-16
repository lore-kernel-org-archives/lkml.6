Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AB9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C9B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLKfNX93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C9B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJPWhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:37:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42874 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPWhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:37:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so11565381pfn.9;
        Tue, 16 Oct 2018 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SZZEzm89nUQYCZIMdozLX5yhM1cilHIoym83KXh9g1U=;
        b=YLKfNX93ypOxOhED1Qthu0CAvblmwfBelOC5Lfeb3YiK65TvFdTeQerATwZYbYNAwh
         lEaSNnik7ocSrJya5HtruL9Z+RJ4GI7lP2ODBRl4wIHIPw5QNLspkEvgpeegAWIC4Qls
         cFTxBhxC04jdypypm7MA+eFN3tSK5SfsIZjOnRogj4up2KfTnQNeq7SmjXz5EzOk1vum
         g087R7XYfXwcnHkNzVbCZspMKBy7otx39/D7qHg3FzaaF04hFMy9qxmoLjolg14C8gNf
         voo/Y7h0BBQhJXF7YB/92/JxxVUi77axvEm0c5HAO1aB8cRIdgsO7tuYgSHHOdCXJdRH
         k2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SZZEzm89nUQYCZIMdozLX5yhM1cilHIoym83KXh9g1U=;
        b=ToxANUpBi9Xm4d1E2ru7ash58u5olBGF5hxCXFVUTsEh6a5Tp0+BRQumrdFy42w/Zq
         T/zGl5JbO/e6b10/ZowXBDzPGwAjHJg7nsHPylMVpSDeXtVFZUK0htTMJik+Dj3ldz7K
         O9zuQ3ep2jZk8x/05kCWuqabfR5WhaEUhK+T/Q3M88g7LkiweuwDcqt6WWOBNgHHRY90
         /SvtWqo1ZOpB97MmG8eh7oeDtsHsFsPzPjwaxxsZBlstfNra2OD8r6b7w8uGA3+UwT7y
         sqlL+xP5/rWwyNZnLlORWcUoPSoVQam3/9YQGzrrcLenpeiVT98Bsdy+sTtLnjonail4
         nNrA==
X-Gm-Message-State: ABuFfojhgTyPaxK4ynTO6wwChodoBp8h+S5r23xbUdwANnerwo3IwGGz
        pyWhRZOHP3CE1/WE6oQyLsY=
X-Google-Smtp-Source: ACcGV634iioyfKDBV0/KDleTyog2hlFmUm/wDbr3bOYCrYiBWNdvd7eO1nRbqPWfObmyFtlDcJW5mw==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr20848352pge.182.1539701194878;
        Tue, 16 Oct 2018 07:46:34 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id c8-v6sm16944694pfi.142.2018.10.16.07.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 07:46:34 -0700 (PDT)
Date:   Tue, 16 Oct 2018 20:16:27 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: ad7816: Switch to the gpio descriptor interface
Message-ID: <20181016144623.GA9890@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
instead of the deprecated old non-descriptor interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 72 +++++++++++++-------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bf76a8620bdb..190b751af866 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -44,9 +44,9 @@
 
 struct ad7816_chip_info {
 	struct spi_device *spi_dev;
-	u16 rdwr_pin;
-	u16 convert_pin;
-	u16 busy_pin;
+	struct gpio_desc *rdwr_pin;
+	struct gpio_desc *convert_pin;
+	struct gpio_desc *busy_pin;
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
@@ -61,28 +61,28 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret = 0;
 	__be16 buf;
 
-	gpio_set_value(chip->rdwr_pin, 1);
-	gpio_set_value(chip->rdwr_pin, 0);
+	gpiod_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI channel setting error\n");
 		return ret;
 	}
-	gpio_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 1);
 
 	if (chip->mode == AD7816_PD) { /* operating mode 2 */
-		gpio_set_value(chip->convert_pin, 1);
-		gpio_set_value(chip->convert_pin, 0);
+		gpiod_set_value(chip->convert_pin, 1);
+		gpiod_set_value(chip->convert_pin, 0);
 	} else { /* operating mode 1 */
-		gpio_set_value(chip->convert_pin, 0);
-		gpio_set_value(chip->convert_pin, 1);
+		gpiod_set_value(chip->convert_pin, 0);
+		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	while (gpio_get_value(chip->busy_pin))
+	while (gpiod_get_value(chip->busy_pin))
 		cpu_relax();
 
-	gpio_set_value(chip->rdwr_pin, 0);
-	gpio_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 0);
+	gpiod_set_value(chip->rdwr_pin, 1);
 	ret = spi_read(spi_dev, &buf, sizeof(*data));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
@@ -99,8 +99,8 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret = 0;
 
-	gpio_set_value(chip->rdwr_pin, 1);
-	gpio_set_value(chip->rdwr_pin, 0);
+	gpiod_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &data, sizeof(data));
 	if (ret < 0)
 		dev_err(&spi_dev->dev, "SPI oti data write error\n");
@@ -129,10 +129,10 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (strcmp(buf, "full")) {
-		gpio_set_value(chip->rdwr_pin, 1);
+		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-		gpio_set_value(chip->rdwr_pin, 0);
+		gpiod_set_value(chip->rdwr_pin, 0);
 		chip->mode = AD7816_PD;
 	}
 
@@ -345,15 +345,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned short *pins = dev_get_platdata(&spi_dev->dev);
 	int ret = 0;
 	int i;
 
-	if (!pins) {
-		dev_err(&spi_dev->dev, "No necessary GPIO platform data.\n");
-		return -EINVAL;
-	}
-
 	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -364,34 +358,28 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
-	chip->rdwr_pin = pins[0];
-	chip->convert_pin = pins[1];
-	chip->busy_pin = pins[2];
 
-	ret = devm_gpio_request(&spi_dev->dev, chip->rdwr_pin,
-				spi_get_device_id(spi_dev)->name);
-	if (ret) {
+	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
+	if (IS_ERR(chip->rdwr_pin)) {
+		ret = PTR_ERR(chip->rdwr_pin);
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
-			chip->rdwr_pin);
+			ret);
 		return ret;
 	}
-	gpio_direction_input(chip->rdwr_pin);
-	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
-				spi_get_device_id(spi_dev)->name);
-	if (ret) {
+	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
+	if (IS_ERR(chip->convert_pin)) {
+		ret = PTR_ERR(chip->convert_pin);
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
-			chip->convert_pin);
+			ret);
 		return ret;
 	}
-	gpio_direction_input(chip->convert_pin);
-	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
-				spi_get_device_id(spi_dev)->name);
-	if (ret) {
+	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
+	if (IS_ERR(chip->busy_pin)) {
+		ret = PTR_ERR(chip->busy_pin);
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
-			chip->busy_pin);
+			ret);
 		return ret;
 	}
-	gpio_direction_input(chip->busy_pin);
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
 	indio_dev->dev.parent = &spi_dev->dev;
-- 
2.17.1

