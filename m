Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1730C20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1730C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeKLGOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:14:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50966 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730660AbeKLFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsn-0000lM-8U; Sun, 11 Nov 2018 19:58:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001lk-UO; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Anssi Hannula" <anssi.hannula@bitwise.fi>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.563250478@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 284/366] can: xilinx_can: keep only 1-2 frames in TX
 FIFO to fix TX accounting
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 620050d9c2be15c47017ba95efe59e0832e99a56 upstream.

The xilinx_can driver assumes that the TXOK interrupt only clears after
it has been acknowledged as many times as there have been successfully
sent frames.

However, the documentation does not mention such behavior, instead
saying just that the interrupt is cleared when the clear bit is set.

Similarly, testing seems to also suggest that it is immediately cleared
regardless of the amount of frames having been sent. Performing some
heavy TX load and then going back to idle has the tx_head drifting
further away from tx_tail over time, steadily reducing the amount of
frames the driver keeps in the TX FIFO (but not to zero, as the TXOK
interrupt always frees up space for 1 frame from the driver's
perspective, so frames continue to be sent) and delaying the local echo
frames.

The TX FIFO tracking is also otherwise buggy as it does not account for
TX FIFO being cleared after software resets, causing
  BUG!, TX FIFO full when queue awake!
messages to be output.

There does not seem to be any way to accurately track the state of the
TX FIFO for local echo support while using the full TX FIFO.

The Zynq version of the HW (but not the soft-AXI version) has watermark
programming support and with it an additional TX-FIFO-empty interrupt
bit.

Modify the driver to only put 1 frame into TX FIFO at a time on soft-AXI
and 2 frames at a time on Zynq. On Zynq the TXFEMP interrupt bit is used
to detect whether 1 or 2 frames have been sent at interrupt processing
time.

Tested with the integrated CAN on Zynq-7000 SoC. The 1-frame-FIFO mode
was also tested.

An alternative way to solve this would be to drop local echo support but
keep using the full TX FIFO.

v2: Add FIFO space check before TX queue wake with locking to
synchronize with queue stop. This avoids waking the queue when xmit()
had just filled it.

v3: Keep local echo support and reduce the amount of frames in FIFO
instead as suggested by Marc Kleine-Budde.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/xilinx_can.c | 139 +++++++++++++++++++++++++++++++----
 1 file changed, 123 insertions(+), 16 deletions(-)

--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -26,8 +26,10 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/can/dev.h>
@@ -118,6 +120,7 @@ enum xcan_reg {
 /**
  * struct xcan_priv - This definition define CAN driver instance
  * @can:			CAN private data structure.
+ * @tx_lock:			Lock for synchronizing TX interrupt handling
  * @tx_head:			Tx CAN packets ready to send on the queue
  * @tx_tail:			Tx CAN packets successfully sended on the queue
  * @tx_max:			Maximum number packets the driver can send
@@ -132,6 +135,7 @@ enum xcan_reg {
  */
 struct xcan_priv {
 	struct can_priv can;
+	spinlock_t tx_lock;
 	unsigned int tx_head;
 	unsigned int tx_tail;
 	unsigned int tx_max;
@@ -159,6 +163,11 @@ static const struct can_bittiming_const
 	.brp_inc = 1,
 };
 
+#define XCAN_CAP_WATERMARK	0x0001
+struct xcan_devtype_data {
+	unsigned int caps;
+};
+
 /**
  * xcan_write_reg_le - Write a value to the device register little endian
  * @priv:	Driver private data structure
@@ -238,6 +247,10 @@ static int set_reset_mode(struct net_dev
 		usleep_range(500, 10000);
 	}
 
+	/* reset clears FIFOs */
+	priv->tx_head = 0;
+	priv->tx_tail = 0;
+
 	return 0;
 }
 
@@ -391,6 +404,7 @@ static int xcan_start_xmit(struct sk_buf
 	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 id, dlc, data[2] = {0, 0};
+	unsigned long flags;
 
 	if (can_dropped_invalid_skb(ndev, skb))
 		return NETDEV_TX_OK;
@@ -438,6 +452,9 @@ static int xcan_start_xmit(struct sk_buf
 		data[1] = be32_to_cpup((__be32 *)(cf->data + 4));
 
 	can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max);
+
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
 	priv->tx_head++;
 
 	/* Write the Frame to Xilinx CAN TX FIFO */
@@ -453,10 +470,16 @@ static int xcan_start_xmit(struct sk_buf
 		stats->tx_bytes += cf->can_dlc;
 	}
 
+	/* Clear TX-FIFO-empty interrupt for xcan_tx_interrupt() */
+	if (priv->tx_max > 1)
+		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXFEMP_MASK);
+
 	/* Check if the TX buffer is full */
 	if ((priv->tx_head - priv->tx_tail) == priv->tx_max)
 		netif_stop_queue(ndev);
 
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 	return NETDEV_TX_OK;
 }
 
@@ -833,19 +856,71 @@ static void xcan_tx_interrupt(struct net
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
+	unsigned int frames_in_fifo;
+	int frames_sent = 1; /* TXOK => at least 1 frame was sent */
+	unsigned long flags;
+	int retries = 0;
+
+	/* Synchronize with xmit as we need to know the exact number
+	 * of frames in the FIFO to stay in sync due to the TXFEMP
+	 * handling.
+	 * This also prevents a race between netif_wake_queue() and
+	 * netif_stop_queue().
+	 */
+	spin_lock_irqsave(&priv->tx_lock, flags);
+
+	frames_in_fifo = priv->tx_head - priv->tx_tail;
+
+	if (WARN_ON_ONCE(frames_in_fifo == 0)) {
+		/* clear TXOK anyway to avoid getting back here */
+		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
+		spin_unlock_irqrestore(&priv->tx_lock, flags);
+		return;
+	}
+
+	/* Check if 2 frames were sent (TXOK only means that at least 1
+	 * frame was sent).
+	 */
+	if (frames_in_fifo > 1) {
+		WARN_ON(frames_in_fifo > priv->tx_max);
+
+		/* Synchronize TXOK and isr so that after the loop:
+		 * (1) isr variable is up-to-date at least up to TXOK clear
+		 *     time. This avoids us clearing a TXOK of a second frame
+		 *     but not noticing that the FIFO is now empty and thus
+		 *     marking only a single frame as sent.
+		 * (2) No TXOK is left. Having one could mean leaving a
+		 *     stray TXOK as we might process the associated frame
+		 *     via TXFEMP handling as we read TXFEMP *after* TXOK
+		 *     clear to satisfy (1).
+		 */
+		while ((isr & XCAN_IXR_TXOK_MASK) && !WARN_ON(++retries == 100)) {
+			priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
+			isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
+		}
 
-	while ((priv->tx_head - priv->tx_tail > 0) &&
-			(isr & XCAN_IXR_TXOK_MASK)) {
+		if (isr & XCAN_IXR_TXFEMP_MASK) {
+			/* nothing in FIFO anymore */
+			frames_sent = frames_in_fifo;
+		}
+	} else {
+		/* single frame in fifo, just clear TXOK */
 		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
+	}
+
+	while (frames_sent--) {
 		can_get_echo_skb(ndev, priv->tx_tail %
 					priv->tx_max);
 		priv->tx_tail++;
 		stats->tx_packets++;
-		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	}
+
+	netif_wake_queue(ndev);
+
+	spin_unlock_irqrestore(&priv->tx_lock, flags);
+
 	can_led_event(ndev, CAN_LED_EVENT_TX);
 	xcan_update_error_state_after_rxtx(ndev);
-	netif_wake_queue(ndev);
 }
 
 /**
@@ -1121,6 +1196,18 @@ static int __maybe_unused xcan_resume(st
 
 static SIMPLE_DEV_PM_OPS(xcan_dev_pm_ops, xcan_suspend, xcan_resume);
 
+static const struct xcan_devtype_data xcan_zynq_data = {
+	.caps = XCAN_CAP_WATERMARK,
+};
+
+/* Match table for OF platform binding */
+static const struct of_device_id xcan_of_match[] = {
+	{ .compatible = "xlnx,zynq-can-1.0", .data = &xcan_zynq_data },
+	{ .compatible = "xlnx,axi-can-1.00.a", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, xcan_of_match);
+
 /**
  * xcan_probe - Platform registration call
  * @pdev:	Handle to the platform device structure
@@ -1135,8 +1222,10 @@ static int xcan_probe(struct platform_de
 	struct resource *res; /* IO mem resources */
 	struct net_device *ndev;
 	struct xcan_priv *priv;
+	const struct of_device_id *of_id;
+	int caps = 0;
 	void __iomem *addr;
-	int ret, rx_max, tx_max;
+	int ret, rx_max, tx_max, tx_fifo_depth;
 
 	/* Get the virtual base address for the device */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1146,7 +1235,8 @@ static int xcan_probe(struct platform_de
 		goto err;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "tx-fifo-depth", &tx_max);
+	ret = of_property_read_u32(pdev->dev.of_node, "tx-fifo-depth",
+				   &tx_fifo_depth);
 	if (ret < 0)
 		goto err;
 
@@ -1154,6 +1244,30 @@ static int xcan_probe(struct platform_de
 	if (ret < 0)
 		goto err;
 
+	of_id = of_match_device(xcan_of_match, &pdev->dev);
+	if (of_id) {
+		const struct xcan_devtype_data *devtype_data = of_id->data;
+
+		if (devtype_data)
+			caps = devtype_data->caps;
+	}
+
+	/* There is no way to directly figure out how many frames have been
+	 * sent when the TXOK interrupt is processed. If watermark programming
+	 * is supported, we can have 2 frames in the FIFO and use TXFEMP
+	 * to determine if 1 or 2 frames have been sent.
+	 * Theoretically we should be able to use TXFWMEMP to determine up
+	 * to 3 frames, but it seems that after putting a second frame in the
+	 * FIFO, with watermark at 2 frames, it can happen that TXFWMEMP (less
+	 * than 2 frames in FIFO) is set anyway with no TXOK (a frame was
+	 * sent), which is not a sensible state - possibly TXFWMEMP is not
+	 * completely synchronized with the rest of the bits?
+	 */
+	if (caps & XCAN_CAP_WATERMARK)
+		tx_max = min(tx_fifo_depth, 2);
+	else
+		tx_max = 1;
+
 	/* Create a CAN device instance */
 	ndev = alloc_candev(sizeof(struct xcan_priv), tx_max);
 	if (!ndev)
@@ -1168,6 +1282,7 @@ static int xcan_probe(struct platform_de
 					CAN_CTRLMODE_BERR_REPORTING;
 	priv->reg_base = addr;
 	priv->tx_max = tx_max;
+	spin_lock_init(&priv->tx_lock);
 
 	/* Get IRQ for the device */
 	ndev->irq = platform_get_irq(pdev, 0);
@@ -1235,9 +1350,9 @@ static int xcan_probe(struct platform_de
 	devm_can_led_init(ndev);
 	clk_disable_unprepare(priv->bus_clk);
 	clk_disable_unprepare(priv->can_clk);
-	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx fifo depth:%d\n",
+	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx fifo depth: actual %d, using %d\n",
 			priv->reg_base, ndev->irq, priv->can.clock.freq,
-			priv->tx_max);
+			tx_fifo_depth, priv->tx_max);
 
 	return 0;
 
@@ -1273,14 +1388,6 @@ static int xcan_remove(struct platform_d
 	return 0;
 }
 
-/* Match table for OF platform binding */
-static const struct of_device_id xcan_of_match[] = {
-	{ .compatible = "xlnx,zynq-can-1.0", },
-	{ .compatible = "xlnx,axi-can-1.00.a", },
-	{ /* end of list */ },
-};
-MODULE_DEVICE_TABLE(of, xcan_of_match);
-
 static struct platform_driver xcan_driver = {
 	.probe = xcan_probe,
 	.remove	= xcan_remove,

