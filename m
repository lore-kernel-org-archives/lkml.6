Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBZXTJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:19:09 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38613 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZXTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:19:08 -0500
X-Google-Smtp-Source: AH8x2253h03RhiSpn2IH0ZzYkj/z+Fd5aPY/dBp8gSuv+sfj8EJoDAsvZVJ8GAlTa6w20E1d3tHvFA==
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] PCI: Move declaration of of_irq_parse_and_map_pci under OF_IRQ
Date: Mon, 26 Feb 2018 15:19:05 -0800
Message-Id: <1519687145-9430-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4670d610d5923 ("PCI: Move OF-related PCI functions into
PCI core"), sparc:allmodconfig fails to build with the following error.

pcie-cadence-host.c:(.text+0x4c4):
	undefined reference to `of_irq_parse_and_map_pci'
pcie-cadence-host.c:(.text+0x4c8):
	undefined reference to `of_irq_parse_and_map_pci'

of_irq_parse_and_map_pci is now only available if OF_IRQ is enabled.
Make its declaration and its dummy function dependent on OF_IRQ
to solve the problem.

Fixes: 4670d610d5923 ("PCI: Move OF-related PCI functions into PCI core")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/of_pci.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 88865e0ebf4d..091033a6b836 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -13,7 +13,6 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
-int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
@@ -34,12 +33,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 }
 
 static inline int
-of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	return 0;
-}
-
-static inline int
 of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 {
 	return -EINVAL;
@@ -67,6 +60,16 @@ of_pci_get_max_link_speed(struct device_node *node)
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
+#if IS_ENABLED(CONFIG_OF_IRQ)
+int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
+#else
+static inline int
+of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_OF_ADDRESS)
 int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
-- 
2.7.4
