Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F1C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAC72175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfA2PEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:04:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:3065 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfA2PBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="110723799"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Jan 2019 07:01:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 213D6A4F; Tue, 29 Jan 2019 17:01:45 +0200 (EET)
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
Subject: [PATCH 19/28] thunderbolt: Generalize port finding routines to support all port types
Date:   Tue, 29 Jan 2019 18:01:34 +0300
Message-Id: <20190129150143.12681-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
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
index c1bab1bc7150..de69ada9a2f7 100644
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
index 1dcdf619d0f1..0df1d96e46f5 100644
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
-		if (cap < 0)
+		if (sw->ports[i].config.type != type)
 			continue;
-		res = tb_port_read(&sw->ports[i], &data, TB_CFG_PORT, cap, 1);
-		if (res < 0)
+		if (sw->ports[i].cap_adap < 0)
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
index b3a422ab4b4e..bf5bc0fb0f8e 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -463,6 +463,7 @@ struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
+bool tb_port_is_enabled(struct tb_port *port);
 
 bool tb_pci_port_is_enabled(struct tb_port *port);
 int tb_pci_port_enable(struct tb_port *port, bool enable);
-- 
2.20.1

