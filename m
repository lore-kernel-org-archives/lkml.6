Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5251C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A12920675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895472;
	bh=D+vhLWJYRHFnrnTCB3LuxHeOXUWvnVhZ2cKZDFu9r2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bp3h7WS3u854cT0eZJ9aDf4KnrQIdr66NckSc0fLlZjzkX0pH/Mm+ktfTiAH/6UR8
	 hGT7aqPi7fb0fly1cEPov7V83JV/+8jAGpwQzkgbFJ1ZMdZqAlMvfnCVWh3VbRg/nJ
	 KVCVslRsuUgLtKr5aKgoZAzetxqpeFxcGKyD8/fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfBKObK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:31:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbfBKObH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C612B20675;
        Mon, 11 Feb 2019 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895467;
        bh=D+vhLWJYRHFnrnTCB3LuxHeOXUWvnVhZ2cKZDFu9r2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8e829+8PNaqUy/UM06JkRCf4Q9q0NkWGu6s0IjZJCjI+mlxLIhvvq4GGyaS+8Qkd
         S9JciBoniMkKI/c7HJ7PMpmOLqClfGT4UAIoPL9jKtAc4ZvlEL6gkWQBEOatAND0vk
         w661u+BTjEBXYmsr9j5FyRv+BwGoAy47Jdtb4sD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 183/352] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Date:   Mon, 11 Feb 2019 15:16:50 +0100
Message-Id: <20190211141858.751418868@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 71ab1c0336c71ace5725740f200beca9667a339f ]

On (H)SCIF, sci_submit_rx() is called in the receive interrupt handler.
Hence if DMA submission fails, the interrupt handler should resume
handling reception using PIO, else no more data is received.

Make sci_submit_rx() return an error indicator, so the receive interrupt
handler can act appropriately.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 613007d7165e..21fd3f6ad28e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1331,7 +1331,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 	dma_release_channel(chan);
 }
 
-static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
+static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
@@ -1359,7 +1359,7 @@ static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
 	s->active_rx = s->cookie_rx[0];
 
 	dma_async_issue_pending(chan);
-	return;
+	return 0;
 
 fail:
 	/* Switch to PIO */
@@ -1374,6 +1374,7 @@ fail:
 	sci_start_rx(port);
 	if (!port_lock_held)
 		spin_unlock_irqrestore(&port->lock, flags);
+	return -EAGAIN;
 }
 
 static void work_fn_tx(struct work_struct *work)
@@ -1668,8 +1669,10 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 			disable_irq_nosync(irq);
 			scr |= SCSCR_RDRQE;
 		} else {
+			if (sci_submit_rx(s, false) < 0)
+				goto handle_pio;
+
 			scr &= ~SCSCR_RIE;
-			sci_submit_rx(s, false);
 		}
 		serial_port_out(port, SCSCR, scr);
 		/* Clear current interrupt */
@@ -1681,6 +1684,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 
 		return IRQ_HANDLED;
 	}
+
+handle_pio:
 #endif
 
 	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0) {
-- 
2.19.1



