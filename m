Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BCCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F080222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899741;
	bh=8mlOSWb4ShClfox0s19CCQ4mSz+ovXEUhPLUgxkxV4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hcYpZl3OTVw3wtPFXatvezQ0lVQXgalERlVqAG17/9nATRd06BFEZho0eEUQAO+fS
	 xEbKkY8mWSg3HVNPKMIQ/aYRBx3eUqKhhZ162r32JYY3nzSgt7H7Rv4tZN/10+1ukA
	 0UR7sbd3cQOeittJJhLfQxJ5N3PjRXPsSCKdf04k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfBKPmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733282AbfBKOql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1203A20700;
        Mon, 11 Feb 2019 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896400;
        bh=8mlOSWb4ShClfox0s19CCQ4mSz+ovXEUhPLUgxkxV4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTnDGdcXD1rlr49rXZdbKB0weAgNVGEcaUvjygGaCEx0PzVh/5gX9XVXnNi8JnWJ5
         SggdrMxr7yFnAYgy+6yZS2PfGRpmvOHLYZwjegNIzSP3ex5lGyMj5wVqLYr0OmNmgy
         QWsU/fV/T5+6/IX6uh/GXDds3KYhRwTdqzTyqjz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 154/313] serial: sh-sci: Fix locking in sci_submit_rx()
Date:   Mon, 11 Feb 2019 15:17:14 +0100
Message-Id: <20190211141903.818428347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index effba6ce0caa..5fdd7944b73b 100644
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



