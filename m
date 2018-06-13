Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B9F7FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9F4208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="hkMzT4/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9F4208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935908AbeFMOis (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:38:48 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:33890 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935818AbeFMOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:38:18 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 415TrT05RMz4f3lwq;
        Wed, 13 Jun 2018 16:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528900697;
        bh=xKWvSJAExCFYwQPkF9cpeARYs1KgGM4+MQ0/Lt2hetU=; l=10;
        h=From:From:Reply-To:Sender;
        b=hkMzT4/Jcl+9EBh0ZdB3+S+M23K+QHsBdXbGWY8WrjYnMM4P/zEyUs5Ck3ceeVXq8
         5iOOYphx8uG89S8sSJvTWjvEJdsTMk6jFd3B8a4L0dQIFAad8l7TUKcd90BYac9R2I
         9Jo5pUvYP3lYWiTJWSqxKWmhhib7X78DXMWPRXAM=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 415TrS6nF0z4fj;
        Wed, 13 Jun 2018 16:38:16 +0200 (CEST)
X-AuditID: 0a3aad17-513ff70000000e32-e2-5b212c5ac912
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id 7E.4A.03634.A5C212B5; Wed, 13 Jun 2018 16:38:18 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 415TrS47pfz6D44M7;
        Wed, 13 Jun 2018 16:38:16 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.319.2; Wed, 13 Jun 2018 16:38:15 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <yi.zhu5@cn.bosch.com>, <petar.petrovic2@de.bosch.com>,
        <stephan.baetge@de.bosch.com>, <andy.shevchenko@gmail.com>,
        <socketcan@hartkopp.net>, <o.rempel@pengutronix.de>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 4/5] can: implement companion-can driver
Date:   Wed, 13 Jun 2018 16:37:20 +0200
Message-ID: <1528900641-18677-5-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sf0xbVRTHue+9vr42vO3xGOPYuSk1+0NQVjbNnmMxS1xi1QRxypJBVB7y
        pI39gX2FDGKUOqYbdsKEKetIR7ao2YawdZstm+2wo5U5I4KS2TCKJmMWNiUdYwMn6CuFtX/4
        z82553s+53vvuZfC2StyFaU3WQWLiTeoSSWh3PTV6seLH8sq0bh9Cm686SLiPFdHce743QM4
        9/O5NpLrOtJCcMH2ldy1MOJ+nZiXc5+Hu2VbFFqno4/QdjtG5Nro4DDS7vq3V65tnNNop1xr
        Csli5eZywaCvFizrni5V6npnbfLK4Am0s/nYX/I6FKhHDUhBAfME3BzqIRqQkmKZVgx6Aj+Q
        8c0FBKO2qcWNG0GgNyyLISSTDaE+Dx6LVzBFcGjsgwUcZ3wYDHs/WuibzuRD/WRIHosJZi1c
        j7SRsZhmngV7YwsZ914DoR/3LjRSMFo4e865wLLMbgRDge3x+jS4dPAaEYtxBuDbSARvQssd
        SZIjSWpH2HGUIeo11cb1Gm5DrqVMEGs1eblvmI0uFJ91pgfdPsX7EUMhdSr93kNZJayMrxZr
        jH70JIWpM+iCpodL2GVl5vIaHS/qXrdUGQRRraJRSkoKm34/LVaVGfWiqDeb/AgoXL2CLohI
        HF3O19QKFnMc86NVFKHOpO3l7xSzTAVvFd4ShErBsqTmU5QaaDFHOkOaRagQdr6pN1iXZPXq
        uOfKZCXZFqMUfrSBSpW8fbEWtFjJG0V9xSL+QBxnl7IJ9Hv0DDU/2WLHWcJkNgmqTDqYLfFM
        rFJXZbp/AtWDdMkZ6VIZSUKiywS6gqQZptOXY3Cq9KUT3kB70tt2sGmLyQS0/qjEMP15EJ5c
        Bf/s3wTO+Q4Eod9OIzjaP4jg0Ki0uIYjCJyeaQTRG10YTO1xYXAzdB6DbyIBDGZuTWPQOn0P
        h2NXbQQcvmQnYKaumQDX/pME9P19ioDf//AR0Dk4QkCrd7dMKmmXQeO0Wwa3/7wnA+dPzSSM
        ngmSMDXQJQenb5CC8YM3KHBE71Bg3zdLTUhjxaSxBgKxJxWtvPV/xrqYTdxNVYdevjtzonbH
        9bH6odpo97bv+jc/dbGoI80517kn71FbwQXt8ugjLzYosvd1vBoq8gYqOl9QGZblfrnRBoVl
        PXdem1g3N4DGtux6qXVv5fPb8sksr3d87elXSs+7bp3Ef8npdo98MvCu/9Oc0vDG7cGzqHTk
        ua8/dhd+eHnrF29v7frMM5v7vpoQdXxeNm4R+f8Ai/+7WWoEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The upper level companion-can driver provides SocketCAN interface to
userspace for communicate CAN messages with the companion processor.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/net/can/Kconfig     |   8 +
 drivers/net/can/Makefile    |   2 +
 drivers/net/can/companion.c | 693 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 703 insertions(+)
 create mode 100644 drivers/net/can/companion.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index ac4ff39..e403a7e 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -155,6 +155,14 @@ config PCH_CAN
 	  is an IOH for x86 embedded processor (Intel Atom E6xx series).
 	  This driver can access CAN bus.
 
+config COMPANION_CAN
+	tristate "Network device for companion communication (Bosch)"
+	depends on COMPANION_SPI
+	---help---
+	  The network device allows the userspace to use SocketCAN interface
+	  to communicate with the Bosch companion processor via the companion
+	  SPI driver.
+
 source "drivers/net/can/c_can/Kconfig"
 source "drivers/net/can/cc770/Kconfig"
 source "drivers/net/can/ifi_canfd/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 02b8ed7..575ea63 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -34,5 +34,7 @@ obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
 obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
 obj-$(CONFIG_PCH_CAN)		+= pch_can.o
+obj-$(CONFIG_COMPANION_CAN)	+= companion-can.o
+companion-can-objs := companion.o
 
 subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
diff --git a/drivers/net/can/companion.c b/drivers/net/can/companion.c
new file mode 100644
index 0000000..0702d24
--- /dev/null
+++ b/drivers/net/can/companion.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Companion upper level can network device
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/can/dev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/companion.h>
+
+#define TX_QUEUE_DEPTH  16
+#define NUM_TX_QUEUES   8
+#define NUM_RX_QUEUES   1
+#define TX_ECHO_SKB_MAX (NUM_TX_QUEUES * TX_QUEUE_DEPTH)
+#define DRIVER_NAME     "companion-can"
+
+/**
+ * struct companion_can_priv - companion-can private data structure
+ * @can:     standard common CAN private data, must be first member
+ * @parent:  address of the associated parent device
+ * @dev:     address of the associated network device
+ * @port:    the companion CAN port number
+ * @tx_head: array of all tx queue head
+ * @tx_tail: arrat of all tx queue tail
+ */
+struct companion_can_priv {
+	struct can_priv	   can;
+	struct device     *parent;
+	struct net_device *dev;
+	u8                 port;
+	u8                 tx_head[NUM_TX_QUEUES];
+	u8                 tx_tail[NUM_TX_QUEUES];
+};
+
+/**
+ * companion_can_put_echo_skb() - put echo skb into ring buffer
+ * @priv: address of companion-can private data
+ * @prio: which CAN queue to put
+ * @skb:  address of the packet to put
+ */
+static void companion_can_put_echo_skb(struct companion_can_priv *priv,
+				       u8                         prio,
+				       struct sk_buff            *skb)
+{
+	u8 offset = prio * TX_QUEUE_DEPTH;
+	u8 index  = priv->tx_head[prio] % TX_QUEUE_DEPTH;
+
+	can_put_echo_skb(skb, priv->dev, offset + index);
+	priv->tx_head[prio]++;
+}
+
+/**
+ * companion_can_get_echo_skb() - get echo skb from ring buffer
+ * @priv: address of companion-can private data
+ * @prio: which CAN queue to get
+ */
+static u8 companion_can_get_echo_skb(struct companion_can_priv *priv, u8 prio)
+{
+	u8 offset, index, result = 0;
+
+	if (priv->tx_head[prio] != priv->tx_tail[prio]) {
+		offset = prio * TX_QUEUE_DEPTH;
+		index  = priv->tx_tail[prio] % TX_QUEUE_DEPTH;
+		result = can_get_echo_skb(priv->dev, offset + index);
+		priv->tx_tail[prio]++;
+	}
+	return result;
+}
+
+/**
+ * companion_can_free_echo_skb() - free echo skb from ring buffer
+ * @priv: address of companion-can private data
+ * @prio: which CAN queue to free
+ */
+static void companion_can_free_echo_skb(struct companion_can_priv *priv,
+					u8                         prio)
+{
+	u8 offset, index;
+
+	if (priv->tx_head[prio] != priv->tx_tail[prio]) {
+		offset = prio * TX_QUEUE_DEPTH;
+		index  = priv->tx_tail[prio] % TX_QUEUE_DEPTH;
+		can_free_echo_skb(priv->dev, offset + index);
+		priv->tx_tail[prio]++;
+	}
+}
+
+/**
+ * companion_can_set_bittiming() - set CAN bittiming
+ * @dev: address of the associated network device
+ */
+static int companion_can_set_bittiming(struct net_device *dev)
+{
+	struct companion_can_priv  *priv = netdev_priv(dev);
+	const struct can_bittiming *bt   = &priv->can.bittiming;
+	u32                         ctrl = priv->can.ctrlmode;
+	int                         err;
+
+	err = companion_do_set_can_bittiming(priv->parent, priv->port, bt);
+	if (err)
+		return err;
+
+	if (ctrl & CAN_CTRLMODE_LISTENONLY) {
+		err = companion_do_set_can_ctrlmode(priv->parent,
+						    priv->port,
+						    ctrl);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/**
+ * companion_can_set_mode() - set CAN mode
+ * @dev:  address of the associated network device
+ * @mode: the CAN mode to set
+ */
+static int companion_can_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
+	int                        err;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		err = companion_can_set_bittiming(dev);
+		if (err)
+			return err;
+		/* fall through */
+
+	case CAN_MODE_STOP:
+		err = companion_do_set_can_mode(priv->parent,
+						priv->port,
+						mode);
+		if (err)
+			return err;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+/**
+ * companion_can_get_berr_counter() - get CAN error counter
+ * @dev: address of the associated network device
+ * @bec: address of the CAN error counter to store
+ */
+static int companion_can_get_berr_counter(const struct net_device *dev,
+					  struct can_berr_counter *bec)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
+
+	return companion_do_get_can_status(priv->parent, priv->port, bec);
+}
+
+/**
+ * companion_can_handle_state() - handle CAN state transition
+ * @dev:   address of the associated network device
+ * @cf:    address of the CAN frame to store CAN state
+ * @bec:   address of the CAN error counter
+ * @state: the companion CAN state
+ */
+static void companion_can_handle_state(struct net_device       *dev,
+				       struct can_frame        *cf,
+				       struct can_berr_counter *bec,
+				       u8                       state)
+{
+	struct companion_can_priv *priv      = netdev_priv(dev);
+	enum   can_state           new_state = CAN_STATE_ERROR_ACTIVE;
+	enum   can_state           rx_state  = CAN_STATE_ERROR_ACTIVE;
+	enum   can_state           tx_state  = CAN_STATE_ERROR_ACTIVE;
+
+	if (state & COMPANION_CAN_STATE_BUS_OFF) {
+		new_state = CAN_STATE_BUS_OFF;
+		rx_state  = bec->rxerr >= bec->txerr ? new_state : rx_state;
+		tx_state  = bec->txerr >= bec->rxerr ? new_state : tx_state;
+	} else if (state & COMPANION_CAN_STATE_PASSIVE) {
+		new_state = CAN_STATE_ERROR_PASSIVE;
+		rx_state  = bec->rxerr > 127 ? new_state : rx_state;
+		tx_state  = bec->txerr > 127 ? new_state : tx_state;
+	} else if (state & COMPANION_CAN_STATE_WARNING) {
+		new_state = CAN_STATE_ERROR_WARNING;
+		rx_state  = bec->rxerr >= bec->txerr ? new_state : rx_state;
+		tx_state  = bec->txerr >= bec->rxerr ? new_state : tx_state;
+	}
+
+	if (new_state != priv->can.state) {
+		can_change_state(dev, cf, tx_state, rx_state);
+
+		if (new_state == CAN_STATE_BUS_OFF)
+			can_bus_off(dev);
+	}
+}
+
+/**
+ * companion_can_handle_error() - handle CAN error
+ * @dev:  address of the associated network device
+ * @cf:   address of the CAN frame to store CAN error
+ * @code: the companion CAN error code
+ */
+static void companion_can_handle_error(struct net_device *dev,
+				       struct can_frame  *cf,
+				       u8                 code)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
+
+	if (code & COMPANION_CAN_ERROR_RXOV) {
+		cf->can_id  |= CAN_ERR_CRTL;
+		cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+		dev->stats.rx_over_errors++;
+		dev->stats.rx_errors++;
+	}
+
+	if (code & (COMPANION_CAN_ERROR_STUFF |
+		    COMPANION_CAN_ERROR_FORM  |
+		    COMPANION_CAN_ERROR_ACK   |
+		    COMPANION_CAN_ERROR_BIT1  |
+		    COMPANION_CAN_ERROR_BIT0  |
+		    COMPANION_CAN_ERROR_CRC)) {
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+		if (code & COMPANION_CAN_ERROR_STUFF) {
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+			dev->stats.rx_errors++;
+		}
+
+		if (code & COMPANION_CAN_ERROR_FORM) {
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+			dev->stats.rx_errors++;
+		}
+
+		if (code & COMPANION_CAN_ERROR_ACK) {
+			cf->can_id  |= CAN_ERR_ACK;
+			cf->data[3]  = CAN_ERR_PROT_LOC_ACK;
+			dev->stats.tx_errors++;
+		}
+
+		if (code & COMPANION_CAN_ERROR_BIT1) {
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
+			dev->stats.tx_errors++;
+		}
+
+		if (code & COMPANION_CAN_ERROR_BIT0) {
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
+			dev->stats.tx_errors++;
+		}
+
+		if (code & COMPANION_CAN_ERROR_CRC) {
+			cf->data[2] |= CAN_ERR_PROT_BIT;
+			cf->data[3]  = CAN_ERR_PROT_LOC_CRC_SEQ;
+			dev->stats.rx_errors++;
+		}
+
+		priv->can.can_stats.bus_error++;
+	}
+}
+
+/**
+ * companion_can_poll_err() - poll CAN error packet from companion
+ * @dev: address of the associated network device
+ */
+static bool companion_can_poll_err(struct net_device *dev)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
+	struct can_berr_counter    bec;
+	u8                         state;
+	u8                         code;
+	struct sk_buff            *skb;
+	struct can_frame          *cf;
+
+	if (companion_do_can_err(priv->parent,
+				 priv->port,
+				 &bec,
+				 &state,
+				 &code) != 0)
+		return false;
+
+	skb = alloc_can_err_skb(dev, &cf);
+	if (!skb) {
+		dev_err(&dev->dev, "cannot alloc err skb\n");
+		return false;
+	}
+
+	companion_can_handle_state(dev, cf, &bec, state);
+	companion_can_handle_error(dev, cf, code);
+
+	dev->stats.rx_bytes += cf->can_dlc;
+	dev->stats.rx_packets++;
+	netif_rx(skb);
+	return true;
+}
+
+/**
+ * companion_can_poll_data() - poll CAN data packet from companion
+ * @dev: address of the associated network device
+ */
+static bool companion_can_poll_data(struct net_device *dev)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
+	struct sk_buff            *skb;
+	struct can_frame          *cf;
+
+	skb = alloc_can_skb(dev, &cf);
+	if (!skb) {
+		dev_err(&dev->dev, "cannot alloc rx skb\n");
+		dev->stats.rx_dropped++;
+		return false;
+	}
+
+	if (companion_do_can_rx(priv->parent, priv->port, cf) != 0) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	dev->stats.rx_bytes += cf->can_dlc;
+	dev->stats.rx_packets++;
+	netif_rx(skb);
+	can_led_event(dev, CAN_LED_EVENT_RX);
+	return true;
+}
+
+/**
+ * companion_can_on_tx_done() - CAN tx done callback
+ * @data:          address of user supplied callback data
+ * @prio:          which CAN queue is done
+ * @lost_seq_sync: flag indicate lost sequence happened
+ * @success:       flag indicate last send is succeed or not
+ */
+static void companion_can_on_tx_done(void *data,
+				     u8    prio,
+				     bool  lost_seq_sync,
+				     bool  success)
+{
+	struct companion_can_priv *priv  = data;
+	struct net_device         *dev   = priv->dev;
+	struct net_device_stats   *stats = &dev->stats;
+	int                        err;
+
+	if (success) {
+		stats->tx_bytes += companion_can_get_echo_skb(priv, prio);
+		stats->tx_packets++;
+		can_led_event(dev, CAN_LED_EVENT_TX);
+	} else {
+		companion_can_free_echo_skb(priv, prio);
+		dev_err(&dev->dev, "on_tx_done(%d) failed\n", prio);
+	}
+
+	if (lost_seq_sync)
+		dev_err(&dev->dev, "txq[%d] lost sequence sync\n", prio);
+
+	err = companion_do_can_stop_tx_timer(priv->parent, priv->port, prio);
+	if (err)
+		dev_err(&dev->dev,
+			"stop txq[%d] tx timer failed: %d\n",
+			prio, err);
+
+	netif_wake_subqueue(dev, prio);
+}
+
+/**
+ * companion_can_on_rx_done() - CAN rx done callback
+ * @data: address of user supplied callback data
+ */
+static void companion_can_on_rx_done(void *data)
+{
+	struct companion_can_priv *priv = data;
+
+	while (companion_can_poll_data(priv->dev))
+		;
+}
+
+/**
+ * companion_can_on_error() - CAN error callback
+ * @data: address of user supplied callback data
+ */
+static void companion_can_on_error(void *data)
+{
+	struct companion_can_priv *priv = data;
+
+	while (companion_can_poll_err(priv->dev))
+		;
+}
+
+/**
+ * companion_can_on_tx_timeout() - CAN tx timeout callback
+ * @data: address of user supplied callback data
+ * @prio: which CAN queue tx timed out
+ */
+static void companion_can_on_tx_timeout(void *data, u8 prio)
+{
+	struct companion_can_priv *priv          = data;
+	bool                       lost_txq_sync = false;
+	int                        err;
+
+	err = companion_do_get_can_txq_status(priv->parent,
+					      priv->port,
+					      prio,
+					      &lost_txq_sync);
+	if (err) {
+		dev_err(&priv->dev->dev,
+			"get can txq[%d] status failed: %d\n", prio, err);
+
+		if (err != -EINVAL)
+			companion_do_can_start_tx_timer(priv->parent,
+							priv->port,
+							prio);
+		return;
+	}
+
+	if (lost_txq_sync) {
+		dev_err(&priv->dev->dev,
+			"txq[%d] out of sync, restart data flow\n", prio);
+		companion_can_free_echo_skb(priv, prio);
+		netif_wake_subqueue(priv->dev, prio);
+	} else {
+		dev_err(&priv->dev->dev,
+			"txq[%d] is sync'd, but no ack, wait again\n", prio);
+		companion_do_can_start_tx_timer(priv->parent, priv->port, prio);
+	}
+}
+
+static struct companion_can_ops companion_can_can_ops = {
+	.on_tx_done    = companion_can_on_tx_done,
+	.on_rx_done    = companion_can_on_rx_done,
+	.on_error      = companion_can_on_error,
+	.on_tx_timeout = companion_can_on_tx_timeout,
+};
+
+/**
+ * companion_can_open() - ndo_open callback
+ * @dev: address of the associated network device
+ */
+static int companion_can_open(struct net_device *dev)
+{
+	struct companion_can_priv *priv      = netdev_priv(dev);
+	bool                       has_space = false;
+	int                        err, i;
+
+	err = companion_can_ops_register(priv->parent,
+					 priv->port,
+					 &companion_can_can_ops,
+					 priv);
+	if (err) {
+		dev_err(&dev->dev,
+			"companion_can_ops_register() failed: %d\n", err);
+		goto out;
+	}
+
+	err = companion_can_set_mode(dev, CAN_MODE_START);
+	if (err) {
+		dev_err(&dev->dev,
+			"companion_can_set_mode() failed: %d\n", err);
+		goto out_register;
+	}
+
+	err = companion_do_get_can_txq_status_all(priv->parent, priv->port);
+	if (err) {
+		dev_err(&dev->dev,
+			"companion_do_get_can_txq_status_all() failed: %d\n",
+			err);
+		goto out_mode;
+	}
+
+	err = open_candev(dev);
+	if (err) {
+		dev_err(&dev->dev, "open_candev() failed: %d\n", err);
+		goto out_mode;
+	}
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	can_led_event(dev, CAN_LED_EVENT_OPEN);
+
+	for (i = 0; i < NUM_TX_QUEUES; ++i) {
+		err = companion_do_can_txq_has_space(priv->parent,
+						     priv->port,
+						     i,
+						     &has_space);
+
+		if (!err && has_space) {
+			netif_tx_start_queue(netdev_get_tx_queue(dev, i));
+		} else {
+			netif_tx_stop_queue(netdev_get_tx_queue(dev, i));
+			dev_err(&dev->dev, "txq[%d] is not started\n", i);
+		}
+	}
+
+	return 0;
+
+out_mode:
+	companion_can_set_mode(dev, CAN_MODE_STOP);
+out_register:
+	companion_can_ops_unregister(priv->parent, priv->port);
+out:
+	return err;
+}
+
+/**
+ * companion_can_release() - ndo_close callback
+ * @dev: address of the associated network device
+ */
+static int companion_can_release(struct net_device *dev)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
+	int                        err;
+
+	netif_tx_stop_all_queues(dev);
+	can_led_event(dev, CAN_LED_EVENT_STOP);
+	priv->can.state = CAN_STATE_STOPPED;
+	close_candev(dev);
+	err = companion_can_set_mode(dev, CAN_MODE_STOP);
+	companion_can_ops_unregister(priv->parent, priv->port);
+	return err;
+}
+
+/**
+ * companion_can_start_xmit() - ndo_start_xmit callback
+ * @skb: address of the packet to send
+ * @dev: address of the associated network device
+ */
+static int companion_can_start_xmit(struct sk_buff    *skb,
+				    struct net_device *dev)
+{
+	struct companion_can_priv *priv    = netdev_priv(dev);
+	struct can_frame          *cf      = (struct can_frame *)skb->data;
+	u16                        prio    = skb_get_queue_mapping(skb);
+	bool                       is_full = false;
+	int                        err;
+
+	if (can_dropped_invalid_skb(dev, skb)) {
+		dev_err(&dev->dev, "dropped invalid skb on txq[%d]\n", prio);
+		return NETDEV_TX_OK;
+	}
+
+	err = companion_do_can_tx(priv->parent, priv->port, prio, cf);
+	if (err) {
+		dev_err(&dev->dev, "dropped packet on txq[%d]\n", prio);
+		dev_kfree_skb_any(skb);
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	err = companion_do_can_txq_is_full(priv->parent,
+					   priv->port,
+					   prio,
+					   &is_full);
+	if (!err && is_full) {
+		netif_stop_subqueue(dev, prio);
+		err = companion_do_can_start_tx_timer(priv->parent,
+						      priv->port,
+						      prio);
+		if (err)
+			dev_err(&dev->dev,
+				"start txq[%d] tx timer failed: %d\n",
+				prio, err);
+	}
+
+	companion_can_put_echo_skb(priv, prio, skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops companion_can_netdev_ops = {
+	.ndo_open       = companion_can_open,
+	.ndo_stop       = companion_can_release,
+	.ndo_start_xmit = companion_can_start_xmit,
+};
+
+static const struct of_device_id companion_can_of_match[] = {
+	{ .compatible = "bosch,companion-can", .data = NULL, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, companion_can_of_match);
+
+static const struct can_bittiming_const companion_can_bittiming_const = {
+	.name      = DRIVER_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 8,
+	.sjw_max   = 4,
+	.brp_min   = 1,
+	.brp_max   = 1024,
+	.brp_inc   = 1,
+};
+
+/**
+ * companion_can_probe() - probe callback
+ * @pdev: address of the platform device
+ */
+static int companion_can_probe(struct platform_device *pdev)
+{
+	struct device_node        *node = pdev->dev.of_node;
+	struct net_device         *dev;
+	struct companion_can_priv *priv;
+	u32                        port, freq;
+	int                        err;
+
+	if (!node) {
+		dev_err(&pdev->dev, "no device tree data\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(node, "port", &port)) {
+		dev_err(&pdev->dev, "no port property\n");
+		return -ENODEV;
+	}
+
+	if (port != 0 && port != 1) {
+		dev_err(&pdev->dev,
+			"invalid port %d, valid range is [0,1]\n", port);
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "clock-frequency", &freq)) {
+		dev_err(&pdev->dev, "no clock-frequency property\n");
+		return -ENODEV;
+	}
+
+	if (!pdev->dev.parent) {
+		dev_err(&pdev->dev, "no parent device\n");
+		return -ENODEV;
+	}
+
+	dev = alloc_candev_mqs(sizeof(*priv),
+			       TX_ECHO_SKB_MAX,
+			       NUM_TX_QUEUES,
+			       NUM_RX_QUEUES);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->netdev_ops               = &companion_can_netdev_ops;
+	dev->flags                   |= IFF_ECHO;
+	dev->real_num_tx_queues       = NUM_TX_QUEUES;
+
+	priv                          = netdev_priv(dev);
+	priv->can.clock.freq          = freq;
+	priv->can.bittiming_const     = &companion_can_bittiming_const;
+	priv->can.do_set_mode         = companion_can_set_mode;
+	priv->can.do_get_berr_counter = companion_can_get_berr_counter;
+	priv->can.ctrlmode_supported  = CAN_CTRLMODE_LISTENONLY |
+					CAN_CTRLMODE_BERR_REPORTING;
+	priv->parent                  = pdev->dev.parent;
+	priv->dev                     = dev;
+	priv->port                    = port;
+
+	platform_set_drvdata(pdev, dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	err = register_candev(dev);
+	if (err) {
+		dev_err(&pdev->dev, "register_candev() failed: %d\n", err);
+		free_candev(dev);
+		return err;
+	}
+
+	devm_can_led_init(dev);
+	return 0;
+}
+
+/**
+ * companion_can_remove() - remove callback
+ * @pdev: address of the platform device
+ */
+static int companion_can_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	unregister_candev(dev);
+	free_candev(dev);
+	return 0;
+}
+
+static struct platform_driver companion_can_driver = {
+	.driver = {
+		.name           = DRIVER_NAME,
+		.of_match_table = of_match_ptr(companion_can_of_match),
+	},
+	.probe  = companion_can_probe,
+	.remove = companion_can_remove,
+};
+module_platform_driver(companion_can_driver);
+
+MODULE_AUTHOR("Zhu Yi <yi.zhu5@cn.bosch.com>");
+MODULE_DESCRIPTION("Companion upper level can network device");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

