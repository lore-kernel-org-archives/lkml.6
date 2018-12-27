Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8B2208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeL0PNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:13:32 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36403 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeL0PN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:13:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,405,1539673200"; 
   d="scan'208";a="21970191"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Dec 2018 08:13:27 -0700
Received: from M43218.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Thu, 27 Dec 2018 08:13:51 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <me@jue.yt>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <wsa@the-dreams.de>, <andriy.shevchenko@linux.intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v4 2/3] i2c: at91: split driver into core and master file
Date:   Thu, 27 Dec 2018 16:13:10 +0100
Message-ID: <20181227151311.20107-3-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227151311.20107-1-ludovic.desroches@microchip.com>
References: <20181227151311.20107-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Fitschen <me@jue.yt>

The single file i2c-at91.c has been split into core code (i2c-at91-core.c)
and master mode specific code (i2c-at91-master.c). This should enhance
maintainability and reduce ifdeffery for slave mode related code.

The code itself hasn't been touched. Shared functions only had to be made
non-static. Furthermore, includes have been cleaned up.

Signed-off-by: Juergen Fitschen <me@jue.yt>
[ludovic.desroches@microchip.com: fix checkpatch errors]
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS                                   |   3 +-
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-at91-core.c            | 373 ++++++++++++++
 .../busses/{i2c-at91.c => i2c-at91-master.c}  | 467 +-----------------
 drivers/i2c/busses/i2c-at91.h                 | 151 ++++++
 5 files changed, 531 insertions(+), 464 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-core.c
 rename drivers/i2c/busses/{i2c-at91.c => i2c-at91-master.c} (67%)
 create mode 100644 drivers/i2c/busses/i2c-at91.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 82dc44b09a7e..d61941db6933 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9873,7 +9873,8 @@ MICROCHIP I2C DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
-F:	drivers/i2c/busses/i2c-at91.c
+F:	drivers/i2c/busses/i2c-at91.h
+F:	drivers/i2c/busses/i2c-at91-*.c
 
 MICROCHIP ISC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 5f0cb6915969..ea75a777940e 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
 obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
 obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
 obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
+i2c-at91-objs			:= i2c-at91-core.o i2c-at91-master.o
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
new file mode 100644
index 000000000000..5d9c6c81e6ab
--- /dev/null
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -0,0 +1,373 @@
+/*
+ *  i2c Support for Atmel's AT91 Two-Wire Interface (TWI)
+ *
+ *  Copyright (C) 2011 Weinmann Medical GmbH
+ *  Author: Nikolaus Voss <n.voss@weinmann.de>
+ *
+ *  Evolved from original work by:
+ *  Copyright (C) 2004 Rick Bronson
+ *  Converted to 2.6 by Andrew Victor <andrew@sanpeople.com>
+ *
+ *  Borrowed heavily from original work by:
+ *  Copyright (C) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "i2c-at91.h"
+
+unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg)
+{
+	return readl_relaxed(dev->base + reg);
+}
+
+void at91_twi_write(struct at91_twi_dev *dev, unsigned reg, unsigned val)
+{
+	writel_relaxed(val, dev->base + reg);
+}
+
+void at91_disable_twi_interrupts(struct at91_twi_dev *dev)
+{
+	at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_INT_MASK);
+}
+
+void at91_twi_irq_save(struct at91_twi_dev *dev)
+{
+	dev->imr = at91_twi_read(dev, AT91_TWI_IMR) & AT91_TWI_INT_MASK;
+	at91_disable_twi_interrupts(dev);
+}
+
+void at91_twi_irq_restore(struct at91_twi_dev *dev)
+{
+	at91_twi_write(dev, AT91_TWI_IER, dev->imr);
+}
+
+void at91_init_twi_bus(struct at91_twi_dev *dev)
+{
+	at91_disable_twi_interrupts(dev);
+	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
+
+	at91_init_twi_bus_master(dev);
+}
+
+static struct at91_twi_pdata at91rm9200_config = {
+	.clk_max_div = 5,
+	.clk_offset = 3,
+	.has_unre_flag = true,
+	.has_alt_cmd = false,
+	.has_hold_field = false,
+};
+
+static struct at91_twi_pdata at91sam9261_config = {
+	.clk_max_div = 5,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_alt_cmd = false,
+	.has_hold_field = false,
+};
+
+static struct at91_twi_pdata at91sam9260_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_alt_cmd = false,
+	.has_hold_field = false,
+};
+
+static struct at91_twi_pdata at91sam9g20_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_alt_cmd = false,
+	.has_hold_field = false,
+};
+
+static struct at91_twi_pdata at91sam9g10_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_alt_cmd = false,
+	.has_hold_field = false,
+};
+
+static const struct platform_device_id at91_twi_devtypes[] = {
+	{
+		.name = "i2c-at91rm9200",
+		.driver_data = (unsigned long) &at91rm9200_config,
+	}, {
+		.name = "i2c-at91sam9261",
+		.driver_data = (unsigned long) &at91sam9261_config,
+	}, {
+		.name = "i2c-at91sam9260",
+		.driver_data = (unsigned long) &at91sam9260_config,
+	}, {
+		.name = "i2c-at91sam9g20",
+		.driver_data = (unsigned long) &at91sam9g20_config,
+	}, {
+		.name = "i2c-at91sam9g10",
+		.driver_data = (unsigned long) &at91sam9g10_config,
+	}, {
+		/* sentinel */
+	}
+};
+
+#if defined(CONFIG_OF)
+static struct at91_twi_pdata at91sam9x5_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_alt_cmd = false,
+	.has_hold_field = false,
+};
+
+static struct at91_twi_pdata sama5d4_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_alt_cmd = false,
+	.has_hold_field = true,
+};
+
+static struct at91_twi_pdata sama5d2_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = true,
+	.has_alt_cmd = true,
+	.has_hold_field = true,
+};
+
+static const struct of_device_id atmel_twi_dt_ids[] = {
+	{
+		.compatible = "atmel,at91rm9200-i2c",
+		.data = &at91rm9200_config,
+	}, {
+		.compatible = "atmel,at91sam9260-i2c",
+		.data = &at91sam9260_config,
+	}, {
+		.compatible = "atmel,at91sam9261-i2c",
+		.data = &at91sam9261_config,
+	}, {
+		.compatible = "atmel,at91sam9g20-i2c",
+		.data = &at91sam9g20_config,
+	}, {
+		.compatible = "atmel,at91sam9g10-i2c",
+		.data = &at91sam9g10_config,
+	}, {
+		.compatible = "atmel,at91sam9x5-i2c",
+		.data = &at91sam9x5_config,
+	}, {
+		.compatible = "atmel,sama5d4-i2c",
+		.data = &sama5d4_config,
+	}, {
+		.compatible = "atmel,sama5d2-i2c",
+		.data = &sama5d2_config,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
+#endif
+
+static struct at91_twi_pdata *at91_twi_get_driver_data(
+					struct platform_device *pdev)
+{
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
+		if (!match)
+			return NULL;
+		return (struct at91_twi_pdata *)match->data;
+	}
+	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
+}
+
+static int at91_twi_probe(struct platform_device *pdev)
+{
+	struct at91_twi_dev *dev;
+	struct resource *mem;
+	int rc;
+	u32 phy_addr;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->dev = &pdev->dev;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+	phy_addr = mem->start;
+
+	dev->pdata = at91_twi_get_driver_data(pdev);
+	if (!dev->pdata)
+		return -ENODEV;
+
+	dev->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0)
+		return dev->irq;
+
+	platform_set_drvdata(pdev, dev);
+
+	dev->clk = devm_clk_get(dev->dev, NULL);
+	if (IS_ERR(dev->clk)) {
+		dev_err(dev->dev, "no clock defined\n");
+		return -ENODEV;
+	}
+	clk_prepare_enable(dev->clk);
+
+	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
+	i2c_set_adapdata(&dev->adapter, dev);
+	dev->adapter.owner = THIS_MODULE;
+	dev->adapter.class = I2C_CLASS_DEPRECATED;
+	dev->adapter.dev.parent = dev->dev;
+	dev->adapter.nr = pdev->id;
+	dev->adapter.timeout = AT91_I2C_TIMEOUT;
+	dev->adapter.dev.of_node = pdev->dev.of_node;
+
+	rc = at91_twi_probe_master(pdev, phy_addr, dev);
+	if (rc)
+		return rc;
+
+	at91_init_twi_bus(dev);
+
+	pm_runtime_set_autosuspend_delay(dev->dev, AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(dev->dev);
+	pm_runtime_set_active(dev->dev);
+	pm_runtime_enable(dev->dev);
+
+	rc = i2c_add_numbered_adapter(&dev->adapter);
+	if (rc) {
+		clk_disable_unprepare(dev->clk);
+
+		pm_runtime_disable(dev->dev);
+		pm_runtime_set_suspended(dev->dev);
+
+		return rc;
+	}
+
+	dev_info(dev->dev, "AT91 i2c bus driver (hw version: %#x).\n",
+		 at91_twi_read(dev, AT91_TWI_VER));
+	return 0;
+}
+
+static int at91_twi_remove(struct platform_device *pdev)
+{
+	struct at91_twi_dev *dev = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&dev->adapter);
+	clk_disable_unprepare(dev->clk);
+
+	pm_runtime_disable(dev->dev);
+	pm_runtime_set_suspended(dev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int at91_twi_runtime_suspend(struct device *dev)
+{
+	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(twi_dev->clk);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int at91_twi_runtime_resume(struct device *dev)
+{
+	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return clk_prepare_enable(twi_dev->clk);
+}
+
+static int at91_twi_suspend_noirq(struct device *dev)
+{
+	if (!pm_runtime_status_suspended(dev))
+		at91_twi_runtime_suspend(dev);
+
+	return 0;
+}
+
+static int at91_twi_resume_noirq(struct device *dev)
+{
+	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pm_runtime_status_suspended(dev)) {
+		ret = at91_twi_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_request_autosuspend(dev);
+
+	at91_init_twi_bus(twi_dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops at91_twi_pm = {
+	.suspend_noirq	= at91_twi_suspend_noirq,
+	.resume_noirq	= at91_twi_resume_noirq,
+	.runtime_suspend	= at91_twi_runtime_suspend,
+	.runtime_resume		= at91_twi_runtime_resume,
+};
+
+#define at91_twi_pm_ops (&at91_twi_pm)
+#else
+#define at91_twi_pm_ops NULL
+#endif
+
+static struct platform_driver at91_twi_driver = {
+	.probe		= at91_twi_probe,
+	.remove		= at91_twi_remove,
+	.id_table	= at91_twi_devtypes,
+	.driver		= {
+		.name	= "at91_i2c",
+		.of_match_table = of_match_ptr(atmel_twi_dt_ids),
+		.pm	= at91_twi_pm_ops,
+	},
+};
+
+static int __init at91_twi_init(void)
+{
+	return platform_driver_register(&at91_twi_driver);
+}
+
+static void __exit at91_twi_exit(void)
+{
+	platform_driver_unregister(&at91_twi_driver);
+}
+
+subsys_initcall(at91_twi_init);
+module_exit(at91_twi_exit);
+
+MODULE_AUTHOR("Nikolaus Voss <n.voss@weinmann.de>");
+MODULE_DESCRIPTION("I2C (TWI) driver for Atmel AT91");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:at91_i2c");
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91-master.c
similarity index 67%
rename from drivers/i2c/busses/i2c-at91.c
rename to drivers/i2c/busses/i2c-at91-master.c
index bc74184462c6..4ef335f95506 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -25,156 +25,15 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/platform_data/dma-atmel.h>
 #include <linux/pm_runtime.h>
-#include <linux/pinctrl/consumer.h>
-
-#define DEFAULT_TWI_CLK_HZ		100000		/* max 400 Kbits/s */
-#define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
-#define AT91_I2C_DMA_THRESHOLD	8			/* enable DMA if transfer size is bigger than this threshold */
-#define AUTOSUSPEND_TIMEOUT		2000
-#define AT91_I2C_MAX_ALT_CMD_DATA_SIZE	256
-
-/* AT91 TWI register definitions */
-#define	AT91_TWI_CR		0x0000	/* Control Register */
-#define	AT91_TWI_START		BIT(0)	/* Send a Start Condition */
-#define	AT91_TWI_STOP		BIT(1)	/* Send a Stop Condition */
-#define	AT91_TWI_MSEN		BIT(2)	/* Master Transfer Enable */
-#define	AT91_TWI_MSDIS		BIT(3)	/* Master Transfer Disable */
-#define	AT91_TWI_SVEN		BIT(4)	/* Slave Transfer Enable */
-#define	AT91_TWI_SVDIS		BIT(5)	/* Slave Transfer Disable */
-#define	AT91_TWI_QUICK		BIT(6)	/* SMBus quick command */
-#define	AT91_TWI_SWRST		BIT(7)	/* Software Reset */
-#define	AT91_TWI_ACMEN		BIT(16) /* Alternative Command Mode Enable */
-#define	AT91_TWI_ACMDIS		BIT(17) /* Alternative Command Mode Disable */
-#define	AT91_TWI_THRCLR		BIT(24) /* Transmit Holding Register Clear */
-#define	AT91_TWI_RHRCLR		BIT(25) /* Receive Holding Register Clear */
-#define	AT91_TWI_LOCKCLR	BIT(26) /* Lock Clear */
-#define	AT91_TWI_FIFOEN		BIT(28) /* FIFO Enable */
-#define	AT91_TWI_FIFODIS	BIT(29) /* FIFO Disable */
-
-#define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
-#define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
-#define	AT91_TWI_MREAD		BIT(12)	/* Master Read Direction */
-
-#define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
-
-#define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
-#define	AT91_TWI_CWGR_HOLD_MAX	0x1f
-#define	AT91_TWI_CWGR_HOLD(x)	(((x) & AT91_TWI_CWGR_HOLD_MAX) << 24)
-
-#define	AT91_TWI_SR		0x0020	/* Status Register */
-#define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
-#define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
-#define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
-#define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
-#define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
-#define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
-#define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
-
-#define	AT91_TWI_INT_MASK \
-	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
-
-#define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
-#define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
-#define	AT91_TWI_IMR		0x002c	/* Interrupt Mask Register */
-#define	AT91_TWI_RHR		0x0030	/* Receive Holding Register */
-#define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
-
-#define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
-#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
-#define	AT91_TWI_ACR_DIR	BIT(8)
-
-#define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
-#define	AT91_TWI_FMR_TXRDYM(mode)	(((mode) & 0x3) << 0)
-#define	AT91_TWI_FMR_TXRDYM_MASK	(0x3 << 0)
-#define	AT91_TWI_FMR_RXRDYM(mode)	(((mode) & 0x3) << 4)
-#define	AT91_TWI_FMR_RXRDYM_MASK	(0x3 << 4)
-#define	AT91_TWI_ONE_DATA	0x0
-#define	AT91_TWI_TWO_DATA	0x1
-#define	AT91_TWI_FOUR_DATA	0x2
-
-#define	AT91_TWI_FLR		0x0054	/* FIFO Level Register */
-
-#define	AT91_TWI_FSR		0x0060	/* FIFO Status Register */
-#define	AT91_TWI_FIER		0x0064	/* FIFO Interrupt Enable Register */
-#define	AT91_TWI_FIDR		0x0068	/* FIFO Interrupt Disable Register */
-#define	AT91_TWI_FIMR		0x006c	/* FIFO Interrupt Mask Register */
-
-#define	AT91_TWI_VER		0x00fc	/* Version Register */
-
-struct at91_twi_pdata {
-	unsigned clk_max_div;
-	unsigned clk_offset;
-	bool has_unre_flag;
-	bool has_alt_cmd;
-	bool has_hold_field;
-	struct at_dma_slave dma_slave;
-};
-
-struct at91_twi_dma {
-	struct dma_chan *chan_rx;
-	struct dma_chan *chan_tx;
-	struct scatterlist sg[2];
-	struct dma_async_tx_descriptor *data_desc;
-	enum dma_data_direction direction;
-	bool buf_mapped;
-	bool xfer_in_progress;
-};
-
-struct at91_twi_dev {
-	struct device *dev;
-	void __iomem *base;
-	struct completion cmd_complete;
-	struct clk *clk;
-	u8 *buf;
-	size_t buf_len;
-	struct i2c_msg *msg;
-	int irq;
-	unsigned imr;
-	unsigned transfer_status;
-	struct i2c_adapter adapter;
-	unsigned twi_cwgr_reg;
-	struct at91_twi_pdata *pdata;
-	bool use_dma;
-	bool use_alt_cmd;
-	bool recv_len_abort;
-	u32 fifo_size;
-	struct at91_twi_dma dma;
-};
-
-static unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg)
-{
-	return readl_relaxed(dev->base + reg);
-}
-
-static void at91_twi_write(struct at91_twi_dev *dev, unsigned reg, unsigned val)
-{
-	writel_relaxed(val, dev->base + reg);
-}
-
-static void at91_disable_twi_interrupts(struct at91_twi_dev *dev)
-{
-	at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_INT_MASK);
-}
-
-static void at91_twi_irq_save(struct at91_twi_dev *dev)
-{
-	dev->imr = at91_twi_read(dev, AT91_TWI_IMR) & AT91_TWI_INT_MASK;
-	at91_disable_twi_interrupts(dev);
-}
 
-static void at91_twi_irq_restore(struct at91_twi_dev *dev)
-{
-	at91_twi_write(dev, AT91_TWI_IER, dev->imr);
-}
+#include "i2c-at91.h"
 
-static void at91_init_twi_bus_master(struct at91_twi_dev *dev)
+void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 {
 	/* FIFO should be enabled immediately after the software reset */
 	if (dev->fifo_size)
@@ -184,14 +43,6 @@ static void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
 }
 
-static void at91_init_twi_bus(struct at91_twi_dev *dev)
-{
-	at91_disable_twi_interrupts(dev);
-	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
-
-	at91_init_twi_bus_master(dev);
-}
-
 /*
  * Calculate symmetric clock as stated in datasheet:
  * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
@@ -839,124 +690,6 @@ static const struct i2c_algorithm at91_twi_algorithm = {
 	.functionality	= at91_twi_func,
 };
 
-static struct at91_twi_pdata at91rm9200_config = {
-	.clk_max_div = 5,
-	.clk_offset = 3,
-	.has_unre_flag = true,
-	.has_alt_cmd = false,
-	.has_hold_field = false,
-};
-
-static struct at91_twi_pdata at91sam9261_config = {
-	.clk_max_div = 5,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_alt_cmd = false,
-	.has_hold_field = false,
-};
-
-static struct at91_twi_pdata at91sam9260_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_alt_cmd = false,
-	.has_hold_field = false,
-};
-
-static struct at91_twi_pdata at91sam9g20_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_alt_cmd = false,
-	.has_hold_field = false,
-};
-
-static struct at91_twi_pdata at91sam9g10_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_alt_cmd = false,
-	.has_hold_field = false,
-};
-
-static const struct platform_device_id at91_twi_devtypes[] = {
-	{
-		.name = "i2c-at91rm9200",
-		.driver_data = (unsigned long) &at91rm9200_config,
-	}, {
-		.name = "i2c-at91sam9261",
-		.driver_data = (unsigned long) &at91sam9261_config,
-	}, {
-		.name = "i2c-at91sam9260",
-		.driver_data = (unsigned long) &at91sam9260_config,
-	}, {
-		.name = "i2c-at91sam9g20",
-		.driver_data = (unsigned long) &at91sam9g20_config,
-	}, {
-		.name = "i2c-at91sam9g10",
-		.driver_data = (unsigned long) &at91sam9g10_config,
-	}, {
-		/* sentinel */
-	}
-};
-
-#if defined(CONFIG_OF)
-static struct at91_twi_pdata at91sam9x5_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_alt_cmd = false,
-	.has_hold_field = false,
-};
-
-static struct at91_twi_pdata sama5d4_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_alt_cmd = false,
-	.has_hold_field = true,
-};
-
-static struct at91_twi_pdata sama5d2_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = true,
-	.has_alt_cmd = true,
-	.has_hold_field = true,
-};
-
-static const struct of_device_id atmel_twi_dt_ids[] = {
-	{
-		.compatible = "atmel,at91rm9200-i2c",
-		.data = &at91rm9200_config,
-	} , {
-		.compatible = "atmel,at91sam9260-i2c",
-		.data = &at91sam9260_config,
-	} , {
-		.compatible = "atmel,at91sam9261-i2c",
-		.data = &at91sam9261_config,
-	} , {
-		.compatible = "atmel,at91sam9g20-i2c",
-		.data = &at91sam9g20_config,
-	} , {
-		.compatible = "atmel,at91sam9g10-i2c",
-		.data = &at91sam9g10_config,
-	}, {
-		.compatible = "atmel,at91sam9x5-i2c",
-		.data = &at91sam9x5_config,
-	}, {
-		.compatible = "atmel,sama5d4-i2c",
-		.data = &sama5d4_config,
-	}, {
-		.compatible = "atmel,sama5d2-i2c",
-		.data = &sama5d2_config,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
-#endif
-
 static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 {
 	int ret = 0;
@@ -1039,21 +772,8 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	return ret;
 }
 
-static struct at91_twi_pdata *at91_twi_get_driver_data(
-					struct platform_device *pdev)
-{
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
-		if (!match)
-			return NULL;
-		return (struct at91_twi_pdata *)match->data;
-	}
-	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
-}
-
-static int at91_twi_probe_master(struct platform_device *pdev,
-				 u32 phy_addr, struct at91_twi_dev *dev)
+int at91_twi_probe_master(struct platform_device *pdev,
+			  u32 phy_addr, struct at91_twi_dev *dev)
 {
 	int rc;
 	u32 bus_clk_rate;
@@ -1090,182 +810,3 @@ static int at91_twi_probe_master(struct platform_device *pdev,
 
 	return 0;
 }
-
-static int at91_twi_probe(struct platform_device *pdev)
-{
-	struct at91_twi_dev *dev;
-	struct resource *mem;
-	int rc;
-	u32 phy_addr;
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->dev = &pdev->dev;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -ENODEV;
-	phy_addr = mem->start;
-
-	dev->pdata = at91_twi_get_driver_data(pdev);
-	if (!dev->pdata)
-		return -ENODEV;
-
-	dev->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(dev->base))
-		return PTR_ERR(dev->base);
-
-	dev->irq = platform_get_irq(pdev, 0);
-	if (dev->irq < 0)
-		return dev->irq;
-
-	platform_set_drvdata(pdev, dev);
-
-	dev->clk = devm_clk_get(dev->dev, NULL);
-	if (IS_ERR(dev->clk)) {
-		dev_err(dev->dev, "no clock defined\n");
-		return -ENODEV;
-	}
-	rc = clk_prepare_enable(dev->clk);
-	if (rc)
-		return rc;
-
-	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
-	i2c_set_adapdata(&dev->adapter, dev);
-	dev->adapter.owner = THIS_MODULE;
-	dev->adapter.class = I2C_CLASS_DEPRECATED;
-	dev->adapter.dev.parent = dev->dev;
-	dev->adapter.nr = pdev->id;
-	dev->adapter.timeout = AT91_I2C_TIMEOUT;
-	dev->adapter.dev.of_node = pdev->dev.of_node;
-
-	rc = at91_twi_probe_master(pdev, phy_addr, dev);
-	if (rc)
-		return rc;
-
-	at91_init_twi_bus(dev);
-
-	pm_runtime_set_autosuspend_delay(dev->dev, AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(dev->dev);
-	pm_runtime_set_active(dev->dev);
-	pm_runtime_enable(dev->dev);
-
-	rc = i2c_add_numbered_adapter(&dev->adapter);
-	if (rc) {
-		clk_disable_unprepare(dev->clk);
-
-		pm_runtime_disable(dev->dev);
-		pm_runtime_set_suspended(dev->dev);
-
-		return rc;
-	}
-
-	dev_info(dev->dev, "AT91 i2c bus driver (hw version: %#x).\n",
-		 at91_twi_read(dev, AT91_TWI_VER));
-	return 0;
-}
-
-static int at91_twi_remove(struct platform_device *pdev)
-{
-	struct at91_twi_dev *dev = platform_get_drvdata(pdev);
-
-	i2c_del_adapter(&dev->adapter);
-	clk_disable_unprepare(dev->clk);
-
-	pm_runtime_disable(dev->dev);
-	pm_runtime_set_suspended(dev->dev);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-
-static int at91_twi_runtime_suspend(struct device *dev)
-{
-	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
-
-	clk_disable_unprepare(twi_dev->clk);
-
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-
-static int at91_twi_runtime_resume(struct device *dev)
-{
-	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
-
-	pinctrl_pm_select_default_state(dev);
-
-	return clk_prepare_enable(twi_dev->clk);
-}
-
-static int at91_twi_suspend_noirq(struct device *dev)
-{
-	if (!pm_runtime_status_suspended(dev))
-		at91_twi_runtime_suspend(dev);
-
-	return 0;
-}
-
-static int at91_twi_resume_noirq(struct device *dev)
-{
-	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
-	int ret;
-
-	if (!pm_runtime_status_suspended(dev)) {
-		ret = at91_twi_runtime_resume(dev);
-		if (ret)
-			return ret;
-	}
-
-	pm_runtime_mark_last_busy(dev);
-	pm_request_autosuspend(dev);
-
-	at91_init_twi_bus(twi_dev);
-
-	return 0;
-}
-
-static const struct dev_pm_ops at91_twi_pm = {
-	.suspend_noirq	= at91_twi_suspend_noirq,
-	.resume_noirq	= at91_twi_resume_noirq,
-	.runtime_suspend	= at91_twi_runtime_suspend,
-	.runtime_resume		= at91_twi_runtime_resume,
-};
-
-#define at91_twi_pm_ops (&at91_twi_pm)
-#else
-#define at91_twi_pm_ops NULL
-#endif
-
-static struct platform_driver at91_twi_driver = {
-	.probe		= at91_twi_probe,
-	.remove		= at91_twi_remove,
-	.id_table	= at91_twi_devtypes,
-	.driver		= {
-		.name	= "at91_i2c",
-		.of_match_table = of_match_ptr(atmel_twi_dt_ids),
-		.pm	= at91_twi_pm_ops,
-	},
-};
-
-static int __init at91_twi_init(void)
-{
-	return platform_driver_register(&at91_twi_driver);
-}
-
-static void __exit at91_twi_exit(void)
-{
-	platform_driver_unregister(&at91_twi_driver);
-}
-
-subsys_initcall(at91_twi_init);
-module_exit(at91_twi_exit);
-
-MODULE_AUTHOR("Nikolaus Voss <n.voss@weinmann.de>");
-MODULE_DESCRIPTION("I2C (TWI) driver for Atmel AT91");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:at91_i2c");
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
new file mode 100644
index 000000000000..555b1674ddbe
--- /dev/null
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -0,0 +1,151 @@
+/*
+ *  i2c Support for Atmel's AT91 Two-Wire Interface (TWI)
+ *
+ *  Copyright (C) 2011 Weinmann Medical GmbH
+ *  Author: Nikolaus Voss <n.voss@weinmann.de>
+ *
+ *  Evolved from original work by:
+ *  Copyright (C) 2004 Rick Bronson
+ *  Converted to 2.6 by Andrew Victor <andrew@sanpeople.com>
+ *
+ *  Borrowed heavily from original work by:
+ *  Copyright (C) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/i2c.h>
+#include <linux/platform_data/dma-atmel.h>
+#include <linux/platform_device.h>
+
+#define DEFAULT_TWI_CLK_HZ		100000		/* max 400 Kbits/s */
+#define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
+#define AT91_I2C_DMA_THRESHOLD	8			/* enable DMA if transfer size is bigger than this threshold */
+#define AUTOSUSPEND_TIMEOUT		2000
+#define AT91_I2C_MAX_ALT_CMD_DATA_SIZE	256
+
+/* AT91 TWI register definitions */
+#define	AT91_TWI_CR		0x0000	/* Control Register */
+#define	AT91_TWI_START		BIT(0)	/* Send a Start Condition */
+#define	AT91_TWI_STOP		BIT(1)	/* Send a Stop Condition */
+#define	AT91_TWI_MSEN		BIT(2)	/* Master Transfer Enable */
+#define	AT91_TWI_MSDIS		BIT(3)	/* Master Transfer Disable */
+#define	AT91_TWI_SVEN		BIT(4)	/* Slave Transfer Enable */
+#define	AT91_TWI_SVDIS		BIT(5)	/* Slave Transfer Disable */
+#define	AT91_TWI_QUICK		BIT(6)	/* SMBus quick command */
+#define	AT91_TWI_SWRST		BIT(7)	/* Software Reset */
+#define	AT91_TWI_ACMEN		BIT(16) /* Alternative Command Mode Enable */
+#define	AT91_TWI_ACMDIS		BIT(17) /* Alternative Command Mode Disable */
+#define	AT91_TWI_THRCLR		BIT(24) /* Transmit Holding Register Clear */
+#define	AT91_TWI_RHRCLR		BIT(25) /* Receive Holding Register Clear */
+#define	AT91_TWI_LOCKCLR	BIT(26) /* Lock Clear */
+#define	AT91_TWI_FIFOEN		BIT(28) /* FIFO Enable */
+#define	AT91_TWI_FIFODIS	BIT(29) /* FIFO Disable */
+
+#define	AT91_TWI_MMR		0x0004	/* Master Mode Register */
+#define	AT91_TWI_IADRSZ_1	0x0100	/* Internal Device Address Size */
+#define	AT91_TWI_MREAD		BIT(12)	/* Master Read Direction */
+
+#define	AT91_TWI_IADR		0x000c	/* Internal Address Register */
+
+#define	AT91_TWI_CWGR		0x0010	/* Clock Waveform Generator Reg */
+#define	AT91_TWI_CWGR_HOLD_MAX	0x1f
+#define	AT91_TWI_CWGR_HOLD(x)	(((x) & AT91_TWI_CWGR_HOLD_MAX) << 24)
+
+#define	AT91_TWI_SR		0x0020	/* Status Register */
+#define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
+#define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
+#define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
+#define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
+#define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
+#define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
+#define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
+
+#define	AT91_TWI_INT_MASK \
+	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
+
+#define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
+#define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
+#define	AT91_TWI_IMR		0x002c	/* Interrupt Mask Register */
+#define	AT91_TWI_RHR		0x0030	/* Receive Holding Register */
+#define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
+
+#define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
+#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
+#define	AT91_TWI_ACR_DIR	BIT(8)
+
+#define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
+#define	AT91_TWI_FMR_TXRDYM(mode)	(((mode) & 0x3) << 0)
+#define	AT91_TWI_FMR_TXRDYM_MASK	(0x3 << 0)
+#define	AT91_TWI_FMR_RXRDYM(mode)	(((mode) & 0x3) << 4)
+#define	AT91_TWI_FMR_RXRDYM_MASK	(0x3 << 4)
+#define	AT91_TWI_ONE_DATA	0x0
+#define	AT91_TWI_TWO_DATA	0x1
+#define	AT91_TWI_FOUR_DATA	0x2
+
+#define	AT91_TWI_FLR		0x0054	/* FIFO Level Register */
+
+#define	AT91_TWI_FSR		0x0060	/* FIFO Status Register */
+#define	AT91_TWI_FIER		0x0064	/* FIFO Interrupt Enable Register */
+#define	AT91_TWI_FIDR		0x0068	/* FIFO Interrupt Disable Register */
+#define	AT91_TWI_FIMR		0x006c	/* FIFO Interrupt Mask Register */
+
+#define	AT91_TWI_VER		0x00fc	/* Version Register */
+
+struct at91_twi_pdata {
+	unsigned clk_max_div;
+	unsigned clk_offset;
+	bool has_unre_flag;
+	bool has_alt_cmd;
+	bool has_hold_field;
+	struct at_dma_slave dma_slave;
+};
+
+struct at91_twi_dma {
+	struct dma_chan *chan_rx;
+	struct dma_chan *chan_tx;
+	struct scatterlist sg[2];
+	struct dma_async_tx_descriptor *data_desc;
+	enum dma_data_direction direction;
+	bool buf_mapped;
+	bool xfer_in_progress;
+};
+
+struct at91_twi_dev {
+	struct device *dev;
+	void __iomem *base;
+	struct completion cmd_complete;
+	struct clk *clk;
+	u8 *buf;
+	size_t buf_len;
+	struct i2c_msg *msg;
+	int irq;
+	unsigned imr;
+	unsigned transfer_status;
+	struct i2c_adapter adapter;
+	unsigned twi_cwgr_reg;
+	struct at91_twi_pdata *pdata;
+	bool use_dma;
+	bool use_alt_cmd;
+	bool recv_len_abort;
+	u32 fifo_size;
+	struct at91_twi_dma dma;
+};
+
+unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg);
+void at91_twi_write(struct at91_twi_dev *dev, unsigned reg, unsigned val);
+void at91_disable_twi_interrupts(struct at91_twi_dev *dev);
+void at91_twi_irq_save(struct at91_twi_dev *dev);
+void at91_twi_irq_restore(struct at91_twi_dev *dev);
+void at91_init_twi_bus(struct at91_twi_dev *dev);
+
+void at91_init_twi_bus_master(struct at91_twi_dev *dev);
+int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
+			  struct at91_twi_dev *dev);
-- 
2.20.1

