Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5921C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78172083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78172083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeHaRsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:48:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58953 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeHaRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:48:10 -0400
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="16999761"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 06:40:37 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 06:40:36 -0700
From:   Radu Pirea <radu.pirea@microchip.com>
To:     <richard.genoud@gmail.com>, <pirea.radu@gmail.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [RESEND PATCH v11 3/6] mfd: at91-usart: added mfd driver for usart
Date:   Fri, 31 Aug 2018 16:41:38 +0300
Message-ID: <20180831134141.9335-4-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831134141.9335-1-radu.pirea@microchip.com>
References: <20180831134141.9335-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mfd driver is just a wrapper over atmel_serial driver and
spi-at91-usart driver. Selection of one of the drivers is based on a
property from device tree. If the property is not specified, the default
driver is atmel_serial.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/mfd/Kconfig      |  9 +++++
 drivers/mfd/Makefile     |  1 +
 drivers/mfd/at91-usart.c | 71 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/mfd/at91-usart.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 11841f4b7b2b..0b79c5d04cc9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -99,6 +99,15 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_AT91_USART
+	tristate "AT91 USART Driver"
+	select MFD_CORE
+	help
+	  Select this to get support for AT91 USART IP. This is a wrapper
+	  over at91-usart-serial driver and usart-spi-driver. Only one function
+	  can be used at a time. The choice is done at boot time by the probe
+	  function of this MFD driver according to a device tree property.
+
 config MFD_ATMEL_FLEXCOM
 	tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5856a9489cbd..12980a4ad460 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -196,6 +196,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
+obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
new file mode 100644
index 000000000000..a4b9929c156f
--- /dev/null
+++ b/drivers/mfd/at91-usart.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for AT91 USART
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#include <dt-bindings/mfd/at91-usart.h>
+
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/property.h>
+
+static struct mfd_cell at91_usart_spi_subdev = {
+		.name = "at91_usart_spi",
+		.of_compatible = "microchip,at91sam9g45-usart-spi",
+	};
+
+static struct mfd_cell at91_usart_serial_subdev = {
+		.name = "atmel_usart_serial",
+		.of_compatible = "atmel,at91rm9200-usart-serial",
+	};
+
+static int at91_usart_mode_probe(struct platform_device *pdev)
+{
+	struct mfd_cell cell;
+	u32 opmode = AT91_USART_MODE_SERIAL;
+
+	device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
+
+	switch (opmode) {
+	case AT91_USART_MODE_SPI:
+		cell = at91_usart_spi_subdev;
+		break;
+	case AT91_USART_MODE_SERIAL:
+		cell = at91_usart_serial_subdev;
+		break;
+	default:
+		dev_err(&pdev->dev, "atmel,usart-mode has an invalid value %u\n",
+			opmode);
+		return -EINVAL;
+	}
+
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
+			      NULL, 0, NULL);
+}
+
+static const struct of_device_id at91_usart_mode_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-usart" },
+	{ .compatible = "atmel,at91sam9260-usart" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, at91_usart_mode_of_match);
+
+static struct platform_driver at91_usart_mfd = {
+	.probe	= at91_usart_mode_probe,
+	.driver	= {
+		.name		= "at91_usart_mode",
+		.of_match_table	= at91_usart_mode_of_match,
+	},
+};
+
+module_platform_driver(at91_usart_mfd);
+
+MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
+MODULE_DESCRIPTION("AT91 USART MFD driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

