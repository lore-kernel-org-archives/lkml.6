Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229FC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764162083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Au6zJksi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764162083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIAUzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:55:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40707 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeIAUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:55:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so2298492pga.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u9S+IwXTtUPV4JAD8SAdBcU3BcDCxDZSRNqvDApyuVs=;
        b=Au6zJksi6D9iGdXcT2McWgmo2L2zMae3MmfDikzgKrtZmdX78qdupVjqbazXLZc6Ze
         OtaSIFOnfHSNRCDrsaQkw3c5B6CJr5KhLaJ2zsvgs1p6YnMTe69MM44l9+72OwJzdZUt
         bLYVMRITi1FpyuhzRPWJva3ctxSA8ALebqbRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u9S+IwXTtUPV4JAD8SAdBcU3BcDCxDZSRNqvDApyuVs=;
        b=iI3gfCDx9tr+kZnfGPV+T+awg6yGo1Ox9/B6P9xdmvW1TC+QCboj0ZLHNq+U6o5eEP
         zUzzBE5UUf1gONG420n4yHbhT0RiPsaX7EvJ1X+sMpKYJHR0AyLgbGWSrTXYIPm3a5xp
         9XTka7uDkwgKkQyi0JXQIyohopAvUv0YAk6Vxw483SpRdiWNnfXHYdbRK+KxWNkFLszv
         r5MnUXQ/woLo3+CBNtIKk5IjYDiFFOtqq3nWPTGRXqJoAME6oE21jVp01AK0B7GYcZgx
         SlYMMxIG4X/GxrMK5xMARFEou3ZyxQNrHcN9lzFJjxbbQunTWzMEz1ct1ihAnlIC9jDD
         fdZA==
X-Gm-Message-State: APzg51BvxlQSwz9KcXe0grQqrHMtMHPrCtnqeku7ceQU/t1dWcTqj+iU
        fg28Eh99XSbJ5Rc6sMMGkStX
X-Google-Smtp-Source: ANB0VdaaPmi3WP4tjBn9ofAvsghpbJQZ906qEwUj6czGtti5lUJMQYlmbhLqcazdJlKS5/rBOYZNnA==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr19198370pgc.344.1535820192555;
        Sat, 01 Sep 2018 09:43:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:724a:4d47:6510:16:9ba1:39a3])
        by smtp.gmail.com with ESMTPSA id y7-v6sm23763595pff.181.2018.09.01.09.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:43:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] tty: serial: Add Tx DMA support for UART in Actions Semi Owl SoCs
Date:   Sat,  1 Sep 2018 22:12:15 +0530
Message-Id: <20180901164215.3683-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
References: <20180901164215.3683-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Tx DMA support for Actions Semi Owl SoCs. If there is no DMA
property specified in DT, it will fallback to default interrupt mode.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/tty/serial/owl-uart.c | 172 +++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23..1b3016db7ae2 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -11,6 +11,8 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -48,6 +50,8 @@
 #define OWL_UART_CTL_RXIE		BIT(18)
 #define OWL_UART_CTL_TXIE		BIT(19)
 #define OWL_UART_CTL_LBEN		BIT(20)
+#define OWL_UART_CTL_DRCR		BIT(21)
+#define OWL_UART_CTL_DTCR		BIT(22)
 
 #define OWL_UART_STAT_RIP		BIT(0)
 #define OWL_UART_STAT_TIP		BIT(1)
@@ -71,12 +75,21 @@ struct owl_uart_info {
 struct owl_uart_port {
 	struct uart_port port;
 	struct clk *clk;
+
+	struct dma_chan *tx_ch;
+	dma_addr_t tx_dma_buf;
+	dma_cookie_t dma_tx_cookie;
+	u32 tx_size;
+	bool tx_dma;
+	bool dma_tx_running;
 };
 
 #define to_owl_uart_port(prt) container_of(prt, struct owl_uart_port, prt)
 
 static struct owl_uart_port *owl_uart_ports[OWL_UART_PORT_NUM];
 
+static void owl_uart_dma_start_tx(struct owl_uart_port *owl_port);
+
 static inline void owl_uart_write(struct uart_port *port, u32 val, unsigned int off)
 {
 	writel(val, port->membase + off);
@@ -115,6 +128,83 @@ static unsigned int owl_uart_get_mctrl(struct uart_port *port)
 	return mctrl;
 }
 
+static void owl_uart_dma_tx_callback(void *data)
+{
+	struct owl_uart_port *owl_port = data;
+	struct uart_port *port = &owl_port->port;
+	struct circ_buf	*xmit = &port->state->xmit;
+	unsigned long flags;
+	u32 val;
+
+	dma_sync_single_for_cpu(port->dev, owl_port->tx_dma_buf,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	owl_port->dma_tx_running = 0;
+
+	xmit->tail += owl_port->tx_size;
+	xmit->tail &= UART_XMIT_SIZE - 1;
+	port->icount.tx += owl_port->tx_size;
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	/* Disable Tx DRQ */
+	val = owl_uart_read(port, OWL_UART_CTL);
+	val &= ~OWL_UART_CTL_TXDE;
+	owl_uart_write(port, val, OWL_UART_CTL);
+
+	/* Clear pending Tx IRQ */
+	val = owl_uart_read(port, OWL_UART_STAT);
+	val |= OWL_UART_STAT_TIP;
+	owl_uart_write(port, val, OWL_UART_STAT);
+
+	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port))
+		owl_uart_dma_start_tx(owl_port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void owl_uart_dma_start_tx(struct owl_uart_port *owl_port)
+{
+	struct uart_port *port = &owl_port->port;
+	struct circ_buf *xmit = &port->state->xmit;
+	struct dma_async_tx_descriptor *desc;
+	u32 val;
+
+	if (uart_tx_stopped(port) || uart_circ_empty(xmit) ||
+	    owl_port->dma_tx_running)
+		return;
+
+	dma_sync_single_for_device(port->dev, owl_port->tx_dma_buf,
+				   UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	owl_port->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail,
+					    UART_XMIT_SIZE);
+
+	desc = dmaengine_prep_slave_single(owl_port->tx_ch,
+					   owl_port->tx_dma_buf + xmit->tail,
+					   owl_port->tx_size, DMA_MEM_TO_DEV,
+					   DMA_PREP_INTERRUPT);
+	if (!desc)
+		return;
+
+	desc->callback = owl_uart_dma_tx_callback;
+	desc->callback_param = owl_port;
+
+	/* Enable Tx DRQ */
+	val = owl_uart_read(port, OWL_UART_CTL);
+	val &= ~OWL_UART_CTL_TXIE;
+	val |= OWL_UART_CTL_TXDE | OWL_UART_CTL_DTCR;
+	owl_uart_write(port, val, OWL_UART_CTL);
+
+	/* Start Tx DMA transfer */
+	owl_port->dma_tx_running = true;
+	owl_port->dma_tx_cookie = dmaengine_submit(desc);
+	dma_async_issue_pending(owl_port->tx_ch);
+}
+
 static unsigned int owl_uart_tx_empty(struct uart_port *port)
 {
 	unsigned long flags;
@@ -159,6 +249,7 @@ static void owl_uart_stop_tx(struct uart_port *port)
 
 static void owl_uart_start_tx(struct uart_port *port)
 {
+	struct owl_uart_port *owl_port = to_owl_uart_port(port);
 	u32 val;
 
 	if (uart_tx_stopped(port)) {
@@ -166,6 +257,11 @@ static void owl_uart_start_tx(struct uart_port *port)
 		return;
 	}
 
+	if (owl_port->tx_dma) {
+		owl_uart_dma_start_tx(owl_port);
+		return;
+	}
+
 	val = owl_uart_read(port, OWL_UART_STAT);
 	val |= OWL_UART_STAT_TIP;
 	owl_uart_write(port, val, OWL_UART_STAT);
@@ -273,13 +369,27 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void owl_dma_channel_free(struct owl_uart_port *owl_port)
+{
+	dmaengine_terminate_all(owl_port->tx_ch);
+	dma_release_channel(owl_port->tx_ch);
+	dma_unmap_single(owl_port->port.dev, owl_port->tx_dma_buf,
+			 UART_XMIT_SIZE, DMA_TO_DEVICE);
+	owl_port->dma_tx_running = false;
+	owl_port->tx_ch = NULL;
+}
+
 static void owl_uart_shutdown(struct uart_port *port)
 {
-	u32 val;
+	struct owl_uart_port *owl_port = to_owl_uart_port(port);
 	unsigned long flags;
+	u32 val;
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	if (owl_port->tx_dma)
+		owl_dma_channel_free(owl_port);
+
 	val = owl_uart_read(port, OWL_UART_CTL);
 	val &= ~(OWL_UART_CTL_TXIE | OWL_UART_CTL_RXIE
 		| OWL_UART_CTL_TXDE | OWL_UART_CTL_RXDE | OWL_UART_CTL_EN);
@@ -290,6 +400,62 @@ static void owl_uart_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
+static int owl_uart_dma_tx_init(struct uart_port *port)
+{
+	struct owl_uart_port *owl_port = to_owl_uart_port(port);
+	struct device *dev = port->dev;
+	struct dma_slave_config slave_config;
+	int ret;
+
+	owl_port->tx_dma = false;
+
+	/* Request DMA TX channel */
+	owl_port->tx_ch = dma_request_slave_channel(dev, "tx");
+	if (!owl_port->tx_ch) {
+		dev_info(dev, "tx dma alloc failed\n");
+		return -ENODEV;
+	}
+
+	owl_port->tx_dma_buf = dma_map_single(dev,
+					      owl_port->port.state->xmit.buf,
+					      UART_XMIT_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, owl_port->tx_dma_buf)) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+
+	/* Configure DMA channel */
+	memset(&slave_config, 0, sizeof(slave_config));
+	slave_config.direction = DMA_MEM_TO_DEV;
+	slave_config.dst_addr = port->mapbase + OWL_UART_TXDAT;
+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
+	ret = dmaengine_slave_config(owl_port->tx_ch, &slave_config);
+	if (ret < 0) {
+		dev_err(dev, "tx dma channel config failed\n");
+		ret = -ENODEV;
+		goto map_err;
+	}
+
+	/* Use DMA buffer size as the FIFO size */
+	port->fifosize = UART_XMIT_SIZE;
+
+	/* Set DMA flag */
+	owl_port->tx_dma = true;
+	owl_port->dma_tx_running = false;
+
+	return 0;
+
+map_err:
+	dma_unmap_single(dev, owl_port->tx_dma_buf, UART_XMIT_SIZE,
+			 DMA_TO_DEVICE);
+alloc_err:
+	dma_release_channel(owl_port->tx_ch);
+	owl_port->tx_ch = NULL;
+
+	return ret;
+}
+
 static int owl_uart_startup(struct uart_port *port)
 {
 	u32 val;
@@ -301,6 +467,10 @@ static int owl_uart_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
+	ret = owl_uart_dma_tx_init(port);
+	if (!ret)
+		dev_info(port->dev, "using DMA for tx\n");
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	val = owl_uart_read(port, OWL_UART_STAT);
-- 
2.17.1

