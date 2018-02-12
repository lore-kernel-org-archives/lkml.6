Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeBLDLq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 22:11:46 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56816 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeBLDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 22:08:45 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Message-Id: <2ce948e1e6c0ef2476f57600b429b24355871eb8.1518397634.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v4 06/13] net/mac89x0: Convert to platform_driver
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently these Dayna cards don't have a pseudoslot declaration ROM
which means they can't be probed like NuBus cards.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/config.c                |  4 ++
 drivers/net/Space.c                   |  3 --
 drivers/net/ethernet/cirrus/mac89x0.c | 69 ++++++++++++++++-------------------
 include/net/Space.h                   |  1 -
 4 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index d3d435248a24..c73eb8209555 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -1088,6 +1088,10 @@ int __init mac_platform_init(void)
 	    macintosh_config->expansion_type == MAC_EXP_PDS_COMM)
 		platform_device_register_simple("macsonic", -1, NULL, 0);
 
+	if (macintosh_config->expansion_type == MAC_EXP_PDS ||
+	    macintosh_config->expansion_type == MAC_EXP_PDS_COMM)
+		platform_device_register_simple("mac89x0", -1, NULL, 0);
+
 	if (macintosh_config->ether_type == MAC_ETHER_MACE)
 		platform_device_register_simple("macmace", -1, NULL, 0);
 
diff --git a/drivers/net/Space.c b/drivers/net/Space.c
index 11fe71278f40..fe123808c6b8 100644
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -117,9 +117,6 @@ static struct devprobe2 m68k_probes[] __initdata = {
 #ifdef CONFIG_MAC8390           /* NuBus NS8390-based cards */
 	{mac8390_probe, 0},
 #endif
-#ifdef CONFIG_MAC89x0
-	{mac89x0_probe, 0},
-#endif
 	{NULL, 0},
 };
 
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 4fe0ae93ab36..7f7c72409921 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -93,6 +93,7 @@ static const char version[] =
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
+#include <linux/platform_device.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
@@ -105,6 +106,10 @@ static const char version[] =
 
 #include "cs89x0.h"
 
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "CS89[02]0 debug level (0-5)");
+
 static unsigned int net_debug = NET_DEBUG;
 
 /* Information that need to be kept for each board. */
@@ -167,10 +172,9 @@ static const struct net_device_ops mac89x0_netdev_ops = {
 
 /* Probe for the CS8900 card in slot E.  We won't bother looking
    anywhere else until we have a really good reason to do so. */
-struct net_device * __init mac89x0_probe(int unit)
+static int mac89x0_device_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
-	static int once_is_enough;
 	struct net_local *lp;
 	static unsigned version_printed;
 	int i, slot;
@@ -181,20 +185,13 @@ struct net_device * __init mac89x0_probe(int unit)
 	struct nubus_rsrc *fres;
 
 	if (!MACH_IS_MAC)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
+
+	net_debug = debug;
 
 	dev = alloc_etherdev(sizeof(struct net_local));
 	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	if (unit >= 0) {
-		sprintf(dev->name, "eth%d", unit);
-		netdev_boot_setup_check(dev);
-	}
-
-	if (once_is_enough)
-		goto out;
-	once_is_enough = 1;
+		return -ENOMEM;
 
 	/* We might have to parameterize this later */
 	slot = 0xE;
@@ -221,6 +218,8 @@ struct net_device * __init mac89x0_probe(int unit)
 	if (sig != swab16(CHIP_EISA_ID_SIG))
 		goto out;
 
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
 	/* Initialize the net_device structure. */
 	lp = netdev_priv(dev);
 
@@ -280,12 +279,14 @@ struct net_device * __init mac89x0_probe(int unit)
 	err = register_netdev(dev);
 	if (err)
 		goto out1;
-	return NULL;
+
+	platform_set_drvdata(pdev, dev);
+	return 0;
 out1:
 	nubus_writew(0, dev->base_addr + ADD_PORT);
 out:
 	free_netdev(dev);
-	return ERR_PTR(err);
+	return err;
 }
 
 /* Open/initialize the board.  This is called (in the current kernel)
@@ -571,32 +572,24 @@ static int set_mac_address(struct net_device *dev, void *addr)
 	return 0;
 }
 
-#ifdef MODULE
-
-static struct net_device *dev_cs89x0;
-static int debug;
-
-module_param(debug, int, 0);
-MODULE_PARM_DESC(debug, "CS89[02]0 debug level (0-5)");
 MODULE_LICENSE("GPL");
 
-int __init
-init_module(void)
+static int mac89x0_device_remove(struct platform_device *pdev)
 {
-	net_debug = debug;
-        dev_cs89x0 = mac89x0_probe(-1);
-	if (IS_ERR(dev_cs89x0)) {
-                printk(KERN_WARNING "mac89x0.c: No card found\n");
-		return PTR_ERR(dev_cs89x0);
-	}
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	unregister_netdev(dev);
+	nubus_writew(0, dev->base_addr + ADD_PORT);
+	free_netdev(dev);
 	return 0;
 }
 
-void
-cleanup_module(void)
-{
-	unregister_netdev(dev_cs89x0);
-	nubus_writew(0, dev_cs89x0->base_addr + ADD_PORT);
-	free_netdev(dev_cs89x0);
-}
-#endif /* MODULE */
+static struct platform_driver mac89x0_platform_driver = {
+	.probe = mac89x0_device_probe,
+	.remove = mac89x0_device_remove,
+	.driver = {
+		.name = "mac89x0",
+	},
+};
+
+module_platform_driver(mac89x0_platform_driver);
diff --git a/include/net/Space.h b/include/net/Space.h
index 27fb5c937c4f..436c46b9473f 100644
--- a/include/net/Space.h
+++ b/include/net/Space.h
@@ -21,7 +21,6 @@ struct net_device *mvme147lance_probe(int unit);
 struct net_device *tc515_probe(int unit);
 struct net_device *lance_probe(int unit);
 struct net_device *mac8390_probe(int unit);
-struct net_device *mac89x0_probe(int unit);
 struct net_device *cops_probe(int unit);
 struct net_device *ltpc_probe(void);
 
-- 
2.13.6
