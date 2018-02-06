Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeBFMDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:03:31 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:54680 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeBFMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:03:03 -0500
X-Auth-Info: E8/J9Kt7BBrzreS2TI95YO7LIwb9Y7sdF7Aw9XFzt1E=
From: Heiko Schocher <hs@denx.de>
To: linux-can@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Markus Marb <markus@marb.org>,
        netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH 2/2] net, can, ifi: loopback Tx message in IFI block
Date: Tue,  6 Feb 2018 13:02:35 +0100
Message-Id: <20180206120235.15167-2-hs@denx.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206120235.15167-1-hs@denx.de>
References: <20180206120235.15167-1-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current ifi driver reads first Rx messages, than loopback
the Tx message, if the IFI_CANFD_INTERRUPT_TXFIFO_REMOVE
bit is set. This can lead into the case, that Rx messages
overhelm Tx messages!

Fixed this in the following way:

Set in the IFI_CANFD_TXFIFO_DLC register the FN value to
1, so the IFI block loopsback itself the Tx message when
sended correctly on the canfd bus. Only the IFI block can
insert the Tx message in the correct place.

The linux driver now needs only to free the skb, when
the Tx message was sended correctly.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/net/can/ifi_canfd/ifi_canfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 05feb8177936..0d36cb8659ae 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -211,6 +211,7 @@ struct ifi_canfd_priv {
 	struct napi_struct	napi;
 	struct net_device	*ndev;
 	void __iomem		*base;
+	unsigned int		tx_len;
 };
 
 static void ifi_canfd_irq_enable(struct net_device *ndev, bool enable)
@@ -617,8 +618,10 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 
 	/* TX IRQ */
 	if (isr & IFI_CANFD_INTERRUPT_TXFIFO_REMOVE) {
-		stats->tx_bytes += can_get_echo_skb(ndev, 0);
+		can_free_echo_skb(ndev, 0);
+		stats->tx_bytes += priv->tx_len;
 		stats->tx_packets++;
+		priv->tx_len = 0;
 		can_led_event(ndev, CAN_LED_EVENT_TX);
 	}
 
@@ -889,6 +892,7 @@ static netdev_tx_t ifi_canfd_start_xmit(struct sk_buff *skb,
 	}
 
 	txdlc = can_len2dlc(cf->len);
+	priv->tx_len = txdlc;
 	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
 		txdlc |= IFI_CANFD_TXFIFO_DLC_EDL;
 		if (cf->flags & CANFD_BRS)
@@ -898,6 +902,12 @@ static netdev_tx_t ifi_canfd_start_xmit(struct sk_buff *skb,
 	if (cf->can_id & CAN_RTR_FLAG)
 		txdlc |= IFI_CANFD_TXFIFO_DLC_RTR;
 
+	/*
+	 * set FNR to 1, so we get our Tx Message looped back
+	 * into RxFIFO
+	 */
+	txdlc += (1 << IFI_CANFD_TXFIFO_DLC_FNR_OFFSET);
+
 	/* message ram configuration */
 	writel(txid, priv->base + IFI_CANFD_TXFIFO_ID);
 	writel(txdlc, priv->base + IFI_CANFD_TXFIFO_DLC);
-- 
2.14.3
