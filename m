Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CD420844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfBFNTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:19:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:45138 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbfBFNRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="131998016"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2019 05:17:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4C454884; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
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
Subject: [PATCH v2 19/28] thunderbolt: Generalize port finding routines to support all port types
Date:   Wed,  6 Feb 2019 16:17:29 +0300
Message-Id: <20190206131738.43696-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be needing these routines to find Display Port adapters as well
so modify them to take port type as the second parameter.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 16 ++++++++++++++++
 drivers/thunderbolt/tb.c     | 35 +++++++++++++++++------------------
 drivers/thunderbolt/tb.h     |  1 +
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c6cb6c44a571..29bf9119e0ae 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -743,6 +743,22 @@ struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
 	return next;
 }
 
+/**
+ * tb_port_is_enabled() - Is the adapter port enabled
+ * @port: Port to check
+ */
+bool tb_port_is_enabled(struct tb_port *port)
+{
+	switch (port->config.type) {
+	case TB_TYPE_PCIE_UP:
+	case TB_TYPE_PCIE_DOWN:
+		return tb_pci_port_is_enabled(port);
+
+	default:
+		return false;
+	}
+}
+
 /**
  * tb_pci_port_is_enabled() - Is the PCIe adapter port enabled
  * @port: PCIe port to check
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index a450bebfeb92..98c993259759 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -188,40 +188,39 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 	}
 }
 
-
 /**
- * find_pci_up_port() - return the first PCIe up port on @sw or NULL
+ * tb_find_port() - return the first port of @type on @sw or NULL
+ * @sw: Switch to find the port from
+ * @type: Port type to look for
  */
-static struct tb_port *tb_find_pci_up_port(struct tb_switch *sw)
+static struct tb_port *tb_find_port(struct tb_switch *sw,
+				    enum tb_port_type type)
 {
 	int i;
 	for (i = 1; i <= sw->config.max_port_number; i++)
-		if (sw->ports[i].config.type == TB_TYPE_PCIE_UP)
+		if (sw->ports[i].config.type == type)
 			return &sw->ports[i];
 	return NULL;
 }
 
 /**
- * find_unused_down_port() - return the first inactive PCIe down port on @sw
+ * tb_find_unused_port() - return the first inactive port on @sw
+ * @sw: Switch to find the port on
+ * @type: Port type to look for
  */
-static struct tb_port *tb_find_unused_down_port(struct tb_switch *sw)
+static struct tb_port *tb_find_unused_port(struct tb_switch *sw,
+					   enum tb_port_type type)
 {
 	int i;
-	int cap;
-	int res;
-	int data;
+
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		if (tb_is_upstream_port(&sw->ports[i]))
 			continue;
-		if (sw->ports[i].config.type != TB_TYPE_PCIE_DOWN)
-			continue;
-		cap = sw->ports[i].cap_adap;
-		if (!cap)
+		if (sw->ports[i].config.type != type)
 			continue;
-		res = tb_port_read(&sw->ports[i], &data, TB_CFG_PORT, cap, 1);
-		if (res < 0)
+		if (!sw->ports[i].cap_adap)
 			continue;
-		if (data & 0x80000000)
+		if (tb_port_is_enabled(&sw->ports[i]))
 			continue;
 		return &sw->ports[i];
 	}
@@ -235,7 +234,7 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 	struct tb_port *up, *down;
 	struct tb_tunnel *tunnel;
 
-	up = tb_find_pci_up_port(sw);
+	up = tb_find_port(sw, TB_TYPE_PCIE_UP);
 	if (!up)
 		return 0;
 
@@ -246,7 +245,7 @@ static int tb_tunnel_pci(struct tb *tb, struct tb_switch *sw)
 	down = NULL;
 	parent_sw = tb_to_switch(sw->dev.parent);
 	while (parent_sw) {
-		down = tb_find_unused_down_port(parent_sw);
+		down = tb_find_unused_port(parent_sw, TB_TYPE_PCIE_DOWN);
 		if (down)
 			break;
 		parent_sw = tb_to_switch(parent_sw->dev.parent);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 8906ee0a8a6a..d16a67898a34 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -462,6 +462,7 @@ struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
+bool tb_port_is_enabled(struct tb_port *port);
 
 bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
-- 
2.20.1

