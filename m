Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCZGln (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:41:43 -0400
Received: from atl4mhob19.registeredsite.com ([209.17.115.112]:44946 "EHLO
        atl4mhob19.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751938AbeCZGlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:41:42 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] of_net: Implement of_get_nvmem_mac_address helper
Date: Mon, 26 Mar 2018 08:41:29 +0200
Message-Id: <1522046489-19652-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl> <20180323151101.GB24361@lunn.ch>
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
v2: Use of_nvmem_cell_get to avoid needing the assiciated device
    Use void* instead of char*
    Add devicetree binding doc
 Documentation/devicetree/bindings/net/ethernet.txt |  2 +
 drivers/of/of_net.c                                | 47 ++++++++++++++++++++++
 include/linux/of_net.h                             |  6 +++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
index 2974e63..cfc376b 100644
--- a/Documentation/devicetree/bindings/net/ethernet.txt
+++ b/Documentation/devicetree/bindings/net/ethernet.txt
@@ -10,6 +10,8 @@ Documentation/devicetree/bindings/phy/phy-bindings.txt.
   the boot program; should be used in cases where the MAC address assigned to
   the device by the boot program is different from the "local-mac-address"
   property;
+- nvmem-cells: phandle, reference to an nvmem node for the MAC address;
+- nvmem-cell-names: string, should be "mac-address" if nvmem is to be used;
 - max-speed: number, specifies maximum speed in Mbit/s supported by the device;
 - max-frame-size: number, maximum transfer unit (IEEE defined MTU), rather than
   the maximum frame size (there's contradiction in the Devicetree
diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index d820f3e..8999745 100644
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
@@ -80,3 +81,49 @@ const void *of_get_mac_address(struct device_node *np)
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
+int of_get_nvmem_mac_address(struct device_node *np, void *addr)
+{
+	const void *mac;
+	struct nvmem_cell *cell;
+	size_t len;
+	int ret;
+
+	mac = of_get_mac_address(np);
+	if (mac) {
+		ether_addr_copy(addr, mac);
+		return 0;
+	}
+
+	cell = of_nvmem_cell_get(np, "mac-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	mac = nvmem_cell_read(cell, &len);
+
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(mac))
+		return PTR_ERR(mac);
+
+	if (len < 6 || !is_valid_ether_addr(mac)) {
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
index 9cd72aa..90d81ee 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -13,6 +13,7 @@
 struct net_device;
 extern int of_get_phy_mode(struct device_node *np);
 extern const void *of_get_mac_address(struct device_node *np);
+extern int of_get_nvmem_mac_address(struct device_node *np, void *addr);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np)
@@ -25,6 +26,11 @@ static inline const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 
+static inline int of_get_nvmem_mac_address(struct device_node *np, void *addr)
+{
+	return -ENODEV;
+}
+
 static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	return NULL;
-- 
1.9.1
