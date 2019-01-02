Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED75C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F9F214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJixZEUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfABVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:37:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46994 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfABVg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:36:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so15704588pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIKx1gBAi9KRYs5qxynywDbWUKYDuXC2dkXStFWKXxU=;
        b=JJixZEUVXEl6iWplE1TWBIb5U5PNn4XkqUqk++vlaVdqs7XOn1tXs7q94BpN2z14Pv
         hEBEYgA5OW4nA1/ZBS7vUeQFNLb1n8qXRBKyxp2hP7evEmWK2Rt3dvFSYHFX9eLKNveR
         7k5s6fsctb5GdYyV8ZdnNhKsw5OVcFVrfqxvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIKx1gBAi9KRYs5qxynywDbWUKYDuXC2dkXStFWKXxU=;
        b=IDnB6hHk4QOkVQ7OleOVrnDeqC9m1x3oK3K+VMXcBtnbb/GQ783jrjR+vJwun453NU
         esitm+fuAb30zrJ91MLQGtIrrt7DL1g7M+b+tSthEDlEYQ//a7zE2bu3YywrthO08L6J
         1IhyOVScVdImsTOlLzurytMkYSkkqTjk2UQkIrbYAUyUcWeysIAha7Z18UP4P2AWJ1jU
         JTXiHli5FFza91RvE9yvDt6Y+cv6U/3wszX2cfK4RfN8YiM/WtwQdajs+2/1IXF5PfO0
         cx9JmqHYSdfbgGYDcXXQl3i1mCh97/Cn1xrXRjKPccwbNZpAuGGZAibU8x0Zek9LGfjJ
         tzag==
X-Gm-Message-State: AJcUukf0m2+xo6MbCJO6CRfCwJ+VnCKb+OJFtXaiKn/WEyf/9bUo86/1
        TFGIAYQPaACI7jKa79zhRslC1w==
X-Google-Smtp-Source: ALg8bN7jEdB1oG1rAhEjceJiHtlC0XD0INWnLxh+xhrjFg53J+ddirEASWr2tg5AZhxHZnlxBRPNcQ==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr14866631pgb.417.1546465019040;
        Wed, 02 Jan 2019 13:36:59 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id m67sm105323631pfb.25.2019.01.02.13.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 13:36:58 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 2/4] tty: serial: qcom_geni_serial: Remove set_rfr_wm() and related variables
Date:   Wed,  2 Jan 2019 13:36:34 -0800
Message-Id: <20190102213636.40866-3-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20190102213636.40866-1-ryandcase@chromium.org>
References: <20190102213636.40866-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables of tx_wm and rx_wm were set to the same define value in
all cases, never updated, and the define was sometimes used
interchangably. Remove the variables/function and use the fixed value.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index dc95b96148ed..5521ed4a0708 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -105,9 +105,6 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_depth;
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
-	u32 tx_wm;
-	u32 rx_wm;
-	u32 rx_rfr;
 	enum geni_se_xfer_mode xfer_mode;
 	bool setup;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
@@ -365,9 +362,7 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 							unsigned char c)
 {
-	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
-
-	writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
@@ -579,7 +574,7 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
 		irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 		irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-		writel(port->tx_wm, uport->membase +
+		writel(DEF_TX_WM, uport->membase +
 						SE_GENI_TX_WATERMARK_REG);
 		writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 	}
@@ -852,17 +847,6 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
 }
 
-static void set_rfr_wm(struct qcom_geni_serial_port *port)
-{
-	/*
-	 * Set RFR (Flow off) to FIFO_DEPTH - 2.
-	 * RX WM level at 10% RX_FIFO_DEPTH.
-	 * TX WM level at 10% TX_FIFO_DEPTH.
-	 */
-	port->rx_rfr = port->rx_fifo_depth - 2;
-	port->rx_wm = UART_CONSOLE_RX_WM;
-	port->tx_wm = DEF_TX_WM;
-}
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
@@ -903,7 +887,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 
 	get_tx_fifo_size(port);
 
-	set_rfr_wm(port);
 	writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
 	/*
 	 * Make an unconditional cancel on the main sequencer to reset
@@ -916,7 +899,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 						false, true, false);
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
 						false, false, true);
-	geni_se_init(&port->se, port->rx_wm, port->rx_rfr);
+	geni_se_init(&port->se, UART_CONSOLE_RX_WM, port->rx_fifo_depth - 2);
 	geni_se_select_mode(&port->se, port->xfer_mode);
 	if (!uart_console(uport)) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
-- 
2.20.1.415.g653613c723-goog

