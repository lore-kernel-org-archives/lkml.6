Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24509C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C542075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="pANWrGe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C542075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeIDPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:45:09 -0400
Received: from mail-sender230.upb.ro ([141.85.13.230]:56734 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbeIDPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:45:03 -0400
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id 1B552B560060;
        Tue,  4 Sep 2018 14:13:21 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id DD88BB560063;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro DD88BB560063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1536059600;
        bh=jURLLgmV3noC2145CGKJEt5aymllIv3r3uQnmUJAhpo=;
        h=From:To:Date:Message-Id;
        b=pANWrGe2sCjh1QIPScb8reuJ7J7mq62BwXt9GhjVzJruGxiKLVQ4H//GamyM/JElB
         wRGPQAxDjn2U9cFm7WXFR345QDX9qWi2q3WMacTlYN1XvAmJFY+zKkijEUsWkbLcgE
         cYj0avAPuIjIjkgthVt0UseI40bhqV9Z9nN/PZg0=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lYIvXQVXm27Y; Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id B24B1B56004E;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v12 3/6] mfd: at91-usart: added mfd driver for usart
Date:   Tue,  4 Sep 2018 14:13:07 +0300
Message-Id: <20180904111310.4049-4-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Pirea <radu.pirea@microchip.com>

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
index e9fd20dba18d..c7e66928abb9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -184,6 +184,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
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

