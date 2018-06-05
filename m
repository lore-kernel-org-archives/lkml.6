Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFESqY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:46:24 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:59872 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeFESqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:46:20 -0400
X-AuditID: 0a3aad14-925ff70000003a2f-f6-5b16da8656b5
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>, <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 4/5] can: implement companion-can driver
Date: Tue, 5 Jun 2018 20:43:59 +0200
Message-ID: <1528224240-30786-5-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sf0wTZxjHee/elqPh5nEt+FiVPy4mGuJccf5onFuWbc5uMcaY+Ifwhzvg
        oA30R3oFC5kJLgGB4VhFIz9cJVWywdzKyuY6QYQmOliyDrvMpcgE4i8UHcGKg8Hc7mix/WP/
        vHne5/v9PM/dNy9Fsn3JWspkcQh2C1/CKVVYteOrtS9Xj2Tk6iaurtf7R8dIfedfp0j9r5fO
        KPVez0msv9aWoW+/9YPiTaXB3TKIDTOhm8jQ8I/OEPFl7sM5qp0FQompTLC/8sYHKuPwb08V
        tmcXkXOkek8l6q1CdSiFAmYLfNx9Q1mHVBTLNBHwY6Q6drmMoPfKVOxyEcH09TYsI0omC8KD
        flKuNcwBaL1bjWUTyXQguPv5z4QsqBk9BKu+S5ZrzKyDmaP9SzXN7AbvkzoiujsTwsHapUEp
        jAEWqv5c8rCSJ+gL4qg/DYaa7yzVJAMwMDlJfopWtCRILQlSGyI6UXqhoCszZ2/fottkzxPE
        Cl32pnyr2YeikWr86MREQQAxFOJS6cWBjFxWwZeJ5eYA2koRXDq90SO1XsqzFpQbedF4yF5a
        IoiclkZJSUms+kVbLM0zm0TRZLUEEFAkp6H5kMTRBXx5hWC3RrEAWk1hbiVdc+FBDssU8Q6h
        WBBsgn1ZfY2iOKANYQlMswtFgrPQVOJYlrm10Z0ZiUriWoJKCaBXqVRp91vyCFq08WbRVBTD
        V0VxdrkbR39Cb1PPp0/Wkyy2WC2CdiVdLvOM7DSWWl58gXYN/dmQJpdNTxDiUx6i35GUoZpu
        luFU6eXGdwPtV585yKbFmnFo8zmJYbo3w63p1bDo2gHu5xcQhMe7EZz7JYSgdUw6fDcnEbj9
        swhmprwERGp8BDwK9xDQO3mVgLknswQ0zS6Q0DF6FMPZoXoMc5WNGHyuLgyDf3+DYeJ+H4av
        Q39gaLpcpZAsbQpomP1eAU8fLyjAPdyohLFvrykhct2bDO6+EAUPmqcoaJl5RkH98XnqoRQr
        IcV6z6mWY3Xwjv+JNdaN/5u2EtWf7uh5z3X+eCHWvH5jw6GPgpH8zi5xfuRIbeVikdd1qrXd
        ctpZk1fbwD52zaVrsr60teZ/+Imtp/2Ls/PFG2y3Gc+K/Vpn0zHvu6GBbdkbXSc631/VlzOW
        Xzw63nh4fPfe4Tv9855/rTvf2XbMdKDX09G/5t6RXRWGcOYum7rLjA5yWDTy2VmkXeT/A2SQ
        Uq5RBAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The upper level companion-can driver provides SocketCAN interface to
userspace for communicate CAN messages with the companion processor.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/net/can/Kconfig         |   8 +
 drivers/net/can/Makefile        |   1 +
 drivers/net/can/companion-can.c | 694 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 703 insertions(+)
 create mode 100644 drivers/net/can/companion-can.c

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
index 02b8ed7..a66a1f9 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
 obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
 obj-$(CONFIG_PCH_CAN)		+= pch_can.o
+obj-$(CONFIG_COMPANION_CAN)	+= companion-can.o
 
 subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
diff --git a/drivers/net/can/companion-can.c b/drivers/net/can/companion-can.c
new file mode 100644
index 0000000..5078640
--- /dev/null
+++ b/drivers/net/can/companion-can.c
@@ -0,0 +1,694 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion upper level can network device
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
+#define TX_ECHO_SKB_MAX NUM_TX_QUEUES * TX_QUEUE_DEPTH
+#define DRIVER_NAME     "bosch,companion-can"
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
+                                       u8                         prio,
+                                       struct sk_buff            *skb)
+{
+	u8 offset = prio * TX_QUEUE_DEPTH;
+	u8 index  = priv->tx_head[prio] % TX_QUEUE_DEPTH;
+	can_put_echo_skb(skb, priv->dev, offset + index);
+	priv->tx_head[prio]++;
+}
+
+/**
+ * companion_can_get_echo_skb() - get echo skb from ring buffer
+ * @priv: address of companion-can private data
+ * @prio: which CAN queue to get
+ */
+static u8 companion_can_get_echo_skb(struct companion_can_priv *priv,
+                                     u8                         prio)
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
+                                        u8                         prio)
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
+		                                    priv->port,
+		                                    ctrl);
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
+static int companion_can_set_mode(struct net_device *dev,
+                                  enum can_mode      mode)
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
+		                                priv->port,
+		                                mode);
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
+                                          struct can_berr_counter *bec)
+{
+	struct companion_can_priv *priv = netdev_priv(dev);
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
+                                       struct can_frame        *cf,
+                                       struct can_berr_counter *bec,
+                                       u8                       state)
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
+                                       struct can_frame  *cf,
+                                       u8                 code)
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
+	            COMPANION_CAN_ERROR_FORM  |
+	            COMPANION_CAN_ERROR_ACK   |
+	            COMPANION_CAN_ERROR_BIT1  |
+	            COMPANION_CAN_ERROR_BIT0  |
+	            COMPANION_CAN_ERROR_CRC))
+	{
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
+	                         priv->port,
+	                         &bec,
+	                         &state,
+	                         &code) != 0)
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
+                                     u8    prio,
+                                     bool  lost_seq_sync,
+                                     bool  success)
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
+	/*TODO: what else action should take in case lost sequence?*/
+	if (lost_seq_sync)
+		dev_err(&dev->dev, "txq[%d] lost sequence sync\n", prio);
+
+	err = companion_do_can_stop_tx_timer(priv->parent, priv->port, prio);
+	if (err)
+		dev_err(&dev->dev,
+		        "stop txq[%d] tx timer failed: %d\n",
+		        prio, err);
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
+	while (companion_can_poll_data(priv->dev));
+}
+
+/**
+ * companion_can_on_error() - CAN error callback
+ * @data: address of user supplied callback data
+ */
+static void companion_can_on_error(void *data)
+{
+	struct companion_can_priv *priv = data;
+	while (companion_can_poll_err(priv->dev));
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
+	                                      priv->port,
+	                                      prio,
+	                                      &lost_txq_sync);
+	if (err) {
+		dev_err(&priv->dev->dev,
+		        "get can txq[%d] status failed: %d\n", prio, err);
+
+		if (err != -EINVAL)
+			companion_do_can_start_tx_timer(priv->parent,
+			                                priv->port,
+			                                prio);
+		return;
+	}
+
+	if (lost_txq_sync) {
+		dev_err(&priv->dev->dev,
+		        "txq[%d] out of sync, restart data flow\n", prio);
+		companion_can_free_echo_skb(priv, prio);
+		netif_wake_subqueue(priv->dev, prio);
+	} else {
+		dev_err(&priv->dev->dev,
+		        "txq[%d] is sync'd, but no ack, wait again\n", prio);
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
+	                                 priv->port,
+	                                 &companion_can_can_ops,
+	                                 priv);
+	if (err) {
+		dev_err(&dev->dev,
+			"companion_can_ops_register() failed: %d\n", err);
+		goto out;
+	}
+
+	err = companion_can_set_mode(dev, CAN_MODE_START);
+	if (err) {
+		dev_err(&dev->dev,
+		        "companion_can_set_mode() failed: %d\n", err);
+		goto out_register;
+	}
+
+	err = companion_do_get_can_txq_status_all(priv->parent, priv->port);
+	if (err) {
+		dev_err(&dev->dev,
+		        "companion_do_get_can_txq_status_all() failed: %d\n",
+		        err);
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
+	/*TODO: start all here or start depends on queue space?*/
+	for (i = 0; i < NUM_TX_QUEUES; ++i) {
+		err = companion_do_can_txq_has_space(priv->parent,
+		                                     priv->port,
+		                                     i,
+		                                     &has_space);
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
+	int                        result;
+
+	netif_tx_stop_all_queues(dev);
+	can_led_event(dev, CAN_LED_EVENT_STOP);
+	priv->can.state = CAN_STATE_STOPPED;
+	close_candev(dev);
+	result = companion_can_set_mode(dev, CAN_MODE_STOP);
+	companion_can_ops_unregister(priv->parent, priv->port);
+	return result;
+}
+
+/**
+ * companion_can_start_xmit() - ndo_start_xmit callback
+ * @skb: address of the packet to send
+ * @dev: address of the associated network device
+ */
+static int companion_can_start_xmit(struct sk_buff    *skb,
+                                    struct net_device *dev)
+{
+	struct companion_can_priv *priv    = netdev_priv(dev);
+	struct can_frame          *cf      = (struct can_frame*)skb->data;
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
+	                                   priv->port,
+	                                   prio,
+	                                   &is_full);
+	if (!err && is_full) {
+		netif_stop_subqueue(dev, prio);
+		err = companion_do_can_start_tx_timer(priv->parent,
+		                                      priv->port,
+		                                      prio);
+		if (err)
+			dev_err(&dev->dev,
+			        "start txq[%d] tx timer failed: %d\n",
+			        prio, err);
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
+	{ .compatible = DRIVER_NAME, .data = NULL, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, companion_can_of_match);
+
+static const struct can_bittiming_const companion_can_bittiming_const = {
+	.name      = "bosch,companion",
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
+	if ((port != 0) && (port != 1)) {
+		dev_err(&pdev->dev,
+		        "invalid port %d, valid range is [0,1]\n", port);
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
+	                       TX_ECHO_SKB_MAX,
+	                       NUM_TX_QUEUES,
+	                       NUM_RX_QUEUES);
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
+	                                CAN_CTRLMODE_BERR_REPORTING;
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
+		.owner          = THIS_MODULE,
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
