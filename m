Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeEQNIM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:08:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39994 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:08:10 -0400
X-Google-Smtp-Source: AB8JxZqDk7yRYQkJvlzFqzcKRQnXGO8dq8dafQzB7phFcXHB5L1OU5bzakQyPHOmgDUzIePPKP+o8g==
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: tobin@apporbit.com
Cc: andrea.greco.gapmilano@gmail.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arcnet: com20020: Add ethtool support
Date: Thu, 17 May 2018 15:07:57 +0200
Message-Id: <20180517130757.2895-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

Setup ethtols for export com20020 diag register

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/com20020-io.c  |  1 +
 drivers/net/arcnet/com20020-isa.c |  1 +
 drivers/net/arcnet/com20020.c     | 24 ++++++++++++++++++++++++
 drivers/net/arcnet/com20020.h     |  1 +
 drivers/net/arcnet/com20020_cs.c  |  1 +
 include/uapi/linux/if_arcnet.h    |  6 ++++++
 6 files changed, 34 insertions(+)

diff --git a/drivers/net/arcnet/com20020-io.c b/drivers/net/arcnet/com20020-io.c
index fce458242193..0d4355bcd873 100644
--- a/drivers/net/arcnet/com20020-io.c
+++ b/drivers/net/arcnet/com20020-io.c
@@ -183,6 +183,7 @@ static int com20020_probe(struct platform_device *pdev)
 
 	dev = alloc_arcdev(NULL);
 	dev->netdev_ops = &com20020_netdev_ops;
+	dev->ethtool_ops = &com20020_ethtool_ops;
 	lp = netdev_priv(dev);
 
 	lp->card_flags = ARC_CAN_10MBIT;
diff --git a/drivers/net/arcnet/com20020-isa.c b/drivers/net/arcnet/com20020-isa.c
index 38fa60ddaf2e..44ab6dcccb58 100644
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -154,6 +154,7 @@ static int __init com20020_init(void)
 		dev->dev_addr[0] = node;
 
 	dev->netdev_ops = &com20020_netdev_ops;
+	dev->ethtool_ops = &com20020_ethtool_ops;
 
 	lp = netdev_priv(dev);
 	lp->backplane = backplane;
diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index f1de02f05305..02dd93a18e53 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -201,6 +201,29 @@ const struct net_device_ops com20020_netdev_ops = {
 	.ndo_set_rx_mode = com20020_set_mc_list,
 };
 
+static int com20020_ethtool_regs_len(struct net_device *netdev)
+{
+	return sizeof(struct com20020_ethtool_regs);
+}
+
+static void com20020_ethtool_regs_read(struct net_device *dev,
+				       struct ethtool_regs *regs, void *p)
+{
+	struct arcnet_local *lp = netdev_priv(dev);
+	struct com20020_ethtool_regs *com_reg = p;
+
+	memset(p, 0, sizeof(struct com20020_ethtool_regs));
+
+	com_reg->status = lp->hw.status(dev) & 0xFF;
+	com_reg->diag_register = (lp->hw.status(dev) >> 8) & 0xFF;
+	com_reg->reconf_count = lp->num_recons;
+}
+
+const struct ethtool_ops com20020_ethtool_ops = {
+	.get_regs = com20020_ethtool_regs_read,
+	.get_regs_len  = com20020_ethtool_regs_len,
+};
+
 /* Set up the struct net_device associated with this card.  Called after
  * probing succeeds.
  */
@@ -402,6 +425,7 @@ static void com20020_set_mc_list(struct net_device *dev)
 EXPORT_SYMBOL(com20020_check);
 EXPORT_SYMBOL(com20020_found);
 EXPORT_SYMBOL(com20020_netdev_ops);
+EXPORT_SYMBOL(com20020_ethtool_ops);
 #endif
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/arcnet/com20020.h b/drivers/net/arcnet/com20020.h
index 0bcc5d0a6903..a1024c8f8a1f 100644
--- a/drivers/net/arcnet/com20020.h
+++ b/drivers/net/arcnet/com20020.h
@@ -31,6 +31,7 @@
 int com20020_check(struct net_device *dev);
 int com20020_found(struct net_device *dev, int shared);
 extern const struct net_device_ops com20020_netdev_ops;
+extern const struct ethtool_ops com20020_ethtool_ops;
 
 /* The number of low I/O ports used by the card. */
 #define ARCNET_TOTAL_SIZE 8
diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index cf607ffcf358..ae64f436fd54 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -233,6 +233,7 @@ static int com20020_config(struct pcmcia_device *link)
 	}
 
 	dev->irq = link->irq;
+	dev->ethtool_ops = &com20020_ethtool_ops;
 
 	ret = pcmcia_enable_device(link);
 	if (ret)
diff --git a/include/uapi/linux/if_arcnet.h b/include/uapi/linux/if_arcnet.h
index 683878036d76..790c0fa7386d 100644
--- a/include/uapi/linux/if_arcnet.h
+++ b/include/uapi/linux/if_arcnet.h
@@ -127,4 +127,10 @@ struct archdr {
 	} soft;
 };
 
+struct com20020_ethtool_regs {
+	__u8 status;
+	__u8 diag_register;
+	__u32 reconf_count;
+};
+
 #endif				/* _LINUX_IF_ARCNET_H */
-- 
2.14.3
