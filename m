Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A62C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEF920827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O9BmoOms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfAHB7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:59:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45892 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfAHB7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:59:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so1081074pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UA+1hpLGIyRtNpWzZ3z1GOHv2MYLMjhrcWwr2rl6CeM=;
        b=O9BmoOmspftCi3rk9syy9eT3z+IqxSW3SXWQnIm1NuHvWqq8xqXD+BkSfVTC3mv3+H
         ohF1dHLDtT4pK00oKtgnPdQ9ZFXD127qJURry2gRtsxAohirKvWGFbPPFVIUS9TthO+q
         o+gCBcjzXhr29Sahm9DqLhUdpAVKxKXFoZ8rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UA+1hpLGIyRtNpWzZ3z1GOHv2MYLMjhrcWwr2rl6CeM=;
        b=m+uOkIHh/sADJGrIsjwUmd9+r8SBvfuKzJ5HGREiVpQ/jSHCQ00BeNf3cZ+Y4OO30/
         1wROfsKbBDDsrvrCBJb0y2pz4FNo2N+605Kq9dSmUwJQS1ydvIi7t9X/1eJak9q7eit1
         aAtjs0Nybx9WRIRheGVXRrJjxWog2POAtTsiVYjQ58I9E0pl1HxY4mhH3At0lJgcRLqK
         tNnn0Q40+OYj2R0ukLB6IsEjOlx1D165Q/VWpdUn6LOaspjBvSiLS5w0ccfslI9QGYrf
         /iEg9C0gctWqqiAtAgiYKi6/rqqclV2LsOsoyGqUQNIom5iD8mbaXRdZ2x8IWRdAmRGC
         v+DA==
X-Gm-Message-State: AA+aEWb//0GiKAAhIQa8MF1D0C7BHzKEj0KVIRyvGJNg+XH9qvTMSxV9
        zwiBQD/DGMkAxVhzpUwR5B7jfA==
X-Google-Smtp-Source: AFSGD/UlNpc3ligYVqkQLNIXSZ2tArS2ezHX9Q/4X1DmlzuhQaVYj1e5u/QEIDEe1OoXQ+eIg7KB2g==
X-Received: by 2002:a62:2082:: with SMTP id m2mr63985571pfj.163.1546912763031;
        Mon, 07 Jan 2019 17:59:23 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id p2sm93942693pfb.28.2019.01.07.17.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:59:22 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 3/4] tty: serial: qcom_geni_serial: Remove xfer_mode variable
Date:   Mon,  7 Jan 2019 17:58:37 -0800
Message-Id: <20190108015838.166271-4-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108015838.166271-1-ryandcase@chromium.org>
References: <20190108015838.166271-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports FIFO mode so setting and checking this variable
is unnecessary. If DMA support is ever added then such checks can be
introduced.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Fixed commit message typo
- Coalesced lines where possible

 drivers/tty/serial/qcom_geni_serial.c | 67 ++++++++++-----------------
 1 file changed, 24 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 22d3cb4b3b39..626bf7d399aa 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -105,7 +105,6 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_depth;
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
-	enum geni_se_xfer_mode xfer_mode;
 	bool setup;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
@@ -552,29 +551,20 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
 static void qcom_geni_serial_start_tx(struct uart_port *uport)
 {
 	u32 irq_en;
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	u32 status;
 
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		/*
-		 * readl ensures reading & writing of IRQ_EN register
-		 * is not re-ordered before checking the status of the
-		 * Serial Engine.
-		 */
-		status = readl(uport->membase + SE_GENI_STATUS);
-		if (status & M_GENI_CMD_ACTIVE)
-			return;
+	status = readl(uport->membase + SE_GENI_STATUS);
+	if (status & M_GENI_CMD_ACTIVE)
+		return;
 
-		if (!qcom_geni_serial_tx_empty(uport))
-			return;
+	if (!qcom_geni_serial_tx_empty(uport))
+		return;
 
-		irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
-		irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
+	irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
+	irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-		writel(DEF_TX_WM, uport->membase +
-						SE_GENI_TX_WATERMARK_REG);
-		writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
-	}
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 }
 
 static void qcom_geni_serial_stop_tx(struct uart_port *uport)
@@ -584,12 +574,8 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-	irq_en &= ~M_CMD_DONE_EN;
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
-		writel(0, uport->membase +
-				     SE_GENI_TX_WATERMARK_REG);
-	}
+	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
+	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
@@ -619,15 +605,13 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 
 	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
 
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
-		irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
-		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
+	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-		irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
-		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	}
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 }
 
 static void qcom_geni_serial_stop_rx(struct uart_port *uport)
@@ -637,15 +621,13 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	u32 irq_clear = S_CMD_DONE_EN;
 
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
-		irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
-		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
+	irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
+	writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-		irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
-		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	}
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 
 	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop rx is called multiple times. */
@@ -888,7 +870,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	 * Make an unconditional cancel on the main sequencer to reset
 	 * it else we could end up in data loss scenarios.
 	 */
-	port->xfer_mode = GENI_SE_FIFO;
 	if (uart_console(uport))
 		qcom_geni_serial_poll_tx_done(uport);
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->tx_bytes_pw,
@@ -896,7 +877,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
 						false, false, true);
 	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
-	geni_se_select_mode(&port->se, port->xfer_mode);
+	geni_se_select_mode(&port->se, GENI_SE_FIFO);
 	if (!uart_console(uport)) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
 			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
-- 
2.20.1.97.g81188d93c3-goog

