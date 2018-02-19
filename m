Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeBSCjk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 21:39:40 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39592 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeBSCjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 21:39:18 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <79d1e1fe9e93c490809af29dfdba9d7b4e74c6be.1519007130.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519007130.git.fthain@telegraphics.com.au>
References: <cover.1519007130.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 3/4] net/mac8390: Convert to nubus_driver
Date: Sun, 18 Feb 2018 21:39:17 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves an old bug that constrained this driver to no more than
one card.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/Space.c                 |   3 -
 drivers/net/ethernet/8390/mac8390.c | 139 +++++++++++++++++-------------------
 include/net/Space.h                 |   1 -
 3 files changed, 67 insertions(+), 76 deletions(-)

diff --git a/drivers/net/Space.c b/drivers/net/Space.c
index 11fe71278f40..64333ec999ac 100644
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -114,9 +114,6 @@ static struct devprobe2 m68k_probes[] __initdata = {
 #ifdef CONFIG_MVME147_NET	/* MVME147 internal Ethernet */
 	{mvme147lance_probe, 0},
 #endif
-#ifdef CONFIG_MAC8390           /* NuBus NS8390-based cards */
-	{mac8390_probe, 0},
-#endif
 #ifdef CONFIG_MAC89x0
 	{mac89x0_probe, 0},
 #endif
diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index abe50338b9f7..8042dd73eb6a 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -123,8 +123,7 @@ enum mac8390_access {
 };
 
 extern int mac8390_memtest(struct net_device *dev);
-static int mac8390_initdev(struct net_device *dev,
-			   struct nubus_rsrc *ndev,
+static int mac8390_initdev(struct net_device *dev, struct nubus_board *board,
 			   enum mac8390_type type);
 
 static int mac8390_open(struct net_device *dev);
@@ -169,7 +168,7 @@ static void slow_sane_block_output(struct net_device *dev, int count,
 static void word_memcpy_tocard(unsigned long tp, const void *fp, int count);
 static void word_memcpy_fromcard(void *tp, unsigned long fp, int count);
 
-static enum mac8390_type __init mac8390_ident(struct nubus_rsrc *fres)
+static enum mac8390_type mac8390_ident(struct nubus_rsrc *fres)
 {
 	switch (fres->dr_sw) {
 	case NUBUS_DRSW_3COM:
@@ -235,7 +234,7 @@ static enum mac8390_type __init mac8390_ident(struct nubus_rsrc *fres)
 	return MAC8390_NONE;
 }
 
-static enum mac8390_access __init mac8390_testio(volatile unsigned long membase)
+static enum mac8390_access mac8390_testio(unsigned long membase)
 {
 	unsigned long outdata = 0xA5A0B5B0;
 	unsigned long indata =  0x00000000;
@@ -253,7 +252,7 @@ static enum mac8390_access __init mac8390_testio(volatile unsigned long membase)
 	return ACCESS_UNKNOWN;
 }
 
-static int __init mac8390_memsize(unsigned long membase)
+static int mac8390_memsize(unsigned long membase)
 {
 	unsigned long flags;
 	int i, j;
@@ -289,28 +288,28 @@ static int __init mac8390_memsize(unsigned long membase)
 	return i * 0x1000;
 }
 
-static bool __init mac8390_init(struct net_device *dev,
-				struct nubus_rsrc *ndev,
-				enum mac8390_type cardtype)
+static bool mac8390_rsrc_init(struct net_device *dev,
+			      struct nubus_rsrc *fres,
+			      enum mac8390_type cardtype)
 {
+	struct nubus_board *board = fres->board;
 	struct nubus_dir dir;
 	struct nubus_dirent ent;
 	int offset;
 	volatile unsigned short *i;
 
-	dev->irq = SLOT2IRQ(ndev->board->slot);
+	dev->irq = SLOT2IRQ(board->slot);
 	/* This is getting to be a habit */
-	dev->base_addr = (ndev->board->slot_addr |
-			  ((ndev->board->slot & 0xf) << 20));
+	dev->base_addr = board->slot_addr | ((board->slot & 0xf) << 20);
 
 	/*
 	 * Get some Nubus info - we will trust the card's idea
 	 * of where its memory and registers are.
 	 */
 
-	if (nubus_get_func_dir(ndev, &dir) == -1) {
+	if (nubus_get_func_dir(fres, &dir) == -1) {
 		pr_err("%s: Unable to get Nubus functional directory for slot %X!\n",
-		       dev->name, ndev->board->slot);
+		       dev->name, board->slot);
 		return false;
 	}
 
@@ -327,7 +326,7 @@ static bool __init mac8390_init(struct net_device *dev,
 		if (nubus_find_rsrc(&dir, NUBUS_RESID_MINOR_BASEOS,
 				    &ent) == -1) {
 			pr_err("%s: Memory offset resource for slot %X not found!\n",
-			       dev->name, ndev->board->slot);
+			       dev->name, board->slot);
 			return false;
 		}
 		nubus_get_rsrc_mem(&offset, &ent, 4);
@@ -338,7 +337,7 @@ static bool __init mac8390_init(struct net_device *dev,
 		if (nubus_find_rsrc(&dir, NUBUS_RESID_MINOR_LENGTH,
 				    &ent) == -1) {
 			pr_info("%s: Memory length resource for slot %X not found, probing\n",
-				dev->name, ndev->board->slot);
+				dev->name, board->slot);
 			offset = mac8390_memsize(dev->mem_start);
 		} else {
 			nubus_get_rsrc_mem(&offset, &ent, 4);
@@ -348,25 +347,25 @@ static bool __init mac8390_init(struct net_device *dev,
 		switch (cardtype) {
 		case MAC8390_KINETICS:
 		case MAC8390_DAYNA: /* it's the same */
-			dev->base_addr = (int)(ndev->board->slot_addr +
+			dev->base_addr = (int)(board->slot_addr +
 					       DAYNA_8390_BASE);
-			dev->mem_start = (int)(ndev->board->slot_addr +
+			dev->mem_start = (int)(board->slot_addr +
 					       DAYNA_8390_MEM);
 			dev->mem_end = dev->mem_start +
 				       mac8390_memsize(dev->mem_start);
 			break;
 		case MAC8390_INTERLAN:
-			dev->base_addr = (int)(ndev->board->slot_addr +
+			dev->base_addr = (int)(board->slot_addr +
 					       INTERLAN_8390_BASE);
-			dev->mem_start = (int)(ndev->board->slot_addr +
+			dev->mem_start = (int)(board->slot_addr +
 					       INTERLAN_8390_MEM);
 			dev->mem_end = dev->mem_start +
 				       mac8390_memsize(dev->mem_start);
 			break;
 		case MAC8390_CABLETRON:
-			dev->base_addr = (int)(ndev->board->slot_addr +
+			dev->base_addr = (int)(board->slot_addr +
 					       CABLETRON_8390_BASE);
-			dev->mem_start = (int)(ndev->board->slot_addr +
+			dev->mem_start = (int)(board->slot_addr +
 					       CABLETRON_8390_MEM);
 			/* The base address is unreadable if 0x00
 			 * has been written to the command register
@@ -382,7 +381,7 @@ static bool __init mac8390_init(struct net_device *dev,
 
 		default:
 			pr_err("Card type %s is unsupported, sorry\n",
-			       ndev->board->name);
+			       board->name);
 			return false;
 		}
 	}
@@ -390,86 +389,83 @@ static bool __init mac8390_init(struct net_device *dev,
 	return true;
 }
 
-struct net_device * __init mac8390_probe(int unit)
+static int mac8390_device_probe(struct nubus_board *board)
 {
 	struct net_device *dev;
-	struct nubus_rsrc *ndev = NULL;
 	int err = -ENODEV;
-	static unsigned int slots;
-
-	enum mac8390_type cardtype;
-
-	/* probably should check for Nubus instead */
-
-	if (!MACH_IS_MAC)
-		return ERR_PTR(-ENODEV);
+	struct nubus_rsrc *fres;
+	enum mac8390_type cardtype = MAC8390_NONE;
 
 	dev = ____alloc_ei_netdev(0);
 	if (!dev)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	if (unit >= 0)
-		sprintf(dev->name, "eth%d", unit);
+	SET_NETDEV_DEV(dev, &board->dev);
 
-	for_each_func_rsrc(ndev) {
-		if (ndev->category != NUBUS_CAT_NETWORK ||
-		    ndev->type != NUBUS_TYPE_ETHERNET)
+	for_each_board_func_rsrc(board, fres) {
+		if (fres->category != NUBUS_CAT_NETWORK ||
+		    fres->type != NUBUS_TYPE_ETHERNET)
 			continue;
 
-		/* Have we seen it already? */
-		if (slots & (1 << ndev->board->slot))
-			continue;
-		slots |= 1 << ndev->board->slot;
-
-		cardtype = mac8390_ident(ndev);
+		cardtype = mac8390_ident(fres);
 		if (cardtype == MAC8390_NONE)
 			continue;
 
-		if (!mac8390_init(dev, ndev, cardtype))
-			continue;
-
-		/* Do the nasty 8390 stuff */
-		if (!mac8390_initdev(dev, ndev, cardtype))
+		if (mac8390_rsrc_init(dev, fres, cardtype))
 			break;
 	}
+	if (!fres)
+		goto out;
 
-	if (!ndev)
+	err = mac8390_initdev(dev, board, cardtype);
+	if (err)
 		goto out;
 
 	err = register_netdev(dev);
 	if (err)
 		goto out;
-	return dev;
+
+	nubus_set_drvdata(board, dev);
+	return 0;
 
 out:
 	free_netdev(dev);
-	return ERR_PTR(err);
+	return err;
 }
 
-#ifdef MODULE
+static int mac8390_device_remove(struct nubus_board *board)
+{
+	struct net_device *dev = nubus_get_drvdata(board);
+
+	unregister_netdev(dev);
+	free_netdev(dev);
+	return 0;
+}
+
+static struct nubus_driver mac8390_driver = {
+	.probe = mac8390_device_probe,
+	.remove = mac8390_device_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.owner = THIS_MODULE,
+	}
+};
+
 MODULE_AUTHOR("David Huggins-Daines <dhd@debian.org> and others");
 MODULE_DESCRIPTION("Macintosh NS8390-based Nubus Ethernet driver");
 MODULE_LICENSE("GPL");
 
-static struct net_device *dev_mac8390;
-
-int __init init_module(void)
+static int __init mac8390_init(void)
 {
-	dev_mac8390 = mac8390_probe(-1);
-	if (IS_ERR(dev_mac8390)) {
-		pr_warn("mac8390: No card found\n");
-		return PTR_ERR(dev_mac8390);
-	}
-	return 0;
+	return nubus_driver_register(&mac8390_driver);
 }
+module_init(mac8390_init);
 
-void __exit cleanup_module(void)
+static void __exit mac8390_exit(void)
 {
-	unregister_netdev(dev_mac8390);
-	free_netdev(dev_mac8390);
+	nubus_driver_unregister(&mac8390_driver);
 }
-
-#endif /* MODULE */
+module_exit(mac8390_exit);
 
 static const struct net_device_ops mac8390_netdev_ops = {
 	.ndo_open 		= mac8390_open,
@@ -485,9 +481,8 @@ static const struct net_device_ops mac8390_netdev_ops = {
 #endif
 };
 
-static int __init mac8390_initdev(struct net_device *dev,
-				  struct nubus_rsrc *ndev,
-				  enum mac8390_type type)
+static int mac8390_initdev(struct net_device *dev, struct nubus_board *board,
+			   enum mac8390_type type)
 {
 	static u32 fwrd4_offsets[16] = {
 		0,      4,      8,      12,
@@ -605,7 +600,7 @@ static int __init mac8390_initdev(struct net_device *dev,
 
 	default:
 		pr_err("Card type %s is unsupported, sorry\n",
-		       ndev->board->name);
+		       board->name);
 		return -ENODEV;
 	}
 
@@ -613,7 +608,7 @@ static int __init mac8390_initdev(struct net_device *dev,
 
 	/* Good, done, now spit out some messages */
 	pr_info("%s: %s in slot %X (type %s)\n",
-		dev->name, ndev->board->name, ndev->board->slot,
+		dev->name, board->name, board->slot,
 		cardname[type]);
 	pr_info("MAC %pM IRQ %d, %d KB shared memory at %#lx, %d-bit access.\n",
 		dev->dev_addr, dev->irq,
diff --git a/include/net/Space.h b/include/net/Space.h
index 27fb5c937c4f..336da258885a 100644
--- a/include/net/Space.h
+++ b/include/net/Space.h
@@ -20,7 +20,6 @@ struct net_device *cs89x0_probe(int unit);
 struct net_device *mvme147lance_probe(int unit);
 struct net_device *tc515_probe(int unit);
 struct net_device *lance_probe(int unit);
-struct net_device *mac8390_probe(int unit);
 struct net_device *mac89x0_probe(int unit);
 struct net_device *cops_probe(int unit);
 struct net_device *ltpc_probe(void);
-- 
2.16.1
