Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeBXX2X (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:28:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58374 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbeBXX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:27:25 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>
Message-Id: <9f0f6a8180c9aa06fc8f31bb7e7024fe002fbd80.1519514463.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519514463.git.fthain@telegraphics.com.au>
References: <cover.1519514463.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 3/4] net/sonic: Clean up and modernize log messages
Date: Sat, 24 Feb 2018 18:27:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing printk severity levels by adopting pr_foo() calls for the
platform_driver and dev_foo() calls for the nubus_driver.
Avoid KERN_CONT usage as per advice from checkpatch.
Avoid #ifdef around printk calls.
Don't log driver probe messages after calling register_netdev().

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Chris Zankel <chris@zankel.net>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Only the macsonic.c changes have been tested. The other changes
are similar but untested.
---
 drivers/net/ethernet/natsemi/jazzsonic.c | 13 ++++-----
 drivers/net/ethernet/natsemi/macsonic.c  | 49 ++++++++++++++------------------
 drivers/net/ethernet/natsemi/xtsonic.c   | 11 +++----
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index d5b28884e21e..58495316d318 100644
--- a/drivers/net/ethernet/natsemi/jazzsonic.c
+++ b/drivers/net/ethernet/natsemi/jazzsonic.c
@@ -142,17 +142,14 @@ static int sonic_probe1(struct net_device *dev)
 		i++;
 
 	if (known_revisions[i] == 0xffff) {
-		printk("SONIC ethernet controller not found (0x%4x)\n",
-		       silicon_revision);
+		pr_info("SONIC ethernet controller not found (0x%4x)\n",
+			silicon_revision);
 		goto out;
 	}
 
 	if (sonic_debug  &&  version_printed++ == 0)
 		printk(version);
 
-	printk(KERN_INFO "%s: Sonic ethernet found at 0x%08lx, ",
-	       dev_name(lp->device), dev->base_addr);
-
 	/*
 	 * Put the sonic into software reset, then
 	 * retrieve and print the ethernet address.
@@ -245,12 +242,14 @@ static int jazz_sonic_probe(struct platform_device *pdev)
 	err = sonic_probe1(dev);
 	if (err)
 		goto out;
+
+	pr_info("SONIC ethernet @%08lx, MAC %pM, IRQ %d\n",
+		dev->base_addr, dev->dev_addr, dev->irq);
+
 	err = register_netdev(dev);
 	if (err)
 		goto out1;
 
-	printk("%s: MAC %pM IRQ %d\n", dev->name, dev->dev_addr, dev->irq);
-
 	return 0;
 
 out1:
diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index f6745a893c82..dc690f287a6d 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -311,8 +311,6 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 	int sr;
 	bool commslot = macintosh_config->expansion_type == MAC_EXP_PDS_COMM;
 
-	printk(KERN_INFO "Checking for internal Macintosh ethernet (SONIC).. ");
-
 	/* Bogus probing, on the models which may or may not have
 	   Ethernet (BTW, the Ethernet *is* always at the same
 	   address, and nothing else lives there, at least if Apple's
@@ -322,13 +320,11 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 
 		card_present = hwreg_present((void*)ONBOARD_SONIC_REGISTERS);
 		if (!card_present) {
-			printk("none.\n");
+			pr_info("Onboard/comm-slot SONIC not found\n");
 			return -ENODEV;
 		}
 	}
 
-	printk("yes\n");
-
 	/* Danger!  My arms are flailing wildly!  You *must* set lp->reg_offset
 	 * and dev->base_addr before using SONIC_READ() or SONIC_WRITE() */
 	dev->base_addr = ONBOARD_SONIC_REGISTERS;
@@ -341,14 +337,11 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 		printk(KERN_INFO "%s", version);
 		sonic_version_printed = 1;
 	}
-	printk(KERN_INFO "%s: onboard / comm-slot SONIC at 0x%08lx\n",
-	       dev_name(lp->device), dev->base_addr);
 
 	/* The PowerBook's SONIC is 16 bit always. */
 	if (macintosh_config->ident == MAC_MODEL_PB520) {
 		lp->reg_offset = 0;
 		lp->dma_bitmode = SONIC_BITMODE16;
-		sr = SONIC_READ(SONIC_SR);
 	} else if (commslot) {
 		/* Some of the comm-slot cards are 16 bit.  But some
 		   of them are not.  The 32-bit cards use offset 2 and
@@ -365,22 +358,21 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 		else {
 			lp->dma_bitmode = SONIC_BITMODE16;
 			lp->reg_offset = 0;
-			sr = SONIC_READ(SONIC_SR);
 		}
 	} else {
 		/* All onboard cards are at offset 2 with 32 bit DMA. */
 		lp->reg_offset = 2;
 		lp->dma_bitmode = SONIC_BITMODE32;
-		sr = SONIC_READ(SONIC_SR);
 	}
-	printk(KERN_INFO
-	       "%s: revision 0x%04x, using %d bit DMA and register offset %d\n",
-	       dev_name(lp->device), sr, lp->dma_bitmode?32:16, lp->reg_offset);
 
-#if 0 /* This is sometimes useful to find out how MacOS configured the card. */
-	printk(KERN_INFO "%s: DCR: 0x%04x, DCR2: 0x%04x\n", dev_name(lp->device),
-	       SONIC_READ(SONIC_DCR) & 0xffff, SONIC_READ(SONIC_DCR2) & 0xffff);
-#endif
+	pr_info("Onboard/comm-slot SONIC, revision 0x%04x, %d bit DMA, register offset %d\n",
+		SONIC_READ(SONIC_SR), lp->dma_bitmode ? 32 : 16,
+		lp->reg_offset);
+
+	/* This is sometimes useful to find out how MacOS configured the card */
+	pr_debug("%s: DCR=0x%04x, DCR2=0x%04x\n", __func__,
+		 SONIC_READ(SONIC_DCR) & 0xffff,
+		 SONIC_READ(SONIC_DCR2) & 0xffff);
 
 	/* Software reset, then initialize control registers. */
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
@@ -401,6 +393,9 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 	/* Now look for the MAC address. */
 	mac_onboard_sonic_ethernet_addr(dev);
 
+	pr_info("SONIC ethernet @%08lx, MAC %pM, IRQ %d\n",
+		dev->base_addr, dev->dev_addr, dev->irq);
+
 	/* Shared init code */
 	return macsonic_init(dev);
 }
@@ -508,15 +503,15 @@ static int mac_sonic_nubus_probe_board(struct nubus_board *board, int id,
 		printk(KERN_INFO "%s", version);
 		sonic_version_printed = 1;
 	}
-	printk(KERN_INFO "%s: %s in slot %X\n",
-	       dev_name(lp->device), board->name, board->slot);
-	printk(KERN_INFO "%s: revision 0x%04x, using %d bit DMA and register offset %d\n",
-	       dev_name(lp->device), SONIC_READ(SONIC_SR), dma_bitmode?32:16, reg_offset);
-
-#if 0 /* This is sometimes useful to find out how MacOS configured the card. */
-	printk(KERN_INFO "%s: DCR: 0x%04x, DCR2: 0x%04x\n", dev_name(lp->device),
-	       SONIC_READ(SONIC_DCR) & 0xffff, SONIC_READ(SONIC_DCR2) & 0xffff);
-#endif
+
+	dev_info(&board->dev, "%s, revision 0x%04x, %d bit DMA, register offset %d\n",
+		 board->name, SONIC_READ(SONIC_SR),
+		 lp->dma_bitmode ? 32 : 16, lp->reg_offset);
+
+	/* This is sometimes useful to find out how MacOS configured the card */
+	dev_dbg(&board->dev, "%s: DCR=0x%04x, DCR2=0x%04x\n", __func__,
+		SONIC_READ(SONIC_DCR) & 0xffff,
+		SONIC_READ(SONIC_DCR2) & 0xffff);
 
 	/* Software reset, then initialize control registers. */
 	SONIC_WRITE(SONIC_CMD, SONIC_CR_RST);
@@ -564,8 +559,6 @@ static int mac_sonic_platform_probe(struct platform_device *pdev)
 	if (err)
 		goto out;
 
-	printk("%s: MAC %pM IRQ %d\n", dev->name, dev->dev_addr, dev->irq);
-
 	return 0;
 
 out:
diff --git a/drivers/net/ethernet/natsemi/xtsonic.c b/drivers/net/ethernet/natsemi/xtsonic.c
index 1817deea98a4..d1659c75cce8 100644
--- a/drivers/net/ethernet/natsemi/xtsonic.c
+++ b/drivers/net/ethernet/natsemi/xtsonic.c
@@ -155,8 +155,8 @@ static int __init sonic_probe1(struct net_device *dev)
 		i++;
 
 	if (known_revisions[i] == 0xffff) {
-		printk("SONIC ethernet controller not found (0x%4x)\n",
-				silicon_revision);
+		pr_info("SONIC ethernet controller not found (0x%4x)\n",
+			silicon_revision);
 		return -ENODEV;
 	}
 
@@ -273,12 +273,13 @@ int xtsonic_probe(struct platform_device *pdev)
 
 	if ((err = sonic_probe1(dev)))
 		goto out;
+
+	pr_info("SONIC ethernet @%08lx, MAC %pM, IRQ %d\n",
+		dev->base_addr, dev->dev_addr, dev->irq);
+
 	if ((err = register_netdev(dev)))
 		goto out1;
 
-	printk("%s: SONIC ethernet @%08lx, MAC %pM, IRQ %d\n", dev->name,
-	       dev->base_addr, dev->dev_addr, dev->irq);
-
 	return 0;
 
 out1:
-- 
2.16.1
