Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA1ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E5921523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5921523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeITMXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:23:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45537 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731388AbeITMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:23:40 -0400
X-UUID: 0323f2d4d4e14daf89461573ce1bc2cd-20180920
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1757115165; Thu, 20 Sep 2018 14:41:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 20 Sep 2018 14:41:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 20 Sep 2018 14:41:37 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ed Blake <ed.blake@sondrel.com>,
        Long Cheng <long.cheng@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH 3/4] serial: 8250-mtk: add uart DMA support
Date:   Thu, 20 Sep 2018 14:41:12 +0800
Message-ID: <1537425673-18807-4-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
References: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8A97C2F15F2FFBAFE5C69D506CCA2A1392CF79244FC1BEB74C8297A8F4C0F8C42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify uart register to support DMA function.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c |  211 +++++++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index dd5e1ce..9da9db4 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -14,6 +14,10 @@
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/console.h>
+#include <linux/dma-mapping.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #include "8250.h"
 
@@ -22,12 +26,173 @@
 #define UART_MTK_SAMPLE_POINT	0x0b	/* Sample point register */
 #define MTK_UART_RATE_FIX	0x0d	/* UART Rate Fix Register */
 
+#define MTK_UART_DMA_EN		0x13	/* DMA Enable register */
+#define MTK_UART_DMA_EN_TX	0x2
+#define MTK_UART_DMA_EN_RX	0x5
+
+#define MTK_UART_TX_SIZE	UART_XMIT_SIZE
+#define MTK_UART_RX_SIZE	0x8000
+#define MTK_UART_TX_TRIGGER	1
+#define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
+
+#ifdef CONFIG_SERIAL_8250_DMA
+enum dma_rx_status {
+	DMA_RX_START = 0,
+	DMA_RX_RUNNING = 1,
+	DMA_RX_SHUTDOWN = 2,
+};
+#endif
+
 struct mtk8250_data {
 	int			line;
+	unsigned int		rx_pos;
 	struct clk		*uart_clk;
 	struct clk		*bus_clk;
+	struct uart_8250_dma	*dma;
+#ifdef CONFIG_SERIAL_8250_DMA
+	enum dma_rx_status	rx_status;
+#endif
 };
 
+#ifdef CONFIG_SERIAL_8250_DMA
+static void mtk8250_rx_dma(struct uart_8250_port *up);
+
+static void mtk8250_dma_rx_complete(void *param)
+{
+	struct uart_8250_port *up = param;
+	struct uart_8250_dma *dma = up->dma;
+	struct mtk8250_data *data = up->port.private_data;
+	struct tty_port *tty_port = &up->port.state->port;
+	struct dma_tx_state state;
+	unsigned char *ptr;
+	int copied;
+
+	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
+				dma->rx_size, DMA_FROM_DEVICE);
+
+	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	dmaengine_terminate_all(dma->rxchan);
+
+	if (data->rx_status == DMA_RX_SHUTDOWN)
+		return;
+
+	if ((data->rx_pos + state.residue) <= dma->rx_size) {
+		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
+		copied = tty_insert_flip_string(tty_port, ptr, state.residue);
+	} else {
+		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
+		copied = tty_insert_flip_string(tty_port, ptr,
+						dma->rx_size - data->rx_pos);
+		ptr = (unsigned char *)(dma->rx_buf);
+		copied += tty_insert_flip_string(tty_port, ptr,
+				data->rx_pos + state.residue - dma->rx_size);
+	}
+	up->port.icount.rx += copied;
+
+	tty_flip_buffer_push(tty_port);
+
+	mtk8250_rx_dma(up);
+}
+
+static void mtk8250_rx_dma(struct uart_8250_port *up)
+{
+	struct uart_8250_dma *dma = up->dma;
+	struct mtk8250_data *data = up->port.private_data;
+	struct dma_async_tx_descriptor	*desc;
+	struct dma_tx_state	 state;
+
+	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
+					   dma->rx_size, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		pr_err("failed to prepare rx slave single\n");
+		return;
+	}
+
+	desc->callback = mtk8250_dma_rx_complete;
+	desc->callback_param = up;
+
+	dma->rx_cookie = dmaengine_submit(desc);
+
+	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	data->rx_pos = state.residue;
+
+	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
+				   dma->rx_size, DMA_FROM_DEVICE);
+
+	dma_async_issue_pending(dma->rxchan);
+}
+
+static void mtk8250_dma_enable(struct uart_8250_port *up)
+{
+	struct uart_8250_dma *dma = up->dma;
+	struct mtk8250_data *data = up->port.private_data;
+	int lcr = serial_in(up, UART_LCR);
+
+	if (data->rx_status != DMA_RX_START)
+		return;
+
+	dma->rxconf.direction		= DMA_DEV_TO_MEM;
+	dma->rxconf.src_addr_width	= dma->rx_size / 1024;
+	dma->rxconf.src_addr		= dma->rx_addr;
+
+	dma->txconf.direction		= DMA_MEM_TO_DEV;
+	dma->txconf.dst_addr_width	= MTK_UART_TX_SIZE / 1024;
+	dma->txconf.dst_addr		= dma->tx_addr;
+
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+		UART_FCR_CLEAR_XMIT);
+	serial_out(up, MTK_UART_DMA_EN,
+		   MTK_UART_DMA_EN_RX | MTK_UART_DMA_EN_TX);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, UART_LCR, lcr);
+
+	if (dmaengine_slave_config(dma->rxchan, &dma->rxconf) != 0)
+		pr_err("failed to configure rx dma channel\n");
+	if (dmaengine_slave_config(dma->txchan, &dma->txconf) != 0)
+		pr_err("failed to configure tx dma channel\n");
+
+	data->rx_status = DMA_RX_RUNNING;
+	data->rx_pos = 0;
+	mtk8250_rx_dma(up);
+}
+#endif
+
+static int mtk8250_startup(struct uart_port *port)
+{
+#ifdef CONFIG_SERIAL_8250_DMA
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct mtk8250_data *data = port->private_data;
+
+	/* disable DMA for console */
+	if (uart_console(port))
+		up->dma = NULL;
+
+	if (up->dma) {
+		data->rx_status = DMA_RX_START;
+		uart_circ_clear(&port->state->xmit);
+	}
+#endif
+	memset(&port->icount, 0, sizeof(port->icount));
+
+	return serial8250_do_startup(port);
+}
+
+static void mtk8250_shutdown(struct uart_port *port)
+{
+#ifdef CONFIG_SERIAL_8250_DMA
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct mtk8250_data *data = port->private_data;
+
+	if (up->dma)
+		data->rx_status = DMA_RX_SHUTDOWN;
+#endif
+
+	return serial8250_do_shutdown(port);
+}
+
 static void
 mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
@@ -36,6 +201,17 @@ struct mtk8250_data {
 	unsigned long flags;
 	unsigned int baud, quot;
 
+#ifdef CONFIG_SERIAL_8250_DMA
+	if (up->dma) {
+		if (uart_console(port)) {
+			devm_kfree(up->port.dev, up->dma);
+			up->dma = NULL;
+		} else {
+			mtk8250_dma_enable(up);
+		}
+	}
+#endif
+
 	serial8250_do_set_termios(port, termios, old);
 
 	/*
@@ -143,9 +319,20 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 		pm_runtime_put_sync_suspend(port->dev);
 }
 
+#ifdef CONFIG_SERIAL_8250_DMA
+static bool mtk8250_dma_filter(struct dma_chan *chan, void *param)
+{
+	return false;
+}
+#endif
+
 static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 			   struct mtk8250_data *data)
 {
+#ifdef CONFIG_SERIAL_8250_DMA
+	int dmacnt;
+#endif
+
 	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		/*
@@ -162,7 +349,23 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	}
 
 	data->bus_clk = devm_clk_get(&pdev->dev, "bus");
-	return PTR_ERR_OR_ZERO(data->bus_clk);
+	if (IS_ERR(data->bus_clk))
+		return PTR_ERR(data->bus_clk);
+
+	data->dma = NULL;
+#ifdef CONFIG_SERIAL_8250_DMA
+	dmacnt = of_property_count_strings(pdev->dev.of_node, "dma-names");
+	if (dmacnt == 2) {
+		data->dma = devm_kzalloc(&pdev->dev, sizeof(*data->dma),
+					 GFP_KERNEL);
+		data->dma->fn = mtk8250_dma_filter;
+		data->dma->rx_size = MTK_UART_RX_SIZE;
+		data->dma->rxconf.src_maxburst = MTK_UART_RX_TRIGGER;
+		data->dma->txconf.dst_maxburst = MTK_UART_TX_TRIGGER;
+	}
+#endif
+
+	return 0;
 }
 
 static int mtk8250_probe(struct platform_device *pdev)
@@ -204,8 +407,14 @@ static int mtk8250_probe(struct platform_device *pdev)
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
 	uart.port.private_data = data;
+	uart.port.shutdown = mtk8250_shutdown;
+	uart.port.startup = mtk8250_startup;
 	uart.port.set_termios = mtk8250_set_termios;
 	uart.port.uartclk = clk_get_rate(data->uart_clk);
+#ifdef CONFIG_SERIAL_8250_DMA
+	if (data->dma)
+		uart.dma = data->dma;
+#endif
 
 	/* Disable Rate Fix function */
 	writel(0x0, uart.port.membase +
-- 
1.7.9.5

