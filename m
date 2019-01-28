Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93AC282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A20621736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULyCdkRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1Jtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:49:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41669 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA1Jtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:49:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so11327884lfj.8;
        Mon, 28 Jan 2019 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojc4LVaSgZvQCAKegN4dIOYy2YW2Fe7BAEkqaOnlWy8=;
        b=ULyCdkRiYNVcfeDs+MmNtSSjIXlFkoh86p4CFDI5NLo2AfucipTtS0ygQngu0eZoLa
         xfVjShm4hPcA+3HsGu14iJwNab+MlxM7paZMOI5CTI3iAKVzu3Jfwz7+0fRcaI+Pzbm5
         1xSN4TFnYI9bgShgnYwZAlN2LM0sGVgIIpYclHuJYU+gWm8MGZ+rpixFPngyA9I89A94
         EIPZyAfl3JNz5fezApxGawpYyLSPdMUWg1g0wCgTiTX7k5685dsRIN34+JBQB6vvJVNP
         4+0ujRZvdgQRxBb4klYUT3P63m4gLybzqIQD9iKqTymVnhsLJS9Ijcbe68nwtjQpTqW8
         kIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ojc4LVaSgZvQCAKegN4dIOYy2YW2Fe7BAEkqaOnlWy8=;
        b=Dm0iPRiKOwsuhdym/7yYL4/Thc9PwHlrxcvWyKWrtV3J2dnHKX5QCQsc26vfMj70PY
         4nVRmZhzufGRUpP9xJUAoreQMFSS562NPyp79AaXXSC1dNjH6y1cSSQDtsIdlXgh75dt
         BoggLCDz29I1oeKw7LR9Ohp822/6Q+92A5K3jGZkqwSE9yJiV+SNssEonnRpowoakCfX
         dzU6nNAYe9dKr1eDPa6RHSr5GS0wKZ3ySIWDbH1vZArsgHEBTcoB8OrYF9pe7deXs9n/
         +x/54ej3hrBQTx6/LvrXUUDim6Y5JPBkcQ/kBRqNY2UA8Etd9lMVvKprrmg+f6QvhiBJ
         PMTA==
X-Gm-Message-State: AJcUukdaFf7x+GP/kdIKNgFM9ZdCXSiC9otr3yfN06rOUkZYG+dxui8N
        /fM1W9LnfXbh9P/JDd1BDX2UWeBU
X-Google-Smtp-Source: ALg8bN5M1dn1a9/QHR3NOpW6VSPAObHjKr7M6I3LxlH+5avYiJYE9R6FByXdyvlE0zW11p1e3H4emw==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr15511995lfh.74.1548668988602;
        Mon, 28 Jan 2019 01:49:48 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id r29-v6sm2859053ljd.44.2019.01.28.01.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:49:47 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH v3 1/2] iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612
Date:   Mon, 28 Jan 2019 10:49:30 +0100
Message-Id: <20190128094931.4430-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a driver for Texas Instruments Dual, 12-Bit Serial Input
Digital-to-Analog Converter.

Datasheet of this chip:
http://www.ti.com/lit/ds/sbas106/sbas106.pdf

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
v3: Changes by Jonathan Cameron <jic23@kernel.org>

- Include OF compatible strings
- Rename RESOLUTION define
- Create defines for BIT positions
- Support DMA
- Rename gpio
- Remove scantype
- Fix scale
- Use iio_priv at variable definition
- (Ab)use ARRAY_SIZE for number of channels (love the idea)


 MAINTAINERS                  |   6 ++
 drivers/iio/dac/Kconfig      |  10 ++
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac7612.c | 173 +++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/iio/dac/ti-dac7612.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d039f66a5cef..30ba5435906b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14877,6 +14877,12 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 
+Texas Instruments' DAC7612 DAC Driver
+M:	Ricardo Ribalda <ricardo@ribalda.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/dac/ti-dac7612.c
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index f28daf67db6a..fbef9107acad 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -375,6 +375,16 @@ config TI_DAC7311
 
 	  If compiled as a module, it will be called ti-dac7311.
 
+config TI_DAC7612
+	tristate "Texas Instruments 12-bit 2-channel DAC driver"
+	depends on SPI_MASTER && GPIOLIB
+	help
+	  Driver for the Texas Instruments DAC7612, DAC7612U, DAC7612UB
+	  The driver hand drive the load pin automatically, otherwise
+	  it needs to be toggled manually.
+
+	  If compiled as a module, it will be called ti-dac7612.
+
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
 	depends on OF
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index f0a37c93de8e..1369fa1d2f0e 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -41,4 +41,5 @@ obj-$(CONFIG_STM32_DAC) += stm32-dac.o
 obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
 obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
 obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
+obj-$(CONFIG_TI_DAC7612) += ti-dac7612.o
 obj-$(CONFIG_VF610_DAC) += vf610_dac.o
diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
new file mode 100644
index 000000000000..a2f58256a784
--- /dev/null
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAC7612 Dual, 12-Bit Serial input Digital-to-Analog Converter
+ *
+ * Copyright 2019 Qtechnology A/S
+ * 2019 Ricardo Ribalda <ricardo@ribalda.com>
+ *
+ * Licensed under the GPL-2.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+
+#define DAC7612_RESOLUTION 12
+#define DAC7612_ADDRESS 4
+#define DAC7612_START 5
+
+struct dac7612 {
+	struct spi_device *spi;
+	struct gpio_desc *loaddacs;
+	uint16_t cache[2];
+
+	// DMA
+	uint8_t data[2] ____cacheline_aligned;
+};
+
+static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
+{
+	int ret;
+
+	priv->data[0] = BIT(DAC7612_START) | (channel << DAC7612_ADDRESS);
+	priv->data[0] |= val >> 8;
+	priv->data[1] = val & 0xff;
+
+	priv->cache[channel] = val;
+
+	ret = spi_write(priv->spi, priv->data, sizeof(priv->data));
+	if (ret)
+		return ret;
+
+	gpiod_set_value(priv->loaddacs, 1);
+	gpiod_set_value(priv->loaddacs, 0);
+
+	return 0;
+}
+
+#define dac7612_CHANNEL(chan, name) {				\
+	.type = IIO_VOLTAGE,					\
+	.channel = (chan),					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.datasheet_name = name,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec dac7612_channels[] = {
+	dac7612_CHANNEL(0, "OUTA"),
+	dac7612_CHANNEL(1, "OUTB"),
+};
+
+static int dac7612_read_raw(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct dac7612 *priv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		priv = iio_priv(iio_dev);
+		*val = priv->cache[chan->channel];
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dac7612_write_raw(struct iio_dev *iio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct dac7612 *priv = iio_priv(iio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if ((val >= BIT(DAC7612_RESOLUTION)) || val < 0 || val2)
+		return -EINVAL;
+
+	if (val == priv->cache[chan->channel])
+		return 0;
+
+	mutex_lock(&iio_dev->mlock);
+	ret = dac7612_cmd_single(priv, chan->channel, val);
+	mutex_unlock(&iio_dev->mlock);
+
+	return ret;
+}
+
+static const struct iio_info dac7612_info = {
+	.read_raw = dac7612_read_raw,
+	.write_raw = dac7612_write_raw,
+};
+
+static int dac7612_probe(struct spi_device *spi)
+{
+	struct iio_dev *iio_dev;
+	struct dac7612 *priv;
+	int i;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(iio_dev);
+	priv->loaddacs = devm_gpiod_get_optional(&spi->dev, "loaddacs",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(priv->loaddacs))
+		return PTR_ERR(priv->loaddacs);
+	priv->spi = spi;
+	spi_set_drvdata(spi, iio_dev);
+	iio_dev->dev.parent = &spi->dev;
+	iio_dev->info = &dac7612_info;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->channels = dac7612_channels;
+	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
+	iio_dev->name = spi_get_device_id(spi)->name;
+
+	for (i = 0; i < ARRAY_SIZE(priv->cache); i++) {
+		ret = dac7612_cmd_single(priv, i, 0);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, iio_dev);
+}
+
+static const struct spi_device_id dac7612_id[] = {
+	{"ti-dac7612"},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, dac7612_id);
+
+static const struct of_device_id dac7612_of_match[] = {
+	{ .compatible = "ti,dac7612" },
+	{ .compatible = "ti,dac7612u" },
+	{ .compatible = "ti,dac7612b" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dac7612_of_match);
+
+static struct spi_driver dac7612_driver = {
+	.driver = {
+		   .name = "ti-dac7612",
+		   .of_match_table = dac7612_of_match,
+		   },
+	.probe = dac7612_probe,
+	.id_table = dac7612_id,
+};
+module_spi_driver(dac7612_driver);
+
+MODULE_AUTHOR("Ricardo Ribalda <ricardo@ribalda.com>");
+MODULE_DESCRIPTION("Texas Instruments DAC7612 DAC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

