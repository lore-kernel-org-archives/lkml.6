Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72800C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4263921741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690795;
	bh=IkxOmtWqrTZIC0pVGVAwZCgJOCuwIKwRkJF+mo75mD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wtHcJVBNzaQEiFvp2yIKPtjn7sdihuALhaRsbpo6GRRlMpCcu2ATpMVCgrsHN+EAk
	 jqcDfkdzqwFs6eqhcVfliDUJ6V+PaAbHB/sb78F8dCLs35sxP0szCKQjLBVMbGNU9a
	 63V2C5uYOPIggQoPQ8LfwfBwxEpQCTcZCGztzX74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfA1PxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbfA1PxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10622147A;
        Mon, 28 Jan 2019 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690788;
        bh=IkxOmtWqrTZIC0pVGVAwZCgJOCuwIKwRkJF+mo75mD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5ZTINYTi8nymRe1/NyWYNwApxBC3v0W6kdwVaLp1nXmdPnJNsHCDbT6pbVKLUyLH
         Kf/NznD4qJsnuYwqffV5wDHRaXBdj2vMiFHVUdazuhtWMwKPBYKxOtv7XksMv83SJZ
         o7NTdpQomZbrM3Jgx+wCRBDG3dITSoJmAVWfQXt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 193/304] serial: sh-sci: Fix locking in sci_submit_rx()
Date:   Mon, 28 Jan 2019 10:41:50 -0500
Message-Id: <20190128154341.47195-193-sashal@kernel.org>
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

[ Upstream commit dd1f2250da95e87cb3e612858f94b14f99445a7c ]

Some callers of sci_submit_rx() hold the port spinlock, others don't.
During fallback to PIO, the driver needs to obtain the port spinlock.
If the lock was already held, spinlock recursion is detected, causing a
deadlock: BUG: spinlock recursion on CPU#0.

Fix this by adding a flag parameter to sci_submit_rx() for the caller to
indicate the port spinlock is already held, so spinlock recursion can be
avoided.

Move the spin_lock_irqsave() up, so all DMA disable steps are protected,
which is safe as the recently introduced dmaengine_terminate_async() can
be called in atomic context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cc56cb3b3eca..613007d7165e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1331,7 +1331,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 	dma_release_channel(chan);
 }
 
-static void sci_submit_rx(struct sci_port *s)
+static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
@@ -1362,16 +1362,18 @@ static void sci_submit_rx(struct sci_port *s)
 	return;
 
 fail:
+	/* Switch to PIO */
+	if (!port_lock_held)
+		spin_lock_irqsave(&port->lock, flags);
 	if (i)
 		dmaengine_terminate_async(chan);
 	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
 	s->active_rx = -EINVAL;
-	/* Switch to PIO */
-	spin_lock_irqsave(&port->lock, flags);
 	s->chan_rx = NULL;
 	sci_start_rx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	if (!port_lock_held)
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void work_fn_tx(struct work_struct *work)
@@ -1491,7 +1493,7 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	}
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
-		sci_submit_rx(s);
+		sci_submit_rx(s, true);
 
 	/* Direct new serial port interrupts back to CPU */
 	scr = serial_port_in(port, SCSCR);
@@ -1617,7 +1619,7 @@ static void sci_request_dma(struct uart_port *port)
 		s->chan_rx_saved = s->chan_rx = chan;
 
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
-			sci_submit_rx(s);
+			sci_submit_rx(s, false);
 	}
 }
 
@@ -1667,7 +1669,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 			scr |= SCSCR_RDRQE;
 		} else {
 			scr &= ~SCSCR_RIE;
-			sci_submit_rx(s);
+			sci_submit_rx(s, false);
 		}
 		serial_port_out(port, SCSCR, scr);
 		/* Clear current interrupt */
-- 
2.19.1

