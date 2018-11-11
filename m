Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68696C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3561E20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3561E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbeKLGOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:14:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50994 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730672AbeKLFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsn-0000oF-MH; Sun, 11 Nov 2018 19:58:57 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001lO-PV; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Wolfgang Grandegger" <wg@grandegger.com>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Andri Yngvason" <andri.yngvason@marel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.634432653@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 280/366] can: dev: Consolidate and unify state change
 handling
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

From: Andri Yngvason <andri.yngvason@marel.com>

commit bac78aabcfece0c493b2ad824c68fbdc20448cbc upstream.

The handling of can error states is different between platforms.
This is an attempt to correct that problem.

I've moved this handling into a generic function for changing the
error state. This ensures that error state changes are handled
the same way everywhere (where this function is used).

This new mechanism also adds reverse state transitioning in error
frames, i.e. the user will be notified through the socket interface
when the state goes down.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/dev.c          | 78 ++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h        |  3 ++
 include/uapi/linux/can/error.h |  1 +
 3 files changed, 82 insertions(+)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -275,6 +275,84 @@ static int can_get_bittiming(struct net_
 	return err;
 }
 
+static void can_update_state_error_stats(struct net_device *dev,
+					 enum can_state new_state)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (new_state <= priv->state)
+		return;
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_WARNING:
+		priv->can_stats.error_warning++;
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		priv->can_stats.error_passive++;
+		break;
+	case CAN_STATE_BUS_OFF:
+	default:
+		break;
+	};
+}
+
+static int can_tx_state_to_frame(struct net_device *dev, enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return CAN_ERR_CRTL_ACTIVE;
+	case CAN_STATE_ERROR_WARNING:
+		return CAN_ERR_CRTL_TX_WARNING;
+	case CAN_STATE_ERROR_PASSIVE:
+		return CAN_ERR_CRTL_TX_PASSIVE;
+	default:
+		return 0;
+	}
+}
+
+static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return CAN_ERR_CRTL_ACTIVE;
+	case CAN_STATE_ERROR_WARNING:
+		return CAN_ERR_CRTL_RX_WARNING;
+	case CAN_STATE_ERROR_PASSIVE:
+		return CAN_ERR_CRTL_RX_PASSIVE;
+	default:
+		return 0;
+	}
+}
+
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state tx_state, enum can_state rx_state)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	enum can_state new_state = max(tx_state, rx_state);
+
+	if (unlikely(new_state == priv->state)) {
+		netdev_warn(dev, "%s: oops, state did not change", __func__);
+		return;
+	}
+
+	netdev_dbg(dev, "New error state: %d\n", new_state);
+
+	can_update_state_error_stats(dev, new_state);
+	priv->state = new_state;
+
+	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
+		cf->can_id |= CAN_ERR_BUSOFF;
+		return;
+	}
+
+	cf->can_id |= CAN_ERR_CRTL;
+	cf->data[1] |= tx_state >= rx_state ?
+		       can_tx_state_to_frame(dev, tx_state) : 0;
+	cf->data[1] |= tx_state <= rx_state ?
+		       can_rx_state_to_frame(dev, rx_state) : 0;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
 /*
  * Local echo of CAN messages
  *
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -122,6 +122,9 @@ void unregister_candev(struct net_device
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state tx_state, enum can_state rx_state);
+
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -71,6 +71,7 @@
 #define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status TX */
 				      /* (at least one error counter exceeds */
 				      /* the protocol-defined level of 127)  */
+#define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */
 
 /* error in CAN protocol (type) / data[2] */
 #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */

