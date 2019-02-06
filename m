Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4097AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAF420821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfBFNSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:18:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:26739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbfBFNRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136336038"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 05:17:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 82FAD9A8; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
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
Subject: [PATCH v2 24/28] thunderbolt: Add support for DMA tunnels
Date:   Wed,  6 Feb 2019 16:17:34 +0300
Message-Id: <20190206131738.43696-25-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to PCIe and Display Port tunnels it is also possible to
create tunnels that forward DMA traffic from the host interface adapter
(NHI) to a NULL port that is connected to another domain through a
Thunderbolt cable. These tunnels can be used to carry software messages
such as networking packets.

To support this we introduce another tunnel type (TB_TUNNEL_DMA) that
supports paths from NHI to NULL port and back.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c    | 20 ++++++--
 drivers/thunderbolt/switch.c  | 22 ++++++++
 drivers/thunderbolt/tb.h      |  2 +
 drivers/thunderbolt/tb_regs.h |  3 ++
 drivers/thunderbolt/tunnel.c  | 94 ++++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tunnel.h  | 10 ++++
 6 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index ada60d4aa99b..afdb667fcc0d 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -284,7 +284,8 @@ static void __tb_path_deallocate_nfc(struct tb_path *path, int first_hop)
 	}
 }
 
-static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index)
+static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index,
+				    bool clear_fc)
 {
 	struct tb_regs_hop hop;
 	ktime_t timeout;
@@ -311,8 +312,20 @@ static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index)
 		if (ret)
 			return ret;
 
-		if (!hop.pending)
+		if (!hop.pending) {
+			if (clear_fc) {
+				/* Clear flow control */
+				hop.ingress_fc = 0;
+				hop.egress_fc = 0;
+				hop.ingress_shared_buffer = 0;
+				hop.egress_shared_buffer = 0;
+
+				return tb_port_write(port, &hop, TB_CFG_HOPS,
+						     2 * hop_index, 2);
+			}
+
 			return 0;
+		}
 
 		usleep_range(10, 20);
 	} while (ktime_before(ktime_get(), timeout));
@@ -326,7 +339,8 @@ static void __tb_path_deactivate_hops(struct tb_path *path, int first_hop)
 
 	for (i = first_hop; i < path->path_length; i++) {
 		res = __tb_path_deactivate_hop(path->hops[i].in_port,
-					       path->hops[i].in_hop_index);
+					       path->hops[i].in_hop_index,
+					       path->clear_fc);
 		if (res)
 			tb_port_warn(path->hops[i].in_port,
 				     "hop deactivation failed for hop %d, index %d\n",
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a1876dcd1d10..13eed95fc667 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -562,6 +562,28 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits)
 			     TB_CFG_PORT, 4, 1);
 }
 
+/**
+ * tb_port_set_initial_credits() - Set initial port link credits allocated
+ * @port: Port to set the initial credits
+ * @credits: Number of credits to to allocate
+ *
+ * Set initial credits value to be used for ingress shared buffering.
+ */
+int tb_port_set_initial_credits(struct tb_port *port, u32 credits)
+{
+	u32 data;
+	int ret;
+
+	ret = tb_port_read(port, &data, TB_CFG_PORT, 5, 1);
+	if (ret)
+		return ret;
+
+	data &= ~TB_PORT_LCA_MASK;
+	data |= (credits << TB_PORT_LCA_SHIFT) & TB_PORT_LCA_MASK;
+
+	return tb_port_write(port, &data, TB_CFG_PORT, 5, 1);
+}
+
 /**
  * tb_port_clear_counter() - clear a counter in TB_CFG_COUNTER
  *
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 7e155eed1fee..3a42a47df69f 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -198,6 +198,7 @@ struct tb_path {
 	int weight:4;
 	bool drop_packages;
 	bool activated;
+	bool clear_fc;
 	struct tb_path_hop *hops;
 	int path_length; /* number of hops */
 };
@@ -465,6 +466,7 @@ static inline struct tb_switch *tb_to_switch(struct device *dev)
 
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
 int tb_port_add_nfc_credits(struct tb_port *port, int credits);
+int tb_port_set_initial_credits(struct tb_port *port, u32 credits);
 int tb_port_clear_counter(struct tb_port *port, int counter);
 int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_in_hopid(struct tb_port *port, int hopid);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 420d2a623f31..4591c8b1d546 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -215,6 +215,9 @@ struct tb_regs_port_header {
 #define TB_PORT_NFC_CREDITS_MASK	GENMASK(19, 0)
 #define TB_PORT_MAX_CREDITS_SHIFT	20
 #define TB_PORT_MAX_CREDITS_MASK	GENMASK(26, 20)
+/* DWORD 5 */
+#define TB_PORT_LCA_SHIFT		22
+#define TB_PORT_LCA_MASK		GENMASK(28, 22)
 
 /* Display Port adapter registers */
 
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 7aab7e07739b..f10a0a15b873 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -26,7 +26,10 @@
 #define TB_DP_AUX_PATH_OUT		1
 #define TB_DP_AUX_PATH_IN		2
 
-static const char * const tb_tunnel_names[] = { "PCI", "DP" };
+#define TB_DMA_PATH_OUT			0
+#define TB_DMA_PATH_IN			1
+
+static const char * const tb_tunnel_names[] = { "PCI", "DP", "DMA" };
 
 #define __TB_TUNNEL_PRINT(level, tunnel, fmt, arg...)                   \
 	do {                                                            \
@@ -461,6 +464,95 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 	return NULL;
 }
 
+static u32 tb_dma_credits(struct tb_port *nhi)
+{
+	u32 max_credits;
+
+	max_credits = nhi->config.nfc_credits & TB_PORT_MAX_CREDITS_MASK;
+	max_credits >>= TB_PORT_MAX_CREDITS_SHIFT;
+
+	return min(max_credits, 13U);
+}
+
+static int tb_dma_activate(struct tb_tunnel *tunnel, bool active)
+{
+	struct tb_port *nhi = tunnel->src_port;
+	u32 credits;
+
+	credits = active ? tb_dma_credits(nhi) : 0;
+	return tb_port_set_initial_credits(nhi, credits);
+}
+
+static void tb_dma_init_path(struct tb_path *path, unsigned int isb,
+			     unsigned int efc, u32 credits)
+{
+	int i;
+
+	path->egress_fc_enable = efc;
+	path->ingress_fc_enable = TB_PATH_ALL;
+	path->egress_shared_buffer = TB_PATH_NONE;
+	path->ingress_shared_buffer = isb;
+	path->priority = 5;
+	path->weight = 1;
+	path->clear_fc = true;
+
+	for (i = 0; i < path->path_length; i++)
+		path->hops[i].initial_credits = credits;
+}
+
+/**
+ * tb_tunnel_alloc_dma() - allocate a DMA tunnel
+ * @tb: Pointer to the domain structure
+ * @nhi: Host controller port
+ * @dst: Destination null port which the other domain is connected to
+ * @transmit_ring: NHI ring number used to send packets towards the
+ *		   other domain
+ * @transmit_path: HopID used for transmitting packets
+ * @receive_ring: NHI ring number used to receive packets from the
+ *		  other domain
+ * @reveive_path: HopID used for receiving packets
+ *
+ * Return: Returns a tb_tunnel on success or NULL on failure.
+ */
+struct tb_tunnel *tb_tunnel_alloc_dma(struct tb *tb, struct tb_port *nhi,
+				      struct tb_port *dst, int transmit_ring,
+				      int transmit_path, int receive_ring,
+				      int receive_path)
+{
+	struct tb_tunnel *tunnel;
+	struct tb_path *path;
+	u32 credits;
+
+	tunnel = tb_tunnel_alloc(tb, 2, TB_TUNNEL_DMA);
+	if (!tunnel)
+		return NULL;
+
+	tunnel->activate = tb_dma_activate;
+	tunnel->src_port = nhi;
+	tunnel->dst_port = dst;
+
+	credits = tb_dma_credits(nhi);
+
+	path = tb_path_alloc(tb, dst, nhi, receive_path, receive_ring, 0);
+	if (!path) {
+		tb_tunnel_free(tunnel);
+		return NULL;
+	}
+	tb_dma_init_path(path, TB_PATH_NONE, TB_PATH_SOURCE | TB_PATH_INTERNAL,
+			 credits);
+	tunnel->paths[TB_DMA_PATH_IN] = path;
+
+	path = tb_path_alloc(tb, nhi, dst, transmit_ring, transmit_path, 0);
+	if (!path) {
+		tb_tunnel_free(tunnel);
+		return NULL;
+	}
+	tb_dma_init_path(path, TB_PATH_SOURCE, TB_PATH_ALL, credits);
+	tunnel->paths[TB_DMA_PATH_OUT] = path;
+
+	return tunnel;
+}
+
 /**
  * tb_tunnel_free() - free a tunnel
  * @tunnel: Tunnel to be freed
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 07583f8247c1..fa51217e5925 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -14,6 +14,7 @@
 enum tb_tunnel_type {
 	TB_TUNNEL_PCI,
 	TB_TUNNEL_DP,
+	TB_TUNNEL_DMA,
 };
 
 /**
@@ -44,6 +45,10 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in);
 struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 				     struct tb_port *out);
+struct tb_tunnel *tb_tunnel_alloc_dma(struct tb *tb, struct tb_port *nhi,
+				      struct tb_port *dst, int transmit_ring,
+				      int transmit_path, int receive_ring,
+				      int receive_path);
 
 void tb_tunnel_free(struct tb_tunnel *tunnel);
 int tb_tunnel_activate(struct tb_tunnel *tunnel);
@@ -61,5 +66,10 @@ static inline bool tb_tunnel_is_dp(const struct tb_tunnel *tunnel)
 	return tunnel->type == TB_TUNNEL_DP;
 }
 
+static inline bool tb_tunnel_is_dma(const struct tb_tunnel *tunnel)
+{
+	return tunnel->type == TB_TUNNEL_DMA;
+}
+
 #endif
 
-- 
2.20.1

