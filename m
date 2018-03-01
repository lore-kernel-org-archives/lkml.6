Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163190AbeCAXbG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:31:06 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52472 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163012AbeCAX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:29:29 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1c8ae855bc1474da6e37f1726545f5811610f5f9.1519813462.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519813462.git.fthain@telegraphics.com.au>
References: <cover.1519813462.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 3/4] net/mac89x0: Fix and modernize log messages
Date: Thu,  1 Mar 2018 18:29:28 -0500 (EST)
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
index 911139abbe20..9a266496a538 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -56,6 +56,8 @@
   local_irq_{dis,en}able()
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 static const char version[] =
 "cs89x0.c:v1.02 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
 
@@ -245,16 +247,14 @@ static int mac89x0_device_probe(struct platform_device *pdev)
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
@@ -269,7 +269,7 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 
 	/* print the IRQ and ethernet address. */
 
-	printk(" IRQ %d ADDR %pM\n", dev->irq, dev->dev_addr);
+	pr_info("MAC %pM, IRQ %d\n", dev->dev_addr, dev->irq);
 
 	dev->netdev_ops		= &mac89x0_netdev_ops;
 
@@ -472,7 +472,6 @@ net_rx(struct net_device *dev)
 	/* Malloc up new buffer. */
 	skb = alloc_skb(length, GFP_ATOMIC);
 	if (skb == NULL) {
-		printk("%s: Memory squeeze, dropping packet.\n", dev->name);
 		dev->stats.rx_dropped++;
 		return;
 	}
@@ -560,7 +559,7 @@ static int set_mac_address(struct net_device *dev, void *addr)
 		return -EADDRNOTAVAIL;
 
 	memcpy(dev->dev_addr, saddr->sa_data, ETH_ALEN);
-	printk("%s: Setting MAC address to %pM\n", dev->name, dev->dev_addr);
+	netdev_info(dev, "Setting MAC address to %pM\n", dev->dev_addr);
 
 	/* set the Ethernet address */
 	for (i=0; i < ETH_ALEN/2; i++)
-- 
2.16.1
