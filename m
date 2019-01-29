Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685F921852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfA2PBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:01:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:40215 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbfA2PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="122266139"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2019 07:01:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id ABC6417F; Tue, 29 Jan 2019 17:01:44 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH 11/28] thunderbolt: Generalize tunnel creation functionality
Date:   Tue, 29 Jan 2019 18:01:26 +0300
Message-Id: <20190129150143.12681-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to tunnel non-PCIe traffic, separate tunnel functionality
into generic and PCIe specific parts. Rename struct tb_pci_tunnel to
tb_tunnel, and make it hold an array of paths instead of just two.
Update all the tunneling functions to take this structure as parameter.

We also move tb_pci_port_active() to switch.c (and rename it) where we
will be keeping all port and switch related functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  |  13 ++
 drivers/thunderbolt/tb.c      |  30 ++--
 drivers/thunderbolt/tb.h      |   2 +
 drivers/thunderbolt/tb_regs.h |   4 +
 drivers/thunderbolt/tunnel.c  | 298 ++++++++++++++++++++--------------
 drivers/thunderbolt/tunnel.h  |  38 +++--
 6 files changed, 235 insertions(+), 150 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index fcafe4095de5..93b26c901637 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -606,6 +606,19 @@ static int tb_init_port(struct tb_port *port)
 
 }
 
+/**
+ * tb_pci_port_enable() - Enable PCIe adapter port
+ * @port: PCIe port to enable
+ * @enable: Enable/disable the PCIe adapter
+ */
+int tb_pci_port_enable(struct tb_port *port, bool enable)
+{
+	u32 word = enable ? TB_PCI_EN : 0x0;
+	if (port->cap_adap < 0)
+		return -ENXIO;
+	return tb_port_write(port, &word, TB_CFG_PORT, port->cap_adap, 1);
+}
+
 /* switch utility functions */
 
 static void tb_dump_switch(struct tb *tb, struct tb_regs_switch_header *sw)
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 6047afc6f7b8..8986f4a179bd 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -91,14 +91,14 @@ static void tb_scan_port(struct tb_port *port)
 static void tb_free_invalid_tunnels(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
-	struct tb_pci_tunnel *tunnel;
-	struct tb_pci_tunnel *n;
+	struct tb_tunnel *tunnel;
+	struct tb_tunnel *n;
 
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
-		if (tb_pci_is_invalid(tunnel)) {
-			tb_pci_deactivate(tunnel);
+		if (tb_tunnel_is_invalid(tunnel)) {
+			tb_tunnel_deactivate(tunnel);
 			list_del(&tunnel->list);
-			tb_pci_free(tunnel);
+			tb_tunnel_free(tunnel);
 		}
 	}
 }
@@ -178,7 +178,7 @@ static void tb_activate_pcie_devices(struct tb *tb)
 	struct tb_switch *sw;
 	struct tb_port *up_port;
 	struct tb_port *down_port;
-	struct tb_pci_tunnel *tunnel;
+	struct tb_tunnel *tunnel;
 	struct tb_cm *tcm = tb_priv(tb);
 
 	/* scan for pcie devices at depth 1*/
@@ -214,17 +214,17 @@ static void tb_activate_pcie_devices(struct tb *tb)
 				     "All PCIe down ports are occupied, aborting\n");
 			continue;
 		}
-		tunnel = tb_pci_alloc(tb, up_port, down_port);
+		tunnel = tb_tunnel_alloc_pci(tb, up_port, down_port);
 		if (!tunnel) {
 			tb_port_info(up_port,
 				     "PCIe tunnel allocation failed, aborting\n");
 			continue;
 		}
 
-		if (tb_pci_activate(tunnel)) {
+		if (tb_tunnel_activate(tunnel)) {
 			tb_port_info(up_port,
 				     "PCIe tunnel activation failed, aborting\n");
-			tb_pci_free(tunnel);
+			tb_tunnel_free(tunnel);
 			continue;
 		}
 
@@ -350,13 +350,13 @@ static void tb_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 static void tb_stop(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
-	struct tb_pci_tunnel *tunnel;
-	struct tb_pci_tunnel *n;
+	struct tb_tunnel *tunnel;
+	struct tb_tunnel *n;
 
 	/* tunnels are only present after everything has been initialized */
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
-		tb_pci_deactivate(tunnel);
-		tb_pci_free(tunnel);
+		tb_tunnel_deactivate(tunnel);
+		tb_tunnel_free(tunnel);
 	}
 	tb_switch_remove(tb->root_switch);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
@@ -415,7 +415,7 @@ static int tb_suspend_noirq(struct tb *tb)
 static int tb_resume_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
-	struct tb_pci_tunnel *tunnel, *n;
+	struct tb_tunnel *tunnel, *n;
 
 	tb_dbg(tb, "resuming...\n");
 
@@ -426,7 +426,7 @@ static int tb_resume_noirq(struct tb *tb)
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
-		tb_pci_restart(tunnel);
+		tb_tunnel_restart(tunnel);
 	if (!list_empty(&tcm->tunnel_list)) {
 		/*
 		 * the pcie links need some time to get going.
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 43a1d7dfba73..ca7e78190920 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -444,6 +444,8 @@ int tb_port_clear_counter(struct tb_port *port, int counter);
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
 
+int tb_pci_port_enable(struct tb_port *port, bool enable);
+
 struct tb_path *tb_path_alloc(struct tb *tb, int num_hops);
 void tb_path_free(struct tb_path *path);
 int tb_path_activate(struct tb_path *path);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 82ac4ec8757f..75e935acade5 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -211,6 +211,10 @@ struct tb_regs_port_header {
 
 } __packed;
 
+/* PCIe adapter registers */
+
+#define TB_PCI_EN			BIT(31)
+
 /* Hop register from TB_CFG_HOPS. 8 byte per entry. */
 struct tb_regs_hop {
 	/* DWORD 0 */
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index bd1194f65d14..20ce28276f7a 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - Tunneling support
+ * Thunderbolt driver - Tunneling support
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2019, Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -11,14 +12,17 @@
 #include "tunnel.h"
 #include "tb.h"
 
+#define TB_PCI_PATH_DOWN		0
+#define TB_PCI_PATH_UP			1
+
 #define __TB_TUNNEL_PRINT(level, tunnel, fmt, arg...)                   \
 	do {                                                            \
-		struct tb_pci_tunnel *__tunnel = (tunnel);              \
+		struct tb_tunnel *__tunnel = (tunnel);                  \
 		level(__tunnel->tb, "%llx:%x <-> %llx:%x (PCI): " fmt,  \
-		      tb_route(__tunnel->down_port->sw),                \
-		      __tunnel->down_port->port,                        \
-		      tb_route(__tunnel->up_port->sw),                  \
-		      __tunnel->up_port->port,                          \
+		      tb_route(__tunnel->src_port->sw),                 \
+		      __tunnel->src_port->port,                         \
+		      tb_route(__tunnel->dst_port->sw),                 \
+		      __tunnel->dst_port->port,                         \
 		      ## arg);                                          \
 	} while (0)
 
@@ -29,6 +33,38 @@
 #define tb_tunnel_info(tunnel, fmt, arg...) \
 	__TB_TUNNEL_PRINT(tb_info, tunnel, fmt, ##arg)
 
+static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths)
+{
+	struct tb_tunnel *tunnel;
+
+	tunnel = kzalloc(sizeof(*tunnel), GFP_KERNEL);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->paths = kcalloc(npaths, sizeof(tunnel->paths[0]), GFP_KERNEL);
+	if (!tunnel->paths) {
+		tb_tunnel_free(tunnel);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&tunnel->list);
+	tunnel->tb = tb;
+	tunnel->npaths = npaths;
+
+	return tunnel;
+}
+
+static int tb_pci_activate(struct tb_tunnel *tunnel, bool activate)
+{
+	int res;
+
+	res = tb_pci_port_enable(tunnel->src_port, activate);
+	if (res)
+		return res;
+
+	return tb_pci_port_enable(tunnel->dst_port, activate);
+}
+
 static void tb_pci_init_path(struct tb_path *path)
 {
 	path->egress_fc_enable = TB_PATH_SOURCE | TB_PATH_INTERNAL;
@@ -42,7 +78,10 @@ static void tb_pci_init_path(struct tb_path *path)
 }
 
 /**
- * tb_pci_alloc() - allocate a pci tunnel
+ * tb_tunnel_alloc_pci() - allocate a pci tunnel
+ * @tb: Pointer to the domain structure
+ * @up: PCIe upstream adapter port
+ * @down: PCIe downstream adapter port
  *
  * Allocate a PCI tunnel. The ports must be of type TB_TYPE_PCIE_UP and
  * TB_TYPE_PCIE_DOWN.
@@ -54,170 +93,185 @@ static void tb_pci_init_path(struct tb_path *path)
  * my thunderbolt devices). Therefore at most ONE path per device may be
  * activated.
  *
- * Return: Returns a tb_pci_tunnel on success or NULL on failure.
+ * Return: Returns a tb_tunnel on success or NULL on failure.
  */
-struct tb_pci_tunnel *tb_pci_alloc(struct tb *tb, struct tb_port *up,
-				   struct tb_port *down)
+struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
+				      struct tb_port *down)
 {
-	struct tb_pci_tunnel *tunnel = kzalloc(sizeof(*tunnel), GFP_KERNEL);
+	struct tb_path *path_to_up;
+	struct tb_path *path_to_down;
+	struct tb_tunnel *tunnel;
+
+	tunnel = tb_tunnel_alloc(tb, 2);
 	if (!tunnel)
-		goto err;
-	tunnel->tb = tb;
-	tunnel->down_port = down;
-	tunnel->up_port = up;
-	INIT_LIST_HEAD(&tunnel->list);
-	tunnel->path_to_up = tb_path_alloc(up->sw->tb, 2);
-	if (!tunnel->path_to_up)
-		goto err;
-	tunnel->path_to_down = tb_path_alloc(up->sw->tb, 2);
-	if (!tunnel->path_to_down)
-		goto err;
-	tb_pci_init_path(tunnel->path_to_up);
-	tb_pci_init_path(tunnel->path_to_down);
-
-	tunnel->path_to_up->hops[0].in_port = down;
-	tunnel->path_to_up->hops[0].in_hop_index = 8;
-	tunnel->path_to_up->hops[0].in_counter_index = -1;
-	tunnel->path_to_up->hops[0].out_port = tb_upstream_port(up->sw)->remote;
-	tunnel->path_to_up->hops[0].next_hop_index = 8;
-
-	tunnel->path_to_up->hops[1].in_port = tb_upstream_port(up->sw);
-	tunnel->path_to_up->hops[1].in_hop_index = 8;
-	tunnel->path_to_up->hops[1].in_counter_index = -1;
-	tunnel->path_to_up->hops[1].out_port = up;
-	tunnel->path_to_up->hops[1].next_hop_index = 8;
-
-	tunnel->path_to_down->hops[0].in_port = up;
-	tunnel->path_to_down->hops[0].in_hop_index = 8;
-	tunnel->path_to_down->hops[0].in_counter_index = -1;
-	tunnel->path_to_down->hops[0].out_port = tb_upstream_port(up->sw);
-	tunnel->path_to_down->hops[0].next_hop_index = 8;
-
-	tunnel->path_to_down->hops[1].in_port =
-		tb_upstream_port(up->sw)->remote;
-	tunnel->path_to_down->hops[1].in_hop_index = 8;
-	tunnel->path_to_down->hops[1].in_counter_index = -1;
-	tunnel->path_to_down->hops[1].out_port = down;
-	tunnel->path_to_down->hops[1].next_hop_index = 8;
-	return tunnel;
+		return NULL;
 
-err:
-	if (tunnel) {
-		if (tunnel->path_to_down)
-			tb_path_free(tunnel->path_to_down);
-		if (tunnel->path_to_up)
-			tb_path_free(tunnel->path_to_up);
-		kfree(tunnel);
+	tunnel->activate = tb_pci_activate;
+	tunnel->src_port = down;
+	tunnel->dst_port = up;
+
+	path_to_up = tb_path_alloc(tb, 2);
+	if (!path_to_up) {
+		tb_tunnel_free(tunnel);
+		return NULL;
 	}
-	return NULL;
+	tunnel->paths[TB_PCI_PATH_UP] = path_to_up;
+
+	path_to_down = tb_path_alloc(tb, 2);
+	if (!path_to_down) {
+		tb_tunnel_free(tunnel);
+		return NULL;
+	}
+	tunnel->paths[TB_PCI_PATH_DOWN] = path_to_down;
+
+	tb_pci_init_path(path_to_up);
+	tb_pci_init_path(path_to_down);
+
+	path_to_up->hops[0].in_port = down;
+	path_to_up->hops[0].in_hop_index = 8;
+	path_to_up->hops[0].in_counter_index = -1;
+	path_to_up->hops[0].out_port = tb_upstream_port(up->sw)->remote;
+	path_to_up->hops[0].next_hop_index = 8;
+
+	path_to_up->hops[1].in_port = tb_upstream_port(up->sw);
+	path_to_up->hops[1].in_hop_index = 8;
+	path_to_up->hops[1].in_counter_index = -1;
+	path_to_up->hops[1].out_port = up;
+	path_to_up->hops[1].next_hop_index = 8;
+
+	path_to_down->hops[0].in_port = up;
+	path_to_down->hops[0].in_hop_index = 8;
+	path_to_down->hops[0].in_counter_index = -1;
+	path_to_down->hops[0].out_port = tb_upstream_port(up->sw);
+	path_to_down->hops[0].next_hop_index = 8;
+
+	path_to_down->hops[1].in_port = tb_upstream_port(up->sw)->remote;
+	path_to_down->hops[1].in_hop_index = 8;
+	path_to_down->hops[1].in_counter_index = -1;
+	path_to_down->hops[1].out_port = down;
+	path_to_down->hops[1].next_hop_index = 8;
+
+	return tunnel;
 }
 
 /**
- * tb_pci_free() - free a tunnel
+ * tb_tunnel_free() - free a tunnel
+ * @tunnel: Tunnel to be freed
  *
  * The tunnel must have been deactivated.
  */
-void tb_pci_free(struct tb_pci_tunnel *tunnel)
+void tb_tunnel_free(struct tb_tunnel *tunnel)
 {
-	if (tunnel->path_to_up->activated || tunnel->path_to_down->activated) {
-		tb_tunnel_WARN(tunnel, "trying to free an activated tunnel\n");
+	int i;
+
+	if (!tunnel)
 		return;
+
+	for (i = 0; i < tunnel->npaths; i++) {
+		if (tunnel->paths[i] && tunnel->paths[i]->activated) {
+			tb_tunnel_WARN(tunnel,
+				       "trying to free an activated tunnel\n");
+			return;
+		}
 	}
-	tb_path_free(tunnel->path_to_up);
-	tb_path_free(tunnel->path_to_down);
+
+	for (i = 0; i < tunnel->npaths; i++) {
+		if (tunnel->paths[i])
+			tb_path_free(tunnel->paths[i]);
+	}
+
+	kfree(tunnel->paths);
 	kfree(tunnel);
 }
 
 /**
- * tb_pci_is_invalid - check whether an activated path is still valid
+ * tb_tunnel_is_invalid - check whether an activated path is still valid
+ * @tunnel: Tunnel to check
  */
-bool tb_pci_is_invalid(struct tb_pci_tunnel *tunnel)
+bool tb_tunnel_is_invalid(struct tb_tunnel *tunnel)
 {
-	WARN_ON(!tunnel->path_to_up->activated);
-	WARN_ON(!tunnel->path_to_down->activated);
+	int i;
 
-	return tb_path_is_invalid(tunnel->path_to_up)
-	       || tb_path_is_invalid(tunnel->path_to_down);
-}
+	for (i = 0; i < tunnel->npaths; i++) {
+		WARN_ON(!tunnel->paths[i]->activated);
+		if (tb_path_is_invalid(tunnel->paths[i]))
+			return true;
+	}
 
-/**
- * tb_pci_port_active() - activate/deactivate PCI capability
- *
- * Return: Returns 0 on success or an error code on failure.
- */
-static int tb_pci_port_active(struct tb_port *port, bool active)
-{
-	u32 word = active ? 0x80000000 : 0x0;
-	if (port->cap_adap < 0)
-		return -ENXIO;
-	return tb_port_write(port, &word, TB_CFG_PORT, port->cap_adap, 1);
+	return false;
 }
 
 /**
- * tb_pci_restart() - activate a tunnel after a hardware reset
+ * tb_tunnel_restart() - activate a tunnel after a hardware reset
+ * @tunnel: Tunnel to restart
+ *
+ * Return: 0 on success and negative errno in case if failure
  */
-int tb_pci_restart(struct tb_pci_tunnel *tunnel)
+int tb_tunnel_restart(struct tb_tunnel *tunnel)
 {
-	int res;
-	tunnel->path_to_up->activated = false;
-	tunnel->path_to_down->activated = false;
+	int res, i;
 
 	tb_tunnel_info(tunnel, "activating\n");
 
-	res = tb_path_activate(tunnel->path_to_up);
-	if (res)
-		goto err;
-	res = tb_path_activate(tunnel->path_to_down);
-	if (res)
-		goto err;
+	for (i = 0; i < tunnel->npaths; i++) {
+		tunnel->paths[i]->activated = false;
+		res = tb_path_activate(tunnel->paths[i]);
+		if (res)
+			goto err;
+	}
 
-	res = tb_pci_port_active(tunnel->down_port, true);
-	if (res)
-		goto err;
+	if (tunnel->activate) {
+		res = tunnel->activate(tunnel, true);
+		if (res)
+			goto err;
+	}
 
-	res = tb_pci_port_active(tunnel->up_port, true);
-	if (res)
-		goto err;
 	return 0;
+
 err:
 	tb_tunnel_warn(tunnel, "activation failed\n");
-	tb_pci_deactivate(tunnel);
+	tb_tunnel_deactivate(tunnel);
 	return res;
 }
 
 /**
- * tb_pci_activate() - activate a tunnel
+ * tb_tunnel_activate() - activate a tunnel
+ * @tunnel: Tunnel to activate
  *
  * Return: Returns 0 on success or an error code on failure.
  */
-int tb_pci_activate(struct tb_pci_tunnel *tunnel)
+int tb_tunnel_activate(struct tb_tunnel *tunnel)
 {
-	if (tunnel->path_to_up->activated || tunnel->path_to_down->activated) {
-		tb_tunnel_WARN(tunnel,
-			       "trying to activate an already activated tunnel\n");
-		return -EINVAL;
-	}
+	int i;
 
-	return tb_pci_restart(tunnel);
-}
+	tb_tunnel_info(tunnel, "activating\n");
 
+	for (i = 0; i < tunnel->npaths; i++) {
+		if (tunnel->paths[i]->activated) {
+			tb_tunnel_WARN(tunnel,
+				       "trying to activate an already activated tunnel\n");
+			return -EINVAL;
+		}
+	}
 
+	return tb_tunnel_restart(tunnel);
+}
 
 /**
- * tb_pci_deactivate() - deactivate a tunnel
+ * tb_tunnel_deactivate() - deactivate a tunnel
+ * @tunnel: Tunnel to deactivate
  */
-void tb_pci_deactivate(struct tb_pci_tunnel *tunnel)
+void tb_tunnel_deactivate(struct tb_tunnel *tunnel)
 {
+	int i;
+
 	tb_tunnel_info(tunnel, "deactivating\n");
-	/*
-	 * TODO: enable reset by writing 0x04000000 to TB_CAP_PCIE + 1 on up
-	 * port. Seems to have no effect?
-	 */
-	tb_pci_port_active(tunnel->up_port, false);
-	tb_pci_port_active(tunnel->down_port, false);
-	if (tunnel->path_to_down->activated)
-		tb_path_deactivate(tunnel->path_to_down);
-	if (tunnel->path_to_up->activated)
-		tb_path_deactivate(tunnel->path_to_up);
-}
 
+	if (tunnel->activate)
+		tunnel->activate(tunnel, false);
+
+	for (i = 0; i < tunnel->npaths; i++) {
+		if (tunnel->paths[i]->activated)
+			tb_path_deactivate(tunnel->paths[i]);
+	}
+}
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index dff0f27d6ab5..b4e992165e56 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Thunderbolt Cactus Ridge driver - Tunneling support
+ * Thunderbolt driver - Tunneling support
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2019, Intel Corporation
  */
 
 #ifndef TB_TUNNEL_H_
@@ -10,22 +11,33 @@
 
 #include "tb.h"
 
-struct tb_pci_tunnel {
+/**
+ * struct tb_tunnel - Tunnel between two ports
+ * @tb: Pointer to the domain
+ * @src_port: Source port of the tunnel
+ * @dst_port: Destination port of the tunnel
+ * @paths: All paths required by the tunnel
+ * @npaths: Number of paths in @paths
+ * @activate: Optional tunnel specific activation/deactivation
+ * @list: Tunnels are linked using this field
+ */
+struct tb_tunnel {
 	struct tb *tb;
-	struct tb_port *up_port;
-	struct tb_port *down_port;
-	struct tb_path *path_to_up;
-	struct tb_path *path_to_down;
+	struct tb_port *src_port;
+	struct tb_port *dst_port;
+	struct tb_path **paths;
+	size_t npaths;
+	int (*activate)(struct tb_tunnel *tunnel, bool activate);
 	struct list_head list;
 };
 
-struct tb_pci_tunnel *tb_pci_alloc(struct tb *tb, struct tb_port *up,
-				   struct tb_port *down);
-void tb_pci_free(struct tb_pci_tunnel *tunnel);
-int tb_pci_activate(struct tb_pci_tunnel *tunnel);
-int tb_pci_restart(struct tb_pci_tunnel *tunnel);
-void tb_pci_deactivate(struct tb_pci_tunnel *tunnel);
-bool tb_pci_is_invalid(struct tb_pci_tunnel *tunnel);
+struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
+				      struct tb_port *down);
+void tb_tunnel_free(struct tb_tunnel *tunnel);
+int tb_tunnel_activate(struct tb_tunnel *tunnel);
+int tb_tunnel_restart(struct tb_tunnel *tunnel);
+void tb_tunnel_deactivate(struct tb_tunnel *tunnel);
+bool tb_tunnel_is_invalid(struct tb_tunnel *tunnel);
 
 #endif
 
-- 
2.20.1

