Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D96C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C302B217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeLSSR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:17:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeLSSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:17:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so9792943pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gFiQ6Cd6LqoiqWhSF4c+voiZBdlsxof1yD663f/ytmQ=;
        b=cRjrrE7By9hS19P8lvRgJHI2Liw4jUrcxpwS7Gqz10GarPz/MIkznVbTlzcnB6gd/S
         KurKvamYluTv2iXv/rkoK8O5+P2rPPbeRTpnOqNMIoO5tklKYb13/RHvTIJsM6LSu6Qu
         ojmDzGB5bauq49OusxwkbfBT3vEIXqU6lPYrRj6XDhDQj2aZdNkqdhRdBJyxVlp50B7j
         7uhcijl4Mw/VEgwSOM5O+qIU7Pkt1VmbGogmgJB6hjk2wA0pu1uU7J99cy6EaijRgzFp
         hGu+JeOaFv9XhVgwPzclI9DC3vY3wvm+YesrDlhYBRC92u6w/ju0+3oE8Y23Vs+hLGnc
         wFyw==
X-Gm-Message-State: AA+aEWZk5SkEKpTnZ4MySj2J/ouWizE6zylsu3Pjad4BDy2OpWcCkKjS
        Mt49O8N4ZAvwopIl09UhWKkv6g==
X-Google-Smtp-Source: AFSGD/WXpgZbCVYFedKXsxFmZo/RXOyurWa4gErZwMludblmlHdc0MUy8yTkvCKZkyOZ7TsQokFjUw==
X-Received: by 2002:a62:130c:: with SMTP id b12mr21543798pfj.247.1545243474412;
        Wed, 19 Dec 2018 10:17:54 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x186sm28487121pfb.59.2018.12.19.10.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 10:17:53 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Fix wrap around of TX buffer
Date:   Wed, 19 Dec 2018 10:17:47 -0800
Message-Id: <20181219181747.118278-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix
softlock") the size of TX transfers was limited to the TX FIFO size,
and wrap arounds of the UART circular buffer were split into two
transfers. With the commit wrap around are allowed within a transfer.
The TX FIFO of the geni serial port uses a word size of 4 bytes. In
case of a circular buffer wrap within a transfer the driver currently
may write an incomplete word to the FIFO, with some bytes containing
data from the circular buffer and others being zero. Since the
transfer isn't completed yet the zero bytes are sent as if they were
actual data.

Handle wrap arounds of the TX buffer properly and ensure that words
written to the TX FIFO always contain valid data (unless the transfer
is completed).

Fixes: a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix softlock")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index cf7a95e339ad9..2ee2d3286a6b4 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -744,7 +744,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 	avail *= port->tx_bytes_pw;
 
 	tail = xmit->tail;
-	chunk = min3(avail, pending, (size_t)(UART_XMIT_SIZE - tail));
+	chunk = min(avail, pending);
 	if (!chunk)
 		goto out_write_wakeup;
 
@@ -766,19 +766,21 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
 		memset(buf, 0, ARRAY_SIZE(buf));
 		tx_bytes = min_t(size_t, remaining, port->tx_bytes_pw);
-		for (c = 0; c < tx_bytes ; c++)
-			buf[c] = xmit->buf[tail + c];
+
+		for (c = 0; c < tx_bytes ; c++) {
+			buf[c] = xmit->buf[tail++];
+			tail &= UART_XMIT_SIZE - 1;
+		}
 
 		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
 
 		i += tx_bytes;
-		tail += tx_bytes;
 		uport->icount.tx += tx_bytes;
 		remaining -= tx_bytes;
 		port->tx_remaining -= tx_bytes;
 	}
 
-	xmit->tail = tail & (UART_XMIT_SIZE - 1);
+	xmit->tail = tail;
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had
-- 
2.20.0.405.gbc1bbc6f85-goog

