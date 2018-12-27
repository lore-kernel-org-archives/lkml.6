Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75393C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F129208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeL0PN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:13:27 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:65339 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeL0PN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:13:26 -0500
X-IronPort-AV: E=Sophos;i="5.56,405,1539673200"; 
   d="scan'208";a="24405605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Dec 2018 08:13:25 -0700
Received: from M43218.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Thu, 27 Dec 2018 08:13:49 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <me@jue.yt>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <wsa@the-dreams.de>, <andriy.shevchenko@linux.intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v4 1/3] i2c: at91: segregate master mode specific code from probe and init func
Date:   Thu, 27 Dec 2018 16:13:09 +0100
Message-ID: <20181227151311.20107-2-ludovic.desroches@microchip.com>
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

In order to implement slave mode support for the at91 hardware we have to
segregate all master mode specific function parts from the general parts.
The upcoming slave mode patch will call its sepcific probe resp. init
function instead of the master mode functions after the shared general
code has been executed.

This concept has been influenced by the i2c-designware driver.

Signed-off-by: Juergen Fitschen <me@jue.yt>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 90 +++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3bf5ff..bc74184462c6 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -174,10 +174,8 @@ static void at91_twi_irq_restore(struct at91_twi_dev *dev)
 	at91_twi_write(dev, AT91_TWI_IER, dev->imr);
 }
 
-static void at91_init_twi_bus(struct at91_twi_dev *dev)
+static void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 {
-	at91_disable_twi_interrupts(dev);
-	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
 	/* FIFO should be enabled immediately after the software reset */
 	if (dev->fifo_size)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_FIFOEN);
@@ -186,6 +184,14 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
 	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
 }
 
+static void at91_init_twi_bus(struct at91_twi_dev *dev)
+{
+	at91_disable_twi_interrupts(dev);
+	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
+
+	at91_init_twi_bus_master(dev);
+}
+
 /*
  * Calculate symmetric clock as stated in datasheet:
  * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
@@ -1046,18 +1052,56 @@ static struct at91_twi_pdata *at91_twi_get_driver_data(
 	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
 }
 
+static int at91_twi_probe_master(struct platform_device *pdev,
+				 u32 phy_addr, struct at91_twi_dev *dev)
+{
+	int rc;
+	u32 bus_clk_rate;
+
+	init_completion(&dev->cmd_complete);
+
+	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
+			      dev_name(dev->dev), dev);
+	if (rc) {
+		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
+		return rc;
+	}
+
+	if (dev->dev->of_node) {
+		rc = at91_twi_configure_dma(dev, phy_addr);
+		if (rc == -EPROBE_DEFER)
+			return rc;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
+				  &dev->fifo_size)) {
+		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
+	}
+
+	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
+				  &bus_clk_rate);
+	if (rc)
+		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
+
+	at91_calc_twi_clock(dev, bus_clk_rate);
+
+	dev->adapter.algo = &at91_twi_algorithm;
+	dev->adapter.quirks = &at91_twi_quirks;
+
+	return 0;
+}
+
 static int at91_twi_probe(struct platform_device *pdev)
 {
 	struct at91_twi_dev *dev;
 	struct resource *mem;
 	int rc;
 	u32 phy_addr;
-	u32 bus_clk_rate;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-	init_completion(&dev->cmd_complete);
+
 	dev->dev = &pdev->dev;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1077,13 +1121,6 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (dev->irq < 0)
 		return dev->irq;
 
-	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
-			 dev_name(dev->dev), dev);
-	if (rc) {
-		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
-		return rc;
-	}
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
@@ -1095,38 +1132,21 @@ static int at91_twi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	if (dev->dev->of_node) {
-		rc = at91_twi_configure_dma(dev, phy_addr);
-		if (rc == -EPROBE_DEFER) {
-			clk_disable_unprepare(dev->clk);
-			return rc;
-		}
-	}
-
-	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
-				  &dev->fifo_size)) {
-		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
-	}
-
-	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
-			&bus_clk_rate);
-	if (rc)
-		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
-
-	at91_calc_twi_clock(dev, bus_clk_rate);
-	at91_init_twi_bus(dev);
-
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
 	i2c_set_adapdata(&dev->adapter, dev);
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_DEPRECATED;
-	dev->adapter.algo = &at91_twi_algorithm;
-	dev->adapter.quirks = &at91_twi_quirks;
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node = pdev->dev.of_node;
 
+	rc = at91_twi_probe_master(pdev, phy_addr, dev);
+	if (rc)
+		return rc;
+
+	at91_init_twi_bus(dev);
+
 	pm_runtime_set_autosuspend_delay(dev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev->dev);
 	pm_runtime_set_active(dev->dev);
-- 
2.20.1

