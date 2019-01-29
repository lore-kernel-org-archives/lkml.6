Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27805C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC19E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfA2PCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:02:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:8099 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbfA2PCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:02:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="122266167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2019 07:01:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6098DD22; Tue, 29 Jan 2019 17:01:45 +0200 (EET)
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
Subject: [PATCH 25/28] thunderbolt: Make tb_switch_alloc() return ERR_PTR()
Date:   Tue, 29 Jan 2019 18:01:40 +0300
Message-Id: <20190129150143.12681-26-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to detect possible connections to other domains we need to be
able to find out why tb_switch_alloc() fails so make it return ERR_PTR()
instead. This allows the caller to differentiate between errors such as
-ENOMEM which comes from the kernel and for instance -EIO which comes
from the hardware when trying to access the possible switch.

Convert all the current call sites to handle this properly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c    |  6 +++---
 drivers/thunderbolt/switch.c | 36 ++++++++++++++++++++----------------
 drivers/thunderbolt/tb.c     |  6 +++---
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 041e7ab0efd3..e28a4255d56a 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -468,7 +468,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	pm_runtime_get_sync(&parent_sw->dev);
 
 	sw = tb_switch_alloc(parent_sw->tb, &parent_sw->dev, route);
-	if (!sw)
+	if (IS_ERR(sw))
 		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
@@ -1852,8 +1852,8 @@ static int icm_start(struct tb *tb)
 		tb->root_switch = tb_switch_alloc_safe_mode(tb, &tb->dev, 0);
 	else
 		tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
-	if (!tb->root_switch)
-		return -ENODEV;
+	if (IS_ERR(tb->root_switch))
+		return PTR_ERR(tb->root_switch);
 
 	/*
 	 * NVM upgrade has not been tested on Apple systems and they
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index bcf8b447facb..e10bae4a770c 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1481,30 +1481,32 @@ static int tb_switch_get_generation(struct tb_switch *sw)
  * separately. The returned switch should be released by calling
  * tb_switch_put().
  *
- * Return: Pointer to the allocated switch or %NULL in case of failure
+ * Return: Pointer to the allocated switch or ERR_PTR() in case of
+ * failure.
  */
 struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 				  u64 route)
 {
 	struct tb_switch *sw;
 	int upstream_port;
-	int i, cap, depth;
+	int i, ret, depth;
 
 	/* Make sure we do not exceed maximum topology limit */
 	depth = tb_route_length(route);
 	if (depth > TB_SWITCH_MAX_DEPTH)
-		return NULL;
+		return ERR_PTR(-EADDRNOTAVAIL);
 
 	upstream_port = tb_cfg_get_upstream_port(tb->ctl, route);
 	if (upstream_port < 0)
-		return NULL;
+		return ERR_PTR(upstream_port);
 
 	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
 	if (!sw)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sw->tb = tb;
-	if (tb_cfg_read(tb->ctl, &sw->config, route, 0, TB_CFG_SWITCH, 0, 5))
+	ret = tb_cfg_read(tb->ctl, &sw->config, route, 0, TB_CFG_SWITCH, 0, 5);
+	if (ret)
 		goto err_free_sw_ports;
 
 	tb_dbg(tb, "current switch config:\n");
@@ -1520,8 +1522,10 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	/* initialize ports */
 	sw->ports = kcalloc(sw->config.max_port_number + 1, sizeof(*sw->ports),
 				GFP_KERNEL);
-	if (!sw->ports)
+	if (!sw->ports) {
+		ret = -ENOMEM;
 		goto err_free_sw_ports;
+	}
 
 	for (i = 0; i <= sw->config.max_port_number; i++) {
 		/* minimum setup for tb_find_cap and tb_drom_read to work */
@@ -1531,16 +1535,16 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 
 	sw->generation = tb_switch_get_generation(sw);
 
-	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_PLUG_EVENTS);
-	if (cap < 0) {
+	ret = tb_switch_find_vse_cap(sw, TB_VSE_CAP_PLUG_EVENTS);
+	if (ret < 0) {
 		tb_sw_warn(sw, "cannot find TB_VSE_CAP_PLUG_EVENTS aborting\n");
 		goto err_free_sw_ports;
 	}
-	sw->cap_plug_events = cap;
+	sw->cap_plug_events = ret;
 
-	cap = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
-	if (cap > 0)
-		sw->cap_lc = cap;
+	ret = tb_switch_find_vse_cap(sw, TB_VSE_CAP_LINK_CONTROLLER);
+	if (ret > 0)
+		sw->cap_lc = ret;
 
 	/* Root switch is always authorized */
 	if (!route)
@@ -1559,7 +1563,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	kfree(sw->ports);
 	kfree(sw);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /**
@@ -1574,7 +1578,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
  *
  * The returned switch must be released by calling tb_switch_put().
  *
- * Return: Pointer to the allocated switch or %NULL in case of failure
+ * Return: Pointer to the allocated switch or ERR_PTR() in case of failure
  */
 struct tb_switch *
 tb_switch_alloc_safe_mode(struct tb *tb, struct device *parent, u64 route)
@@ -1583,7 +1587,7 @@ tb_switch_alloc_safe_mode(struct tb *tb, struct device *parent, u64 route)
 
 	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
 	if (!sw)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sw->tb = tb;
 	sw->config.depth = tb_route_length(route);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 56bbd1237bd9..4eb74254116c 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -155,7 +155,7 @@ static void tb_scan_port(struct tb_port *port)
 	}
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
-	if (!sw)
+	if (IS_ERR(sw))
 		return;
 
 	if (tb_switch_configure(sw)) {
@@ -516,8 +516,8 @@ static int tb_start(struct tb *tb)
 	int ret;
 
 	tb->root_switch = tb_switch_alloc(tb, &tb->dev, 0);
-	if (!tb->root_switch)
-		return -ENOMEM;
+	if (IS_ERR(tb->root_switch))
+		return PTR_ERR(tb->root_switch);
 
 	/*
 	 * ICM firmware upgrade needs running firmware and in native
-- 
2.20.1

