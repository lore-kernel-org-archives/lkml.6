Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeBLDLK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 22:11:10 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56836 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932550AbeBLDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 22:08:45 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <6f29887c4e8f2e3d8090599a27eacc5631e8031d.1518397634.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v4 07/13] net/mac89x0: Fix and modernize log messages
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix log message fragments that no longer produce the desired output
since the behaviour of printk() was changed.
Add missing printk severity levels.
Drop deprecated "out of memory" message as per checkpatch advice.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/cirrus/mac89x0.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 7f7c72409921..9cc8d4cf2785 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -56,6 +56,8 @@
   local_irq_{dis,en}able()
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 static const char version[] =
 "cs89x0.c:v1.02 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
 
@@ -248,16 +250,14 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 	if (net_debug && version_printed++ == 0)
 		printk(version);
 
-	printk(KERN_INFO "%s: cs89%c0%s rev %c found at %#8lx",
-	       dev->name,
-	       lp->chip_type==CS8900?'0':'2',
-	       lp->chip_type==CS8920M?"M":"",
-	       lp->chip_revision,
-	       dev->base_addr);
+	pr_info("cs89%c0%s rev %c found at %#8lx\n",
+		lp->chip_type == CS8900 ? '0' : '2',
+		lp->chip_type == CS8920M ? "M" : "",
+		lp->chip_revision, dev->base_addr);
 
 	/* Try to read the MAC address */
 	if ((readreg(dev, PP_SelfST) & (EEPROM_PRESENT | EEPROM_OK)) == 0) {
-		printk("\nmac89x0: No EEPROM, giving up now.\n");
+		pr_info("No EEPROM, giving up now.\n");
 		goto out1;
         } else {
                 for (i = 0; i < ETH_ALEN; i += 2) {
@@ -272,7 +272,7 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 
 	/* print the IRQ and ethernet address. */
 
-	printk(" IRQ %d ADDR %pM\n", dev->irq, dev->dev_addr);
+	pr_info("MAC %pM, IRQ %d\n", dev->dev_addr, dev->irq);
 
 	dev->netdev_ops		= &mac89x0_netdev_ops;
 
@@ -475,7 +475,6 @@ net_rx(struct net_device *dev)
 	/* Malloc up new buffer. */
 	skb = alloc_skb(length, GFP_ATOMIC);
 	if (skb == NULL) {
-		printk("%s: Memory squeeze, dropping packet.\n", dev->name);
 		dev->stats.rx_dropped++;
 		return;
 	}
@@ -563,7 +562,7 @@ static int set_mac_address(struct net_device *dev, void *addr)
 		return -EADDRNOTAVAIL;
 
 	memcpy(dev->dev_addr, saddr->sa_data, ETH_ALEN);
-	printk("%s: Setting MAC address to %pM\n", dev->name, dev->dev_addr);
+	netdev_info(dev, "Setting MAC address to %pM\n", dev->dev_addr);
 
 	/* set the Ethernet address */
 	for (i=0; i < ETH_ALEN/2; i++)
-- 
2.13.6
