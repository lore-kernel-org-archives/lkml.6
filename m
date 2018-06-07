Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p9KMHGk9GVv2QAAAmS7hNA
	; Thu, 07 Jun 2018 14:13:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 75C91607DC; Thu,  7 Jun 2018 14:13:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 837D7602FC;
	Thu,  7 Jun 2018 14:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 837D7602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933169AbeFGOLw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:11:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39551 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933167AbeFGOJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:40 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0005hK-OD; Thu, 07 Jun 2018 15:09:13 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Ed-JU; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Richard Weinberger" <richard@nod.at>,
        "Andri Yngvason" <andri.yngvason@marel.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.83161550@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 349/410] can: cc770: Fix queue stall & dropped RTR reply
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit 746201235b3f876792099079f4c6fea941d76183 upstream.

While waiting for the TX object to send an RTR, an external message with a
matching id can overwrite the TX data. In this case we must call the rx
routine and then try transmitting the message that was overwritten again.

The queue was being stalled because the RX event did not generate an
interrupt to wake up the queue again and the TX event did not happen
because the TXRQST flag is reset by the chip when new data is received.

According to the CC770 datasheet the id of a message object should not be
changed while the MSGVAL bit is set. This has been fixed by resetting the
MSGVAL bit before modifying the object in the transmit function and setting
it after. It is not enough to set & reset CPUUPD.

It is important to keep the MSGVAL bit reset while the message object is
being modified. Otherwise, during RTR transmission, a frame with matching
id could trigger an rx-interrupt, which would cause a race condition
between the interrupt routine and the transmit function.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Tested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/cc770/cc770.c | 94 ++++++++++++++++++++++++-----------
 drivers/net/can/cc770/cc770.h |  2 +
 2 files changed, 68 insertions(+), 28 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -390,37 +390,23 @@ static int cc770_get_berr_counter(const
 	return 0;
 }
 
-static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static void cc770_tx(struct net_device *dev, int mo)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+	struct can_frame *cf = (struct can_frame *)priv->tx_skb->data;
 	u8 dlc, rtr;
 	u32 id;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
-		return NETDEV_TX_OK;
-
-	if ((cc770_read_reg(priv,
-			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
-		netdev_err(dev, "TX register is still occupied!\n");
-		return NETDEV_TX_BUSY;
-	}
-
-	netif_stop_queue(dev);
-
 	dlc = cf->can_dlc;
 	id = cf->can_id;
-	if (cf->can_id & CAN_RTR_FLAG)
-		rtr = 0;
-	else
-		rtr = MSGCFG_DIR;
+	rtr = cf->can_id & CAN_RTR_FLAG ? 0 : MSGCFG_DIR;
+
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_RES | TXRQST_RES | CPUUPD_SET | NEWDAT_RES);
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_SET | TXIE_SET | RXIE_RES | INTPND_RES);
+
 	if (id & CAN_EFF_FLAG) {
 		id &= CAN_EFF_MASK;
 		cc770_write_reg(priv, msgobj[mo].config,
@@ -439,13 +425,30 @@ static netdev_tx_t cc770_start_xmit(stru
 	for (i = 0; i < dlc; i++)
 		cc770_write_reg(priv, msgobj[mo].data[i], cf->data[i]);
 
-	/* Store echo skb before starting the transfer */
-	can_put_echo_skb(skb, dev, 0);
-
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
-			RMTPND_RES | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+			RMTPND_UNC | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_SET | TXIE_SET | RXIE_SET | INTPND_UNC);
+}
+
+static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct cc770_priv *priv = netdev_priv(dev);
+	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	netif_stop_queue(dev);
+
+	if ((cc770_read_reg(priv,
+			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
+		netdev_err(dev, "TX register is still occupied!\n");
+		return NETDEV_TX_BUSY;
+	}
 
-	stats->tx_bytes += dlc;
+	priv->tx_skb = skb;
+	cc770_tx(dev, mo);
 
 	return NETDEV_TX_OK;
 }
@@ -670,13 +673,47 @@ static void cc770_tx_interrupt(struct ne
 	struct cc770_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	unsigned int mo = obj2msgobj(o);
+	struct can_frame *cf;
+	u8 ctrl1;
+
+	ctrl1 = cc770_read_reg(priv, msgobj[mo].ctrl1);
 
-	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
+	cc770_write_reg(priv, msgobj[mo].ctrl1,
+			RMTPND_RES | TXRQST_RES | MSGLST_RES | NEWDAT_RES);
 
-	stats->tx_packets++;
+	if (unlikely(!priv->tx_skb)) {
+		netdev_err(dev, "missing tx skb in tx interrupt\n");
+		return;
+	}
+
+	if (unlikely(ctrl1 & MSGLST_SET)) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+	}
+
+	/* When the CC770 is sending an RTR message and it receives a regular
+	 * message that matches the id of the RTR message, it will overwrite the
+	 * outgoing message in the TX register. When this happens we must
+	 * process the received message and try to transmit the outgoing skb
+	 * again.
+	 */
+	if (unlikely(ctrl1 & NEWDAT_SET)) {
+		cc770_rx(dev, mo, ctrl1);
+		cc770_tx(dev, mo);
+		return;
+	}
+
+	can_put_echo_skb(priv->tx_skb, dev, 0);
 	can_get_echo_skb(dev, 0);
+
+	cf = (struct can_frame *)priv->tx_skb->data;
+	stats->tx_bytes += cf->can_dlc;
+	stats->tx_packets++;
+
+	priv->tx_skb = NULL;
+
 	netif_wake_queue(dev);
 }
 
@@ -788,6 +825,7 @@ struct net_device *alloc_cc770dev(int si
 	priv->can.do_set_bittiming = cc770_set_bittiming;
 	priv->can.do_set_mode = cc770_set_mode;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
+	priv->tx_skb = NULL;
 
 	memcpy(priv->obj_flags, cc770_obj_flags, sizeof(cc770_obj_flags));
 
--- a/drivers/net/can/cc770/cc770.h
+++ b/drivers/net/can/cc770/cc770.h
@@ -193,6 +193,8 @@ struct cc770_priv {
 	u8 cpu_interface;	/* CPU interface register */
 	u8 clkout;		/* Clock out register */
 	u8 bus_config;		/* Bus conffiguration register */
+
+	struct sk_buff *tx_skb;
 };
 
 struct net_device *alloc_cc770dev(int sizeof_priv);
