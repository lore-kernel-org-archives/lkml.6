Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C933DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8692C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfA2PCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:02:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:8099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbfA2PBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="314531764"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2019 07:01:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 37CE9B5B; Tue, 29 Jan 2019 17:01:45 +0200 (EET)
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
Subject: [PATCH 21/28] thunderbolt: Add support for Display Port tunnels
Date:   Tue, 29 Jan 2019 18:01:36 +0300
Message-Id: <20190129150143.12681-22-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display Port tunnels are somewhat more complex than PCIe tunnels as it
requires 3 tunnels (AUX Rx/Tx and Video). In addition we are not
supposed to create the tunnels immediately when a DP OUT is enumerated.
Instead we need to wait until we get hotplug event to that adapter port
or check if the port has HPD set before tunnels can be established. This
adds Display Port tunneling support to the software connection manager.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 111 ++++++++++++++
 drivers/thunderbolt/tb.c      | 119 ++++++++++++---
 drivers/thunderbolt/tb.h      |  17 +++
 drivers/thunderbolt/tb_regs.h |  22 +++
 drivers/thunderbolt/tunnel.c  | 277 +++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tunnel.h  |  21 +++
 6 files changed, 545 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 42681431eb7e..13dceddcfa48 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -760,6 +760,10 @@ bool tb_port_is_enabled(struct tb_port *port)
 	case TB_TYPE_PCIE_DOWN:
 		return tb_pci_port_is_enabled(port);
 
+	case TB_TYPE_DP_HDMI_IN:
+	case TB_TYPE_DP_HDMI_OUT:
+		return tb_dp_port_is_enabled(port);
+
 	default:
 		return false;
 	}
@@ -792,6 +796,113 @@ int tb_pci_port_enable(struct tb_port *port, bool enable)
 	return tb_port_write(port, &word, TB_CFG_PORT, port->cap_adap, 1);
 }
 
+/**
+ * tb_dp_port_hpd_is_active() - Is HPD already active
+ * @port: DP out port to check
+ *
+ * Checks if the DP OUT adapter port has HDP bit already set.
+ */
+int tb_dp_port_hpd_is_active(struct tb_port *port)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap + 2, 1);
+	if (ret)
+		return ret;
+
+	return !!(data & TB_DP_HDP);
+}
+
+/**
+ * tb_dp_port_hpd_clear() - Clear HPD from DP IN port
+ * @port: Port to clear HPD
+ *
+ * If the DP IN port has HDP set, this function can be used to clear it.
+ */
+int tb_dp_port_hpd_clear(struct tb_port *port)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap + 3, 1);
+	if (ret)
+		return ret;
+
+	data |= TB_DP_HPDC;
+	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap + 3, 1);
+}
+
+/**
+ * tb_dp_port_set_hops() - Set video/aux Hop IDs for DP port
+ * @port: DP IN/OUT port to set hops
+ * @video: Video Hop ID
+ * @aux_tx: AUX TX Hop ID
+ * @aux_rx: AUX RX Hop ID
+ *
+ * Programs specified Hop IDs for DP IN/OUT port.
+ */
+int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
+			unsigned int aux_tx, unsigned int aux_rx)
+{
+	u32 data[2];
+	int ret;
+
+	ret = tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
+			   ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	data[0] &= ~TB_DP_VIDEO_HOPID_MASK;
+	data[1] &= ~(TB_DP_AUX_RX_HOPID_MASK | TB_DP_AUX_TX_HOPID_MASK);
+
+	data[0] |= (video << TB_DP_VIDEO_HOPID_SHIFT) & TB_DP_VIDEO_HOPID_MASK;
+	data[1] |= aux_tx & TB_DP_AUX_TX_HOPID_MASK;
+	data[1] |= (aux_rx << TB_DP_AUX_RX_HOPID_SHIFT) & TB_DP_AUX_RX_HOPID_MASK;
+
+	return tb_port_write(port, data, TB_CFG_PORT, port->cap_adap,
+			     ARRAY_SIZE(data));
+}
+
+/**
+ * tb_dp_port_is_enabled() - Is DP adapter port enabled
+ * @port: DP adapter port to check
+ */
+bool tb_dp_port_is_enabled(struct tb_port *port)
+{
+	u32 data;
+
+	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
+		return false;
+
+	return !!(data & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
+}
+
+/**
+ * tb_dp_port_enable() - Enables/disables DP paths of a port
+ * @port: DP IN/OUT port
+ * @enable: Enable/disable DP path
+ *
+ * Once Hop IDs are programmed DP paths can be enabled or disabled by
+ * calling this function.
+ */
+int tb_dp_port_enable(struct tb_port *port, bool enable)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1);
+	if (ret)
+		return ret;
+
+	if (enable)
+		data |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
+	else
+		data &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
+
+	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap, 1);
+}
+
 /* switch utility functions */
 
 static void tb_dump_switch(struct tb *tb, struct tb_regs_switch_header *sw)
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 0df1d96e46f5..56bbd1237bd9 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -28,6 +28,32 @@ struct tb_cm {
 	bool hotplug_active;
 };
 
+struct tb_hotplug_event {
+	struct work_struct work;
+	struct tb *tb;
+	u64 route;
+	u8 port;
+	bool unplug;
+};
+
+static void tb_handle_hotplug(struct work_struct *work);
+
+static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
+{
+	struct tb_hotplug_event *ev;
+
+	ev = kmalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return;
+
+	ev->tb = tb;
+	ev->route = route;
+	ev->port = port;
+	ev->unplug = unplug;
+	INIT_WORK(&ev->work, tb_handle_hotplug);
+	queue_work(tb->wq, &ev->work);
+}
+
 /* enumeration & hot plug handling */
 
 static void tb_discover_tunnels(struct tb_switch *sw)
@@ -42,6 +68,10 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 
 		port = &sw->ports[i];
 		switch (port->config.type) {
+		case TB_TYPE_DP_HDMI_IN:
+			tunnel = tb_tunnel_discover_dp(tb, port);
+			break;
+
 		case TB_TYPE_PCIE_DOWN:
 			tunnel = tb_tunnel_discover_pci(tb, port);
 			break;
@@ -102,6 +132,14 @@ static void tb_scan_port(struct tb_port *port)
 	struct tb_switch *sw;
 	if (tb_is_upstream_port(port))
 		return;
+
+	if (tb_port_is_dpout(port) && tb_dp_port_hpd_is_active(port) == 1) {
+		tb_port_dbg(port, "DP adapter HPD set, queuing hotplug\n");
+		tb_queue_hotplug(port->sw->tb, tb_route(port->sw), port->port,
+				 false);
+		return;
+	}
+
 	if (port->config.type != TB_TYPE_PORT)
 		return;
 	if (port->dual_link_port && port->link_nr)
@@ -148,6 +186,26 @@ static void tb_scan_port(struct tb_port *port)
 	tb_scan_switch(sw);
 }
 
+static int tb_free_tunnel(struct tb *tb, enum tb_tunnel_type type,
+			  struct tb_port *src_port, struct tb_port *dst_port)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_tunnel *tunnel;
+
+	list_for_each_entry(tunnel, &tcm->tunnel_list, list) {
+		if (tunnel->type == type &&
+		    ((src_port && src_port == tunnel->src_port) ||
+		     (dst_port && dst_port == tunnel->dst_port))) {
+			tb_tunnel_deactivate(tunnel);
+			list_del(&tunnel->list);
+			tb_tunnel_free(tunnel);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 /**
  * tb_free_invalid_tunnels() - destroy tunnels of devices that have gone away
  */
@@ -227,6 +285,44 @@ static struct tb_port *tb_find_unused_port(struct tb_switch *sw,
 	return NULL;
 }
 
+static int tb_tunnel_dp(struct tb *tb, struct tb_port *out)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_switch *sw = out->sw;
+	struct tb_tunnel *tunnel;
+	struct tb_port *in;
+
+	if (tb_port_is_enabled(out))
+		return 0;
+
+	do {
+		sw = tb_to_switch(sw->dev.parent);
+		if (!sw)
+			return 0;
+		in = tb_find_unused_port(sw, TB_TYPE_DP_HDMI_IN);
+	} while (!in);
+
+	tunnel = tb_tunnel_alloc_dp(tb, in, out);
+	if (!tunnel) {
+		tb_port_dbg(out, "DP tunnel allocation failed\n");
+		return -EIO;
+	}
+
+	if (tb_tunnel_activate(tunnel)) {
+		tb_port_info(out, "DP tunnel activation failed, aborting\n");
+		tb_tunnel_free(tunnel);
+		return -EIO;
+	}
+
+	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+	return 0;
+}
+
+static void tb_teardown_dp(struct tb *tb, struct tb_port *out)
+{
+	tb_free_tunnel(tb, TB_TUNNEL_DP, NULL, out);
+}
+
 static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -283,14 +379,6 @@ static int tb_approve_switch(struct tb *tb, struct tb_switch *sw)
 
 /* hotplug handling */
 
-struct tb_hotplug_event {
-	struct work_struct work;
-	struct tb *tb;
-	u64 route;
-	u8 port;
-	bool unplug;
-};
-
 /**
  * tb_handle_hotplug() - handle hotplug event
  *
@@ -335,6 +423,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 			cancel_work_sync(&sw->work);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
+		} else if (tb_port_is_dpout(port)) {
+			tb_teardown_dp(tb, port);
 		} else {
 			tb_port_info(port,
 				     "got unplug event for disconnected port, ignoring\n");
@@ -348,6 +438,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 			tb_scan_port(port);
 			if (!port->remote)
 				tb_port_info(port, "hotplug: no switch found\n");
+		} else if (tb_port_is_dpout(port)) {
+			tb_tunnel_dp(tb, port);
 		}
 	}
 out:
@@ -364,7 +456,6 @@ static void tb_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 			    const void *buf, size_t size)
 {
 	const struct cfg_event_pkg *pkg = buf;
-	struct tb_hotplug_event *ev;
 	u64 route;
 
 	if (type != TB_CFG_PKG_EVENT) {
@@ -380,15 +471,7 @@ static void tb_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 			pkg->port);
 	}
 
-	ev = kmalloc(sizeof(*ev), GFP_KERNEL);
-	if (!ev)
-		return;
-	INIT_WORK(&ev->work, tb_handle_hotplug);
-	ev->tb = tb;
-	ev->route = route;
-	ev->port = pkg->port;
-	ev->unplug = pkg->unplug;
-	queue_work(tb->wq, &ev->work);
+	tb_queue_hotplug(tb, route, pkg->port, pkg->unplug);
 }
 
 static void tb_stop(struct tb *tb)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index bf5bc0fb0f8e..7b6d1428bfad 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -292,6 +292,16 @@ static inline bool tb_port_is_null(const struct tb_port *port)
 	return port->port && port->config.type == TB_TYPE_PORT;
 }
 
+static inline bool tb_port_is_dpin(const struct tb_port *port)
+{
+	return port->config.type == TB_TYPE_DP_HDMI_IN;
+}
+
+static inline bool tb_port_is_dpout(const struct tb_port *port)
+{
+	return port->config.type == TB_TYPE_DP_HDMI_OUT;
+}
+
 static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 			     enum tb_cfg_space space, u32 offset, u32 length)
 {
@@ -468,6 +478,13 @@ bool tb_port_is_enabled(struct tb_port *port);
 bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
 
+int tb_dp_port_hpd_is_active(struct tb_port *port);
+int tb_dp_port_hpd_clear(struct tb_port *port);
+int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
+			unsigned int aux_tx, unsigned int aux_rx);
+bool tb_dp_port_is_enabled(struct tb_port *port);
+int tb_dp_port_enable(struct tb_port *port, bool enable);
+
 struct tb_path *tb_path_discover(struct tb_port *port, int start_hopid,
 				 struct tb_port **last);
 struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src,
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 74c0f4a5606d..420d2a623f31 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -213,6 +213,28 @@ struct tb_regs_port_header {
 
 /* DWORD 4 */
 #define TB_PORT_NFC_CREDITS_MASK	GENMASK(19, 0)
+#define TB_PORT_MAX_CREDITS_SHIFT	20
+#define TB_PORT_MAX_CREDITS_MASK	GENMASK(26, 20)
+
+/* Display Port adapter registers */
+
+/* DWORD 0 */
+#define TB_DP_VIDEO_EN			BIT(31)
+#define TB_DP_AUX_EN			BIT(30)
+#define TB_DP_VIDEO_HOPID_SHIFT		16
+#define TB_DP_VIDEO_HOPID_MASK		GENMASK(26, 16)
+/* DWORD 1 */
+#define TB_DP_AUX_TX_HOPID_MASK		GENMASK(10, 0)
+#define TB_DP_AUX_RX_HOPID_SHIFT	11
+#define TB_DP_AUX_RX_HOPID_MASK		GENMASK(21, 11)
+/* DWORD 2 */
+#define TB_DP_HDP			BIT(6)
+/* DWORD 3 */
+#define TB_DP_HPDC			BIT(9)
+/* DWORD 4 */
+#define TB_DP_LOCAL_CAP			4
+/* DWORD 5 */
+#define TB_DP_REMOTE_CAP		5
 
 /* PCIe adapter registers */
 
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 1a5e2aa395c6..5dd648912032 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -18,14 +18,25 @@
 #define TB_PCI_PATH_DOWN		0
 #define TB_PCI_PATH_UP			1
 
+/* DP adapters use hop ID 8 for aux and 9 for video */
+#define TB_DP_AUX_TX_HOPID		8
+#define TB_DP_VIDEO_HOPID		9
+
+#define TB_DP_VIDEO_PATH_OUT		0
+#define TB_DP_AUX_PATH_OUT		1
+#define TB_DP_AUX_PATH_IN		2
+
+static const char * const tb_tunnel_names[] = { "PCI", "DP" };
+
 #define __TB_TUNNEL_PRINT(level, tunnel, fmt, arg...)                   \
 	do {                                                            \
 		struct tb_tunnel *__tunnel = (tunnel);                  \
-		level(__tunnel->tb, "%llx:%x <-> %llx:%x (PCI): " fmt,  \
+		level(__tunnel->tb, "%llx:%x <-> %llx:%x (%s): " fmt,   \
 		      tb_route(__tunnel->src_port->sw),                 \
 		      __tunnel->src_port->port,                         \
 		      tb_route(__tunnel->dst_port->sw),                 \
 		      __tunnel->dst_port->port,                         \
+		      tb_tunnel_names[__tunnel->type],			\
 		      ## arg);                                          \
 	} while (0)
 
@@ -36,7 +47,8 @@
 #define tb_tunnel_info(tunnel, fmt, arg...) \
 	__TB_TUNNEL_PRINT(tb_info, tunnel, fmt, ##arg)
 
-static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths)
+static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths,
+					 enum tb_tunnel_type type)
 {
 	struct tb_tunnel *tunnel;
 
@@ -53,6 +65,7 @@ static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths)
 	INIT_LIST_HEAD(&tunnel->list);
 	tunnel->tb = tb;
 	tunnel->npaths = npaths;
+	tunnel->type = type;
 
 	return tunnel;
 }
@@ -99,7 +112,7 @@ struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down)
 	if (!tb_pci_port_is_enabled(down))
 		return NULL;
 
-	tunnel = tb_tunnel_alloc(tb, 2);
+	tunnel = tb_tunnel_alloc(tb, 2, TB_TUNNEL_PCI);
 	if (!tunnel)
 		return NULL;
 
@@ -165,7 +178,7 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	struct tb_tunnel *tunnel;
 	struct tb_path *path;
 
-	tunnel = tb_tunnel_alloc(tb, 2);
+	tunnel = tb_tunnel_alloc(tb, 2, TB_TUNNEL_PCI);
 	if (!tunnel)
 		return NULL;
 
@@ -192,6 +205,262 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	return tunnel;
 }
 
+static int tb_dp_xchg_caps(struct tb_port *in, struct tb_port *out)
+{
+	u32 in_dp_cap, out_dp_cap;
+	int ret;
+
+	/*
+	 * Copy DP_LOCAL_CAP register to DP_REMOTE_CAP register for
+	 * newer generation hardware.
+	 */
+	if (in->sw->generation < 2 || out->sw->generation < 2)
+		return 0;
+
+	/* Read both DP_LOCAL_CAP registers */
+	ret = tb_port_read(in, &in_dp_cap, TB_CFG_PORT,
+			   in->cap_adap + TB_DP_LOCAL_CAP, 1);
+	if (ret)
+		return ret;
+
+	ret = tb_port_read(out, &out_dp_cap, TB_CFG_PORT,
+			   out->cap_adap + TB_DP_LOCAL_CAP, 1);
+	if (ret)
+		return ret;
+
+	/* Write them to the opposite adapter port */
+	ret = tb_port_write(out, &in_dp_cap, TB_CFG_PORT,
+			    out->cap_adap + TB_DP_REMOTE_CAP, 1);
+	if (ret)
+		return ret;
+
+	return tb_port_write(in, &out_dp_cap, TB_CFG_PORT,
+			     in->cap_adap + TB_DP_REMOTE_CAP, 1);
+}
+
+static int tb_dp_activate(struct tb_tunnel *tunnel, bool active)
+{
+	int ret;
+
+	if (active) {
+		struct tb_path **paths;
+		int last;
+
+		ret = tb_dp_xchg_caps(tunnel->src_port, tunnel->dst_port);
+		if (ret)
+			return ret;
+
+		paths = tunnel->paths;
+		last = paths[TB_DP_VIDEO_PATH_OUT]->path_length - 1;
+
+		tb_dp_port_set_hops(tunnel->src_port,
+			paths[TB_DP_VIDEO_PATH_OUT]->hops[0].in_hop_index,
+			paths[TB_DP_AUX_PATH_OUT]->hops[0].in_hop_index,
+			paths[TB_DP_AUX_PATH_IN]->hops[last].next_hop_index);
+
+		tb_dp_port_set_hops(tunnel->dst_port,
+			paths[TB_DP_VIDEO_PATH_OUT]->hops[last].next_hop_index,
+			paths[TB_DP_AUX_PATH_IN]->hops[0].in_hop_index,
+			paths[TB_DP_AUX_PATH_OUT]->hops[last].next_hop_index);
+	} else {
+		tb_dp_port_hpd_clear(tunnel->src_port);
+	}
+
+	ret = tb_dp_port_enable(tunnel->src_port, active);
+	if (ret)
+		return ret;
+
+	return tb_dp_port_enable(tunnel->dst_port, active);
+}
+
+static void tb_dp_init_aux_path(struct tb_path *path)
+{
+	int i;
+
+	path->egress_fc_enable = TB_PATH_SOURCE | TB_PATH_INTERNAL;
+	path->egress_shared_buffer = TB_PATH_NONE;
+	path->ingress_fc_enable = TB_PATH_ALL;
+	path->ingress_shared_buffer = TB_PATH_NONE;
+	path->priority = 2;
+	path->weight = 1;
+
+	path->hops[0].initial_credits = 1;
+	for (i = 1; i < path->path_length; i++)
+		path->hops[i].initial_credits = 1;
+}
+
+static void tb_dp_init_video_path(struct tb_path *path, bool discover)
+{
+	const struct tb_port *in = path->hops[0].in_port;
+
+	path->egress_fc_enable = TB_PATH_NONE;
+	path->egress_shared_buffer = TB_PATH_NONE;
+	path->ingress_fc_enable = TB_PATH_NONE;
+	path->ingress_shared_buffer = TB_PATH_NONE;
+	path->priority = 1;
+	path->weight = 1;
+
+	if (discover) {
+		path->nfc_credits =
+			in->config.nfc_credits & TB_PORT_NFC_CREDITS_MASK;
+	} else {
+		u32 max_credits;
+
+		max_credits = in->config.nfc_credits & TB_PORT_MAX_CREDITS_MASK;
+		max_credits >>= TB_PORT_MAX_CREDITS_SHIFT;
+
+		/* Leave some credits for AUX path */
+		path->nfc_credits = min_t(u32, max_credits - 2, 12);
+	}
+}
+
+/**
+ * tb_tunnel_discover_dp() - Discover existing Display Port tunnels
+ * @tb: Pointer to the domain structure
+ * @in: DP in adapter
+ *
+ * If @in adapter is active, follows the tunnel to the DP out adapter
+ * and back. Returns the discovered tunnel or %NULL if there was no
+ * tunnel.
+ *
+ * Return: DP tunnel or %NULL if no tunnel found.
+ */
+struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_path *path;
+	struct tb_port *out;
+	int ret, hopid;
+	u32 data[4];
+
+	ret = tb_port_read(in, data, TB_CFG_PORT, in->cap_adap,
+			   ARRAY_SIZE(data));
+	if (ret < 0)
+		return NULL;
+
+	/* Both needs to be enabled for now */
+	if (!(data[0] & TB_DP_VIDEO_EN) || !(data[0] & TB_DP_AUX_EN))
+		return NULL;
+
+	tunnel = tb_tunnel_alloc(tb, 3, TB_TUNNEL_DP);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->activate = tb_dp_activate;
+	tunnel->src_port = in;
+
+	hopid = (data[0] & TB_DP_VIDEO_HOPID_MASK) >> TB_DP_VIDEO_HOPID_SHIFT;
+	path = tb_path_discover(in, hopid, &out);
+	if (!path)
+		goto err_free;
+
+	if (out->config.type != TB_TYPE_DP_HDMI_OUT) {
+		tb_port_warn(in, "path does not end to a DP adapter\n");
+		goto err_free;
+	}
+
+	tunnel->paths[TB_DP_VIDEO_PATH_OUT] = path;
+	tunnel->dst_port = out;
+
+	hopid = data[1] & TB_DP_AUX_TX_HOPID_MASK;
+	path = tb_path_discover(in, hopid, NULL);
+	if (!path)
+		goto err_free;
+	tunnel->paths[TB_DP_AUX_PATH_OUT] = path;
+
+	ret = tb_port_read(out, data, TB_CFG_PORT, out->cap_adap,
+			   ARRAY_SIZE(data));
+	if (ret < 0)
+		goto err_free;
+
+	hopid = data[1] & TB_DP_AUX_TX_HOPID_MASK;
+
+	if (!(data[0] & TB_DP_VIDEO_EN) || !(data[0] & TB_DP_AUX_EN))
+		goto err_free;
+
+	path = tb_path_discover(out, hopid, &in);
+	if (!path)
+		goto err_free;
+
+	tunnel->paths[TB_DP_AUX_PATH_IN] = path;
+
+	if (in != tunnel->src_port) {
+		tb_tunnel_warn(tunnel, "path is not complete, skipping\n");
+		goto err_free;
+	}
+
+	/* Activated by the boot firmware */
+	tunnel->paths[TB_DP_VIDEO_PATH_OUT]->activated = true;
+	tunnel->paths[TB_DP_AUX_PATH_OUT]->activated = true;
+	tunnel->paths[TB_DP_AUX_PATH_IN]->activated = true;
+
+	tb_dp_init_video_path(tunnel->paths[TB_DP_VIDEO_PATH_OUT], true);
+	tb_dp_init_aux_path(tunnel->paths[TB_DP_AUX_PATH_OUT]);
+	tb_dp_init_aux_path(tunnel->paths[TB_DP_AUX_PATH_IN]);
+
+	return tunnel;
+
+err_free:
+	tb_tunnel_free(tunnel);
+	return NULL;
+}
+
+/**
+ * tb_tunnel_alloc_dp() - allocate a Display Port tunnel
+ * @tb: Pointer to the domain structure
+ * @in: DP in adapter port
+ * @out: DP out adapter port
+ *
+ * Allocates a tunnel between @in and @out that is capable of tunneling
+ * Display Port traffic.
+ *
+ * Return: Returns a tb_tunnel on success or NULL on failure.
+ */
+struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
+				     struct tb_port *out)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_path **paths;
+	struct tb_path *path;
+
+	if (WARN_ON(in->cap_adap < 0 || out->cap_adap < 0))
+		return NULL;
+
+	tunnel = tb_tunnel_alloc(tb, 3, TB_TUNNEL_DP);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->activate = tb_dp_activate;
+	tunnel->src_port = in;
+	tunnel->dst_port = out;
+
+	paths = tunnel->paths;
+
+	path = tb_path_alloc(tb, in, out, TB_DP_VIDEO_HOPID, -1, 1);
+	if (!path)
+		goto err_free;
+	tb_dp_init_video_path(path, false);
+	paths[TB_DP_VIDEO_PATH_OUT] = path;
+
+	path = tb_path_alloc(tb, in, out, TB_DP_AUX_TX_HOPID, -1, 1);
+	if (!path)
+		goto err_free;
+	tb_dp_init_aux_path(path);
+	paths[TB_DP_AUX_PATH_OUT] = path;
+
+	path = tb_path_alloc(tb, out, in, TB_DP_AUX_TX_HOPID, -1, 1);
+	if (!path)
+		goto err_free;
+	tb_dp_init_aux_path(path);
+	paths[TB_DP_AUX_PATH_IN] = path;
+
+	return tunnel;
+
+err_free:
+	tb_tunnel_free(tunnel);
+	return NULL;
+}
+
 /**
  * tb_tunnel_free() - free a tunnel
  * @tunnel: Tunnel to be freed
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 7e801a31f9d1..07583f8247c1 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -11,6 +11,11 @@
 
 #include "tb.h"
 
+enum tb_tunnel_type {
+	TB_TUNNEL_PCI,
+	TB_TUNNEL_DP,
+};
+
 /**
  * struct tb_tunnel - Tunnel between two ports
  * @tb: Pointer to the domain
@@ -20,6 +25,7 @@
  * @npaths: Number of paths in @paths
  * @activate: Optional tunnel specific activation/deactivation
  * @list: Tunnels are linked using this field
+ * @type: Type of the tunnel
  */
 struct tb_tunnel {
 	struct tb *tb;
@@ -29,16 +35,31 @@ struct tb_tunnel {
 	size_t npaths;
 	int (*activate)(struct tb_tunnel *tunnel, bool activate);
 	struct list_head list;
+	enum tb_tunnel_type type;
 };
 
 struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down);
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 				      struct tb_port *down);
+struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in);
+struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
+				     struct tb_port *out);
+
 void tb_tunnel_free(struct tb_tunnel *tunnel);
 int tb_tunnel_activate(struct tb_tunnel *tunnel);
 int tb_tunnel_restart(struct tb_tunnel *tunnel);
 void tb_tunnel_deactivate(struct tb_tunnel *tunnel);
 bool tb_tunnel_is_invalid(struct tb_tunnel *tunnel);
 
+static inline bool tb_tunnel_is_pci(const struct tb_tunnel *tunnel)
+{
+	return tunnel->type == TB_TUNNEL_PCI;
+}
+
+static inline bool tb_tunnel_is_dp(const struct tb_tunnel *tunnel)
+{
+	return tunnel->type == TB_TUNNEL_DP;
+}
+
 #endif
 
-- 
2.20.1

