Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B110E251D7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B110E251D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeGALMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:12:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752146AbeGALJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DA29AE56;
        Sun,  1 Jul 2018 11:08:58 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 06/15] net: lora: Prepare for device drivers
Date:   Sun,  1 Jul 2018 13:07:55 +0200
Message-Id: <20180701110804.32415-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement helper functions for use by LoRa device drivers.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/Makefile      |   1 +
 drivers/net/lora/Kconfig  |  18 +++++++
 drivers/net/lora/Makefile |  10 ++++
 drivers/net/lora/dev.c    | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/lora/dev.h  |  23 +++++++++
 net/lora/Kconfig          |   6 +++
 6 files changed, 183 insertions(+)
 create mode 100644 drivers/net/lora/Kconfig
 create mode 100644 drivers/net/lora/Makefile
 create mode 100644 drivers/net/lora/dev.c
 create mode 100644 include/linux/lora/dev.h

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 21cde7e78621..9819bf28633d 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
 obj-$(CONFIG_HAMRADIO) += hamradio/
+obj-$(CONFIG_LORA) += lora/
 obj-$(CONFIG_PLIP) += plip/
 obj-$(CONFIG_PPP) += ppp/
 obj-$(CONFIG_PPP_ASYNC) += ppp/
diff --git a/drivers/net/lora/Kconfig b/drivers/net/lora/Kconfig
new file mode 100644
index 000000000000..40969b148a50
--- /dev/null
+++ b/drivers/net/lora/Kconfig
@@ -0,0 +1,18 @@
+#
+# LoRa
+#
+
+menu "LoRa Device Drivers"
+
+config LORA_DEV
+	tristate "LoRa drivers"
+	default y
+	help
+	  LoRa ...
+	  If unsure, say Y.
+
+#
+# Alphabetically sorted.
+#
+
+endmenu
diff --git a/drivers/net/lora/Makefile b/drivers/net/lora/Makefile
new file mode 100644
index 000000000000..8f9d25ea4e70
--- /dev/null
+++ b/drivers/net/lora/Makefile
@@ -0,0 +1,10 @@
+#
+# LoRa
+#
+
+obj-$(CONFIG_LORA_DEV) += lora-dev.o
+lora-dev-y := dev.o
+
+#
+# Alphabetically sorted.
+#
diff --git a/drivers/net/lora/dev.c b/drivers/net/lora/dev.c
new file mode 100644
index 000000000000..8c01106008be
--- /dev/null
+++ b/drivers/net/lora/dev.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017-2018 Andreas Färber
+ */
+
+#include <linux/if_arp.h>
+#include <linux/lora.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/lora/dev.h>
+#include <linux/lora/skb.h>
+#include <net/rtnetlink.h>
+
+#define LORA_MTU 256 /* XXX */
+
+struct sk_buff *alloc_lora_skb(struct net_device *dev, u8 **data)
+{
+	struct sk_buff *skb;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct lora_skb_priv) + LORA_MTU);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb->protocol = htons(ETH_P_LORA);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	lora_skb_reserve(skb);
+	lora_skb_prv(skb)->ifindex = dev->ifindex;
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_lora_skb);
+
+int open_loradev(struct net_device *dev)
+{
+	if (!netif_carrier_ok(dev))
+		netif_carrier_on(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(open_loradev);
+
+void close_loradev(struct net_device *dev)
+{
+}
+EXPORT_SYMBOL_GPL(close_loradev);
+
+static void lora_setup(struct net_device *dev)
+{
+	dev->type = ARPHRD_LORA;
+	dev->mtu = LORA_MTU;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->tx_queue_len = 10;
+
+	dev->flags = IFF_NOARP;
+	dev->features = 0;
+}
+
+struct net_device *alloc_loradev(int sizeof_priv)
+{
+	struct net_device *dev;
+	struct lora_priv *priv;
+
+	dev = alloc_netdev(sizeof_priv, "lora%d", NET_NAME_UNKNOWN, lora_setup);
+	if (!dev)
+		return NULL;
+
+	priv = netdev_priv(dev);
+	priv->dev = dev;
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(alloc_loradev);
+
+void free_loradev(struct net_device *dev)
+{
+	free_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(free_loradev);
+
+static struct rtnl_link_ops lora_link_ops __read_mostly = {
+	.kind = "lora",
+	.setup = lora_setup,
+};
+
+int register_loradev(struct net_device *dev)
+{
+	dev->rtnl_link_ops = &lora_link_ops;
+	return register_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(register_loradev);
+
+void unregister_loradev(struct net_device *dev)
+{
+	unregister_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(unregister_loradev);
+
+static int __init lora_dev_init(void)
+{
+	printk("lora-dev: init\n");
+
+	return rtnl_link_register(&lora_link_ops);
+}
+
+static void __exit lora_dev_exit(void)
+{
+	printk("lora-dev: exit\n");
+
+	rtnl_link_unregister(&lora_link_ops);
+}
+
+module_init(lora_dev_init);
+module_exit(lora_dev_exit);
+
+MODULE_DESCRIPTION("LoRa device driver interface");
+MODULE_ALIAS_RTNL_LINK("lora");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andreas Färber");
diff --git a/include/linux/lora/dev.h b/include/linux/lora/dev.h
new file mode 100644
index 000000000000..531e68f0c9a6
--- /dev/null
+++ b/include/linux/lora/dev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * linux/lora/dev.h
+ *
+ * Copyright (c) 2017-2018 Andreas Färber
+ */
+#ifndef _LORA_DEV_H
+#define _LORA_DEV_H
+
+#include <linux/netdevice.h>
+
+struct net_device *alloc_loradev(int sizeof_priv);
+void free_loradev(struct net_device *dev);
+int register_loradev(struct net_device *dev);
+void unregister_loradev(struct net_device *dev);
+int open_loradev(struct net_device *dev);
+void close_loradev(struct net_device *dev);
+
+struct lora_priv {
+	struct net_device *dev;
+};
+
+#endif /* _LORA_DEV_H */
diff --git a/net/lora/Kconfig b/net/lora/Kconfig
index 44972ea8769f..20658fea3c7c 100644
--- a/net/lora/Kconfig
+++ b/net/lora/Kconfig
@@ -7,3 +7,9 @@ menuconfig LORA
 	tristate "LoRa subsystem support"
 	help
 	  LoRa ...
+
+if LORA
+
+source "drivers/net/lora/Kconfig"
+
+endif
-- 
2.16.4

