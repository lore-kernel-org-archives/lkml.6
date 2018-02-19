Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeBSCjl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:39:41 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39602 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeBSCjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:39:18 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Message-Id: <db538e6962eb16045ec85c15aee2b9b30eedcce5.1519007130.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519007130.git.fthain@telegraphics.com.au>
References: <cover.1519007130.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 2/4] net/8390: Fix msg_enable patch snafu
Date: Sun, 18 Feb 2018 21:39:17 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lib8390 module parameter 'msg_enable' doesn't do anything useful:
it causes an ancient version string to be logged.

Remove redundant code that logs the same string.

In ne.c and wd.c, the value of ei_local->msg_enable is used before
being assigned. Use ne_msg_enable and wd_msg_enable, respectively.

Most of the other 8390 drivers never assign ei_local->msg_enable.
Use the 'msg_enable' module parameter from lib8390 as the default
value.

Eliminate the pointless static and local variables.

Clean up an indentation mistake.

All of these issues originated from the same patch.

Cc: Russell King <linux@armlinux.org.uk>
Fixes: c45f812f0280 ("8390 : Replace ei_debug with msg_enable/NETIF_MSG_* feature")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Only the mac8390.c and lib8390.c changes have been tested. The other
changes are similar but untested.
---
 drivers/net/ethernet/8390/ax88796.c   |  3 ---
 drivers/net/ethernet/8390/axnet_cs.c  |  2 --
 drivers/net/ethernet/8390/etherh.c    | 17 -----------------
 drivers/net/ethernet/8390/hydra.c     |  4 ----
 drivers/net/ethernet/8390/lib8390.c   |  2 ++
 drivers/net/ethernet/8390/mac8390.c   |  8 --------
 drivers/net/ethernet/8390/mcf8390.c   |  4 ----
 drivers/net/ethernet/8390/ne.c        |  2 +-
 drivers/net/ethernet/8390/pcnet_cs.c  |  4 ----
 drivers/net/ethernet/8390/wd.c        |  2 +-
 drivers/net/ethernet/8390/zorro8390.c |  5 -----
 11 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/8390/ax88796.c b/drivers/net/ethernet/8390/ax88796.c
index 245554707163..da61cf3cb3a9 100644
--- a/drivers/net/ethernet/8390/ax88796.c
+++ b/drivers/net/ethernet/8390/ax88796.c
@@ -77,8 +77,6 @@ static unsigned char version[] = "ax88796.c: Copyright 2005,2007 Simtec Electron
 
 #define AX_GPOC_PPDSET	BIT(6)
 
-static u32 ax_msg_enable;
-
 /* device private data */
 
 struct ax_device {
@@ -747,7 +745,6 @@ static int ax_init_dev(struct net_device *dev)
 	ei_local->block_output = &ax_block_output;
 	ei_local->get_8390_hdr = &ax_get_8390_hdr;
 	ei_local->priv = 0;
-	ei_local->msg_enable = ax_msg_enable;
 
 	dev->netdev_ops = &ax_netdev_ops;
 	dev->ethtool_ops = &ax_ethtool_ops;
diff --git a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
index 7bddb8efb6d5..d422a124cd7c 100644
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -104,7 +104,6 @@ static void AX88190_init(struct net_device *dev, int startp);
 static int ax_open(struct net_device *dev);
 static int ax_close(struct net_device *dev);
 static irqreturn_t ax_interrupt(int irq, void *dev_id);
-static u32 axnet_msg_enable;
 
 /*====================================================================*/
 
@@ -151,7 +150,6 @@ static int axnet_probe(struct pcmcia_device *link)
 	return -ENOMEM;
 
     ei_local = netdev_priv(dev);
-    ei_local->msg_enable = axnet_msg_enable;
     spin_lock_init(&ei_local->page_lock);
 
     info = PRIV(dev);
diff --git a/drivers/net/ethernet/8390/etherh.c b/drivers/net/ethernet/8390/etherh.c
index 11cbf22ad201..32e9627e3880 100644
--- a/drivers/net/ethernet/8390/etherh.c
+++ b/drivers/net/ethernet/8390/etherh.c
@@ -64,8 +64,6 @@ static char version[] =
 
 #include "lib8390.c"
 
-static u32 etherh_msg_enable;
-
 struct etherh_priv {
 	void __iomem	*ioc_fast;
 	void __iomem	*memc;
@@ -501,18 +499,6 @@ etherh_close(struct net_device *dev)
 	return 0;
 }
 
-/*
- * Initialisation
- */
-
-static void __init etherh_banner(void)
-{
-	static int version_printed;
-
-	if ((etherh_msg_enable & NETIF_MSG_DRV) && (version_printed++ == 0))
-		pr_info("%s", version);
-}
-
 /*
  * Read the ethernet address string from the on board rom.
  * This is an ascii string...
@@ -671,8 +657,6 @@ etherh_probe(struct expansion_card *ec, const struct ecard_id *id)
 	struct etherh_priv *eh;
 	int ret;
 
-	etherh_banner();
-
 	ret = ecard_request_resources(ec);
 	if (ret)
 		goto out;
@@ -757,7 +741,6 @@ etherh_probe(struct expansion_card *ec, const struct ecard_id *id)
 	ei_local->block_output  = etherh_block_output;
 	ei_local->get_8390_hdr  = etherh_get_header;
 	ei_local->interface_num = 0;
-	ei_local->msg_enable = etherh_msg_enable;
 
 	etherh_reset(dev);
 	__NS8390_init(dev, 0);
diff --git a/drivers/net/ethernet/8390/hydra.c b/drivers/net/ethernet/8390/hydra.c
index 8ae249195301..941754ea78ec 100644
--- a/drivers/net/ethernet/8390/hydra.c
+++ b/drivers/net/ethernet/8390/hydra.c
@@ -66,7 +66,6 @@ static void hydra_block_input(struct net_device *dev, int count,
 static void hydra_block_output(struct net_device *dev, int count,
 			       const unsigned char *buf, int start_page);
 static void hydra_remove_one(struct zorro_dev *z);
-static u32 hydra_msg_enable;
 
 static struct zorro_device_id hydra_zorro_tbl[] = {
     { ZORRO_PROD_HYDRA_SYSTEMS_AMIGANET },
@@ -119,7 +118,6 @@ static int hydra_init(struct zorro_dev *z)
     int start_page, stop_page;
     int j;
     int err;
-    struct ei_device *ei_local;
 
     static u32 hydra_offsets[16] = {
 	0x00, 0x02, 0x04, 0x06, 0x08, 0x0a, 0x0c, 0x0e,
@@ -138,8 +136,6 @@ static int hydra_init(struct zorro_dev *z)
     start_page = NESM_START_PG;
     stop_page = NESM_STOP_PG;
 
-    ei_local = netdev_priv(dev);
-    ei_local->msg_enable = hydra_msg_enable;
     dev->base_addr = ioaddr;
     dev->irq = IRQ_AMIGA_PORTS;
 
diff --git a/drivers/net/ethernet/8390/lib8390.c b/drivers/net/ethernet/8390/lib8390.c
index 60f8e2c8e726..5d9bbde9fe68 100644
--- a/drivers/net/ethernet/8390/lib8390.c
+++ b/drivers/net/ethernet/8390/lib8390.c
@@ -975,6 +975,8 @@ static void ethdev_setup(struct net_device *dev)
 	ether_setup(dev);
 
 	spin_lock_init(&ei_local->page_lock);
+
+	ei_local->msg_enable = msg_enable;
 }
 
 /**
diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index 2f91ce8dc614..abe50338b9f7 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -168,7 +168,6 @@ static void slow_sane_block_output(struct net_device *dev, int count,
 				   const unsigned char *buf, int start_page);
 static void word_memcpy_tocard(unsigned long tp, const void *fp, int count);
 static void word_memcpy_fromcard(void *tp, unsigned long fp, int count);
-static u32 mac8390_msg_enable;
 
 static enum mac8390_type __init mac8390_ident(struct nubus_rsrc *fres)
 {
@@ -299,8 +298,6 @@ static bool __init mac8390_init(struct net_device *dev,
 	int offset;
 	volatile unsigned short *i;
 
-	printk_once(KERN_INFO pr_fmt("%s"), version);
-
 	dev->irq = SLOT2IRQ(ndev->board->slot);
 	/* This is getting to be a habit */
 	dev->base_addr = (ndev->board->slot_addr |
@@ -398,8 +395,6 @@ struct net_device * __init mac8390_probe(int unit)
 	struct net_device *dev;
 	struct nubus_rsrc *ndev = NULL;
 	int err = -ENODEV;
-	struct ei_device *ei_local;
-
 	static unsigned int slots;
 
 	enum mac8390_type cardtype;
@@ -441,9 +436,6 @@ struct net_device * __init mac8390_probe(int unit)
 	if (!ndev)
 		goto out;
 
-	 ei_local = netdev_priv(dev);
-	 ei_local->msg_enable = mac8390_msg_enable;
-
 	err = register_netdev(dev);
 	if (err)
 		goto out;
diff --git a/drivers/net/ethernet/8390/mcf8390.c b/drivers/net/ethernet/8390/mcf8390.c
index 4bb967bc879e..4ad8031ab669 100644
--- a/drivers/net/ethernet/8390/mcf8390.c
+++ b/drivers/net/ethernet/8390/mcf8390.c
@@ -38,7 +38,6 @@ static const char version[] =
 
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
-static u32 mcf8390_msg_enable;
 
 #ifdef NE2000_ODDOFFSET
 /*
@@ -407,7 +406,6 @@ static int mcf8390_init(struct net_device *dev)
 static int mcf8390_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
-	struct ei_device *ei_local;
 	struct resource *mem, *irq;
 	resource_size_t msize;
 	int ret;
@@ -435,8 +433,6 @@ static int mcf8390_probe(struct platform_device *pdev)
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	platform_set_drvdata(pdev, dev);
-	ei_local = netdev_priv(dev);
-	ei_local->msg_enable = mcf8390_msg_enable;
 
 	dev->irq = irq->start;
 	dev->base_addr = mem->start;
diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index 66f47987e2a2..4cdff6e6af89 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -485,7 +485,7 @@ static int __init ne_probe1(struct net_device *dev, unsigned long ioaddr)
 		mdelay(10);		/* wait 10ms for interrupt to propagate */
 		outb_p(0x00, ioaddr + EN0_IMR); 		/* Mask it again. */
 		dev->irq = probe_irq_off(cookie);
-		if (netif_msg_probe(ei_local))
+		if (ne_msg_enable & NETIF_MSG_PROBE)
 			pr_cont(" autoirq is %d", dev->irq);
 	} else if (dev->irq == 2)
 		/* Fixup for users that don't know that IRQ 2 is really IRQ 9,
diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index bcad4a7fac9f..61e43802b9a5 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -66,7 +66,6 @@
 #define PCNET_RDC_TIMEOUT (2*HZ/100)	/* Max wait in jiffies for Tx RDC */
 
 static const char *if_names[] = { "auto", "10baseT", "10base2"};
-static u32 pcnet_msg_enable;
 
 /*====================================================================*/
 
@@ -556,7 +555,6 @@ static int pcnet_config(struct pcmcia_device *link)
     int start_pg, stop_pg, cm_offset;
     int has_shmem = 0;
     struct hw_info *local_hw_info;
-    struct ei_device *ei_local;
 
     dev_dbg(&link->dev, "pcnet_config\n");
 
@@ -606,8 +604,6 @@ static int pcnet_config(struct pcmcia_device *link)
 	mii_phy_probe(dev);
 
     SET_NETDEV_DEV(dev, &link->dev);
-    ei_local = netdev_priv(dev);
-    ei_local->msg_enable = pcnet_msg_enable;
 
     if (register_netdev(dev) != 0) {
 	pr_notice("register_netdev() failed\n");
diff --git a/drivers/net/ethernet/8390/wd.c b/drivers/net/ethernet/8390/wd.c
index 6efa2722f850..fb17c2c7e1dd 100644
--- a/drivers/net/ethernet/8390/wd.c
+++ b/drivers/net/ethernet/8390/wd.c
@@ -299,7 +299,7 @@ static int __init wd_probe1(struct net_device *dev, int ioaddr)
 
 			outb_p(0x00, nic_addr+EN0_IMR);	/* Mask all intrs. again. */
 
-			if (netif_msg_drv(ei_local))
+			if (wd_msg_enable & NETIF_MSG_PROBE)
 				pr_cont(" autoirq is %d", dev->irq);
 			if (dev->irq < 2)
 				dev->irq = word16 ? 10 : 5;
diff --git a/drivers/net/ethernet/8390/zorro8390.c b/drivers/net/ethernet/8390/zorro8390.c
index 6d93956b293b..35a500a21521 100644
--- a/drivers/net/ethernet/8390/zorro8390.c
+++ b/drivers/net/ethernet/8390/zorro8390.c
@@ -44,8 +44,6 @@
 static const char version[] =
 	"8390.c:v1.10cvs 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
-static u32 zorro8390_msg_enable;
-
 #include "lib8390.c"
 
 #define DRV_NAME	"zorro8390"
@@ -296,7 +294,6 @@ static int zorro8390_init(struct net_device *dev, unsigned long board,
 	int err;
 	unsigned char SA_prom[32];
 	int start_page, stop_page;
-	struct ei_device *ei_local = netdev_priv(dev);
 	static u32 zorro8390_offsets[16] = {
 		0x00, 0x02, 0x04, 0x06, 0x08, 0x0a, 0x0c, 0x0e,
 		0x10, 0x12, 0x14, 0x16, 0x18, 0x1a, 0x1c, 0x1e,
@@ -388,8 +385,6 @@ static int zorro8390_init(struct net_device *dev, unsigned long board,
 	dev->netdev_ops = &zorro8390_netdev_ops;
 	__NS8390_init(dev, 0);
 
-	ei_local->msg_enable = zorro8390_msg_enable;
-
 	err = register_netdev(dev);
 	if (err) {
 		free_irq(IRQ_AMIGA_PORTS, dev);
-- 
2.16.1
