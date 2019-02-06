Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E75C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92FC2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfBFNTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:19:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:18602 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbfBFNRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="141146083"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2019 05:17:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2D245839; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
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
Subject: [PATCH v2 16/28] thunderbolt: Discover preboot PCIe paths the boot firmware established
Date:   Wed,  6 Feb 2019 16:17:26 +0300
Message-Id: <20190206131738.43696-17-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Apple Macs the boot firmware (EFI) connects all devices automatically
when the system is started, before it hands over to the OS. Instead of
ignoring we discover all those PCIe tunnels and record them using our
internal structures, just like we do when a device is connected after
the OS is already up.

By doing this we can properly tear down tunnels when devices are
disconnected. Also this allows us to resume the existing tunnels after
system suspend/resume cycle.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c   | 144 +++++++++++++++++++++++++++++------
 drivers/thunderbolt/switch.c |  14 ++++
 drivers/thunderbolt/tb.c     |  35 +++++++++
 drivers/thunderbolt/tb.h     |   4 +
 drivers/thunderbolt/tunnel.c |  68 +++++++++++++++++
 drivers/thunderbolt/tunnel.h |   1 +
 6 files changed, 244 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 122e6a1daf34..ada60d4aa99b 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - path/tunnel functionality
+ * Thunderbolt driver - path/tunnel functionality
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2019, Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -12,6 +13,7 @@
 
 #include "tb.h"
 
+#define MAX_PATH_HOPS	7
 
 static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 {
@@ -30,6 +32,124 @@ static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 		    hop->unknown1, hop->unknown2, hop->unknown3);
 }
 
+static struct tb_port *tb_port_remote(struct tb_port *port)
+{
+	struct tb_port *remote = port->remote;
+
+	/*
+	 * If we have a dual link, the remote is available through the
+	 * primary link.
+	 */
+	if (!remote && port->dual_link_port && port->dual_link_port->remote)
+		return port->dual_link_port->remote->dual_link_port;
+	return remote;
+}
+
+/**
+ * tb_path_discover() - Discover a path starting from given hopid
+ * @port: First input port of a path
+ * @start_hopid: Starting hop ID of a path
+ * @last: Last port on a path will be filled here if not %NULL
+ *
+ * Follows a path starting from @port and @hopid to the last output port
+ * of the path. Allocates hop IDs for the visited ports. Call
+ * tb_path_free() to release the path and allocated hop IDs when the
+ * path is not needed anymore.
+ *
+ * Return: Discovered path on success, %NULL in case of failure
+ */
+struct tb_path *tb_path_discover(struct tb_port *port, int start_hopid,
+				 struct tb_port **last)
+{
+	struct tb_port *out_port;
+	struct tb_regs_hop hop;
+	struct tb_path *path;
+	struct tb_switch *sw;
+	struct tb_port *p;
+	size_t num_hops;
+	int ret, i, h;
+
+	p = port;
+	h = start_hopid;
+
+	for (i = 0; p && i < MAX_PATH_HOPS; i++) {
+		sw = p->sw;
+
+		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 2);
+		if (ret) {
+			tb_port_warn(p, "failed to read path at %d\n", h);
+			return NULL;
+		}
+
+		if (!hop.enable)
+			return NULL;
+
+		out_port = &sw->ports[hop.out_port];
+		if (last)
+			*last = out_port;
+
+		h = hop.next_hop;
+		p = tb_port_remote(out_port);
+	}
+
+	num_hops = i;
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
+	if (!path)
+		return NULL;
+
+	path->tb = port->sw->tb;
+	path->path_length = num_hops;
+
+	path->hops = kcalloc(num_hops, sizeof(*path->hops), GFP_KERNEL);
+	if (!path->hops) {
+		kfree(path);
+		return NULL;
+	}
+
+	p = port;
+	h = start_hopid;
+
+	for (i = 0; i < num_hops; i++) {
+		int next_hop;
+
+		sw = p->sw;
+
+		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 2);
+		if (ret) {
+			tb_port_warn(p, "failed to read path at %d\n", h);
+			goto err;
+		}
+
+		if (tb_port_alloc_in_hopid(p, h, h) < 0)
+			goto err;
+
+		out_port = &sw->ports[hop.out_port];
+		next_hop = hop.next_hop;
+
+		if (tb_port_alloc_out_hopid(out_port, next_hop, next_hop) < 0) {
+			tb_port_release_in_hopid(p, h);
+			goto err;
+		}
+
+		path->hops[i].in_port = p;
+		path->hops[i].in_hop_index = h;
+		path->hops[i].in_counter_index = -1;
+		path->hops[i].out_port = out_port;
+		path->hops[i].next_hop_index = next_hop;
+
+		h = next_hop;
+		p = tb_port_remote(out_port);
+	}
+
+	return path;
+
+err:
+	tb_port_warn(port, "failed to discover path starting at hop %d\n",
+		     start_hopid);
+	tb_path_free(path);
+	return NULL;
+}
+
 /**
  * tb_path_alloc() - allocate a thunderbolt path between two ports
  * @tb: Domain pointer
@@ -279,30 +399,10 @@ int tb_path_activate(struct tb_path *path)
 	for (i = path->path_length - 1; i >= 0; i--) {
 		struct tb_regs_hop hop = { 0 };
 
-		/*
-		 * We do (currently) not tear down paths setup by the firmeware.
-		 * If a firmware device is unplugged and plugged in again then
-		 * it can happen that we reuse some of the hops from the (now
-		 * defunct) firmeware path. This causes the hotplug operation to
-		 * fail (the pci device does not show up). Clearing the hop
-		 * before overwriting it fixes the problem.
-		 *
-		 * Should be removed once we discover and tear down firmeware
-		 * paths.
-		 */
-		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
-				    2 * path->hops[i].in_hop_index, 2);
-		if (res) {
-			__tb_path_deactivate_hops(path, i);
-			__tb_path_deallocate_nfc(path, 0);
-			goto err;
-		}
-
 		/* dword 0 */
 		hop.next_hop = path->hops[i].next_hop_index;
 		hop.out_port = path->hops[i].out_port->port;
-		/* TODO: figure out why these are good values */
-		hop.initial_credits = (i == path->path_length - 1) ? 16 : 7;
+		hop.initial_credits = path->hops[i].initial_credits;
 		hop.unknown1 = 0;
 		hop.enable = 1;
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 23b6bae8362e..c6cb6c44a571 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -743,6 +743,20 @@ struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
 	return next;
 }
 
+/**
+ * tb_pci_port_is_enabled() - Is the PCIe adapter port enabled
+ * @port: PCIe port to check
+ */
+bool tb_pci_port_is_enabled(struct tb_port *port)
+{
+	u32 data;
+
+	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
+		return false;
+
+	return !!(data & TB_PCI_EN);
+}
+
 /**
  * tb_pci_port_enable() - Enable PCIe adapter port
  * @port: PCIe port to enable
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 99f1c7e28d12..371633e17916 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -29,6 +29,39 @@ struct tb_cm {
 
 /* enumeration & hot plug handling */
 
+static void tb_discover_tunnels(struct tb_switch *sw)
+{
+	struct tb *tb = sw->tb;
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_port *port;
+	int i;
+
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		struct tb_tunnel *tunnel = NULL;
+
+		port = &sw->ports[i];
+		switch (port->config.type) {
+		case TB_TYPE_PCIE_DOWN:
+			tunnel = tb_tunnel_discover_pci(tb, port);
+			break;
+
+		default:
+			break;
+		}
+
+		/* Find and add existing tunnels */
+		if (tunnel)
+			list_add_tail(&tunnel->list, &tcm->tunnel_list);
+	}
+
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		port = &sw->ports[i];
+		if (tb_is_upstream_port(port))
+			continue;
+		if (port->remote)
+			tb_discover_tunnels(port->remote->sw);
+	}
+}
 
 static void tb_scan_port(struct tb_port *port);
 
@@ -393,6 +426,8 @@ static int tb_start(struct tb *tb)
 
 	/* Full scan to discover devices added before the driver was loaded. */
 	tb_scan_switch(tb->root_switch);
+	/* Find out tunnels created by the boot firmware */
+	tb_discover_tunnels(tb->root_switch);
 	tb_activate_pcie_devices(tb);
 
 	/* Allow tb_handle_hotplug to progress events */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 0e4d9088faf6..5a0b831a37ad 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -165,6 +165,7 @@ struct tb_path_hop {
 	int in_hop_index;
 	int in_counter_index; /* write -1 to disable counters for this hop. */
 	int next_hop_index;
+	unsigned int initial_credits;
 };
 
 /**
@@ -457,8 +458,11 @@ struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
 
+bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
 
+struct tb_path *tb_path_discover(struct tb_port *port, int start_hopid,
+				 struct tb_port **last);
 struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src,
 			      struct tb_port *dst, int start_hopid,
 			      int end_hopid, int link_nr);
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index b48c66efe87a..1a5e2aa395c6 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -78,6 +78,74 @@ static void tb_pci_init_path(struct tb_path *path)
 	path->weight = 1;
 	path->drop_packages = 0;
 	path->nfc_credits = 0;
+	path->hops[0].initial_credits = 7;
+	path->hops[1].initial_credits = 16;
+}
+
+/**
+ * tb_tunnel_discover_pci() - Discover existing PCIe tunnels
+ * @tb: Pointer to the domain structure
+ * @down: PCIe downstream adapter
+ *
+ * If @down adapter is active, follows the tunnel to the PCIe upstream
+ * adapter and back. Returns the discovered tunnel or %NULL if there was
+ * no tunnel.
+ */
+struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_path *path;
+
+	if (!tb_pci_port_is_enabled(down))
+		return NULL;
+
+	tunnel = tb_tunnel_alloc(tb, 2);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->activate = tb_pci_activate;
+	tunnel->src_port = down;
+
+	path = tb_path_discover(down, TB_PCI_HOPID, &tunnel->dst_port);
+	if (!path)
+		goto err_free;
+
+	if (tunnel->dst_port->config.type != TB_TYPE_PCIE_UP) {
+		tb_port_warn(tunnel->dst_port,
+			     "path does not end to a PCIe adapter\n");
+		goto err_free;
+	}
+
+	tunnel->paths[TB_PCI_PATH_UP] = path;
+
+	path = tb_path_discover(tunnel->dst_port, TB_PCI_HOPID, &down);
+	if (!path)
+		goto err_free;
+	tunnel->paths[TB_PCI_PATH_DOWN] = path;
+
+	if (down != tunnel->src_port) {
+		tb_tunnel_warn(tunnel, "path is not complete, skipping\n");
+		goto err_free;
+	}
+
+	if (!tb_pci_port_is_enabled(tunnel->dst_port)) {
+		tb_tunnel_warn(tunnel,
+			       "tunnel is not fully activated, skipping\n");
+		goto err_free;
+	}
+
+	/* Activated by the boot firmware */
+	tunnel->paths[TB_PCI_PATH_UP]->activated = true;
+	tunnel->paths[TB_PCI_PATH_DOWN]->activated = true;
+
+	tb_pci_init_path(tunnel->paths[TB_PCI_PATH_UP]);
+	tb_pci_init_path(tunnel->paths[TB_PCI_PATH_DOWN]);
+
+	return tunnel;
+
+err_free:
+	tb_tunnel_free(tunnel);
+	return NULL;
 }
 
 /**
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index b4e992165e56..7e801a31f9d1 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -31,6 +31,7 @@ struct tb_tunnel {
 	struct list_head list;
 };
 
+struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down);
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 				      struct tb_port *down);
 void tb_tunnel_free(struct tb_tunnel *tunnel);
-- 
2.20.1

