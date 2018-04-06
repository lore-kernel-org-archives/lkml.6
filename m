Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx486+adE16x1XwFQ22uWBELano05s4SHvUsTCc9G5WQBNkZINwbzMCzavRBFx7EuNsEiijam
ARC-Seal: i=1; a=rsa-sha256; t=1523021214; cv=none;
        d=google.com; s=arc-20160816;
        b=ixMBhBbPo5yEurtlgPhylysiHn4ufvxx09iVh7AJhYigALoFn/mtcI7FWWbbAtnpnK
         SSEZnfD3c4tsyqUHfYgY2xd0cXK1jUnQTVmW0j4IhYxwPHb5QF1YYmYpJQAsnBGgzBYj
         vuHJQ+vGRp8+4qKVHJ366ddbmGn78qB8Jn2Q8y7hOB03YI2FzIRv70wknmPZFUNLSVSI
         SM+R+3G7l1MJ1XXL3W/UngxxH2fHCNY0GHPDuD0wbJIhkn5Rvo0LkylzkiW6E4cooM+z
         bsfF2bstIQ4c/ey/5kO2YLCr+WqwcnjxVZ2zKIocVZdVavG0Byr/C0btlcLA4O/F+GqE
         BTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7i1yh+Yz7wJAhckJisfXc6CGj+vKZ+VXjhKBVMT2l3U=;
        b=X7nkaUDCetXjwISK7gMGy5IhgJbnE4BPYbx2BPkZpLu/sDh2m+rb13V/eHyXCHH4IQ
         TJcoeao8osivgNFWmK4FgQ7X5c6eMEhJb6qgwX+mluAZHdAQNUWZNQA2EJJrkF/8Mw32
         555TWMGlLwskrKRvJMDpxrL5RnLjQYHu5KdsJKN7izUCYoaajNadZtfnvSiS5tozdNtN
         Pa79tEjDVtSRGW8BOFzaUW3khSJV+G1NnYGZJVO5FKcr/h2zGvbrzrXsCL4zDkxSVA0q
         pc6lbrPXtH8kYkqIzJFfyN9PbI1tcpSjeeluP+PP2ajkol62cO8EIxSxZrkHlvTvvwjn
         VgZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andri Yngvason <andri.yngvason@marel.com>,
	Richard Weinberger <richard@nod.at>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3.18 17/93] can: cc770: Fix queue stall & dropped RTR reply
Date: Fri,  6 Apr 2018 15:22:46 +0200
Message-Id: <20180406084225.736445735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003492379897808?=
X-GMAIL-MSGID: =?utf-8?q?1597003492379897808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |   94 +++++++++++++++++++++++++++++-------------
 drivers/net/can/cc770/cc770.h |    2 
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
