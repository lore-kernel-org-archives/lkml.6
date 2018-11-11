Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04401C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B214C20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B214C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbeKLGOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:14:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50970 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730664AbeKLFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsn-0000l5-M7; Sun, 11 Nov 2018 19:58:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001ld-TH; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Anssi Hannula" <anssi.hannula@bitwise.fi>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.196683228@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 283/366] can: xilinx_can: fix recovery from error
 states not being propagated
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

commit 877e0b75947e2c7acf5624331bb17ceb093c98ae upstream.

The xilinx_can driver contains no mechanism for propagating recovery
from CAN_STATE_ERROR_WARNING and CAN_STATE_ERROR_PASSIVE.

Add such a mechanism by factoring the handling of
XCAN_STATE_ERROR_PASSIVE and XCAN_STATE_ERROR_WARNING out of
xcan_err_interrupt and checking for recovery after RX and TX if the
interface is in one of those states.

Tested with the integrated CAN on Zynq-7000 SoC.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/xilinx_can.c | 155 ++++++++++++++++++++++++++++-------
 1 file changed, 127 insertions(+), 28 deletions(-)

--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -2,6 +2,7 @@
  *
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
  * Copyright (C) 2009 PetaLogix. All rights reserved.
+ * Copyright (C) 2017 Sandvik Mining and Construction Oy
  *
  * Description:
  * This driver is developed for Axi CAN IP and for Zynq CANPS Controller.
@@ -528,6 +529,123 @@ static int xcan_rx(struct net_device *nd
 }
 
 /**
+ * xcan_current_error_state - Get current error state from HW
+ * @ndev:	Pointer to net_device structure
+ *
+ * Checks the current CAN error state from the HW. Note that this
+ * only checks for ERROR_PASSIVE and ERROR_WARNING.
+ *
+ * Return:
+ * ERROR_PASSIVE or ERROR_WARNING if either is active, ERROR_ACTIVE
+ * otherwise.
+ */
+static enum can_state xcan_current_error_state(struct net_device *ndev)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	u32 status = priv->read_reg(priv, XCAN_SR_OFFSET);
+
+	if ((status & XCAN_SR_ESTAT_MASK) == XCAN_SR_ESTAT_MASK)
+		return CAN_STATE_ERROR_PASSIVE;
+	else if (status & XCAN_SR_ERRWRN_MASK)
+		return CAN_STATE_ERROR_WARNING;
+	else
+		return CAN_STATE_ERROR_ACTIVE;
+}
+
+/**
+ * xcan_set_error_state - Set new CAN error state
+ * @ndev:	Pointer to net_device structure
+ * @new_state:	The new CAN state to be set
+ * @cf:		Error frame to be populated or NULL
+ *
+ * Set new CAN error state for the device, updating statistics and
+ * populating the error frame if given.
+ */
+static void xcan_set_error_state(struct net_device *ndev,
+				 enum can_state new_state,
+				 struct can_frame *cf)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	u32 ecr = priv->read_reg(priv, XCAN_ECR_OFFSET);
+	u32 txerr = ecr & XCAN_ECR_TEC_MASK;
+	u32 rxerr = (ecr & XCAN_ECR_REC_MASK) >> XCAN_ESR_REC_SHIFT;
+
+	priv->can.state = new_state;
+
+	if (cf) {
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_PASSIVE:
+		priv->can.can_stats.error_passive++;
+		if (cf)
+			cf->data[1] = (rxerr > 127) ?
+					CAN_ERR_CRTL_RX_PASSIVE :
+					CAN_ERR_CRTL_TX_PASSIVE;
+		break;
+	case CAN_STATE_ERROR_WARNING:
+		priv->can.can_stats.error_warning++;
+		if (cf)
+			cf->data[1] |= (txerr > rxerr) ?
+					CAN_ERR_CRTL_TX_WARNING :
+					CAN_ERR_CRTL_RX_WARNING;
+		break;
+	case CAN_STATE_ERROR_ACTIVE:
+		if (cf)
+			cf->data[1] |= CAN_ERR_CRTL_ACTIVE;
+		break;
+	default:
+		/* non-ERROR states are handled elsewhere */
+		WARN_ON(1);
+		break;
+	}
+}
+
+/**
+ * xcan_update_error_state_after_rxtx - Update CAN error state after RX/TX
+ * @ndev:	Pointer to net_device structure
+ *
+ * If the device is in a ERROR-WARNING or ERROR-PASSIVE state, check if
+ * the performed RX/TX has caused it to drop to a lesser state and set
+ * the interface state accordingly.
+ */
+static void xcan_update_error_state_after_rxtx(struct net_device *ndev)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	enum can_state old_state = priv->can.state;
+	enum can_state new_state;
+
+	/* changing error state due to successful frame RX/TX can only
+	 * occur from these states
+	 */
+	if (old_state != CAN_STATE_ERROR_WARNING &&
+	    old_state != CAN_STATE_ERROR_PASSIVE)
+		return;
+
+	new_state = xcan_current_error_state(ndev);
+
+	if (new_state != old_state) {
+		struct sk_buff *skb;
+		struct can_frame *cf;
+
+		skb = alloc_can_err_skb(ndev, &cf);
+
+		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
+
+		if (skb) {
+			struct net_device_stats *stats = &ndev->stats;
+
+			stats->rx_packets++;
+			stats->rx_bytes += cf->can_dlc;
+			netif_rx(skb);
+		}
+	}
+}
+
+/**
  * xcan_err_interrupt - error frame Isr
  * @ndev:	net_device pointer
  * @isr:	interrupt status register value
@@ -542,16 +660,12 @@ static void xcan_err_interrupt(struct ne
 	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	u32 err_status, status, txerr = 0, rxerr = 0;
+	u32 err_status;
 
 	skb = alloc_can_err_skb(ndev, &cf);
 
 	err_status = priv->read_reg(priv, XCAN_ESR_OFFSET);
 	priv->write_reg(priv, XCAN_ESR_OFFSET, err_status);
-	txerr = priv->read_reg(priv, XCAN_ECR_OFFSET) & XCAN_ECR_TEC_MASK;
-	rxerr = ((priv->read_reg(priv, XCAN_ECR_OFFSET) &
-			XCAN_ECR_REC_MASK) >> XCAN_ESR_REC_SHIFT);
-	status = priv->read_reg(priv, XCAN_SR_OFFSET);
 
 	if (isr & XCAN_IXR_BSOFF_MASK) {
 		priv->can.state = CAN_STATE_BUS_OFF;
@@ -561,28 +675,10 @@ static void xcan_err_interrupt(struct ne
 		can_bus_off(ndev);
 		if (skb)
 			cf->can_id |= CAN_ERR_BUSOFF;
-	} else if ((status & XCAN_SR_ESTAT_MASK) == XCAN_SR_ESTAT_MASK) {
-		priv->can.state = CAN_STATE_ERROR_PASSIVE;
-		priv->can.can_stats.error_passive++;
-		if (skb) {
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] = (rxerr > 127) ?
-					CAN_ERR_CRTL_RX_PASSIVE :
-					CAN_ERR_CRTL_TX_PASSIVE;
-			cf->data[6] = txerr;
-			cf->data[7] = rxerr;
-		}
-	} else if (status & XCAN_SR_ERRWRN_MASK) {
-		priv->can.state = CAN_STATE_ERROR_WARNING;
-		priv->can.can_stats.error_warning++;
-		if (skb) {
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] |= (txerr > rxerr) ?
-					CAN_ERR_CRTL_TX_WARNING :
-					CAN_ERR_CRTL_RX_WARNING;
-			cf->data[6] = txerr;
-			cf->data[7] = rxerr;
-		}
+	} else {
+		enum can_state new_state = xcan_current_error_state(ndev);
+
+		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
 	}
 
 	/* Check for Arbitration lost interrupt */
@@ -714,8 +810,10 @@ static int xcan_rx_poll(struct napi_stru
 		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	}
 
-	if (work_done)
+	if (work_done) {
 		can_led_event(ndev, CAN_LED_EVENT_RX);
+		xcan_update_error_state_after_rxtx(ndev);
+	}
 
 	if (work_done < quota) {
 		napi_complete(napi);
@@ -746,6 +844,7 @@ static void xcan_tx_interrupt(struct net
 		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	}
 	can_led_event(ndev, CAN_LED_EVENT_TX);
+	xcan_update_error_state_after_rxtx(ndev);
 	netif_wake_queue(ndev);
 }
 

