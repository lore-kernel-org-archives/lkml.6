Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B594DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7070D2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPtWVYek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfABVhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:37:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfABVg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:36:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so15714871pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ebUwxLpKG2Lfq86+1TAJTOBnu6ZuAK5FJ6GN0qZC7k=;
        b=kPtWVYekYcc0Nx4ODEo+iapbFMFg5UeDliqkol8kHpJjTBYvRE/l+b2x6gDA2Zk9RR
         NbsN+JU/C6GRFUf2XRAZgKiPrX/UxqlOFQ5qsTLJPu4v/qfG5xZTQ/NQo44ub9PSwjwV
         /HPOwJsPhHH9gkjp3qHnVituyUNJ4dECUAJSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ebUwxLpKG2Lfq86+1TAJTOBnu6ZuAK5FJ6GN0qZC7k=;
        b=el6W+gVNi/3empzD4NpOZtUjcgbezQuqR45GnoNbYdtSAZI2c/OqR7sm68KDO/fMvM
         kjUQ1MXZK0vIKXhgw87XbqDI+P8aapLmxxMrO5w8GBQsi2YpjSZ3jr0QbNIGh5FxrO0B
         Fs4OJ8VfYRg0NJNE6cY98js2xyBvcQoSQ7MdUNLXxZH7A0ij6D49qhdZqTP73T4EbFYm
         gzu8PULAF1tq5B5+O9NIhJRQnuzkN1SSa6H4GWU9Tjyw4JY+9L8JGy8+P/mQwdO/wS/Z
         212dnNDUCmJkQsCOdsg+KmV4qa2bpJYXmRiiFNg6QulI7CmxIw1ATrnRawXKyjg9yeVF
         vOuw==
X-Gm-Message-State: AA+aEWYNM5qf4P1tpZnbdMSUkL5AaAo1/2yXKnZVSYsZsWz54nbRJ7Xt
        4nqEEyyxI3D5MBCfdg0UDmnHkA==
X-Google-Smtp-Source: AFSGD/VWvV7awYyxpRk5vsJlbAnpzkDAQWH8sNYwjteGgmcX/92miYL0pvtd9Gz9MVy9MK/auZkxUg==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr45566335pfg.235.1546465016963;
        Wed, 02 Jan 2019 13:36:56 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id m67sm105323631pfb.25.2019.01.02.13.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 13:36:56 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 1/4] tty: serial: qcom_geni_serial: Remove use of *_relaxed() and mb()
Date:   Wed,  2 Jan 2019 13:36:33 -0800
Message-Id: <20190102213636.40866-2-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20190102213636.40866-1-ryandcase@chromium.org>
References: <20190102213636.40866-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A frequent side comment has been to remove the use of writel_relaxed,
readl_relaxed, and mb.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 187 +++++++++++---------------
 1 file changed, 80 insertions(+), 107 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2b1e73193dad..dc95b96148ed 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -230,7 +230,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 	if (uart_console(uport) || !uart_cts_enabled(uport)) {
 		mctrl |= TIOCM_CTS;
 	} else {
-		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
+		geni_ios = readl(uport->membase + SE_GENI_IOS);
 		if (!(geni_ios & IO2_DATA_IN))
 			mctrl |= TIOCM_CTS;
 	}
@@ -248,7 +248,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 
 	if (!(mctrl & TIOCM_RTS))
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
-	writel_relaxed(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
+	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
 }
 
 static const char *qcom_geni_serial_get_type(struct uart_port *uport)
@@ -277,9 +277,6 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	unsigned int fifo_bits;
 	unsigned long timeout_us = 20000;
 
-	/* Ensure polling is not re-ordered before the prior writes/reads */
-	mb();
-
 	if (uport->private_data) {
 		port = to_dev_port(uport, uport);
 		baud = port->baud;
@@ -299,7 +296,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	 */
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
-		reg = readl_relaxed(uport->membase + offset);
+		reg = readl(uport->membase + offset);
 		if ((bool)(reg & field) == set)
 			return true;
 		udelay(10);
@@ -312,7 +309,7 @@ static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
 	u32 m_cmd;
 
-	writel_relaxed(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
+	writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
 	m_cmd = UART_START_TX << M_OPCODE_SHFT;
 	writel(m_cmd, uport->membase + SE_GENI_M_CMD0);
 }
@@ -325,13 +322,13 @@ static void qcom_geni_serial_poll_tx_done(struct uart_port *uport)
 	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_DONE_EN, true);
 	if (!done) {
-		writel_relaxed(M_GENI_CMD_ABORT, uport->membase +
+		writel(M_GENI_CMD_ABORT, uport->membase +
 						SE_GENI_M_CMD_CTRL_REG);
 		irq_clear |= M_CMD_ABORT_EN;
 		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 							M_CMD_ABORT_EN, true);
 	}
-	writel_relaxed(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_abort_rx(struct uart_port *uport)
@@ -341,8 +338,8 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
 	writel(S_GENI_CMD_ABORT, uport->membase + SE_GENI_S_CMD_CTRL_REG);
 	qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
 					S_GENI_CMD_ABORT, false);
-	writel_relaxed(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
-	writel_relaxed(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
+	writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	writel(FORCE_DEFAULT, uport->membase + GENI_FORCE_DEFAULT_REG);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -351,19 +348,13 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 	u32 rx_fifo;
 	u32 status;
 
-	status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
-	writel_relaxed(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
-
-	status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
-	writel_relaxed(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
+	writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 
-	/*
-	 * Ensure the writes to clear interrupts is not re-ordered after
-	 * reading the data.
-	 */
-	mb();
+	status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 
-	status = readl_relaxed(uport->membase + SE_GENI_RX_FIFO_STATUS);
+	status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
 	if (!(status & RX_FIFO_WC_MSK))
 		return NO_POLL_CHAR;
 
@@ -376,12 +367,12 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	writel_relaxed(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(port->tx_wm, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, 1);
 	WARN_ON(!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_TX_FIFO_WATERMARK_EN, true));
-	writel_relaxed(c, uport->membase + SE_GENI_TX_FIFOn);
-	writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
+	writel(c, uport->membase + SE_GENI_TX_FIFOn);
+	writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 	qcom_geni_serial_poll_tx_done(uport);
 }
@@ -390,7 +381,7 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
 static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
 {
-	writel_relaxed(ch, uport->membase + SE_GENI_TX_FIFOn);
+	writel(ch, uport->membase + SE_GENI_TX_FIFOn);
 }
 
 static void
@@ -409,7 +400,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 			bytes_to_send++;
 	}
 
-	writel_relaxed(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
+	writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(uport, bytes_to_send);
 	for (i = 0; i < count; ) {
 		size_t chars_to_write = 0;
@@ -427,7 +418,7 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
 		chars_to_write = min_t(size_t, count - i, avail / 2);
 		uart_console_write(uport, s + i, chars_to_write,
 						qcom_geni_serial_wr_char);
-		writel_relaxed(M_TX_FIFO_WATERMARK_EN, uport->membase +
+		writel(M_TX_FIFO_WATERMARK_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 		i += chars_to_write;
 	}
@@ -456,7 +447,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	else
 		spin_lock_irqsave(&uport->lock, flags);
 
-	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	geni_status = readl(uport->membase + SE_GENI_STATUS);
 
 	/* Cancel the current write to log the fault */
 	if (!locked) {
@@ -466,10 +457,10 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 			geni_se_abort_m_cmd(&port->se);
 			qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 							M_CMD_ABORT_EN, true);
-			writel_relaxed(M_CMD_ABORT_EN, uport->membase +
+			writel(M_CMD_ABORT_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 		}
-		writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
+		writel(M_CMD_CANCEL_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
 		/*
@@ -479,9 +470,9 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		qcom_geni_serial_poll_tx_done(uport);
 
 		if (uart_circ_chars_pending(&uport->state->xmit)) {
-			irq_en = readl_relaxed(uport->membase +
+			irq_en = readl(uport->membase +
 					SE_GENI_M_IRQ_EN);
-			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
 		}
 	}
@@ -585,12 +576,12 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
 		if (!qcom_geni_serial_tx_empty(uport))
 			return;
 
-		irq_en = readl_relaxed(uport->membase +	SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase +	SE_GENI_M_IRQ_EN);
 		irq_en |= M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
 
-		writel_relaxed(port->tx_wm, uport->membase +
+		writel(port->tx_wm, uport->membase +
 						SE_GENI_TX_WATERMARK_REG);
-		writel_relaxed(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
+		writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
 	}
 }
 
@@ -600,35 +591,29 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
 	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 	irq_en &= ~M_CMD_DONE_EN;
 	if (port->xfer_mode == GENI_SE_FIFO) {
 		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
-		writel_relaxed(0, uport->membase +
+		writel(0, uport->membase +
 				     SE_GENI_TX_WATERMARK_REG);
 	}
-	writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop tx is called multiple times. */
 	if (!(status & M_GENI_CMD_ACTIVE))
 		return;
 
-	/*
-	 * Ensure cancel command write is not re-ordered before checking
-	 * the status of the Primary Sequencer.
-	 */
-	mb();
-
 	geni_se_cancel_m_cmd(&port->se);
 	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_CANCEL_EN, true)) {
 		geni_se_abort_m_cmd(&port->se);
 		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_ABORT_EN, true);
-		writel_relaxed(M_CMD_ABORT_EN, uport->membase +
+		writel(M_CMD_ABORT_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
 	}
-	writel_relaxed(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 }
 
 static void qcom_geni_serial_start_rx(struct uart_port *uport)
@@ -637,26 +622,20 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
 	u32 status;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	status = readl(uport->membase + SE_GENI_STATUS);
 	if (status & S_GENI_CMD_ACTIVE)
 		qcom_geni_serial_stop_rx(uport);
 
-	/*
-	 * Ensure setup command write is not re-ordered before checking
-	 * the status of the Secondary Sequencer.
-	 */
-	mb();
-
 	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
 
 	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_S_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
 		irq_en |= S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN;
-		writel_relaxed(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		irq_en |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
-		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	}
 }
 
@@ -668,31 +647,25 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
 	u32 irq_clear = S_CMD_DONE_EN;
 
 	if (port->xfer_mode == GENI_SE_FIFO) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_S_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
 		irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
-		writel_relaxed(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_S_IRQ_EN);
 
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
-		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+		writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+	status = readl(uport->membase + SE_GENI_STATUS);
 	/* Possible stop rx is called multiple times. */
 	if (!(status & S_GENI_CMD_ACTIVE))
 		return;
 
-	/*
-	 * Ensure cancel command write is not re-ordered before checking
-	 * the status of the Secondary Sequencer.
-	 */
-	mb();
-
 	geni_se_cancel_s_cmd(&port->se);
 	qcom_geni_serial_poll_bit(uport, SE_GENI_S_CMD_CTRL_REG,
 					S_GENI_CMD_CANCEL, false);
-	status = readl_relaxed(uport->membase + SE_GENI_STATUS);
-	writel_relaxed(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	status = readl(uport->membase + SE_GENI_STATUS);
+	writel(irq_clear, uport->membase + SE_GENI_S_IRQ_CLEAR);
 	if (status & S_GENI_CMD_ACTIVE)
 		qcom_geni_serial_abort_rx(uport);
 }
@@ -706,7 +679,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	u32 total_bytes;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
-	status = readl_relaxed(uport->membase +	SE_GENI_RX_FIFO_STATUS);
+	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
 	word_cnt = status & RX_FIFO_WC_MSK;
 	last_word_partial = status & RX_LAST;
 	last_word_byte_cnt = (status & RX_LAST_BYTE_VALID_MSK) >>
@@ -736,7 +709,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	unsigned int chunk;
 	int tail;
 
-	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
+	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
 
 	/* Complete the current tx command before taking newly added data */
 	if (active)
@@ -762,9 +735,9 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
 
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
-			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+			writel(irq_en | M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
@@ -797,14 +770,14 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	 * cleared it in qcom_geni_serial_isr it will have already reasserted
 	 * so we must clear it again here after our writes.
 	 */
-	writel_relaxed(M_TX_FIFO_WATERMARK_EN,
+	writel(M_TX_FIFO_WATERMARK_EN,
 			uport->membase + SE_GENI_M_IRQ_CLEAR);
 
 out_write_wakeup:
 	if (!port->tx_remaining) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (irq_en & M_TX_FIFO_WATERMARK_EN)
-			writel_relaxed(irq_en & ~M_TX_FIFO_WATERMARK_EN,
+			writel(irq_en & ~M_TX_FIFO_WATERMARK_EN,
 					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
@@ -828,12 +801,12 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		return IRQ_NONE;
 
 	spin_lock_irqsave(&uport->lock, flags);
-	m_irq_status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
-	s_irq_status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
-	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
-	m_irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
-	writel_relaxed(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
-	writel_relaxed(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
+	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	geni_status = readl(uport->membase + SE_GENI_STATUS);
+	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
+	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 
 	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
 		goto out_unlock;
@@ -931,7 +904,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	get_tx_fifo_size(port);
 
 	set_rfr_wm(port);
-	writel_relaxed(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
+	writel(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
 	/*
 	 * Make an unconditional cancel on the main sequencer to reset
 	 * it else we could end up in data loss scenarios.
@@ -1035,10 +1008,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
 	/* parity */
-	tx_trans_cfg = readl_relaxed(uport->membase + SE_UART_TX_TRANS_CFG);
-	tx_parity_cfg = readl_relaxed(uport->membase + SE_UART_TX_PARITY_CFG);
-	rx_trans_cfg = readl_relaxed(uport->membase + SE_UART_RX_TRANS_CFG);
-	rx_parity_cfg = readl_relaxed(uport->membase + SE_UART_RX_PARITY_CFG);
+	tx_trans_cfg = readl(uport->membase + SE_UART_TX_TRANS_CFG);
+	tx_parity_cfg = readl(uport->membase + SE_UART_TX_PARITY_CFG);
+	rx_trans_cfg = readl(uport->membase + SE_UART_RX_TRANS_CFG);
+	rx_parity_cfg = readl(uport->membase + SE_UART_RX_PARITY_CFG);
 	if (termios->c_cflag & PARENB) {
 		tx_trans_cfg |= UART_TX_PAR_EN;
 		rx_trans_cfg |= UART_RX_PAR_EN;
@@ -1094,17 +1067,17 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		uart_update_timeout(uport, termios->c_cflag, baud);
 
 	if (!uart_console(uport))
-		writel_relaxed(port->loopback,
+		writel(port->loopback,
 				uport->membase + SE_UART_LOOPBACK_CFG);
-	writel_relaxed(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
-	writel_relaxed(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
-	writel_relaxed(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
-	writel_relaxed(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
-	writel_relaxed(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
-	writel_relaxed(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
-	writel_relaxed(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
+	writel(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
+	writel(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
+	writel(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
+	writel(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
+	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
+	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
+	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
+	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
 out_restart_rx:
 	qcom_geni_serial_start_rx(uport);
 }
@@ -1195,13 +1168,13 @@ static int __init qcom_geni_serial_earlycon_setup(struct earlycon_device *dev,
 	geni_se_init(&se, DEF_FIFO_DEPTH_WORDS / 2, DEF_FIFO_DEPTH_WORDS - 2);
 	geni_se_select_mode(&se, GENI_SE_FIFO);
 
-	writel_relaxed(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
-	writel_relaxed(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
-	writel_relaxed(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
-	writel_relaxed(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
-	writel_relaxed(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
-	writel_relaxed(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+	writel(tx_trans_cfg, uport->membase + SE_UART_TX_TRANS_CFG);
+	writel(tx_parity_cfg, uport->membase + SE_UART_TX_PARITY_CFG);
+	writel(rx_trans_cfg, uport->membase + SE_UART_RX_TRANS_CFG);
+	writel(rx_parity_cfg, uport->membase + SE_UART_RX_PARITY_CFG);
+	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
+	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
+	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
 
 	dev->con->write = qcom_geni_serial_earlycon_write;
 	dev->con->setup = NULL;
-- 
2.20.1.415.g653613c723-goog

