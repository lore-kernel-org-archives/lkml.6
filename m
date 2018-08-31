Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E678C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E672083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E672083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeHaRsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:48:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58967 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeHaRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:48:22 -0400
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="16999767"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 06:40:49 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 06:40:48 -0700
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
Subject: [RESEND PATCH v11 6/6] tty/serial: atmel: change the driver to work under at91-usart mfd
Date:   Fri, 31 Aug 2018 16:41:41 +0300
Message-ID: <20180831134141.9335-7-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831134141.9335-1-radu.pirea@microchip.com>
References: <20180831134141.9335-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the place where resources and device tree properties
are searched.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig        |  1 +
 drivers/tty/serial/atmel_serial.c | 42 ++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index df8bd0c7b97d..32886c304641 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -118,6 +118,7 @@ config SERIAL_ATMEL
 	depends on ARCH_AT91 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
+	select MFD_AT91_USART
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
 	  AT91 processors.
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8e4428725848..267d4d1de3f8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -193,8 +193,7 @@ static struct console atmel_console;
 
 #if defined(CONFIG_OF)
 static const struct of_device_id atmel_serial_dt_ids[] = {
-	{ .compatible = "atmel,at91rm9200-usart" },
-	{ .compatible = "atmel,at91sam9260-usart" },
+	{ .compatible = "atmel,at91rm9200-usart-serial" },
 	{ /* sentinel */ }
 };
 #endif
@@ -915,6 +914,7 @@ static void atmel_tx_dma(struct uart_port *port)
 static int atmel_prepare_tx_dma(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct device *mfd_dev = port->dev->parent;
 	dma_cap_mask_t		mask;
 	struct dma_slave_config config;
 	int ret, nent;
@@ -922,7 +922,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	atmel_port->chan_tx = dma_request_slave_channel(port->dev, "tx");
+	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
 	if (atmel_port->chan_tx == NULL)
 		goto chan_err;
 	dev_info(port->dev, "using %s for tx DMA transfers\n",
@@ -1093,6 +1093,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 static int atmel_prepare_rx_dma(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct device *mfd_dev = port->dev->parent;
 	struct dma_async_tx_descriptor *desc;
 	dma_cap_mask_t		mask;
 	struct dma_slave_config config;
@@ -1104,7 +1105,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_CYCLIC, mask);
 
-	atmel_port->chan_rx = dma_request_slave_channel(port->dev, "rx");
+	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
 	if (atmel_port->chan_rx == NULL)
 		goto chan_err;
 	dev_info(port->dev, "using %s for rx DMA transfers\n",
@@ -2222,8 +2223,8 @@ static const char *atmel_type(struct uart_port *port)
  */
 static void atmel_release_port(struct uart_port *port)
 {
-	struct platform_device *pdev = to_platform_device(port->dev);
-	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
+	struct platform_device *mpdev = to_platform_device(port->dev->parent);
+	int size = resource_size(mpdev->resource);
 
 	release_mem_region(port->mapbase, size);
 
@@ -2238,8 +2239,8 @@ static void atmel_release_port(struct uart_port *port)
  */
 static int atmel_request_port(struct uart_port *port)
 {
-	struct platform_device *pdev = to_platform_device(port->dev);
-	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
+	struct platform_device *mpdev = to_platform_device(port->dev->parent);
+	int size = resource_size(mpdev->resource);
 
 	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
 		return -EBUSY;
@@ -2341,27 +2342,28 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 {
 	int ret;
 	struct uart_port *port = &atmel_port->uart;
+	struct platform_device *mpdev = to_platform_device(pdev->dev.parent);
 
 	atmel_init_property(atmel_port, pdev);
 	atmel_set_ops(port);
 
-	uart_get_rs485_mode(&pdev->dev, &port->rs485);
+	uart_get_rs485_mode(&mpdev->dev, &port->rs485);
 
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops		= &atmel_pops;
 	port->fifosize		= 1;
 	port->dev		= &pdev->dev;
-	port->mapbase	= pdev->resource[0].start;
-	port->irq	= pdev->resource[1].start;
+	port->mapbase		= mpdev->resource[0].start;
+	port->irq		= mpdev->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
-	port->membase	= NULL;
+	port->membase		= NULL;
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
 	/* for console, the clock could already be configured */
 	if (!atmel_port->clk) {
-		atmel_port->clk = clk_get(&pdev->dev, "usart");
+		atmel_port->clk = clk_get(&mpdev->dev, "usart");
 		if (IS_ERR(atmel_port->clk)) {
 			ret = PTR_ERR(atmel_port->clk);
 			atmel_port->clk = NULL;
@@ -2694,13 +2696,22 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
 static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *atmel_port;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.parent->of_node;
 	void *data;
 	int ret = -ENODEV;
 	bool rs485_enabled;
 
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
 
+	/*
+	 * In device tree there is no node with "atmel,at91rm9200-usart-serial"
+	 * as compatible string. This driver is probed by at91-usart mfd driver
+	 * which is just a wrapper over the atmel_serial driver and
+	 * spi-at91-usart driver. All attributes needed by this driver are
+	 * found in of_node of parent.
+	 */
+	pdev->dev.of_node = np;
+
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0)
 		/* port id not found in platform data nor device-tree aliases:
@@ -2836,6 +2847,7 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	clk_put(atmel_port->clk);
 	atmel_port->clk = NULL;
+	pdev->dev.of_node = NULL;
 
 	return ret;
 }
@@ -2846,7 +2858,7 @@ static struct platform_driver atmel_serial_driver = {
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
 	.driver		= {
-		.name			= "atmel_usart",
+		.name			= "atmel_usart_serial",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
 	},
 };
-- 
2.18.0

