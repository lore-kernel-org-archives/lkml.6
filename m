Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163161AbeCAXa2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:30:28 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52476 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163022AbeCAX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:29:29 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <efb485ce557c69c11b3d1e6442224b2bf4d4b9d0.1519813462.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519813462.git.fthain@telegraphics.com.au>
References: <cover.1519813462.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 4/4] net/mac89x0: Replace custom debug logging with
 netif_* calls
Date: Thu,  1 Mar 2018 18:29:28 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the conventional style of debug logging because it is both
shorter and more flexible.
Remove the 'version_printed' flag as the version will be printed
only once anyway (when the module loads).

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/cirrus/mac89x0.c | 47 +++++++++++------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 9a266496a538..3f8fe8fd79cc 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -61,18 +61,6 @@
 static const char version[] =
 "cs89x0.c:v1.02 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
 
-/* ======================= configure the driver here ======================= */
-
-/* use 0 for production, 1 for verification, >2 for debug */
-#ifndef NET_DEBUG
-#define NET_DEBUG 0
-#endif
-
-/* ======================= end of configuration ======================= */
-
-
-/* Always include 'config.h' first in case the user wants to turn on
-   or override something. */
 #include <linux/module.h>
 
 /*
@@ -108,14 +96,13 @@ static const char version[] =
 
 #include "cs89x0.h"
 
-static int debug;
+static int debug = -1;
 module_param(debug, int, 0);
-MODULE_PARM_DESC(debug, "CS89[02]0 debug level (0-5)");
-
-static unsigned int net_debug = NET_DEBUG;
+MODULE_PARM_DESC(debug, "debug message level");
 
 /* Information that need to be kept for each board. */
 struct net_local {
+	int msg_enable;
 	int chip_type;		/* one of: CS8900, CS8920, CS8920M */
 	char chip_revision;	/* revision letter of the chip ('A'...) */
 	int send_cmd;		/* the propercommand used to send a packet. */
@@ -178,7 +165,6 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct net_local *lp;
-	static unsigned version_printed;
 	int i, slot;
 	unsigned rev_type = 0;
 	unsigned long ioaddr;
@@ -186,8 +172,6 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	struct nubus_rsrc *fres;
 
-	net_debug = debug;
-
 	dev = alloc_etherdev(sizeof(struct net_local));
 	if (!dev)
 		return -ENOMEM;
@@ -222,6 +206,8 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 	/* Initialize the net_device structure. */
 	lp = netdev_priv(dev);
 
+	lp->msg_enable = netif_msg_init(debug, 0);
+
 	/* Fill in the 'dev' fields. */
 	dev->base_addr = ioaddr;
 	dev->mem_start = (unsigned long)
@@ -244,8 +230,7 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 	if (lp->chip_type != CS8900 && lp->chip_revision >= 'C')
 		lp->send_cmd = TX_NOW;
 
-	if (net_debug && version_printed++ == 0)
-		printk(version);
+	netif_dbg(lp, drv, dev, "%s", version);
 
 	pr_info("cs89%c0%s rev %c found at %#8lx\n",
 		lp->chip_type == CS8900 ? '0' : '2',
@@ -345,11 +330,9 @@ net_send_packet(struct sk_buff *skb, struct net_device *dev)
 	struct net_local *lp = netdev_priv(dev);
 	unsigned long flags;
 
-	if (net_debug > 3)
-		printk("%s: sent %d byte packet of type %x\n",
-		       dev->name, skb->len,
-		       (skb->data[ETH_ALEN+ETH_ALEN] << 8)
-		       | skb->data[ETH_ALEN+ETH_ALEN+1]);
+	netif_dbg(lp, tx_queued, dev, "sent %d byte packet of type %x\n",
+		  skb->len, skb->data[ETH_ALEN + ETH_ALEN] << 8 |
+		  skb->data[ETH_ALEN + ETH_ALEN + 1]);
 
 	/* keep the upload from being interrupted, since we
 	   ask the chip to start transmitting before the
@@ -398,7 +381,7 @@ static irqreturn_t net_interrupt(int irq, void *dev_id)
            faster than you can read them off, you're screwed.  Hasta la
            vista, baby!  */
 	while ((status = swab16(nubus_readw(dev->base_addr + ISQ_PORT)))) {
-		if (net_debug > 4)printk("%s: event=%04x\n", dev->name, status);
+		netif_dbg(lp, intr, dev, "status=%04x\n", status);
 		switch(status & ISQ_EVENT_MASK) {
 		case ISQ_RECEIVER_EVENT:
 			/* Got a packet(s). */
@@ -428,7 +411,7 @@ static irqreturn_t net_interrupt(int irq, void *dev_id)
 				netif_wake_queue(dev);
 			}
 			if (status & TX_UNDERRUN) {
-				if (net_debug > 0) printk("%s: transmit underrun\n", dev->name);
+				netif_dbg(lp, tx_err, dev, "transmit underrun\n");
                                 lp->send_underrun++;
                                 if (lp->send_underrun == 3) lp->send_cmd = TX_AFTER_381;
                                 else if (lp->send_underrun == 6) lp->send_cmd = TX_AFTER_ALL;
@@ -449,6 +432,7 @@ static irqreturn_t net_interrupt(int irq, void *dev_id)
 static void
 net_rx(struct net_device *dev)
 {
+	struct net_local *lp = netdev_priv(dev);
 	struct sk_buff *skb;
 	int status, length;
 
@@ -480,10 +464,9 @@ net_rx(struct net_device *dev)
 	skb_copy_to_linear_data(skb, (void *)(dev->mem_start + PP_RxFrame),
 				length);
 
-	if (net_debug > 3)printk("%s: received %d byte packet of type %x\n",
-                                 dev->name, length,
-                                 (skb->data[ETH_ALEN+ETH_ALEN] << 8)
-				 | skb->data[ETH_ALEN+ETH_ALEN+1]);
+	netif_dbg(lp, rx_status, dev, "received %d byte packet of type %x\n",
+		  length, skb->data[ETH_ALEN + ETH_ALEN] << 8 |
+		  skb->data[ETH_ALEN + ETH_ALEN + 1]);
 
         skb->protocol=eth_type_trans(skb,dev);
 	netif_rx(skb);
-- 
2.16.1
