Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Hm++NjEQGVtmFgAAmS7hNA
	; Thu, 07 Jun 2018 11:00:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BAD186089E; Thu,  7 Jun 2018 11:00:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 280B860115;
	Thu,  7 Jun 2018 11:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 280B860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeFGK76 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:59:58 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:31666 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeFGK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:59:53 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="12270510"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Jun 2018 03:59:52 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 7 Jun 2018 03:59:51 -0700
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC: <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v6 3/6] mfd: at91-usart: added mfd driver for usart
Date: Thu, 7 Jun 2018 14:00:17 +0300
Message-ID: <20180607110020.20565-4-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607110020.20565-1-radu.pirea@microchip.com>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
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
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/Kconfig      |  9 ++++++
 drivers/mfd/Makefile     |  1 +
 drivers/mfd/at91-usart.c | 68 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/mfd/at91-usart.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..a886672b960d 100644
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
index d9d2cf0d32ef..db1332aa96db 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
+obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
new file mode 100644
index 000000000000..1a2bdeff7f6d
--- /dev/null
+++ b/drivers/mfd/at91-usart.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+	u32 opmode;
+	int err;
+
+	err = device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
+
+	switch (opmode) {
+	case AT91_USART_MODE_SPI:
+		cell = at91_usart_spi_subdev;
+		break;
+	case AT91_USART_MODE_SERIAL:
+	default:
+		cell = at91_usart_serial_subdev;
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
+MODULE_DEVICE_TABLE(of, at91_flexcom_of_match);
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
2.17.1
