Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4594C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7169A21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867250;
	bh=KjW24aSySuhgySqJdoDNd6ojO+ordbvwqJMfN6mmk9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZeGfbuFtC6CbvtG78VJvm0+a38ujJqYFVtF8i3RiKzqMzO+fYibAjWynBoOKXvn7
	 Vj+rg7YCHLBjZ4NCOFJLo4g26sO2XjkRnodkR1TMZMMC516OF33v/TWFZkRtbEl0z2
	 ELpH4Il3IkJOEctamo9iYwNAjDjvQxo6srDWgxI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfAGNUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfAGMph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8220218A1;
        Mon,  7 Jan 2019 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865136;
        bh=KjW24aSySuhgySqJdoDNd6ojO+ordbvwqJMfN6mmk9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMVJtq/UdbWsVAMQdIWkPtp7um+vPPVomupkSCYLbEM/AZd66AHGL/sWNJJZTz81t
         ekO1Lj2H2cz+TVryqj4GXDL9HC9SlsXxzweopMwydJGh8FFK56Of84jeKR4UJ0qebi
         UKJuPFKyPW+uyCez5n4FIgchQFI9GEq6vWVf1IDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 015/170] net: macb: restart tx after tx used bit read
Date:   Mon,  7 Jan 2019 13:30:42 +0100
Message-Id: <20190107104454.832732956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 4298388574dae6168fa8940b3edc7ba965e8a7ab ]

On some platforms (currently detected only on SAMA5D4) TX might stuck
even the pachets are still present in DMA memories and TX start was
issued for them. This happens due to race condition between MACB driver
updating next TX buffer descriptor to be used and IP reading the same
descriptor. In such a case, the "TX USED BIT READ" interrupt is asserted.
GEM/MACB user guide specifies that if a "TX USED BIT READ" interrupt
is asserted TX must be restarted. Restart TX if used bit is read and
packets are present in software TX queue. Packets are removed from software
TX queue if TX was successful for them (see macb_tx_interrupt()).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -61,7 +61,8 @@
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
 					| MACB_BIT(ISR_RLE)		\
 					| MACB_BIT(TXERR))
-#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP))
+#define MACB_TX_INT_FLAGS	(MACB_TX_ERR_FLAGS | MACB_BIT(TCOMP)	\
+					| MACB_BIT(TXUBR))
 
 /* Max length of transmit frame must be a multiple of 8 bytes */
 #define MACB_TX_LEN_ALIGN	8
@@ -1313,6 +1314,21 @@ static void macb_hresp_error_task(unsign
 	netif_tx_start_all_queues(dev);
 }
 
+static void macb_tx_restart(struct macb_queue *queue)
+{
+	unsigned int head = queue->tx_head;
+	unsigned int tail = queue->tx_tail;
+	struct macb *bp = queue->bp;
+
+	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+		queue_writel(queue, ISR, MACB_BIT(TXUBR));
+
+	if (head == tail)
+		return;
+
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+}
+
 static irqreturn_t macb_interrupt(int irq, void *dev_id)
 {
 	struct macb_queue *queue = dev_id;
@@ -1370,6 +1386,9 @@ static irqreturn_t macb_interrupt(int ir
 		if (status & MACB_BIT(TCOMP))
 			macb_tx_interrupt(queue);
 
+		if (status & MACB_BIT(TXUBR))
+			macb_tx_restart(queue);
+
 		/* Link change detection isn't possible with RMII, so we'll
 		 * add that if/when we get our hands on a full-blown MII PHY.
 		 */


