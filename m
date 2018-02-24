Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeBXX2W (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:28:22 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58378 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbeBXX10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:27:26 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>
Message-Id: <ca408da4ea1eadb4f1a7836f626d7fd304a3fd5b.1519514463.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519514463.git.fthain@telegraphics.com.au>
References: <cover.1519514463.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 4/4] net/sonic: Replace custom debug logging with netif_*
 calls
Date: Sat, 24 Feb 2018 18:27:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate duplicated debug code by moving it into the core driver.
Don't log the only valid silicon revision number (it's in the source).

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Chris Zankel <chris@zankel.net>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Only the sonic.[ch] and macsonic.c changes have been tested. The other
changes are similar but untested.
---
 drivers/net/ethernet/natsemi/jazzsonic.c | 19 +-----
 drivers/net/ethernet/natsemi/macsonic.c  | 25 ++------
 drivers/net/ethernet/natsemi/sonic.c     | 99 ++++++++++++++++----------------
 drivers/net/ethernet/natsemi/sonic.h     |  2 +
 drivers/net/ethernet/natsemi/xtsonic.c   | 19 +-----
 5 files changed, 61 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index 58495316d318..51fa82b429a3 100644
--- a/drivers/net/ethernet/natsemi/jazzsonic.c
+++ b/drivers/net/ethernet/natsemi/jazzsonic.c
@@ -60,14 +60,6 @@ do {									\
 	*((volatile unsigned int *)dev->base_addr+(reg)) = (val);		\
 } while (0)
 
-
-/* use 0 for production, 1 for verification, >1 for debug */
-#ifdef SONIC_DEBUG
-static unsigned int sonic_debug = SONIC_DEBUG;
-#else
-static unsigned int sonic_debug = 1;
-#endif
-
 /*
  * We cannot use station (ethernet) address prefixes to detect the
  * sonic controller since these are board manufacturer depended.
@@ -117,7 +109,6 @@ static const struct net_device_ops sonic_netdev_ops = {
 
 static int sonic_probe1(struct net_device *dev)
 {
-	static unsigned version_printed;
 	unsigned int silicon_revision;
 	unsigned int val;
 	struct sonic_local *lp = netdev_priv(dev);
@@ -133,9 +124,6 @@ static int sonic_probe1(struct net_device *dev)
 	 * the expected location.
 	 */
 	silicon_revision = SONIC_READ(SONIC_SR);
-	if (sonic_debug > 1)
-		printk("SONIC Silicon Revision = 0x%04x\n",silicon_revision);
-
 	i = 0;
 	while (known_revisions[i] != 0xffff &&
 	       known_revisions[i] != silicon_revision)
@@ -147,9 +135,6 @@ static int sonic_probe1(struct net_device *dev)
 		goto out;
 	}
 
-	if (sonic_debug  &&  version_printed++ == 0)
-		printk(version);
-
 	/*
 	 * Put the sonic into software reset, then
 	 * retrieve and print the ethernet address.
@@ -246,6 +231,8 @@ static int jazz_sonic_probe(struct platform_device *pdev)
 	pr_info("SONIC ethernet @%08lx, MAC %pM, IRQ %d\n",
 		dev->base_addr, dev->dev_addr, dev->irq);
 
+	sonic_msg_init(dev);
+
 	err = register_netdev(dev);
 	if (err)
 		goto out1;
@@ -261,8 +248,6 @@ static int jazz_sonic_probe(struct platform_device *pdev)
 }
 
 MODULE_DESCRIPTION("Jazz SONIC ethernet driver");
-module_param(sonic_debug, int, 0);
-MODULE_PARM_DESC(sonic_debug, "jazzsonic debug level (1-4)");
 MODULE_ALIAS("platform:jazzsonic");
 
 #include "sonic.c"
diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index dc690f287a6d..0937fc2a928e 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -70,15 +70,6 @@
 #define SONIC_WRITE(reg,val) (nubus_writew(val, dev->base_addr + (reg * 4) \
 	      + lp->reg_offset))
 
-/* use 0 for production, 1 for verification, >1 for debug */
-#ifdef SONIC_DEBUG
-static unsigned int sonic_debug = SONIC_DEBUG;
-#else
-static unsigned int sonic_debug = 1;
-#endif
-
-static int sonic_version_printed;
-
 /* For onboard SONIC */
 #define ONBOARD_SONIC_REGISTERS	0x50F0A000
 #define ONBOARD_SONIC_PROM_BASE	0x50f08000
@@ -333,11 +324,6 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 	else
 		dev->irq = IRQ_NUBUS_9;
 
-	if (!sonic_version_printed) {
-		printk(KERN_INFO "%s", version);
-		sonic_version_printed = 1;
-	}
-
 	/* The PowerBook's SONIC is 16 bit always. */
 	if (macintosh_config->ident == MAC_MODEL_PB520) {
 		lp->reg_offset = 0;
@@ -499,11 +485,6 @@ static int mac_sonic_nubus_probe_board(struct nubus_board *board, int id,
 	lp->dma_bitmode = dma_bitmode;
 	dev->irq = SLOT2IRQ(board->slot);
 
-	if (!sonic_version_printed) {
-		printk(KERN_INFO "%s", version);
-		sonic_version_printed = 1;
-	}
-
 	dev_info(&board->dev, "%s, revision 0x%04x, %d bit DMA, register offset %d\n",
 		 board->name, SONIC_READ(SONIC_SR),
 		 lp->dma_bitmode ? 32 : 16, lp->reg_offset);
@@ -555,6 +536,8 @@ static int mac_sonic_platform_probe(struct platform_device *pdev)
 	if (err)
 		goto out;
 
+	sonic_msg_init(dev);
+
 	err = register_netdev(dev);
 	if (err)
 		goto out;
@@ -568,8 +551,6 @@ static int mac_sonic_platform_probe(struct platform_device *pdev)
 }
 
 MODULE_DESCRIPTION("Macintosh SONIC ethernet driver");
-module_param(sonic_debug, int, 0);
-MODULE_PARM_DESC(sonic_debug, "macsonic debug level (1-4)");
 MODULE_ALIAS("platform:macsonic");
 
 #include "sonic.c"
@@ -633,6 +614,8 @@ static int mac_sonic_nubus_probe(struct nubus_board *board)
 	if (err)
 		goto out;
 
+	sonic_msg_init(ndev);
+
 	err = register_netdev(ndev);
 	if (err)
 		goto out;
diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 612c7a44b26c..7ed08486ae23 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -33,7 +33,21 @@
  * the NetBSD file "sys/arch/mac68k/dev/if_sn.c".
  */
 
+static unsigned int version_printed;
 
+static int sonic_debug = -1;
+module_param(sonic_debug, int, 0);
+MODULE_PARM_DESC(sonic_debug, "debug message level");
+
+static void sonic_msg_init(struct net_device *dev)
+{
+	struct sonic_local *lp = netdev_priv(dev);
+
+	lp->msg_enable = netif_msg_init(sonic_debug, 0);
+
+	if (version_printed++ == 0)
+		netif_dbg(lp, drv, dev, "%s", version);
+}
 
 /*
  * Open/initialize the SONIC controller.
@@ -47,8 +61,7 @@ static int sonic_open(struct net_device *dev)
 	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 
-	if (sonic_debug > 2)
-		printk("sonic_open: initializing sonic driver.\n");
+	netif_dbg(lp, ifup, dev, "%s: initializing sonic driver\n", __func__);
 
 	for (i = 0; i < SONIC_NUM_RRS; i++) {
 		struct sk_buff *skb = netdev_alloc_skb(dev, SONIC_RBSIZE + 2);
@@ -95,8 +108,7 @@ static int sonic_open(struct net_device *dev)
 
 	netif_start_queue(dev);
 
-	if (sonic_debug > 2)
-		printk("sonic_open: Initialization done.\n");
+	netif_dbg(lp, ifup, dev, "%s: Initialization done\n", __func__);
 
 	return 0;
 }
@@ -110,8 +122,7 @@ static int sonic_close(struct net_device *dev)
 	struct sonic_local *lp = netdev_priv(dev);
 	int i;
 
-	if (sonic_debug > 2)
-		printk("sonic_close\n");
+	netif_dbg(lp, ifdown, dev, "%s\n", __func__);
 
 	netif_stop_queue(dev);
 
@@ -205,8 +216,7 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 	int length;
 	int entry = lp->next_tx;
 
-	if (sonic_debug > 2)
-		printk("sonic_send_packet: skb=%p, dev=%p\n", skb, dev);
+	netif_dbg(lp, tx_queued, dev, "%s: skb=%p\n", __func__, skb);
 
 	length = skb->len;
 	if (length < ETH_ZLEN) {
@@ -252,14 +262,12 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 	lp->next_tx = (entry + 1) & SONIC_TDS_MASK;
 	if (lp->tx_skb[lp->next_tx] != NULL) {
 		/* The ring is full, the ISR has yet to process the next TD. */
-		if (sonic_debug > 3)
-			printk("%s: stopping queue\n", dev->name);
+		netif_dbg(lp, tx_queued, dev, "%s: stopping queue\n", __func__);
 		netif_stop_queue(dev);
 		/* after this packet, wait for ISR to free up some TDAs */
 	} else netif_start_queue(dev);
 
-	if (sonic_debug > 2)
-		printk("sonic_send_packet: issuing Tx command\n");
+	netif_dbg(lp, tx_queued, dev, "%s: issuing Tx command\n", __func__);
 
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_TXP);
 
@@ -281,8 +289,7 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 
 	do {
 		if (status & SONIC_INT_PKTRX) {
-			if (sonic_debug > 2)
-				printk("%s: packet rx\n", dev->name);
+			netif_dbg(lp, intr, dev, "%s: packet rx\n", __func__);
 			sonic_rx(dev);	/* got packet(s) */
 			SONIC_WRITE(SONIC_ISR, SONIC_INT_PKTRX); /* clear the interrupt */
 		}
@@ -299,8 +306,7 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 			 *   still being allocated by sonic_send_packet (status clear & tx_skb[entry] clear)
 			 */
 
-			if (sonic_debug > 2)
-				printk("%s: tx done\n", dev->name);
+			netif_dbg(lp, intr, dev, "%s: tx done\n", __func__);
 
 			while (lp->tx_skb[entry] != NULL) {
 				if ((td_status = sonic_tda_get(dev, entry, SONIC_TD_STATUS)) == 0)
@@ -346,20 +352,20 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 		 * check error conditions
 		 */
 		if (status & SONIC_INT_RFO) {
-			if (sonic_debug > 1)
-				printk("%s: rx fifo overrun\n", dev->name);
+			netif_dbg(lp, rx_err, dev, "%s: rx fifo overrun\n",
+				  __func__);
 			lp->stats.rx_fifo_errors++;
 			SONIC_WRITE(SONIC_ISR, SONIC_INT_RFO); /* clear the interrupt */
 		}
 		if (status & SONIC_INT_RDE) {
-			if (sonic_debug > 1)
-				printk("%s: rx descriptors exhausted\n", dev->name);
+			netif_dbg(lp, rx_err, dev, "%s: rx descriptors exhausted\n",
+				  __func__);
 			lp->stats.rx_dropped++;
 			SONIC_WRITE(SONIC_ISR, SONIC_INT_RDE); /* clear the interrupt */
 		}
 		if (status & SONIC_INT_RBAE) {
-			if (sonic_debug > 1)
-				printk("%s: rx buffer area exceeded\n", dev->name);
+			netif_dbg(lp, rx_err, dev, "%s: rx buffer area exceeded\n",
+				  __func__);
 			lp->stats.rx_dropped++;
 			SONIC_WRITE(SONIC_ISR, SONIC_INT_RBAE); /* clear the interrupt */
 		}
@@ -380,8 +386,9 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
 
 		/* transmit error */
 		if (status & SONIC_INT_TXER) {
-			if ((SONIC_READ(SONIC_TCR) & SONIC_TCR_FU) && (sonic_debug > 2))
-				printk(KERN_ERR "%s: tx fifo underrun\n", dev->name);
+			if (SONIC_READ(SONIC_TCR) & SONIC_TCR_FU)
+				netif_dbg(lp, tx_err, dev, "%s: tx fifo underrun\n",
+					  __func__);
 			SONIC_WRITE(SONIC_ISR, SONIC_INT_TXER); /* clear the interrupt */
 		}
 
@@ -475,8 +482,8 @@ static void sonic_rx(struct net_device *dev)
 			if (lp->cur_rwp >= lp->rra_end) lp->cur_rwp = lp->rra_laddr & 0xffff;
 			SONIC_WRITE(SONIC_RWP, lp->cur_rwp);
 			if (SONIC_READ(SONIC_ISR) & SONIC_INT_RBE) {
-				if (sonic_debug > 2)
-					printk("%s: rx buffer exhausted\n", dev->name);
+				netif_dbg(lp, rx_err, dev, "%s: rx buffer exhausted\n",
+					  __func__);
 				SONIC_WRITE(SONIC_ISR, SONIC_INT_RBE); /* clear the flag */
 			}
 		} else
@@ -542,9 +549,8 @@ static void sonic_multicast_list(struct net_device *dev)
 		    (netdev_mc_count(dev) > 15)) {
 			rcr |= SONIC_RCR_AMC;
 		} else {
-			if (sonic_debug > 2)
-				printk("sonic_multicast_list: mc_count %d\n",
-				       netdev_mc_count(dev));
+			netif_dbg(lp, ifup, dev, "%s: mc_count %d\n", __func__,
+				  netdev_mc_count(dev));
 			sonic_set_cam_enable(dev, 1);  /* always enable our own address */
 			i = 1;
 			netdev_for_each_mc_addr(ha, dev) {
@@ -562,8 +568,7 @@ static void sonic_multicast_list(struct net_device *dev)
 		}
 	}
 
-	if (sonic_debug > 2)
-		printk("sonic_multicast_list: setting RCR=%x\n", rcr);
+	netif_dbg(lp, ifup, dev, "%s: setting RCR=%x\n", __func__, rcr);
 
 	SONIC_WRITE(SONIC_RCR, rcr);
 }
@@ -596,8 +601,8 @@ static int sonic_init(struct net_device *dev)
 	/*
 	 * initialize the receive resource area
 	 */
-	if (sonic_debug > 2)
-		printk("sonic_init: initialize receive resource area\n");
+	netif_dbg(lp, ifup, dev, "%s: initialize receive resource area\n",
+		  __func__);
 
 	for (i = 0; i < SONIC_NUM_RRS; i++) {
 		u16 bufadr_l = (unsigned long)lp->rx_laddr[i] & 0xffff;
@@ -622,8 +627,7 @@ static int sonic_init(struct net_device *dev)
 	SONIC_WRITE(SONIC_EOBC, (SONIC_RBSIZE >> 1) - (lp->dma_bitmode ? 2 : 1));
 
 	/* load the resource pointers */
-	if (sonic_debug > 3)
-		printk("sonic_init: issuing RRRA command\n");
+	netif_dbg(lp, ifup, dev, "%s: issuing RRRA command\n", __func__);
 
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RRRA);
 	i = 0;
@@ -632,16 +636,17 @@ static int sonic_init(struct net_device *dev)
 			break;
 	}
 
-	if (sonic_debug > 2)
-		printk("sonic_init: status=%x i=%d\n", SONIC_READ(SONIC_CMD), i);
+	netif_dbg(lp, ifup, dev, "%s: status=%x, i=%d\n", __func__,
+		  SONIC_READ(SONIC_CMD), i);
 
 	/*
 	 * Initialize the receive descriptors so that they
 	 * become a circular linked list, ie. let the last
 	 * descriptor point to the first again.
 	 */
-	if (sonic_debug > 2)
-		printk("sonic_init: initialize receive descriptors\n");
+	netif_dbg(lp, ifup, dev, "%s: initialize receive descriptors\n",
+		  __func__);
+
 	for (i=0; i<SONIC_NUM_RDS; i++) {
 		sonic_rda_put(dev, i, SONIC_RD_STATUS, 0);
 		sonic_rda_put(dev, i, SONIC_RD_PKTLEN, 0);
@@ -664,8 +669,9 @@ static int sonic_init(struct net_device *dev)
 	/*
 	 * initialize transmit descriptors
 	 */
-	if (sonic_debug > 2)
-		printk("sonic_init: initialize transmit descriptors\n");
+	netif_dbg(lp, ifup, dev, "%s: initialize transmit descriptors\n",
+		  __func__);
+
 	for (i = 0; i < SONIC_NUM_TDS; i++) {
 		sonic_tda_put(dev, i, SONIC_TD_STATUS, 0);
 		sonic_tda_put(dev, i, SONIC_TD_CONFIG, 0);
@@ -712,10 +718,8 @@ static int sonic_init(struct net_device *dev)
 		if (SONIC_READ(SONIC_ISR) & SONIC_INT_LCD)
 			break;
 	}
-	if (sonic_debug > 2) {
-		printk("sonic_init: CMD=%x, ISR=%x\n, i=%d",
-		       SONIC_READ(SONIC_CMD), SONIC_READ(SONIC_ISR), i);
-	}
+	netif_dbg(lp, ifup, dev, "%s: CMD=%x, ISR=%x, i=%d\n", __func__,
+		  SONIC_READ(SONIC_CMD), SONIC_READ(SONIC_ISR), i);
 
 	/*
 	 * enable receiver, disable loopback
@@ -731,9 +735,8 @@ static int sonic_init(struct net_device *dev)
 	if ((cmd & SONIC_CR_RXEN) == 0 || (cmd & SONIC_CR_STP) == 0)
 		printk(KERN_ERR "sonic_init: failed, status=%x\n", cmd);
 
-	if (sonic_debug > 2)
-		printk("sonic_init: new status=%x\n",
-		       SONIC_READ(SONIC_CMD));
+	netif_dbg(lp, ifup, dev, "%s: new status=%x\n", __func__,
+		  SONIC_READ(SONIC_CMD));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/natsemi/sonic.h b/drivers/net/ethernet/natsemi/sonic.h
index 421b1a283fed..2b27f7049acb 100644
--- a/drivers/net/ethernet/natsemi/sonic.h
+++ b/drivers/net/ethernet/natsemi/sonic.h
@@ -319,6 +319,7 @@ struct sonic_local {
 	unsigned int eol_rx;
 	unsigned int eol_tx;           /* last unacked transmit packet */
 	unsigned int next_tx;          /* next free TD */
+	int msg_enable;
 	struct device *device;         /* generic device */
 	struct net_device_stats stats;
 };
@@ -336,6 +337,7 @@ static struct net_device_stats *sonic_get_stats(struct net_device *dev);
 static void sonic_multicast_list(struct net_device *dev);
 static int sonic_init(struct net_device *dev);
 static void sonic_tx_timeout(struct net_device *dev);
+static void sonic_msg_init(struct net_device *dev);
 
 /* Internal inlines for reading/writing DMA buffers.  Note that bus
    size and endianness matter here, whereas they don't for registers,
diff --git a/drivers/net/ethernet/natsemi/xtsonic.c b/drivers/net/ethernet/natsemi/xtsonic.c
index d1659c75cce8..e1b886e87a76 100644
--- a/drivers/net/ethernet/natsemi/xtsonic.c
+++ b/drivers/net/ethernet/natsemi/xtsonic.c
@@ -73,14 +73,6 @@ extern void xtboard_get_ether_addr(unsigned char *buf);
 #define SONIC_WRITE(reg,val) \
 	*((volatile unsigned int *)dev->base_addr+reg) = val
 
-
-/* Use 0 for production, 1 for verification, and >2 for debug */
-#ifdef SONIC_DEBUG
-static unsigned int sonic_debug = SONIC_DEBUG;
-#else
-static unsigned int sonic_debug = 1;
-#endif
-
 /*
  * We cannot use station (ethernet) address prefixes to detect the
  * sonic controller since these are board manufacturer depended.
@@ -130,7 +122,6 @@ static const struct net_device_ops xtsonic_netdev_ops = {
 
 static int __init sonic_probe1(struct net_device *dev)
 {
-	static unsigned version_printed = 0;
 	unsigned int silicon_revision;
 	struct sonic_local *lp = netdev_priv(dev);
 	unsigned int base_addr = dev->base_addr;
@@ -146,9 +137,6 @@ static int __init sonic_probe1(struct net_device *dev)
 	 * the expected location.
 	 */
 	silicon_revision = SONIC_READ(SONIC_SR);
-	if (sonic_debug > 1)
-		printk("SONIC Silicon Revision = 0x%04x\n",silicon_revision);
-
 	i = 0;
 	while ((known_revisions[i] != 0xffff) &&
 			(known_revisions[i] != silicon_revision))
@@ -160,9 +148,6 @@ static int __init sonic_probe1(struct net_device *dev)
 		return -ENODEV;
 	}
 
-	if (sonic_debug  &&  version_printed++ == 0)
-		printk(version);
-
 	/*
 	 * Put the sonic into software reset, then retrieve ethernet address.
 	 * Note: we are assuming that the boot-loader has initialized the cam.
@@ -277,6 +262,8 @@ int xtsonic_probe(struct platform_device *pdev)
 	pr_info("SONIC ethernet @%08lx, MAC %pM, IRQ %d\n",
 		dev->base_addr, dev->dev_addr, dev->irq);
 
+	sonic_msg_init(dev);
+
 	if ((err = register_netdev(dev)))
 		goto out1;
 
@@ -291,8 +278,6 @@ int xtsonic_probe(struct platform_device *pdev)
 }
 
 MODULE_DESCRIPTION("Xtensa XT2000 SONIC ethernet driver");
-module_param(sonic_debug, int, 0);
-MODULE_PARM_DESC(sonic_debug, "xtsonic debug level (1-4)");
 
 #include "sonic.c"
 
-- 
2.16.1
