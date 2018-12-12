Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D9620849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8hpKSO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D9620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLLAgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:36:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44532 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:36:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so7946092pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZPNaA/sxvH+FGg3+rFTxwpoUlQPq3KwKBn9OFCKHN8=;
        b=V8hpKSO1qgKzDb9RwJtyduZPKO0/RrFh6xHpQRaaxZRu0MURvCDTH51HP5pBtxdaop
         uVcnL2+gcj3KhI3Nrm0w8HnROPanLef9wMuWNkBsnZ5PXFMkeBsNoc4DtmYY645K4a24
         VxE7hKYgSbHbvPehT6twmA7Mnt7llb9mgzDzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZPNaA/sxvH+FGg3+rFTxwpoUlQPq3KwKBn9OFCKHN8=;
        b=VxcsCGVGC/C+iFX4UlxJ2oJvO2fZuWFvRfDKdsqq2aht8e+Q12nLruomMxViHO0Y7J
         pCFrUBMNJ8dqsYl+3Q+AmV3RfMREJ1ZlcEtyF3S9AJnXj5WyAA/DAWmJISOY56lqpKh8
         11qxLx/OGfkQwJFEz5I7ukxcgKZw+Ja1TlEkop87b/Bkfxxlc0GTnUDA4UAvR52uYUx8
         s0tr9u9nU5uU1u1HvNF+Df/bpOldn/HxvTBPBLJ4wIy2Znt76DfFz02hY8jH1ytWoqZr
         JjVBekrckiiSkX7zBfHVtGCJCfDTFzHCl8LzOO9Dex1rdAD0RkacOVsciMdFRTlGaWro
         rGCw==
X-Gm-Message-State: AA+aEWYFZSZLBqg6hCxvCF8/ePnRR8+o4Ip4NfCbHjkHF4csznMoYhOg
        8VY8djxBQJ1EIVL9STKGHYRyeQ==
X-Google-Smtp-Source: AFSGD/VTQZE6COiUffqNwpVzzGXOZvFwTAn7pKFe0hqIjt3InD4Aw1u5pyAV1NLBRpW8ongx+S/2Jw==
X-Received: by 2002:a62:2c4d:: with SMTP id s74mr18095121pfs.6.1544574983415;
        Tue, 11 Dec 2018 16:36:23 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id 7sm55580924pfm.8.2018.12.11.16.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:36:22 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Remove interrupt storm
Date:   Tue, 11 Dec 2018 16:35:22 -0800
Message-Id: <20181212003522.239189-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable M_TX_FIFO_WATERMARK_EN after we've sent all data for a given
transaction so we don't continue to receive a flurry of free space
interrupts while waiting for the M_CMD_DONE notification. Re-enable the
watermark when establishing the next transaction.

Also clear the watermark interrupt after filling the FIFO so we do not
receive notification again prior to actually having free space.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6e38498362ef..965aefa54114 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -724,10 +724,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	size_t pending;
 	int i;
 	u32 status;
+	u32 irq_en;
 	unsigned int chunk;
 	int tail;
 
 	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
+	irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
 
 	/* Complete the current tx command before taking newly added data */
 	if (active)
@@ -752,6 +754,9 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	if (!port->tx_remaining) {
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
+
+		irq_en |= M_TX_FIFO_WATERMARK_EN;
+		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
 	remaining = chunk;
@@ -775,7 +780,15 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	}
 
 	xmit->tail = tail & (UART_XMIT_SIZE - 1);
+	writel_relaxed(M_TX_FIFO_WATERMARK_EN,
+			uport->membase + SE_GENI_M_IRQ_CLEAR);
+
 out_write_wakeup:
+	if (!port->tx_remaining) {
+		irq_en &= ~M_TX_FIFO_WATERMARK_EN;
+		writel_relaxed(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
+	}
+
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(uport);
 }
@@ -811,8 +824,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
 	}
 
-	if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
-	    m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
+	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
 		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
 					geni_status & M_GENI_CMD_ACTIVE);
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

