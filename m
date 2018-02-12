Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeBLDKb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 22:10:31 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56842 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbeBLDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 22:08:45 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <08b0c1c8cd2622ec0b35bae44708c5f9217c5bbd.1518397634.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v4 10/13] net/mac8390: Fix log messages
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_foo() to log the slot number instead of the unexpanded "eth%d"
format string.
Disambiguate the two identical "Card type %s is unsupported" messages.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/8390/mac8390.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index 1113add733b6..44b20bce554e 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -308,14 +308,14 @@ static bool mac8390_rsrc_init(struct net_device *dev,
 	 */
 
 	if (nubus_get_func_dir(fres, &dir) == -1) {
-		pr_err("%s: Unable to get Nubus functional directory for slot %X!\n",
-		       dev->name, board->slot);
+		dev_err(&board->dev,
+			"Unable to get Nubus functional directory\n");
 		return false;
 	}
 
 	/* Get the MAC address */
 	if (nubus_find_rsrc(&dir, NUBUS_RESID_MAC_ADDRESS, &ent) == -1) {
-		pr_info("%s: Couldn't get MAC address!\n", dev->name);
+		dev_info(&board->dev, "MAC address resource not found\n");
 		return false;
 	}
 
@@ -325,8 +325,8 @@ static bool mac8390_rsrc_init(struct net_device *dev,
 		nubus_rewinddir(&dir);
 		if (nubus_find_rsrc(&dir, NUBUS_RESID_MINOR_BASEOS,
 				    &ent) == -1) {
-			pr_err("%s: Memory offset resource for slot %X not found!\n",
-			       dev->name, board->slot);
+			dev_err(&board->dev,
+				"Memory offset resource not found\n");
 			return false;
 		}
 		nubus_get_rsrc_mem(&offset, &ent, 4);
@@ -336,8 +336,8 @@ static bool mac8390_rsrc_init(struct net_device *dev,
 		nubus_rewinddir(&dir);
 		if (nubus_find_rsrc(&dir, NUBUS_RESID_MINOR_LENGTH,
 				    &ent) == -1) {
-			pr_info("%s: Memory length resource for slot %X not found, probing\n",
-				dev->name, board->slot);
+			dev_info(&board->dev,
+				 "Memory length resource not found, probing\n");
 			offset = mac8390_memsize(dev->mem_start);
 		} else {
 			nubus_get_rsrc_mem(&offset, &ent, 4);
@@ -380,8 +380,8 @@ static bool mac8390_rsrc_init(struct net_device *dev,
 			break;
 
 		default:
-			pr_err("Card type %s is unsupported, sorry\n",
-			       board->name);
+			dev_err(&board->dev,
+				"No known base address for card type\n");
 			return false;
 		}
 	}
@@ -536,7 +536,8 @@ static int mac8390_initdev(struct net_device *dev, struct nubus_board *board,
 	case MAC8390_APPLE:
 		switch (mac8390_testio(dev->mem_start)) {
 		case ACCESS_UNKNOWN:
-			pr_err("Don't know how to access card memory!\n");
+			dev_err(&board->dev,
+				"Don't know how to access card memory\n");
 			return -ENODEV;
 
 		case ACCESS_16:
@@ -602,21 +603,18 @@ static int mac8390_initdev(struct net_device *dev, struct nubus_board *board,
 		break;
 
 	default:
-		pr_err("Card type %s is unsupported, sorry\n",
-		       board->name);
+		dev_err(&board->dev, "Unsupported card type\n");
 		return -ENODEV;
 	}
 
 	__NS8390_init(dev, 0);
 
 	/* Good, done, now spit out some messages */
-	pr_info("%s: %s in slot %X (type %s)\n",
-		dev->name, board->name, board->slot,
-		cardname[type]);
-	pr_info("MAC %pM IRQ %d, %d KB shared memory at %#lx, %d-bit access.\n",
-		dev->dev_addr, dev->irq,
-		(unsigned int)(dev->mem_end - dev->mem_start) >> 10,
-		dev->mem_start, access_bitmode ? 32 : 16);
+	dev_info(&board->dev, "%s (type %s)\n", board->name, cardname[type]);
+	dev_info(&board->dev, "MAC %pM, IRQ %d, %d KB shared memory at %#lx, %d-bit access.\n",
+		 dev->dev_addr, dev->irq,
+		 (unsigned int)(dev->mem_end - dev->mem_start) >> 10,
+		 dev->mem_start, access_bitmode ? 32 : 16);
 	return 0;
 }
 
-- 
2.13.6
