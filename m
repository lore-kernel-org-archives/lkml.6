Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB8FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A2C206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QbAX+gro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfAHB7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:59:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44159 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfAHB7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:59:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so1047185plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xFJ9W1/VfwL86QLPSSZmss0MI0vEVm5Y/K7IaVawNs=;
        b=QbAX+gro2dWmORQC277ALWVayIfzKwUwTjY+OraSy0BZ4OHTbBDUQk3eq9qYuebp//
         PSn7Z0snjzY78n7v9bQuD8+1CXCfaTW2hBh1cdaMLyzrCd8rr5/3dH7f3puFXqqAeTYb
         qrVccC8hLscdgRuCtdPXaugLnYWcgF88FFQRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xFJ9W1/VfwL86QLPSSZmss0MI0vEVm5Y/K7IaVawNs=;
        b=TTwYhjnQNJOSOXpQ4QVVJxy45s/EtGVh9iGK7wer8yyTaNSNDQLAbJxsWqs8hK+6Zp
         S2toqcOYQ5uIAYXrjykDokrJkbWIVs6PUug49i+RVwjgJDbRa35Tc/benWPvB118UcQ0
         nliCB7wZsKpsBYctwiEvNbVJof4Vr1ndw2sGM8GxIsBtPUYnxGpXirfbSJGVZoO8CDjL
         7wz1Xp1nqcEMOu455ToE/dJg/8FSaKARrgIcr9miRW+mYBuNPAZfZbXzUeVPk98jRgtK
         qbsbpDKVw43rR9lqEjQx+wKvAriR+iRcm02SID3qUJzyo9eDmCLuFwz0T1Vl8qjtnjlh
         IaQQ==
X-Gm-Message-State: AJcUukdqVGnMP9WVY2tf8gpylL7giW3Z6x6Et0WCHhFRBJ1baQzq+oXh
        QHbhZmlXPo2tnK1oQBNAVdr+XA==
X-Google-Smtp-Source: ALg8bN43nzRNuisBspH3CnKnsVXpKajIW5w0xs6rLFJrYrOT+Rtc8h5B3XHJo1urpYtkHMEgO0oReA==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr62756459plt.2.1546912761539;
        Mon, 07 Jan 2019 17:59:21 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id p2sm93942693pfb.28.2019.01.07.17.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:59:21 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 2/4] tty: serial: qcom_geni_serial: Remove set_rfr_wm() and related variables
Date:   Mon,  7 Jan 2019 17:58:36 -0800
Message-Id: <20190108015838.166271-3-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108015838.166271-1-ryandcase@chromium.org>
References: <20190108015838.166271-1-ryandcase@chromium.org>
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
Reviewed-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Removed CONSOLE from UART_CONSOLE_RX_WM

 drivers/tty/serial/qcom_geni_serial.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e2cb3f7d1a7c..22d3cb4b3b39 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -89,7 +89,7 @@
 #define DEF_FIFO_DEPTH_WORDS	16
 #define DEF_TX_WM		2
 #define DEF_FIFO_WIDTH_BITS	32
-#define UART_CONSOLE_RX_WM	2
+#define UART_RX_WM		2
 #define MAX_LOOPBACK_CFG	3
 
 #ifdef CONFIG_CONSOLE_POLL
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
@@ -576,7 +571,7 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
 		irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 		irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-		writel(port->tx_wm, uport->membase +
+		writel(DEF_TX_WM, uport->membase +
 						SE_GENI_TX_WATERMARK_REG);
 		writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 	}
@@ -848,17 +843,6 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
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
@@ -899,7 +883,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 
 	get_tx_fifo_size(port);
 
-	set_rfr_wm(port);
 	writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
 	/*
 	 * Make an unconditional cancel on the main sequencer to reset
@@ -912,7 +895,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 						false, true, false);
 	geni_se_config_packing(&port->se, BITS_PER_BYTE, port->rx_bytes_pw,
 						false, false, true);
-	geni_se_init(&port->se, port->rx_wm, port->rx_rfr);
+	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
 	geni_se_select_mode(&port->se, port->xfer_mode);
 	if (!uart_console(uport)) {
 		port->rx_fifo = devm_kcalloc(uport->dev,
-- 
2.20.1.97.g81188d93c3-goog

