Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C77C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B355721104
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VyuTJZdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B355721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeLMTn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:43:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41664 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeLMTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:43:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so1507095pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OW0nMljRvOSqvoSd2jmdZZH8Ftrw0r5xrrRavReTO7g=;
        b=VyuTJZdF0XcZQSwpZMvxcpPU/C7R1WHQxSFM/YWY4hldN2Cf3DbDfBr65cIMNEol8Y
         uf7hW6AOSAej7NSx16VKpXhLNFcmfcXMIJybpqcZW9Wy5W17WIQ72gXDUiOGCOtSccLv
         o7O22983VDLBM6+8hgo0q1cz8JZT1cD/MY0B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OW0nMljRvOSqvoSd2jmdZZH8Ftrw0r5xrrRavReTO7g=;
        b=JiG+kSvpcki7GASS2aLVw/7R+bWgY2q8VWYltVvvxy0D46p9LI+kJXj9g7TBYmQnO+
         r6fjtlG86ThhSWCpf/MhgC7J0hDVD6xKN5nn56tv/03BdEuHnDNFGR36BabFqUv8HAnB
         PWhig2bDTP3K+M4yf4SygdZ7oW7RO2bKebS8+EdHrQKLSJX4qu/pl/GP4ImYgop3e5rd
         GQXIu2s1nR2W5wO3+vFNxBjADTTBbcIlGOYjNyDacXJotb/OQajeuHyG9WNk9+FmGKmE
         8FH8dYjYJeU/aKuWLQVxIpIWe0WNqsHM9gqpfoqvwg5zb19MMChWKQkz8+0eIHwFDlvX
         uRPA==
X-Gm-Message-State: AA+aEWbfZPTI6D84gxrJGZEjCpfNILQb5PQIEm7060/S4ZwHOh8aXHYX
        vd0M66iiIm6FxnM+5w9k4XWiWw==
X-Google-Smtp-Source: AFSGD/WulkL++EXOeaYI1nye5KYZ5SUm17EHGe4qtxYib3KRYy+O6HGHhVuQnU1XXBBIB4deGN6/sQ==
X-Received: by 2002:a63:2109:: with SMTP id h9mr74628pgh.277.1544730207319;
        Thu, 13 Dec 2018 11:43:27 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id i184sm5259320pfc.41.2018.12.13.11.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:43:26 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2] tty: serial: qcom_geni_serial: Remove interrupt storm
Date:   Thu, 13 Dec 2018 11:43:20 -0800
Message-Id: <20181213194321.240148-1-ryandcase@chromium.org>
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

Changes in v2:
Addressed Doug's comments
 - Avoid M_TX_WATERMARK_EN writes when values already match
 - Added note about M_TX_WATERMARK_EN triggering and latching

 drivers/tty/serial/qcom_geni_serial.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6e38498362ef..0c93beb69e73 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -724,6 +724,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	size_t pending;
 	int i;
 	u32 status;
+	u32 irq_en;
 	unsigned int chunk;
 	int tail;
 
@@ -752,6 +753,11 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	if (!port->tx_remaining) {
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
+
+		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
+			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+					uport->membase + SE_GENI_M_IRQ_EN);
 	}
 
 	remaining = chunk;
@@ -775,7 +781,23 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	}
 
 	xmit->tail = tail & (UART_XMIT_SIZE - 1);
+
+	/*
+	 * The tx fifo watermark is level triggered and latched. Though we had
+	 * cleared it in qcom_geni_serial_isr it will have already reasserted
+	 * so we must clear it again here after our writes.
+	 */
+	writel_relaxed(M_TX_FIFO_WATERMARK_EN,
+			uport->membase + SE_GENI_M_IRQ_CLEAR);
+
 out_write_wakeup:
+	if (!port->tx_remaining) {
+		irq_en = readl_relaxed(uport->membase + SE_GENI_M_IRQ_EN);
+		if (irq_en & M_TX_FIFO_WATERMARK_EN)
+			writel_relaxed(irq_en & ~M_TX_FIFO_WATERMARK_EN,
+					uport->membase + SE_GENI_M_IRQ_EN);
+	}
+
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(uport);
 }
@@ -811,8 +833,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
 	}
 
-	if (m_irq_status & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN) &&
-	    m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
+	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
 		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
 					geni_status & M_GENI_CMD_ACTIVE);
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

