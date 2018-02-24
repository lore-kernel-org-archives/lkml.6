Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeBXX13 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:27:29 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58366 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeBXX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:27:25 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <edba0c6e3224fe9f446d2606872ac3de781dff2f.1519514463.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519514463.git.fthain@telegraphics.com.au>
References: <cover.1519514463.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 1/4] net/macsonic: Convert to nubus_driver
Date: Sat, 24 Feb 2018 18:27:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This resolves an old issue preventing any NuBus SONIC NICs from
working in a Mac with an on-board SONIC device.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/macsonic.c | 173 ++++++++++++++++++++++----------
 1 file changed, 119 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index b922ab5cedea..c744912f55a9 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -60,8 +60,6 @@
 #include <asm/macints.h>
 #include <asm/mac_via.h>
 
-static char mac_sonic_string[] = "macsonic";
-
 #include "sonic.h"
 
 /* These should basically be bus-size and endian independent (since
@@ -410,7 +408,7 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 	return macsonic_init(dev);
 }
 
-static int mac_nubus_sonic_ethernet_addr(struct net_device *dev,
+static int mac_sonic_nubus_ethernet_addr(struct net_device *dev,
 					 unsigned long prom_addr, int id)
 {
 	int i;
@@ -449,70 +447,49 @@ static int macsonic_ident(struct nubus_rsrc *fres)
 	return -1;
 }
 
-static int mac_nubus_sonic_probe(struct net_device *dev)
+static int mac_sonic_nubus_probe_board(struct nubus_board *board, int id,
+				       struct net_device *dev)
 {
-	static int slots;
-	struct nubus_rsrc *ndev = NULL;
 	struct sonic_local* lp = netdev_priv(dev);
 	unsigned long base_addr, prom_addr;
 	u16 sonic_dcr;
-	int id = -1;
 	int reg_offset, dma_bitmode;
 
-	/* Find the first SONIC that hasn't been initialized already */
-	for_each_func_rsrc(ndev) {
-		if (ndev->category != NUBUS_CAT_NETWORK ||
-		    ndev->type != NUBUS_TYPE_ETHERNET)
-			continue;
-
-		/* Have we seen it already? */
-		if (slots & (1<<ndev->board->slot))
-			continue;
-		slots |= 1<<ndev->board->slot;
-
-		/* Is it one of ours? */
-		if ((id = macsonic_ident(ndev)) != -1)
-			break;
-	}
-
-	if (ndev == NULL)
-		return -ENODEV;
-
 	switch (id) {
 	case MACSONIC_DUODOCK:
-		base_addr = ndev->board->slot_addr + DUODOCK_SONIC_REGISTERS;
-		prom_addr = ndev->board->slot_addr + DUODOCK_SONIC_PROM_BASE;
+		base_addr = board->slot_addr + DUODOCK_SONIC_REGISTERS;
+		prom_addr = board->slot_addr + DUODOCK_SONIC_PROM_BASE;
 		sonic_dcr = SONIC_DCR_EXBUS | SONIC_DCR_RFT0 | SONIC_DCR_RFT1 |
 		            SONIC_DCR_TFT0;
 		reg_offset = 2;
 		dma_bitmode = SONIC_BITMODE32;
 		break;
 	case MACSONIC_APPLE:
-		base_addr = ndev->board->slot_addr + APPLE_SONIC_REGISTERS;
-		prom_addr = ndev->board->slot_addr + APPLE_SONIC_PROM_BASE;
+		base_addr = board->slot_addr + APPLE_SONIC_REGISTERS;
+		prom_addr = board->slot_addr + APPLE_SONIC_PROM_BASE;
 		sonic_dcr = SONIC_DCR_BMS | SONIC_DCR_RFT1 | SONIC_DCR_TFT0;
 		reg_offset = 0;
 		dma_bitmode = SONIC_BITMODE32;
 		break;
 	case MACSONIC_APPLE16:
-		base_addr = ndev->board->slot_addr + APPLE_SONIC_REGISTERS;
-		prom_addr = ndev->board->slot_addr + APPLE_SONIC_PROM_BASE;
+		base_addr = board->slot_addr + APPLE_SONIC_REGISTERS;
+		prom_addr = board->slot_addr + APPLE_SONIC_PROM_BASE;
 		sonic_dcr = SONIC_DCR_EXBUS | SONIC_DCR_RFT1 | SONIC_DCR_TFT0 |
 		            SONIC_DCR_PO1 | SONIC_DCR_BMS;
 		reg_offset = 0;
 		dma_bitmode = SONIC_BITMODE16;
 		break;
 	case MACSONIC_DAYNALINK:
-		base_addr = ndev->board->slot_addr + APPLE_SONIC_REGISTERS;
-		prom_addr = ndev->board->slot_addr + DAYNALINK_PROM_BASE;
+		base_addr = board->slot_addr + APPLE_SONIC_REGISTERS;
+		prom_addr = board->slot_addr + DAYNALINK_PROM_BASE;
 		sonic_dcr = SONIC_DCR_RFT1 | SONIC_DCR_TFT0 |
 		            SONIC_DCR_PO1 | SONIC_DCR_BMS;
 		reg_offset = 0;
 		dma_bitmode = SONIC_BITMODE16;
 		break;
 	case MACSONIC_DAYNA:
-		base_addr = ndev->board->slot_addr + DAYNA_SONIC_REGISTERS;
-		prom_addr = ndev->board->slot_addr + DAYNA_SONIC_MAC_ADDR;
+		base_addr = board->slot_addr + DAYNA_SONIC_REGISTERS;
+		prom_addr = board->slot_addr + DAYNA_SONIC_MAC_ADDR;
 		sonic_dcr = SONIC_DCR_BMS |
 		            SONIC_DCR_RFT1 | SONIC_DCR_TFT0 | SONIC_DCR_PO1;
 		reg_offset = 0;
@@ -528,14 +505,14 @@ static int mac_nubus_sonic_probe(struct net_device *dev)
 	dev->base_addr = base_addr;
 	lp->reg_offset = reg_offset;
 	lp->dma_bitmode = dma_bitmode;
-	dev->irq = SLOT2IRQ(ndev->board->slot);
+	dev->irq = SLOT2IRQ(board->slot);
 
 	if (!sonic_version_printed) {
 		printk(KERN_INFO "%s", version);
 		sonic_version_printed = 1;
 	}
 	printk(KERN_INFO "%s: %s in slot %X\n",
-	       dev_name(lp->device), ndev->board->name, ndev->board->slot);
+	       dev_name(lp->device), board->name, board->slot);
 	printk(KERN_INFO "%s: revision 0x%04x, using %d bit DMA and register offset %d\n",
 	       dev_name(lp->device), SONIC_READ(SONIC_SR), dma_bitmode?32:16, reg_offset);
 
@@ -557,14 +534,17 @@ static int mac_nubus_sonic_probe(struct net_device *dev)
 	SONIC_WRITE(SONIC_ISR, 0x7fff);
 
 	/* Now look for the MAC address. */
-	if (mac_nubus_sonic_ethernet_addr(dev, prom_addr, id) != 0)
+	if (mac_sonic_nubus_ethernet_addr(dev, prom_addr, id) != 0)
 		return -ENODEV;
 
+	dev_info(&board->dev, "SONIC ethernet @%08lx, MAC %pM, IRQ %d\n",
+		 dev->base_addr, dev->dev_addr, dev->irq);
+
 	/* Shared init code */
 	return macsonic_init(dev);
 }
 
-static int mac_sonic_probe(struct platform_device *pdev)
+static int mac_sonic_platform_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct sonic_local *lp;
@@ -579,16 +559,10 @@ static int mac_sonic_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	platform_set_drvdata(pdev, dev);
 
-	/* This will catch fatal stuff like -ENOMEM as well as success */
 	err = mac_onboard_sonic_probe(dev);
-	if (err == 0)
-		goto found;
-	if (err != -ENODEV)
-		goto out;
-	err = mac_nubus_sonic_probe(dev);
 	if (err)
 		goto out;
-found:
+
 	err = register_netdev(dev);
 	if (err)
 		goto out;
@@ -610,7 +584,7 @@ MODULE_ALIAS("platform:macsonic");
 
 #include "sonic.c"
 
-static int mac_sonic_device_remove(struct platform_device *pdev)
+static int mac_sonic_platform_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct sonic_local* lp = netdev_priv(dev);
@@ -623,12 +597,103 @@ static int mac_sonic_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mac_sonic_driver = {
-	.probe  = mac_sonic_probe,
-	.remove = mac_sonic_device_remove,
-	.driver	= {
-		.name	= mac_sonic_string,
+static struct platform_driver mac_sonic_platform_driver = {
+	.probe  = mac_sonic_platform_probe,
+	.remove = mac_sonic_platform_remove,
+	.driver = {
+		.name = "macsonic",
+	},
+};
+
+static int mac_sonic_nubus_probe(struct nubus_board *board)
+{
+	struct net_device *ndev;
+	struct sonic_local *lp;
+	struct nubus_rsrc *fres;
+	int id = -1;
+	int err;
+
+	/* The platform driver will handle a PDS or Comm Slot card (even if
+	 * it has a pseudoslot declaration ROM).
+	 */
+	if (macintosh_config->expansion_type == MAC_EXP_PDS_COMM)
+		return -ENODEV;
+
+	for_each_board_func_rsrc(board, fres) {
+		if (fres->category != NUBUS_CAT_NETWORK ||
+		    fres->type != NUBUS_TYPE_ETHERNET)
+			continue;
+
+		id = macsonic_ident(fres);
+		if (id != -1)
+			break;
+	}
+	if (!fres)
+		return -ENODEV;
+
+	ndev = alloc_etherdev(sizeof(struct sonic_local));
+	if (!ndev)
+		return -ENOMEM;
+
+	lp = netdev_priv(ndev);
+	lp->device = &board->dev;
+	SET_NETDEV_DEV(ndev, &board->dev);
+
+	err = mac_sonic_nubus_probe_board(board, id, ndev);
+	if (err)
+		goto out;
+
+	err = register_netdev(ndev);
+	if (err)
+		goto out;
+
+	nubus_set_drvdata(board, ndev);
+
+	return 0;
+
+out:
+	free_netdev(ndev);
+	return err;
+}
+
+static int mac_sonic_nubus_remove(struct nubus_board *board)
+{
+	struct net_device *ndev = nubus_get_drvdata(board);
+	struct sonic_local *lp = netdev_priv(ndev);
+
+	unregister_netdev(ndev);
+	dma_free_coherent(lp->device,
+			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
+			  lp->descriptors, lp->descriptors_laddr);
+	free_netdev(ndev);
+
+	return 0;
+}
+
+static struct nubus_driver mac_sonic_nubus_driver = {
+	.probe  = mac_sonic_nubus_probe,
+	.remove = mac_sonic_nubus_remove,
+	.driver = {
+		.name = "macsonic-nubus",
+		.owner = THIS_MODULE,
 	},
 };
 
-module_platform_driver(mac_sonic_driver);
+static int perr, nerr;
+
+static int __init mac_sonic_init(void)
+{
+	perr = platform_driver_register(&mac_sonic_platform_driver);
+	nerr = nubus_driver_register(&mac_sonic_nubus_driver);
+	return 0;
+}
+module_init(mac_sonic_init);
+
+static void __exit mac_sonic_exit(void)
+{
+	if (!perr)
+		platform_driver_unregister(&mac_sonic_platform_driver);
+	if (!nerr)
+		nubus_driver_unregister(&mac_sonic_nubus_driver);
+}
+module_exit(mac_sonic_exit);
-- 
2.16.1
