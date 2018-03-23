Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCWOYm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:24:42 -0400
Received: from atl4mhob21.registeredsite.com ([209.17.115.115]:41668 "EHLO
        atl4mhob21.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751303AbeCWOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:24:41 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] of_net: Implement of_get_nvmem_mac_address helper
Date: Fri, 23 Mar 2018 15:24:34 +0100
Message-Id: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common practice to store MAC addresses for network interfaces into
nvmem devices. However the code to actually do this in the kernel lacks,
so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
address from an nvmem cell provider.

This is particulary useful on devices where the ethernet interface cannot
be configured by the bootloader, for example because it's in an FPGA.

Tested by adapting the cadence macb driver to call this instead of
of_get_mac_address().

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/of/of_net.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_net.h |  6 ++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index d820f3e..316a537 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -7,6 +7,7 @@
  */
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/export.h>
@@ -80,3 +81,50 @@ const void *of_get_mac_address(struct device_node *np)
 	return of_get_mac_addr(np, "address");
 }
 EXPORT_SYMBOL(of_get_mac_address);
+
+/**
+ * Search the device tree for a MAC address, by calling of_get_mac_address
+ * and if that doesn't provide an address, fetch it from an nvmem provider
+ * using the name 'mac-address'.
+ * On success, copies the new address is into memory pointed to by addr and
+ * returns 0. Returns a negative error code otherwise.
+ * @dev:	Pointer to the device containing the device_node
+ * @addr:	Pointer to receive the MAC address using ether_addr_copy()
+ */
+int of_get_nvmem_mac_address(struct device *dev, char *addr)
+{
+	const char *mac;
+	struct nvmem_cell *cell;
+	size_t len;
+	int ret;
+
+	mac = of_get_mac_address(dev->of_node);
+	if (mac) {
+		ether_addr_copy(addr, mac);
+		return 0;
+	}
+
+	cell = nvmem_cell_get(dev, "mac-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	mac = (const char *)nvmem_cell_read(cell, &len);
+
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(mac))
+		return PTR_ERR(mac);
+
+	if (len < 6 || !is_valid_ether_addr(mac)) {
+		dev_err(dev, "MAC address from NVMEM is invalid\n");
+		ret = -EINVAL;
+	} else {
+		ether_addr_copy(addr, mac);
+		ret = 0;
+	}
+
+	kfree(mac);
+
+	return ret;
+}
+EXPORT_SYMBOL(of_get_nvmem_mac_address);
diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 9cd72aa..0d52e1d 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -13,6 +13,7 @@
 struct net_device;
 extern int of_get_phy_mode(struct device_node *np);
 extern const void *of_get_mac_address(struct device_node *np);
+extern int of_get_nvmem_mac_address(struct device *dev, char *addr);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np)
@@ -25,6 +26,11 @@ static inline const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 
+static inline int of_get_nvmem_mac_address(struct device *dev, char *addr)
+{
+	return -ENODEV;
+}
+
 static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	return NULL;
-- 
1.9.1
