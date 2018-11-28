Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D65C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048672081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DpGimiam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048672081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeK2K6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:58:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35269 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeK2K6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:58:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so54264plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQE4LgQnSQaslbz0fvJXIldEboshXmIAOvX+8/1krbo=;
        b=DpGimiamTpG/uJ3+YM0Q+r6g7BZtmIJ9BbPxvSumn9TzCMVNHniyZNhUQXEcBDC9up
         q+JoxjxxjrvxDGHYaGCAlP1CQa592d1yELs3GQ/ZGTUEOqBgOTCIsYc48oDvb+EDjuiw
         5OXu2Yk3NUaIeV2cQ5dfEIXj2jukopprXARgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQE4LgQnSQaslbz0fvJXIldEboshXmIAOvX+8/1krbo=;
        b=MqNYid84p2pMfE6R2MTPT+CWojeLkpP8slzfyGFQQjVQZV5BQa16RvFUAGQiLIM6aw
         M+4Ze9Xv+Vr33xLUNlqm5TUYj1GJc9sbOI9qYrQQXxNNNm3vyNDCIXtEGx3pzDy81f6G
         eyul1aqw4eVqDG74FKQEcCKHKXggGCnrDwWpkJcvb9F0eWySdd9EPQb7ZThSR00mKDxq
         T0LfFKwXuhZwEJcP2wW3ZN5tt3Xz29FWS4WsyAdbFtFMylPbfx9mCoHbpIV6mNKUUrzJ
         RKjnbq1Cu0PneVkQjtRmihjhKetfl1yIoQFDjEq0NgJlxFmFxypxFDI0gVnOgPE+vf1I
         b5Dw==
X-Gm-Message-State: AA+aEWaYW0B49YQXuWj/gB53DqLD47TwPF3+MIAc8oQIyRfa06nSlDu8
        SGOHMoR9dj1Ujed/UhUim+swIQ==
X-Google-Smtp-Source: AFSGD/XzFAEdcnsiuyS/ffvNCbpM/iCsVPmlMnQCzvrJ8UsQMpVlvPjQ3EtgMIkQ0KS3A7U94qPbFQ==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr39724905plz.80.1543449317102;
        Wed, 28 Nov 2018 15:55:17 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id s4sm75689pgp.13.2018.11.28.15.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:55:16 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2] tty: serial: qcom_geni_serial: Fix softlock
Date:   Wed, 28 Nov 2018 15:54:59 -0800
Message-Id: <20181128235459.180940-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transfers were being divided into device FIFO sized (64 byte max)
operations which would poll for completion within a spin_lock_irqsave /
spin_unlock_irqrestore block. This both made things slow by waiting for
the FIFO to completely drain before adding further data and would also
result in softlocks on large transmissions.

This patch allows larger transfers with continuous FIFO additions as
space becomes available and removes polling from the interrupt handler.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

Changes in v2:
- Addressed nits raised by Stephen

 drivers/tty/serial/qcom_geni_serial.c | 56 +++++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ded51081add..26f7c0df83ae 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -117,6 +117,8 @@ struct qcom_geni_serial_port {
 	u32 *rx_fifo;
 	u32 loopback;
 	bool brk;
+
+	unsigned int tx_remaining;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -439,6 +441,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	struct qcom_geni_serial_port *port;
 	bool locked = true;
 	unsigned long flags;
+	u32 geni_status;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -452,6 +455,8 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	else
 		spin_lock_irqsave(&uport->lock, flags);
 
+	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
+
 	/* Cancel the current write to log the fault */
 	if (!locked) {
 		geni_se_cancel_m_cmd(&port->se);
@@ -465,9 +470,19 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		}
 		writel_relaxed(M_CMD_CANCEL_EN, uport->membase +
 							SE_GENI_M_IRQ_CLEAR);
+	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
+		/*
+		 * It seems we can interrupt existing transfers unless all data
+		 * has been sent, in which case we need to look for done first.
+		 */
+		qcom_geni_serial_poll_tx_done(uport);
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
+
+	if (port->tx_remaining)
+		qcom_geni_serial_setup_tx(uport, port->tx_remaining);
+
 	if (locked)
 		spin_unlock_irqrestore(&uport->lock, flags);
 }
@@ -701,40 +716,45 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
 	port->handle_rx(uport, total_bytes, drop);
 }
 
-static void qcom_geni_serial_handle_tx(struct uart_port *uport)
+static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
+		bool active)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	struct circ_buf *xmit = &uport->state->xmit;
 	size_t avail;
 	size_t remaining;
+	size_t pending;
 	int i;
 	u32 status;
 	unsigned int chunk;
 	int tail;
-	u32 irq_en;
 
-	chunk = uart_circ_chars_pending(xmit);
 	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
-	/* Both FIFO and framework buffer are drained */
-	if (!chunk && !status) {
+
+	/* Complete the current tx command before taking newly added data */
+	if (active)
+		pending = port->tx_remaining;
+	else
+		pending = uart_circ_chars_pending(xmit);
+
+	/* All data has been transmitted and acknowledged as received */
+	if (!pending && !status && done) {
 		qcom_geni_serial_stop_tx(uport);
 		goto out_write_wakeup;
 	}
 
-	if (!uart_console(uport)) {
-		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
-		irq_en &= ~(M_TX_FIFO_WATERMARK_EN);
-		writel_relaxed(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
-		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
-	}
+	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
+	avail *= port->tx_bytes_pw;
 
-	avail = (port->tx_fifo_depth - port->tx_wm) * port->tx_bytes_pw;
 	tail = xmit->tail;
-	chunk = min3((size_t)chunk, (size_t)(UART_XMIT_SIZE - tail), avail);
+	chunk = min3(avail, pending, (UART_XMIT_SIZE - tail));
 	if (!chunk)
 		goto out_write_wakeup;
 
-	qcom_geni_serial_setup_tx(uport, chunk);
+	if (!port->tx_remaining) {
+		qcom_geni_serial_setup_tx(uport, pending);
+		port->tx_remaining = pending;
+	}
 
 	remaining = chunk;
 	for (i = 0; i < chunk; ) {
@@ -753,11 +773,10 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport)
 		tail += tx_bytes;
 		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
+		port->tx_remaining -= tx_bytes;
 	}
 
 	xmit->tail = tail & (UART_XMIT_SIZE - 1);
-	if (uart_console(uport))
-		qcom_geni_serial_poll_tx_done(uport);
 out_write_wakeup:
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(uport);
@@ -767,6 +786,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 {
 	unsigned int m_irq_status;
 	unsigned int s_irq_status;
+	unsigned int geni_status;
 	struct uart_port *uport = dev;
 	unsigned long flags;
 	unsigned int m_irq_en;
@@ -780,6 +800,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	spin_lock_irqsave(&uport->lock, flags);
 	m_irq_status = readl_relaxed(uport->membase + SE_GENI_M_IRQ_STATUS);
 	s_irq_status = readl_relaxed(uport->membase + SE_GENI_S_IRQ_STATUS);
+	geni_status = readl_relaxed(uport->membase + SE_GENI_STATUS);
 	m_irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
 	writel_relaxed(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel_relaxed(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
@@ -794,7 +815,8 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 
 	if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
 	    m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
-		qcom_geni_serial_handle_tx(uport);
+		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
+					geni_status & M_GENI_CMD_ACTIVE);
 
 	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
 		if (s_irq_status & S_GP_IRQ_0_EN)
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

