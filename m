Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F7BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E91222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X+H842bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfBMBjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:39:05 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43614 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfBMBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:39:05 -0500
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 80E9330C24C;
        Tue, 12 Feb 2019 17:39:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 80E9330C24C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1550021943;
        bh=VE0gVzv134jCDUn3824+3CpYz9zUoV9OQmuoQw1n6Kg=;
        h=From:To:Cc:Subject:Date:From;
        b=X+H842bwk65ZSL+te5N3gQ6eQ2U/r6ZN5112DeDyHmvJEuWuQi+FXgAdkohXTnqPi
         wJmIZUmIRg9442+qk3mKfOjNViZ/ej1veOeojTXmD6q5xwb+DVekE6an+Cu9Dy47z+
         1DoA76+KnWES/h7RoQjyEnhTYo52sdlqHGhClu6c=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id A7BD7AC0783;
        Tue, 12 Feb 2019 17:39:03 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 9245A27ECF1; Tue, 12 Feb 2019 17:39:03 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, david@lechnology.com,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2] iio: adc: ti-ads7950: add GPIO support
Date:   Tue, 12 Feb 2019 17:38:57 -0800
Message-Id: <1550021937-12202-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

The ADS79XX has GPIO pins that can be used. Add support for the GPIO
pins using the GPIO chip framework.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 168 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0ad6359..b229581 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -17,6 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -36,10 +37,14 @@
  */
 #define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000
 
+#define TI_ADS7950_CR_GPIO	BIT(14)
 #define TI_ADS7950_CR_MANUAL	BIT(12)
 #define TI_ADS7950_CR_WRITE	BIT(11)
 #define TI_ADS7950_CR_CHAN(ch)	((ch) << 7)
 #define TI_ADS7950_CR_RANGE_5V	BIT(6)
+#define TI_ADS7950_CR_GPIO_DATA	BIT(5)
+#define TI_ADS7950_NUM_GPIOS	4
+#define TI_ADS7950_GPIO_MASK	GENMASK(TI_ADS7950_NUM_GPIOS - 1, 0)
 
 #define TI_ADS7950_MAX_CHAN	16
 
@@ -56,11 +61,17 @@ struct ti_ads7950_state {
 	struct spi_message	ring_msg;
 	struct spi_message	scan_single_msg;
 
+	struct gpio_chip	chip;
+	struct mutex		slock;
+
 	struct regulator	*reg;
 	unsigned int		vref_mv;
 
 	unsigned int		settings;
 
+	unsigned int		gpio_direction_bitmask;
+	unsigned int		gpio_signal_bitmask;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -248,7 +259,8 @@ static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
 
 	len = 0;
 	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
-		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings;
+		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings
+		      | (st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK);
 		st->tx_buf[len++] = cmd;
 	}
 
@@ -287,8 +299,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	int ret, cmd;
 
 	mutex_lock(&indio_dev->mlock);
-
-	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
+	mutex_lock(&st->slock);
+	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings
+	      | (st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK);
 	st->single_tx = cmd;
 
 	ret = spi_sync(st->spi, &st->scan_single_msg);
@@ -298,6 +311,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	ret = st->single_rx;
 
 out:
+	mutex_unlock(&st->slock);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
@@ -362,6 +376,144 @@ static const struct iio_info ti_ads7950_info = {
 	.update_scan_mode	= ti_ads7950_update_scan_mode,
 };
 
+static void ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
+			   int value)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+
+	mutex_lock(&st->slock);
+
+	if (value)
+		st->gpio_signal_bitmask |= BIT(offset);
+	else
+		st->gpio_signal_bitmask &= ~BIT(offset);
+
+	st->single_tx = cpu_to_be16(TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_WRITE |
+			(st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK));
+	spi_sync(st->spi, &st->scan_single_msg);
+
+	mutex_unlock(&st->slock);
+}
+
+static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+	int ret;
+
+	mutex_lock(&st->slock);
+
+	/* If set as output, return the output */
+	if (st->gpio_direction_bitmask & BIT(offset)) {
+		ret = st->gpio_signal_bitmask & BIT(offset);
+		goto out;
+	}
+
+	st->single_tx = cpu_to_be16(TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_WRITE |
+				    TI_ADS7950_CR_GPIO_DATA);
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	if (ret)
+		goto out;
+
+	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
+
+out:
+	mutex_unlock(&st->slock);
+
+	return ret;
+}
+
+static int ti_ads7950_get_direction(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+
+	return !(st->gpio_direction_bitmask & BIT(offset));
+}
+
+static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
+				     int input)
+{
+	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+	int ret = 0;
+
+	mutex_lock(&st->slock);
+
+	if (input && (st->gpio_direction_bitmask & BIT(offset)))
+		st->gpio_direction_bitmask &= ~BIT(offset);
+	else if (!input && !(st->gpio_direction_bitmask & BIT(offset)))
+		st->gpio_direction_bitmask |= BIT(offset);
+	else
+		goto out;
+
+
+	st->single_tx = cpu_to_be16(TI_ADS7950_CR_GPIO |
+				    (st->gpio_direction_bitmask &
+				    TI_ADS7950_GPIO_MASK));
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+
+out:
+	mutex_unlock(&st->slock);
+
+	return ret;
+}
+
+static int ti_ads7950_direction_input(struct gpio_chip *chip,
+				      unsigned int offset)
+{
+	return _ti_ads7950_set_direction(chip, offset, 1);
+}
+
+static int ti_ads7950_direction_output(struct gpio_chip *chip,
+				       unsigned int offset, int value)
+{
+	ti_ads7950_set(chip, offset, value);
+
+	return _ti_ads7950_set_direction(chip, offset, 0);
+}
+
+static int ti_ads7950_init_gpio(struct ti_ads7950_state *st)
+{
+	int ret;
+
+	/* Initialize GPIO */
+	mutex_lock(&st->slock);
+
+	/* Default to GPIO input */
+	st->gpio_direction_bitmask = 0x0;
+	st->single_tx = cpu_to_be16(TI_ADS7950_CR_GPIO |
+				    (st->gpio_direction_bitmask &
+				    TI_ADS7950_GPIO_MASK));
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	mutex_unlock(&st->slock);
+	if (ret)
+		return ret;
+
+	/* Default to signal low */
+	st->gpio_signal_bitmask = 0x0;
+	st->single_tx = cpu_to_be16(TI_ADS7950_CR_MANUAL |
+				    TI_ADS7950_CR_WRITE |
+				    (st->gpio_signal_bitmask &
+				    TI_ADS7950_GPIO_MASK));
+	ret = spi_sync(st->spi, &st->scan_single_msg);
+	mutex_unlock(&st->slock);
+	if (ret)
+		return ret;
+
+	/* Add GPIO chip */
+	st->chip.label = dev_name(&st->spi->dev);
+	st->chip.parent = &st->spi->dev;
+	st->chip.owner = THIS_MODULE;
+	st->chip.base = -1;
+	st->chip.ngpio = TI_ADS7950_NUM_GPIOS;
+	st->chip.get_direction = ti_ads7950_get_direction;
+	st->chip.direction_input = ti_ads7950_direction_input;
+	st->chip.direction_output = ti_ads7950_direction_output;
+	st->chip.get = ti_ads7950_get;
+	st->chip.set = ti_ads7950_set;
+
+	return gpiochip_add_data(&st->chip, st);
+}
+
 static int ti_ads7950_probe(struct spi_device *spi)
 {
 	struct ti_ads7950_state *st;
@@ -457,8 +609,17 @@ static int ti_ads7950_probe(struct spi_device *spi)
 		goto error_cleanup_ring;
 	}
 
+	mutex_init(&st->slock);
+	ret = ti_ads7950_init_gpio(st);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to initialize GPIOs\n");
+		goto error_destroy_mutex;
+	}
+
 	return 0;
 
+error_destroy_mutex:
+	mutex_destroy(&st->slock);
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
@@ -475,6 +636,7 @@ static int ti_ads7950_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(st->reg);
+	mutex_destroy(&st->slock);
 
 	return 0;
 }
-- 
2.7.4

