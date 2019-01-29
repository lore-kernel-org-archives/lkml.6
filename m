Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6340C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9564E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfA2PCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:02:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:34504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbfA2PBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="270838765"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2019 07:01:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 07BF6A0F; Tue, 29 Jan 2019 17:01:45 +0200 (EET)
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
Subject: [PATCH 17/28] thunderbolt: Add support for full PCIe daisy chains
Date:   Tue, 29 Jan 2019 18:01:32 +0300
Message-Id: <20190129150143.12681-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the software connection manager (tb.c) has only supported
creating a single PCIe tunnel, no PCIe device daisy chaining has been
supported so far. This updates the software connection manager so that
it now can create PCIe tunnels for full chain of six devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 174 +++++++++++++++++++++++----------------
 1 file changed, 104 insertions(+), 70 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 8acd16c3ada6..c2e102f55ee0 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - bus logic (NHI independent)
+ * Thunderbolt driver - bus logic (NHI independent)
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2019, Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -50,8 +51,15 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 		}
 
 		/* Find and add existing tunnels */
-		if (tunnel)
+		if (tunnel) {
+			struct tb_port *p;
+
+			/* Firmware added switches are always authorized */
+			tb_for_each_port(p, tunnel->src_port, tunnel->dst_port)
+				p->sw->boot = true;
+
 			list_add_tail(&tunnel->list, &tcm->tunnel_list);
+		}
 	}
 
 	for (i = 1; i <= sw->config.max_port_number; i++) {
@@ -63,6 +71,16 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 	}
 }
 
+static void tb_switch_authorize(struct work_struct *work)
+{
+	struct tb_switch *sw = container_of(work, typeof(*sw), work);
+
+	mutex_lock(&sw->tb->lock);
+	if (!sw->is_unplugged)
+		tb_domain_approve_switch(sw->tb, sw);
+	mutex_unlock(&sw->tb->lock);
+}
+
 static void tb_scan_port(struct tb_port *port);
 
 /**
@@ -80,6 +98,7 @@ static void tb_scan_switch(struct tb_switch *sw)
  */
 static void tb_scan_port(struct tb_port *port)
 {
+	struct tb_cm *tcm = tb_priv(port->sw->tb);
 	struct tb_switch *sw;
 	if (tb_is_upstream_port(port))
 		return;
@@ -106,6 +125,14 @@ static void tb_scan_port(struct tb_port *port)
 		return;
 	}
 
+	/*
+	 * Do not send uevents until we have discovered all existing
+	 * tunnels and know which switches were authorized already by
+	 * the boot firmware.
+	 */
+	if (!tcm->hotplug_active)
+		dev_set_uevent_suppress(&sw->dev, true);
+
 	sw->authorized = true;
 
 	if (tb_switch_add(sw)) {
@@ -113,6 +140,9 @@ static void tb_scan_port(struct tb_port *port)
 		return;
 	}
 
+	INIT_WORK(&sw->work, tb_switch_authorize);
+	queue_work(sw->tb->wq, &sw->work);
+
 	port->remote = tb_upstream_port(sw);
 	tb_upstream_port(sw)->remote = port;
 	tb_scan_switch(sw);
@@ -149,6 +179,7 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 		if (!port->remote)
 			continue;
 		if (port->remote->sw->is_unplugged) {
+			cancel_work_sync(&port->remote->sw->work);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 		} else {
@@ -197,72 +228,58 @@ static struct tb_port *tb_find_unused_down_port(struct tb_switch *sw)
 	return NULL;
 }
 
-/**
- * tb_activate_pcie_devices() - scan for and activate PCIe devices
- *
- * This method is somewhat ad hoc. For now it only supports one device
- * per port and only devices at depth 1.
- */
-static void tb_activate_pcie_devices(struct tb *tb)
+static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 {
-	int i;
-	int cap;
-	u32 data;
-	struct tb_switch *sw;
-	struct tb_port *up_port;
-	struct tb_port *down_port;
-	struct tb_tunnel *tunnel;
 	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_switch *parent_sw;
+	struct tb_port *up, *down;
+	struct tb_tunnel *tunnel;
 
-	/* scan for pcie devices at depth 1*/
-	for (i = 1; i <= tb->root_switch->config.max_port_number; i++) {
-		if (tb_is_upstream_port(&tb->root_switch->ports[i]))
-			continue;
-		if (tb->root_switch->ports[i].config.type != TB_TYPE_PORT)
-			continue;
-		if (!tb->root_switch->ports[i].remote)
-			continue;
-		sw = tb->root_switch->ports[i].remote->sw;
-		up_port = tb_find_pci_up_port(sw);
-		if (!up_port) {
-			tb_sw_info(sw, "no PCIe devices found, aborting\n");
-			continue;
-		}
+	up = tb_find_pci_up_port(sw);
+	if (!up)
+		return 0;
 
-		/* check whether port is already activated */
-		cap = up_port->cap_adap;
-		if (cap < 0)
-			continue;
-		if (tb_port_read(up_port, &data, TB_CFG_PORT, cap, 1))
-			continue;
-		if (data & 0x80000000) {
-			tb_port_info(up_port,
-				     "PCIe port already activated, aborting\n");
-			continue;
-		}
+	/*
+	 * Look up available down port. Since we are chaining, it is
+	 * typically found right above this switch.
+	 */
+	down = NULL;
+	parent_sw = tb_to_switch(sw->dev.parent);
+	while (parent_sw) {
+		down = tb_find_unused_down_port(parent_sw);
+		if (down)
+			break;
+		parent_sw = tb_to_switch(parent_sw->dev.parent);
+	}
 
-		down_port = tb_find_unused_down_port(tb->root_switch);
-		if (!down_port) {
-			tb_port_info(up_port,
-				     "All PCIe down ports are occupied, aborting\n");
-			continue;
-		}
-		tunnel = tb_tunnel_alloc_pci(tb, up_port, down_port);
-		if (!tunnel) {
-			tb_port_info(up_port,
-				     "PCIe tunnel allocation failed, aborting\n");
-			continue;
-		}
+	if (!down)
+		return 0;
 
-		if (tb_tunnel_activate(tunnel)) {
-			tb_port_info(up_port,
-				     "PCIe tunnel activation failed, aborting\n");
-			tb_tunnel_free(tunnel);
-			continue;
-		}
+	tunnel = tb_tunnel_alloc_pci(tb, up, down);
+	if (!tunnel)
+		return -EIO;
 
-		list_add(&tunnel->list, &tcm->tunnel_list);
+	if (tb_tunnel_activate(tunnel)) {
+		tb_port_info(up,
+			     "PCIe tunnel activation failed, aborting\n");
+		tb_tunnel_free(tunnel);
+		return -EIO;
 	}
+	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+
+	return 0;
+}
+
+static int tb_approve_switch(struct tb *tb, struct tb_switch *sw)
+{
+	/*
+	 * Already authorized by the boot firmware so no need to do
+	 * anything here.
+	 */
+	if (sw->boot)
+		return 0;
+
+	return tb_tunnel_pci(tb, sw);
 }
 
 /* hotplug handling */
@@ -316,6 +333,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 			tb_port_info(port, "unplugged\n");
 			tb_sw_set_unplugged(port->remote->sw);
 			tb_free_invalid_tunnels(tb);
+			cancel_work_sync(&sw->work);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 		} else {
@@ -328,16 +346,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 	} else {
 		tb_port_info(port, "hotplug: scanning\n");
 		tb_scan_port(port);
-		if (!port->remote) {
+		if (!port->remote)
 			tb_port_info(port, "hotplug: no switch found\n");
-		} else if (port->remote->sw->config.depth > 1) {
-			tb_sw_warn(port->remote->sw,
-				   "hotplug: chaining not supported\n");
-		} else {
-			tb_sw_info(port->remote->sw,
-				   "hotplug: activating pcie devices\n");
-			tb_activate_pcie_devices(tb);
-		}
 	}
 out:
 	mutex_unlock(&tb->lock);
@@ -395,6 +405,27 @@ static void tb_stop(struct tb *tb)
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 }
 
+static int tb_scan_finalize_switch(struct device *dev, void *data)
+{
+	if (tb_is_switch(dev)) {
+		struct tb_switch *sw = tb_to_switch(dev);
+
+		/*
+		 * If we found that the switch was already setup by the
+		 * boot firmware, mark it as authorized now before we
+		 * send uevent to userspace.
+		 */
+		if (sw->boot)
+			sw->authorized = 1;
+
+		dev_set_uevent_suppress(dev, false);
+		kobject_uevent(&dev->kobj, KOBJ_ADD);
+		device_for_each_child(dev, NULL, tb_scan_finalize_switch);
+	}
+
+	return 0;
+}
+
 static int tb_start(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -428,7 +459,9 @@ static int tb_start(struct tb *tb)
 	tb_scan_switch(tb->root_switch);
 	/* Find out tunnels created by the boot firmware */
 	tb_discover_tunnels(tb->root_switch);
-	tb_activate_pcie_devices(tb);
+	/* Make the discovered switches available to the userspace */
+	device_for_each_child(&tb->root_switch->dev, NULL,
+			      tb_scan_finalize_switch);
 
 	/* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
@@ -483,6 +516,7 @@ static const struct tb_cm_ops tb_cm_ops = {
 	.suspend_noirq = tb_suspend_noirq,
 	.resume_noirq = tb_resume_noirq,
 	.handle_event = tb_handle_event,
+	.approve_switch = tb_approve_switch,
 };
 
 struct tb *tb_probe(struct tb_nhi *nhi)
-- 
2.20.1

