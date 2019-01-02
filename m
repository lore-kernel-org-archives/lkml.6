Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AAAC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDB9214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PF8zrMya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfABVhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:37:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42954 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfABVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:37:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so15082098pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1f3E1bO+3vRmroIVbHRZat2QBrgOpSmgYakvRuOrTOg=;
        b=PF8zrMyaOnywocNeTjL1xRV7Sp5yFiYFNTR2jkAWHiLtwxKs5gaEQ5mjw9jlJnsWfO
         ucPlt6ZtnH2GrppFJgnzGRjNtYTTIl1Amp7cHITYCIqdswuIf2UMFH6nhVVVL5cHJXlt
         xB9NeBTBWGBR0E8zmV1+kcocELnVg9SRmy1TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1f3E1bO+3vRmroIVbHRZat2QBrgOpSmgYakvRuOrTOg=;
        b=SXKYJbaqyx5103/UVF9pGDctCrPIeim1JTXYt/5pKxgtIFiyqKTznxScZ2Kw2kov1y
         vWbsVUbd0a/xRGXSW2pesdrkRwhR0Gl/T4N7YCg1qaYsmBOihJdfeF5R5+8AbPovD6VT
         Cy363dXBfRotPJH9os8qSBqn2nKMpYBQFfQFGijCuUZuuYkeHsT72OlkKrUXx+t8Ndtu
         mK0WuDgWhxLjUocTgHFy487e884ELl82Bc8tNFq/AxdOniQf+EMIAvPNGXeaSoFFm12c
         oLns688kxnhWA0vqVcDNj5aQCmL6c/f9aTYbcwy0rQMzujji0Uh0zz7Uim2K2tJjq0Ve
         mcpw==
X-Gm-Message-State: AJcUukfpYW/U8TNgPh+iR9utHysjTWHf2vD+BlhxtYvS2mn/vZRXqvtn
        LvsHsp3fFu+Vp7tv+EIuP9uTzg==
X-Google-Smtp-Source: ALg8bN6QSSBXYSwjxckOQy8EjBMPl+ofmTdf8tCQoYDLW7L0Bc20p7RsH+9NtqNujZcmpUULjdKMcQ==
X-Received: by 2002:a63:790e:: with SMTP id u14mr14884503pgc.452.1546465020527;
        Wed, 02 Jan 2019 13:37:00 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id m67sm105323631pfb.25.2019.01.02.13.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 13:37:00 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 3/4] tty: serial: qcom_geni_serial: Remove xfer_mode variable
Date:   Wed,  2 Jan 2019 13:36:35 -0800
Message-Id: <20190102213636.40866-4-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20190102213636.40866-1-ryandcase@chromium.org>
References: <20190102213636.40866-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports FIFO mode so setting and checking this variable
is unnecessary. If DMA support is ever addedd then such checks can be
introduced.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 66 ++++++++++-----------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 5521ed4a0708..3103aa0adc86 100644
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
@@ -555,29 +554,20 @@ static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
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
@@ -588,11 +578,8 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 
 	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~M_CMD_DONE_EN;
-	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
-		writel(0, uport->membase +
-				     SE_GENI_TX_WATERMARK_REG);
-	}
+	irq_en &= ~M_TX_FIFO_WATERMARK_EN;
+	writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
@@ -623,15 +610,13 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 
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
@@ -641,15 +626,13 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
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
@@ -892,7 +875,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	 * Make an unconditional cancel on the main sequencer to reset
 	 * it else we could end up in data loss scenarios.
 	 */
-	port->xfer_mode = GENI_SE_FIFO;
 	if (uart_console(uport))
 		qcom_geni_serial_poll_tx_done(uport);
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->tx_bytes_pw,
@@ -900,7 +882,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
 						false, false, true);
 	geni_se_init(&port->se, UART_CONSOLE_RX_WM, port->rx_fifo_depth - 2);
-	geni_se_select_mode(&port->se, port->xfer_mode);
+	geni_se_select_mode(&port->se, GENI_SE_FIFO);
 	if (!uart_console(uport)) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
 			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
-- 
2.20.1.415.g653613c723-goog

