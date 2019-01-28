Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B54AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C11C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690798;
	bh=w/V69oehWZgZVfladWi/weszw6y6QVrDQei9A5BVSHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJqYANY6PaTxaHjmj4FGzjbj3lRd0Ra8GU4gNIsRsL4A5ArtC/FY7EF7qbXzdxtmr
	 HxZS+PJ7v/dvixxIeqyCB+yL5m0O2uY7FoVnuSh+Pj8VbtlQ0CtyNJPkC0veneKYDw
	 U5VN85b+/FW9ovOZ7NEmr8n7NZzELDWH6lawmFBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfA1PxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbfA1PxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B252420880;
        Mon, 28 Jan 2019 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690791;
        bh=w/V69oehWZgZVfladWi/weszw6y6QVrDQei9A5BVSHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywbF+DQ9bYe3ABB0iEvEoRH/l5QCPnsiVaESz5DuMlQ1jRXKXW7/I9FYpt+NbQhwL
         +VlObzmjyRZmMw8d4W2IvXx7ET0+RFO8OSeNEfssENX5a6BqCoQcJLme5TM/gN9+yp
         SSIybpy9/tqPdY+wqUBKOvRtbixMuOnFLvLr50aA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 194/304] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Date:   Mon, 28 Jan 2019 10:41:51 -0500
Message-Id: <20190128154341.47195-194-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

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

