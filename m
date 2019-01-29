Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A13C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C62C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfA2PCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:02:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:34521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfA2PB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="139779856"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2019 07:01:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 73D46D4C; Tue, 29 Jan 2019 17:01:45 +0200 (EET)
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
Subject: [PATCH 27/28] thunderbolt: Make rest of the logging to happen at debug level
Date:   Tue, 29 Jan 2019 18:01:42 +0300
Message-Id: <20190129150143.12681-28-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver can handle every possible tunnel types there is no
point to log everything as info level so turn these to happen at debug
level instead.

While at it remove duplicated tunnel activation log message
(tb_tunnel_activate() calls tb_tunnel_restart() which print the same
message).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/ctl.c    |  2 +-
 drivers/thunderbolt/icm.c    |  2 +-
 drivers/thunderbolt/path.c   | 30 +++++++++++++++---------------
 drivers/thunderbolt/switch.c | 19 +++++++++----------
 drivers/thunderbolt/tb.c     | 11 +++++------
 drivers/thunderbolt/tunnel.c | 10 ++++------
 6 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 73b386de4d15..2427d73be731 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -720,7 +720,7 @@ int tb_cfg_error(struct tb_ctl *ctl, u64 route, u32 port,
 		.port = port,
 		.error = error,
 	};
-	tb_ctl_info(ctl, "resetting error on %llx:%x.\n", route, port);
+	tb_ctl_dbg(ctl, "resetting error on %llx:%x.\n", route, port);
 	return tb_ctl_tx(ctl, &pkg, sizeof(pkg), TB_CFG_PKG_ERROR);
 }
 
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e28a4255d56a..c44906fac2a4 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1559,7 +1559,7 @@ static int icm_firmware_start(struct tb *tb, struct tb_nhi *nhi)
 	if (val & REG_FW_STS_ICM_EN)
 		return 0;
 
-	dev_info(&nhi->pdev->dev, "starting ICM firmware\n");
+	dev_dbg(&nhi->pdev->dev, "starting ICM firmware\n");
 
 	ret = icm_firmware_reset(tb, nhi);
 	if (ret)
diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index afdb667fcc0d..1aefdef403ef 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -354,12 +354,12 @@ void tb_path_deactivate(struct tb_path *path)
 		tb_WARN(path->tb, "trying to deactivate an inactive path\n");
 		return;
 	}
-	tb_info(path->tb,
-		"deactivating path from %llx:%x to %llx:%x\n",
-		tb_route(path->hops[0].in_port->sw),
-		path->hops[0].in_port->port,
-		tb_route(path->hops[path->path_length - 1].out_port->sw),
-		path->hops[path->path_length - 1].out_port->port);
+	tb_dbg(path->tb,
+	       "deactivating path from %llx:%x to %llx:%x\n",
+	       tb_route(path->hops[0].in_port->sw),
+	       path->hops[0].in_port->port,
+	       tb_route(path->hops[path->path_length - 1].out_port->sw),
+	       path->hops[path->path_length - 1].out_port->port);
 	__tb_path_deactivate_hops(path, 0);
 	__tb_path_deallocate_nfc(path, 0);
 	path->activated = false;
@@ -382,12 +382,12 @@ int tb_path_activate(struct tb_path *path)
 		return -EINVAL;
 	}
 
-	tb_info(path->tb,
-		"activating path from %llx:%x to %llx:%x\n",
-		tb_route(path->hops[0].in_port->sw),
-		path->hops[0].in_port->port,
-		tb_route(path->hops[path->path_length - 1].out_port->sw),
-		path->hops[path->path_length - 1].out_port->port);
+	tb_dbg(path->tb,
+	       "activating path from %llx:%x to %llx:%x\n",
+	       tb_route(path->hops[0].in_port->sw),
+	       path->hops[0].in_port->port,
+	       tb_route(path->hops[path->path_length - 1].out_port->sw),
+	       path->hops[path->path_length - 1].out_port->port);
 
 	/* Clear counters. */
 	for (i = path->path_length - 1; i >= 0; i--) {
@@ -438,8 +438,8 @@ int tb_path_activate(struct tb_path *path)
 					    & out_mask;
 		hop.unknown3 = 0;
 
-		tb_port_info(path->hops[i].in_port, "Writing hop %d, index %d",
-			     i, path->hops[i].in_hop_index);
+		tb_port_dbg(path->hops[i].in_port, "Writing hop %d, index %d",
+			    i, path->hops[i].in_hop_index);
 		tb_dump_hop(path->hops[i].in_port, &hop);
 		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
 				    2 * path->hops[i].in_hop_index, 2);
@@ -450,7 +450,7 @@ int tb_path_activate(struct tb_path *path)
 		}
 	}
 	path->activated = true;
-	tb_info(path->tb, "path activation complete\n");
+	tb_dbg(path->tb, "path activation complete\n");
 	return 0;
 err:
 	tb_WARN(path->tb, "path activation failed\n");
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index f5ebe8bcaeb0..af0ec45129c8 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -500,23 +500,22 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
 		if (state < 0)
 			return state;
 		if (state == TB_PORT_DISABLED) {
-			tb_port_info(port, "is disabled (state: 0)\n");
+			tb_port_dbg(port, "is disabled (state: 0)\n");
 			return 0;
 		}
 		if (state == TB_PORT_UNPLUGGED) {
 			if (wait_if_unplugged) {
 				/* used during resume */
-				tb_port_info(port,
-					     "is unplugged (state: 7), retrying...\n");
+				tb_port_dbg(port,
+					    "is unplugged (state: 7), retrying...\n");
 				msleep(100);
 				continue;
 			}
-			tb_port_info(port, "is unplugged (state: 7)\n");
+			tb_port_dbg(port, "is unplugged (state: 7)\n");
 			return 0;
 		}
 		if (state == TB_PORT_UP) {
-			tb_port_info(port,
-				     "is connected, link is up (state: 2)\n");
+			tb_port_dbg(port, "is connected, link is up (state: 2)\n");
 			return 1;
 		}
 
@@ -524,9 +523,9 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
 		 * After plug-in the state is TB_PORT_CONNECTING. Give it some
 		 * time.
 		 */
-		tb_port_info(port,
-			     "is connected, link is not up (state: %d), retrying...\n",
-			     state);
+		tb_port_dbg(port,
+			    "is connected, link is not up (state: %d), retrying...\n",
+			    state);
 		msleep(100);
 	}
 	tb_port_warn(port,
@@ -592,7 +591,7 @@ int tb_port_set_initial_credits(struct tb_port *port, u32 credits)
 int tb_port_clear_counter(struct tb_port *port, int counter)
 {
 	u32 zero[3] = { 0, 0, 0 };
-	tb_port_info(port, "clearing counter %d\n", counter);
+	tb_port_dbg(port, "clearing counter %d\n", counter);
 	return tb_port_write(port, zero, TB_CFG_COUNTERS, 3 * counter, 3);
 }
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 645798eb0a77..4e0a5d7f4e64 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -514,18 +514,17 @@ static void tb_handle_hotplug(struct work_struct *work)
 		} else if (tb_port_is_dpout(port)) {
 			tb_teardown_dp(tb, port);
 		} else {
-			tb_port_info(port,
-				     "got unplug event for disconnected port, ignoring\n");
+			tb_port_dbg(port,
+				   "got unplug event for disconnected port, ignoring\n");
 		}
 	} else if (port->remote) {
-		tb_port_info(port,
-			     "got plug event for connected port, ignoring\n");
+		tb_port_dbg(port, "got plug event for connected port, ignoring\n");
 	} else {
 		if (tb_port_is_null(port)) {
-			tb_port_info(port, "hotplug: scanning\n");
+			tb_port_dbg(port, "hotplug: scanning\n");
 			tb_scan_port(port);
 			if (!port->remote)
-				tb_port_info(port, "hotplug: no switch found\n");
+				tb_port_dbg(port, "hotplug: no switch found\n");
 		} else if (tb_port_is_dpout(port)) {
 			tb_tunnel_dp(tb, port);
 		}
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index fad18e84d475..fae6defc21d1 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -47,8 +47,8 @@ static const char * const tb_tunnel_names[] = { "PCI", "DP", "DMA" };
 	__TB_TUNNEL_PRINT(tb_WARN, tunnel, fmt, ##arg)
 #define tb_tunnel_warn(tunnel, fmt, arg...) \
 	__TB_TUNNEL_PRINT(tb_warn, tunnel, fmt, ##arg)
-#define tb_tunnel_info(tunnel, fmt, arg...) \
-	__TB_TUNNEL_PRINT(tb_info, tunnel, fmt, ##arg)
+#define tb_tunnel_dbg(tunnel, fmt, arg...) \
+	__TB_TUNNEL_PRINT(tb_dbg, tunnel, fmt, ##arg)
 
 static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths,
 					 enum tb_tunnel_type type)
@@ -610,7 +610,7 @@ int tb_tunnel_restart(struct tb_tunnel *tunnel)
 {
 	int res, i;
 
-	tb_tunnel_info(tunnel, "activating\n");
+	tb_tunnel_dbg(tunnel, "activating\n");
 
 	/* Make sure all paths are properly disabled before enable them again */
 	for (i = 0; i < tunnel->npaths; i++) {
@@ -650,8 +650,6 @@ int tb_tunnel_activate(struct tb_tunnel *tunnel)
 {
 	int i;
 
-	tb_tunnel_info(tunnel, "activating\n");
-
 	for (i = 0; i < tunnel->npaths; i++) {
 		if (tunnel->paths[i]->activated) {
 			tb_tunnel_WARN(tunnel,
@@ -671,7 +669,7 @@ void tb_tunnel_deactivate(struct tb_tunnel *tunnel)
 {
 	int i;
 
-	tb_tunnel_info(tunnel, "deactivating\n");
+	tb_tunnel_dbg(tunnel, "deactivating\n");
 
 	if (tunnel->activate)
 		tunnel->activate(tunnel, false);
-- 
2.20.1

