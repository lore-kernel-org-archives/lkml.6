Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD0C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC243204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC243204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIJCgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:36:50 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39747 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJCgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:36:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8040E100DA1A2;
        Sun,  9 Sep 2018 23:45:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 37FFD213203; Sun,  9 Sep 2018 23:45:42 +0200 (CEST)
Message-Id: <f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de>
In-Reply-To: <cover.1536517047.git.lukas@wunner.de>
References: <cover.1536517047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Sep 2018 23:42:01 +0200
Subject: [PATCH 4/5] thunderbolt: Correlate PCI devices with Thunderbolt ports
To:     Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

macOS correlates PCI devices with Thunderbolt ports and stores their
device paths in each other's I/O Registry entry:

  IOThunderboltPort@7 {
    "PCI Device" = 4
    "PCI Function" = 0
    "PCI Path" = "IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/PEG1@1,1/IOPP/UPSB@0/IOPP/DSB2@4"
    ...
  }

  DSB2@4 {
    "pcidebug" = "6:4:0(132:132)"
    "Thunderbolt Path" = "IOService:/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/PEG1@1,1/IOPP/UPSB@0/IOPP/DSB0@0/IOPP/NHI0@0/AppleThunderboltHAL/AppleThunderboltNHIType1/IOThunderboltController/IOThunderboltPort@6/IOThunderboltSwitchType1/IOThunderboltPort@7"
    ...
  }

Do the same by finding the Thunderbolt port corresponding to a PCI
device from a bus notifier and storing a pointer to the PCI device in
struct tb_port.  On initial switch scan, fill in the pointers for
already enumerated PCI devices.

This achieves a unidirectional mapping from tb_port to pci_dev.  If an
inverse mapping is needed, it may be possible to use the sysdata pointer
in struct pci_dev.

To find the Thunderbolt port, the PCI slot numbers specified in the root
switch's DROM need to be available.  On Macs with Thunderbolt 1 that's
not the case unless the kernel is booted by the EFI stub.

Moreover the driver needs to know which tunnels have been established,
which is not the case with ICM-controlled tunnel management, so the bus
notifier is only registered if tunnel management is under OS control.
Perhaps it is possible to retrieve a list of established tunnels from
the ICM firmware, or if all else fails, follow the hop entries in a
downstream port's config space to discover established tunnels.
Correlation would then also work for ICM-controlled tunnel management.

Ideas what we can do with correlation:

* Represent the relationship between PCI devices and Thunderbolt ports
  with symlinks in sysfs.

* Thunderbolt controllers up to revision 1 of Cactus Ridge 4C have to
  use INTx because MSI signaling is broken.  This results in hotplug
  ports sharing interrupts with other devices and, when daisy-chaining
  multiple affected Thunderbolt controllers, can lead to extremely
  unbalanced interrupt usage.  To avoid this we could prefer downstream
  ports for tunnel establishment which do not share interrupts (based
  on the nr_actions field of the correlated PCI device's irq_desc).

* Alternatively, we could use non-working MSI signaling on affected
  controllers and synthesize an interrupt whenever a tunnel is
  established or goes down on unplug.

The shared interrupts issue is grave.  This is /proc/interrupts on a
MacBookPro9,1 with a daisy-chain of two Light Ridge controllers and
one Port Ridge (all with broken MSI signaling):

  16:  IO-APIC  16-fasteoi  pciehp
  17:  IO-APIC  17-fasteoi  pciehp, pciehp, pciehp, mmc0, snd_hda_intel, b43
  18:  IO-APIC  18-fasteoi  pciehp, pciehp, i801_smbus
  19:  IO-APIC  19-fasteoi  pciehp

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/Makefile      |   2 +-
 drivers/thunderbolt/adapter_pci.c | 166 ++++++++++++++++++++++++++++++
 drivers/thunderbolt/adapter_pci.h |  19 ++++
 drivers/thunderbolt/tb.c          |  21 ++--
 drivers/thunderbolt/tb.h          |  36 +++++++
 5 files changed, 230 insertions(+), 14 deletions(-)
 create mode 100644 drivers/thunderbolt/adapter_pci.c
 create mode 100644 drivers/thunderbolt/adapter_pci.h

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index f2f0de27252b..c91b9f7d4c0b 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,3 +1,3 @@
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
 thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o
-thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o
+thunderbolt-objs += adapter_pci.o domain.o dma_port.o icm.o property.o xdomain.o
diff --git a/drivers/thunderbolt/adapter_pci.c b/drivers/thunderbolt/adapter_pci.c
new file mode 100644
index 000000000000..e5abcbd6d064
--- /dev/null
+++ b/drivers/thunderbolt/adapter_pci.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe adapters on a Thunderbolt switch serve as endpoints for PCI tunnels.
+ * Each may be attached to an upstream or downstream port of the PCIe switch
+ * integrated into a Thunderbolt controller.
+ *
+ * Copyright (C) 2018 Lukas Wunner <lukas@wunner.de>
+ */
+
+#include "tb.h"
+#include "tunnel_pci.h"
+#include "adapter_pci.h"
+
+/**
+ * tb_is_pci_adapter() - whether given PCI device is a Thunderbolt PCIe adapter
+ * @pdev: PCI device
+ *
+ * For simplicity this function returns a false positive in the following cases
+ * and callers need to make sure they can handle that:
+ * * Upstream port on a host controller
+ * * Downstream port to the XHCI on a host controller
+ * * Downstream port on non-chainable endpoint controllers such as Port Ridge
+ */
+static bool tb_is_pci_adapter(struct pci_dev *pdev)
+{
+	/* downstream ports with devfn 0 are reserved for the NHI */
+	return pdev->is_thunderbolt &&
+	       (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM ||
+		(pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+		 pdev->devfn));
+}
+
+/**
+ * tb_pci_find_port() - locate Thunderbolt port for given PCI device
+ * @pdev: PCI device
+ *
+ * Walk up the PCI hierarchy from @pdev to discover the sequence of
+ * PCIe upstream and downstream ports leading to the host controller.
+ * Then walk down the Thunderbolt daisy-chain following the previously
+ * discovered sequence along the tunnels we've established.
+ *
+ * Return the port corresponding to @pdev, or %NULL if none was found.
+ *
+ * This function needs to be called under the global Thunderbolt lock
+ * to prevent tb_switch and tb_pci_tunnel structs from going away.
+ */
+static struct tb_port *tb_pci_find_port(struct tb *tb, struct pci_dev *pdev)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_pci_tunnel *tunnel;
+	struct pci_dev *parent_pdev;
+	struct tb_port *parent_port;
+	struct tb_port *port;
+
+	if (!tb_is_pci_adapter(pdev))
+		return NULL;
+
+	/* base of the recursion: we've reached the host controller */
+	if (pdev->bus == tb->upstream->subordinate) {
+		tb_sw_for_each_port(tb->root_switch, port)
+			if (port->pci.devfn == pdev->devfn)
+				return port;
+
+		return NULL;
+	}
+
+	/* recurse up the PCI hierarchy */
+	parent_pdev = pci_upstream_bridge(pdev);
+	if (!parent_pdev)
+		return NULL;
+
+	parent_port = tb_pci_find_port(tb, parent_pdev);
+	if (!parent_port)
+		return NULL;
+
+	switch (parent_port->config.type) {
+	case TB_TYPE_PCIE_UP:
+		/*
+		 * A PCIe upstream adapter is the parent of
+		 * a PCIe downstream adapter on the same switch.
+		 */
+		tb_sw_for_each_port(parent_port->sw, port)
+			if (port->config.type == TB_TYPE_PCIE_DOWN &&
+			    port->pci.devfn == pdev->devfn)
+				return port;
+		return NULL;
+	case TB_TYPE_PCIE_DOWN:
+		/*
+		 * A PCIe downstream adapter is the parent of
+		 * a PCIe upstream adapter at the other end of a tunnel.
+		 */
+		list_for_each_entry(tunnel, &tcm->tunnel_list, list)
+			if (tunnel->down_port == parent_port)
+				return tunnel->up_port;
+		return NULL;
+	default:
+		return NULL;
+	}
+}
+
+/**
+ * tb_pci_notifier_call() - Thunderbolt PCI bus notifier
+ * @nb: Notifier block embedded in struct tb_cm
+ * @action: Notifier action
+ * @data: PCI device
+ *
+ * On addition of PCI device @data, correlate it with a PCIe adapter on the
+ * Thunderbolt bus and store a pointer to the PCI device in struct tb_port.
+ * On deletion, reset the pointer to %NULL.
+ */
+int tb_pci_notifier_call(struct notifier_block *nb, unsigned long action,
+			 void *data)
+{
+	struct tb_cm *tcm = container_of(nb, struct tb_cm, pci_notifier);
+	struct tb *tb = tb_from_priv(tcm);
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb_port *port;
+
+	if ((action != BUS_NOTIFY_ADD_DEVICE &&
+	     action != BUS_NOTIFY_DEL_DEVICE) || !tb_is_pci_adapter(pdev))
+		return NOTIFY_DONE;
+
+	mutex_lock(&tb->lock);
+	port = tb_pci_find_port(tb, pdev);
+	if (!port)
+		goto out;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		port->pci.dev = pdev;
+		tb_port_info(port, "correlates with %s\n", pci_name(pdev));
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		port->pci.dev = NULL;
+		tb_port_info(port, "no longer correlates with %s\n",
+			     pci_name(pdev));
+		break;
+	}
+out:
+	mutex_unlock(&tb->lock);
+	return NOTIFY_DONE;
+}
+
+/**
+ * tb_pci_correlate() - Correlate given PCI device with a Thunderbolt port
+ * @pdev: PCI device
+ * @data: Thunderbolt bus
+ *
+ * Correlate @pdev with a PCIe adapter on Thunderbolt bus @data and store a
+ * pointer to the PCI device in struct tb_port.  Intended to be used as a
+ * pci_walk_bus() callback.
+ */
+int tb_pci_correlate(struct pci_dev *pdev, void *data)
+{
+	struct tb *tb = data;
+	struct tb_port *port;
+
+	port = tb_pci_find_port(tb, pdev);
+	if (port) {
+		port->pci.dev = pdev;
+		tb_port_info(port, "correlates with %s\n", pci_name(pdev));
+	}
+
+	return 0;
+}
diff --git a/drivers/thunderbolt/adapter_pci.h b/drivers/thunderbolt/adapter_pci.h
new file mode 100644
index 000000000000..76de43cd0f17
--- /dev/null
+++ b/drivers/thunderbolt/adapter_pci.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe adapters on a Thunderbolt switch serve as endpoints for PCI tunnels.
+ * Each may be attached to an upstream or downstream port of the PCIe switch
+ * integrated into a Thunderbolt controller.
+ *
+ * Copyright (C) 2018 Lukas Wunner <lukas@wunner.de>
+ */
+
+#ifndef ADAPTER_PCI_H_
+#define ADAPTER_PCI_H_
+
+#include <linux/notifier.h>
+
+int tb_pci_notifier_call(struct notifier_block *nb, unsigned long action,
+			 void *data);
+int tb_pci_correlate(struct pci_dev *pdev, void *data);
+
+#endif
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 0da2e7a06ab5..3549a51b23d9 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -13,19 +13,7 @@
 #include "tb.h"
 #include "tb_regs.h"
 #include "tunnel_pci.h"
-
-/**
- * struct tb_cm - Simple Thunderbolt connection manager
- * @tunnel_list: List of active tunnels
- * @hotplug_active: tb_handle_hotplug will stop progressing plug
- *		    events and exit if this is not set (it needs to
- *		    acquire the lock one more time). Used to drain wq
- *		    after cfg has been paused.
- */
-struct tb_cm {
-	struct list_head tunnel_list;
-	bool hotplug_active;
-};
+#include "adapter_pci.h"
 
 /* enumeration & hot plug handling */
 
@@ -355,6 +343,7 @@ static void tb_stop(struct tb *tb)
 	struct tb_pci_tunnel *tunnel;
 	struct tb_pci_tunnel *n;
 
+	bus_unregister_notifier(&pci_bus_type, &tcm->pci_notifier);
 	/* tunnels are only present after everything has been initialized */
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
 		tb_pci_deactivate(tunnel);
@@ -395,6 +384,11 @@ static int tb_start(struct tb *tb)
 
 	/* Full scan to discover devices added before the driver was loaded. */
 	tb_scan_switch(tb->root_switch);
+
+	/* Correlate PCI devices with Thunderbolt ports */
+	bus_register_notifier(&pci_bus_type, &tcm->pci_notifier);
+	pci_walk_bus(tb->upstream->subordinate, tb_pci_correlate, tb);
+
 	tb_activate_pcie_devices(tb);
 
 	/* Allow tb_handle_hotplug to progress events */
@@ -469,6 +463,7 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 
 	tcm = tb_priv(tb);
 	INIT_LIST_HEAD(&tcm->tunnel_list);
+	tcm->pci_notifier.notifier_call = tb_pci_notifier_call;
 
 	return tb;
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 755183f0b257..603e6214b060 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -17,6 +17,20 @@
 #include "ctl.h"
 #include "dma_port.h"
 
+/**
+ * struct tb_cm - Native Thunderbolt connection manager
+ * @pci_notifier: Notifier to correlate PCI devices with Thunderbolt ports
+ * @tunnel_list: List of active tunnels
+ * @hotplug_active: tb_handle_hotplug() will stop processing plug events and
+ *		    exit if this is not set (it needs to acquire the lock one
+ *		    more time). Used to drain wq after cfg has been paused.
+ */
+struct tb_cm {
+	struct notifier_block pci_notifier;
+	struct list_head tunnel_list;
+	unsigned int hotplug_active:1;
+};
+
 /**
  * struct tb_switch_nvm - Structure holding switch NVM information
  * @major: Major version number of the active NVM portion
@@ -128,6 +142,9 @@ struct tb_switch {
  * @pci: Data specific to PCIe adapters
  * @pci.devfn: PCI slot/function according to DROM
  * @pci.unknown: Unknown data in DROM (to be reverse-engineered)
+ * @pci.dev: PCI device of corresponding PCIe upstream or downstream port
+ *	     (%NULL if not found or if removed by PCI core).  To access,
+ *	     acquire Thunderbolt lock, call pci_dev_get(), release the lock.
  */
 struct tb_port {
 	struct tb_regs_port_header config;
@@ -143,6 +160,7 @@ struct tb_port {
 		struct {
 			u8 devfn;
 			u8 unknown[9];
+			struct pci_dev *dev;
 		} pci;
 	};
 };
@@ -250,6 +268,11 @@ static inline void *tb_priv(struct tb *tb)
 	return (void *)tb->privdata;
 }
 
+static inline struct tb *tb_from_priv(void *priv)
+{
+	return priv - offsetof(struct tb, privdata);
+}
+
 #define TB_AUTOSUSPEND_DELAY		15000 /* ms */
 
 /* helper functions & macros */
@@ -332,6 +355,19 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 			    length);
 }
 
+/**
+ * tb_sw_for_each_port() - iterate over ports on a switch
+ * @switch: pointer to struct tb_switch over whose ports shall be iterated
+ * @port: pointer to struct tb_port which shall be used as the iterator
+ *
+ * Excludes port 0, which is the switch itself and therefore irrelevant for
+ * most iterations.
+ */
+#define tb_sw_for_each_port(switch, port)				 \
+	for (port = &(switch)->ports[1];				 \
+	     port <= &(switch)->ports[(switch)->config.max_port_number]; \
+	     port++)
+
 #define tb_err(tb, fmt, arg...) dev_err(&(tb)->nhi->pdev->dev, fmt, ## arg)
 #define tb_WARN(tb, fmt, arg...) dev_WARN(&(tb)->nhi->pdev->dev, fmt, ## arg)
 #define tb_warn(tb, fmt, arg...) dev_warn(&(tb)->nhi->pdev->dev, fmt, ## arg)
-- 
2.18.0

