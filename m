Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D84C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23FF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfBFNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:19:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:26754 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730611AbfBFNRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136336033"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 05:17:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 96F9DA23; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
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
Subject: [PATCH v2 26/28] thunderbolt: Add support for XDomain connections
Date:   Wed,  6 Feb 2019 16:17:36 +0300
Message-Id: <20190206131738.43696-27-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two domains (hosts) can be connected through a Thunderbolt cable and in
that case they can start software services such as networking over the
high-speed DMA paths. Now that we have all the basic building blocks in
place to create DMA tunnels over the Thunderbolt fabric we can add this
support to the software connection manager as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c |  29 ++++++--
 drivers/thunderbolt/tb.c     | 131 ++++++++++++++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index ba7dfce0b96f..79391c3d834e 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1885,6 +1885,17 @@ int tb_switch_resume(struct tb_switch *sw)
 	if (tb_route(sw)) {
 		u64 uid;
 
+		/*
+		 * Check first that we can still read the switch config
+		 * space. It may be that there is now another domain
+		 * connected.
+		 */
+		err = tb_cfg_get_upstream_port(sw->tb->ctl, tb_route(sw));
+		if (err < 0) {
+			tb_sw_info(sw, "switch not present anymore\n");
+			return err;
+		}
+
 		err = tb_drom_read_uid_only(sw, &uid);
 		if (err) {
 			tb_sw_warn(sw, "uid read failed\n");
@@ -1916,13 +1927,23 @@ int tb_switch_resume(struct tb_switch *sw)
 		struct tb_port *port = &sw->ports[i];
 		if (tb_is_upstream_port(port))
 			continue;
-		if (!port->remote)
+
+		if (!port->remote && !port->xdomain)
 			continue;
-		if (tb_wait_for_port(port, true) <= 0
-			|| tb_switch_resume(port->remote->sw)) {
+
+		if (tb_wait_for_port(port, true) <= 0) {
 			tb_port_warn(port,
 				     "lost during suspend, disconnecting\n");
-			tb_sw_set_unplugged(port->remote->sw);
+			if (port->remote)
+				tb_sw_set_unplugged(port->remote->sw);
+			else if (port->xdomain)
+				port->xdomain->is_unplugged = true;
+		} else if (port->remote) {
+			if (tb_switch_resume(port->remote->sw)) {
+				tb_port_warn(port,
+					     "lost during suspend, disconnecting\n");
+				tb_sw_set_unplugged(port->remote->sw);
+			}
 		}
 	}
 	return 0;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 65a206f01941..94dd1fd12967 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -111,6 +111,28 @@ static void tb_switch_authorize(struct work_struct *work)
 	mutex_unlock(&sw->tb->lock);
 }
 
+static void tb_scan_xdomain(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+	struct tb *tb = sw->tb;
+	struct tb_xdomain *xd;
+	u64 route;
+
+	route = tb_downstream_route(port);
+	xd = tb_xdomain_find_by_route(tb, route);
+	if (xd) {
+		tb_xdomain_put(xd);
+		return;
+	}
+
+	xd = tb_xdomain_alloc(tb, &sw->dev, route, tb->root_switch->uuid,
+			      NULL);
+	if (xd) {
+		tb_port_at(route, sw)->xdomain = xd;
+		tb_xdomain_add(xd);
+	}
+}
+
 static void tb_scan_port(struct tb_port *port);
 
 /**
@@ -150,19 +172,36 @@ static void tb_scan_port(struct tb_port *port)
 	if (tb_wait_for_port(port, false) <= 0)
 		return;
 	if (port->remote) {
-		tb_port_WARN(port, "port already has a remote!\n");
+		tb_port_dbg(port, "port already has a remote\n");
 		return;
 	}
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
-	if (IS_ERR(sw))
+	if (IS_ERR(sw)) {
+		/*
+		 * If there is an error accessing the connected switch
+		 * it may be connected to another domain. Also we allow
+		 * the other domain to be connected to a max depth switch.
+		 */
+		if (PTR_ERR(sw) == -EIO || PTR_ERR(sw) == -EADDRNOTAVAIL)
+			tb_scan_xdomain(port);
 		return;
+	}
 
 	if (tb_switch_configure(sw)) {
 		tb_switch_put(sw);
 		return;
 	}
 
+	/*
+	 * If there was previously another domain connected remove it
+	 * first.
+	 */
+	if (port->xdomain) {
+		tb_xdomain_remove(port->xdomain);
+		port->xdomain = NULL;
+	}
+
 	/*
 	 * Do not send uevents until we have discovered all existing
 	 * tunnels and know which switches were authorized already by
@@ -377,6 +416,51 @@ static int tb_approve_switch(struct tb *tb, struct tb_switch *sw)
 	return tb_tunnel_pci(tb, sw);
 }
 
+static int tb_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	struct tb_cm *tcm = tb_priv(tb);
+	struct tb_port *nhi_port, *dst_port;
+	struct tb_tunnel *tunnel;
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	dst_port = tb_port_at(xd->route, sw);
+	nhi_port = tb_find_port(tb->root_switch, TB_TYPE_NHI);
+
+	tunnel = tb_tunnel_alloc_dma(tb, nhi_port, dst_port, xd->transmit_ring,
+				     xd->transmit_path, xd->receive_ring,
+				     xd->receive_path);
+	if (!tunnel)
+		return -ENOMEM;
+
+	if (tb_tunnel_activate(tunnel)) {
+		tb_port_info(nhi_port,
+			     "DMA tunnel activation failed, aborting\n");
+		tb_tunnel_free(tunnel);
+		return -EIO;
+	}
+	list_add_tail(&tunnel->list, &tcm->tunnel_list);
+
+	return 0;
+}
+
+static int tb_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	struct tb_port *dst_port;
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	dst_port = tb_port_at(xd->route, sw);
+
+	/*
+	 * It is possible that the tunnel was already teared down (in
+	 * case of cable disconnect) so it is fine if we cannot find it
+	 * here anymore.
+	 */
+	tb_free_tunnel(tb, TB_TUNNEL_DMA, NULL, dst_port);
+	return 0;
+}
+
 /* hotplug handling */
 
 /**
@@ -417,12 +501,16 @@ static void tb_handle_hotplug(struct work_struct *work)
 	}
 	if (ev->unplug) {
 		if (port->remote) {
-			tb_port_info(port, "unplugged\n");
+			tb_port_dbg(port, "switch unplugged\n");
 			tb_sw_set_unplugged(port->remote->sw);
 			tb_free_invalid_tunnels(tb);
 			cancel_work_sync(&sw->work);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
+		} else if (port->xdomain) {
+			tb_port_dbg(port, "xdomain unplugged\n");
+			tb_xdomain_remove(port->xdomain);
+			port->xdomain = NULL;
 		} else if (tb_port_is_dpout(port)) {
 			tb_teardown_dp(tb, port);
 		} else {
@@ -594,13 +682,50 @@ static int tb_resume_noirq(struct tb *tb)
 	return 0;
 }
 
+static int tb_free_unplugged_xdomains(struct tb_switch *sw)
+{
+	int i, ret = 0;
+
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		struct tb_port *port = &sw->ports[i];
+
+		if (tb_is_upstream_port(port))
+			continue;
+		if (port->xdomain && port->xdomain->is_unplugged) {
+			tb_xdomain_remove(port->xdomain);
+			port->xdomain = NULL;
+			ret++;
+		} else if (port->remote) {
+			ret += tb_free_unplugged_xdomains(port->remote->sw);
+		}
+	}
+
+	return ret;
+}
+
+static void tb_complete(struct tb *tb)
+{
+	/*
+	 * Release any unplugged XDomains and if there is a case where
+	 * another domain is swapped in place of unplugged XDomain we
+	 * need to run another rescan.
+	 */
+	mutex_lock(&tb->lock);
+	if (tb_free_unplugged_xdomains(tb->root_switch))
+		tb_scan_switch(tb->root_switch);
+	mutex_unlock(&tb->lock);
+}
+
 static const struct tb_cm_ops tb_cm_ops = {
 	.start = tb_start,
 	.stop = tb_stop,
 	.suspend_noirq = tb_suspend_noirq,
 	.resume_noirq = tb_resume_noirq,
+	.complete = tb_complete,
 	.handle_event = tb_handle_event,
 	.approve_switch = tb_approve_switch,
+	.approve_xdomain_paths = tb_approve_xdomain_paths,
+	.disconnect_xdomain_paths = tb_disconnect_xdomain_paths,
 };
 
 struct tb *tb_probe(struct tb_nhi *nhi)
-- 
2.20.1

