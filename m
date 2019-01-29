Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A0C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FA021848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfA2PFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:05:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:34504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfA2PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="112013836"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2019 07:01:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D5D627E5; Tue, 29 Jan 2019 17:01:44 +0200 (EET)
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
Subject: [PATCH 14/28] thunderbolt: Extend tunnel creation to more than 2 adjacent switches
Date:   Tue, 29 Jan 2019 18:01:29 +0300
Message-Id: <20190129150143.12681-15-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can allocate hop IDs per port on a path, we can take
advantage of this and create tunnels covering longer paths than just
between two adjacent switches. PCIe actually does not need this as it is
always a daisy chain between two adjacent switches but this way we do
not need to hard-code creation of the tunnel.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c   | 94 ++++++++++++++++++++++++++++++++++--
 drivers/thunderbolt/tb.h     |  4 +-
 drivers/thunderbolt/tunnel.c | 54 +++++----------------
 3 files changed, 106 insertions(+), 46 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 48cb15ff4446..122e6a1daf34 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -31,23 +31,97 @@ static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 }
 
 /**
- * tb_path_alloc() - allocate a thunderbolt path
+ * tb_path_alloc() - allocate a thunderbolt path between two ports
+ * @tb: Domain pointer
+ * @src: Source port of the path
+ * @dst: Destination port of the path
+ * @start_hopid: Hop ID used for the first ingress port in the path
+ * @end_hopid: Hop ID used for the last egress port in the path (%-1 for
+ *	       automatic allocation)
+ * @link_nr: Preferred link if there are dual links on the path
+ *
+ * Creates path between two ports starting with given @start_hopid. Reserves
+ * hop IDs for each port (they can be different from @start_hopid depending on
+ * how many hop IDs each port already have reserved). If there are dual
+ * links on the path, prioritizes using @link_nr.
  *
  * Return: Returns a tb_path on success or NULL on failure.
  */
-struct tb_path *tb_path_alloc(struct tb *tb, int num_hops)
+struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src,
+			      struct tb_port *dst, int start_hopid,
+			      int end_hopid, int link_nr)
 {
-	struct tb_path *path = kzalloc(sizeof(*path), GFP_KERNEL);
+	struct tb_port *in_port, *out_port;
+	int in_hopid, out_hopid;
+	struct tb_path *path;
+	size_t num_hops;
+	int i, ret;
+
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return NULL;
+
+	i = 0;
+	tb_for_each_port(in_port, src, dst)
+		i++;
+
+	/* Each hop takes two ports */
+	num_hops = i / 2;
+
 	path->hops = kcalloc(num_hops, sizeof(*path->hops), GFP_KERNEL);
 	if (!path->hops) {
 		kfree(path);
 		return NULL;
 	}
+
+	in_hopid = start_hopid;
+	out_port = NULL;
+	out_hopid = -1;
+
+	for (i = 0; i < num_hops; i++) {
+		in_port = tb_port_get_next(src, dst, out_port);
+
+		if (in_port->dual_link_port && in_port->link_nr != link_nr)
+			in_port = in_port->dual_link_port;
+
+		ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);
+		if (ret < 0)
+			goto err;
+		in_hopid = ret;
+
+		out_port = tb_port_get_next(src, dst, in_port);
+		if (!out_port)
+			goto err;
+
+		if (out_port->dual_link_port && out_port->link_nr != link_nr)
+			out_port = out_port->dual_link_port;
+
+		if (end_hopid && i == num_hops - 1)
+			ret = tb_port_alloc_out_hopid(out_port, end_hopid,
+						      end_hopid);
+		else
+			ret = tb_port_alloc_out_hopid(out_port, -1, -1);
+
+		if (ret < 0)
+			goto err;
+		out_hopid = ret;
+
+		path->hops[i].in_hop_index = in_hopid;
+		path->hops[i].in_port = in_port;
+		path->hops[i].in_counter_index = -1;
+		path->hops[i].out_port = out_port;
+		path->hops[i].next_hop_index = out_hopid;
+
+		in_hopid = out_hopid;
+	}
+
 	path->tb = tb;
 	path->path_length = num_hops;
 	return path;
+
+err:
+	tb_path_free(path);
+	return NULL;
 }
 
 /**
@@ -55,10 +129,24 @@ struct tb_path *tb_path_alloc(struct tb *tb, int num_hops)
  */
 void tb_path_free(struct tb_path *path)
 {
+	int i;
+
 	if (path->activated) {
 		tb_WARN(path->tb, "trying to free an activated path\n")
 		return;
 	}
+
+	for (i = 0; i < path->path_length; i++) {
+		const struct tb_path_hop *hop = &path->hops[i];
+
+		if (hop->in_port)
+			tb_port_release_in_hopid(hop->in_port,
+						 hop->in_hop_index);
+		if (hop->out_port)
+			tb_port_release_out_hopid(hop->out_port,
+						  hop->next_hop_index);
+	}
+
 	kfree(path->hops);
 	kfree(path);
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 360333caa3c4..ceed33895105 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -460,7 +460,9 @@ int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
 
 int tb_pci_port_enable(struct tb_port *port, bool enable);
 
-struct tb_path *tb_path_alloc(struct tb *tb, int num_hops);
+struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src,
+			      struct tb_port *dst, int start_hopid,
+			      int end_hopid, int link_nr);
 void tb_path_free(struct tb_path *path);
 int tb_path_activate(struct tb_path *path);
 void tb_path_deactivate(struct tb_path *path);
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 20ce28276f7a..cdf9ca1c043e 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -12,6 +12,9 @@
 #include "tunnel.h"
 #include "tb.h"
 
+/* PCIe adapters use always hop ID of 8 for both directions */
+#define TB_PCI_HOPID			8
+
 #define TB_PCI_PATH_DOWN		0
 #define TB_PCI_PATH_UP			1
 
@@ -86,21 +89,13 @@ static void tb_pci_init_path(struct tb_path *path)
  * Allocate a PCI tunnel. The ports must be of type TB_TYPE_PCIE_UP and
  * TB_TYPE_PCIE_DOWN.
  *
- * Currently only paths consisting of two hops are supported (that is the
- * ports must be on "adjacent" switches).
- *
- * The paths are hard-coded to use hop 8 (the only working hop id available on
- * my thunderbolt devices). Therefore at most ONE path per device may be
- * activated.
- *
  * Return: Returns a tb_tunnel on success or NULL on failure.
  */
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 				      struct tb_port *down)
 {
-	struct tb_path *path_to_up;
-	struct tb_path *path_to_down;
 	struct tb_tunnel *tunnel;
+	struct tb_path *path;
 
 	tunnel = tb_tunnel_alloc(tb, 2);
 	if (!tunnel)
@@ -110,46 +105,21 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 	tunnel->src_port = down;
 	tunnel->dst_port = up;
 
-	path_to_up = tb_path_alloc(tb, 2);
-	if (!path_to_up) {
+	path = tb_path_alloc(tb, down, up, TB_PCI_HOPID, -1, 0);
+	if (!path) {
 		tb_tunnel_free(tunnel);
 		return NULL;
 	}
-	tunnel->paths[TB_PCI_PATH_UP] = path_to_up;
+	tb_pci_init_path(path);
+	tunnel->paths[TB_PCI_PATH_UP] = path;
 
-	path_to_down = tb_path_alloc(tb, 2);
-	if (!path_to_down) {
+	path = tb_path_alloc(tb, up, down, TB_PCI_HOPID, -1, 0);
+	if (!path) {
 		tb_tunnel_free(tunnel);
 		return NULL;
 	}
-	tunnel->paths[TB_PCI_PATH_DOWN] = path_to_down;
-
-	tb_pci_init_path(path_to_up);
-	tb_pci_init_path(path_to_down);
-
-	path_to_up->hops[0].in_port = down;
-	path_to_up->hops[0].in_hop_index = 8;
-	path_to_up->hops[0].in_counter_index = -1;
-	path_to_up->hops[0].out_port = tb_upstream_port(up->sw)->remote;
-	path_to_up->hops[0].next_hop_index = 8;
-
-	path_to_up->hops[1].in_port = tb_upstream_port(up->sw);
-	path_to_up->hops[1].in_hop_index = 8;
-	path_to_up->hops[1].in_counter_index = -1;
-	path_to_up->hops[1].out_port = up;
-	path_to_up->hops[1].next_hop_index = 8;
-
-	path_to_down->hops[0].in_port = up;
-	path_to_down->hops[0].in_hop_index = 8;
-	path_to_down->hops[0].in_counter_index = -1;
-	path_to_down->hops[0].out_port = tb_upstream_port(up->sw);
-	path_to_down->hops[0].next_hop_index = 8;
-
-	path_to_down->hops[1].in_port = tb_upstream_port(up->sw)->remote;
-	path_to_down->hops[1].in_hop_index = 8;
-	path_to_down->hops[1].in_counter_index = -1;
-	path_to_down->hops[1].out_port = down;
-	path_to_down->hops[1].next_hop_index = 8;
+	tb_pci_init_path(path);
+	tunnel->paths[TB_PCI_PATH_DOWN] = path;
 
 	return tunnel;
 }
-- 
2.20.1

