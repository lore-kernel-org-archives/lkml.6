Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140CCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A81218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfBFNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:21:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:26750 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbfBFNRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136336022"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 05:17:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DE0984ED; Wed,  6 Feb 2019 15:17:38 +0200 (EET)
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
Subject: [PATCH v2 09/28] thunderbolt: Cache adapter specific capability offset into struct port
Date:   Wed,  6 Feb 2019 16:17:19 +0300
Message-Id: <20190206131738.43696-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adapter specific capability either is there or not if the port does
not hold an adapter. Instead of always finding it on-demand we read the
offset just once when the port is initialized.

While there we update the struct port documentation to follow kernel-doc
format.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c     | 4 ++++
 drivers/thunderbolt/tb.c         | 8 ++++----
 drivers/thunderbolt/tb.h         | 2 ++
 drivers/thunderbolt/tunnel_pci.c | 9 +++------
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 1eee2502b5ba..ec3c274ff278 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -593,6 +593,10 @@ static int tb_init_port(struct tb_port *port)
 			port->cap_phy = cap;
 		else
 			tb_port_WARN(port, "non switch port without a PHY\n");
+	} else if (port->port != 0) {
+		cap = tb_port_find_cap(port, TB_PORT_CAP_ADAP);
+		if (cap > 0)
+			port->cap_adap = cap;
 	}
 
 	tb_dump_port(port->sw->tb, &port->config);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 30e02c716f6c..7fd88b41d082 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -151,8 +151,8 @@ static struct tb_port *tb_find_unused_down_port(struct tb_switch *sw)
 			continue;
 		if (sw->ports[i].config.type != TB_TYPE_PCIE_DOWN)
 			continue;
-		cap = tb_port_find_cap(&sw->ports[i], TB_PORT_CAP_ADAP);
-		if (cap < 0)
+		cap = sw->ports[i].cap_adap;
+		if (!cap)
 			continue;
 		res = tb_port_read(&sw->ports[i], &data, TB_CFG_PORT, cap, 1);
 		if (res < 0)
@@ -197,8 +197,8 @@ static void tb_activate_pcie_devices(struct tb *tb)
 		}
 
 		/* check whether port is already activated */
-		cap = tb_port_find_cap(up_port, TB_PORT_CAP_ADAP);
-		if (cap < 0)
+		cap = up_port->cap_adap;
+		if (!cap)
 			continue;
 		if (tb_port_read(up_port, &data, TB_CFG_PORT, cap, 1))
 			continue;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 3160169389cc..bab451ab31ff 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -124,6 +124,7 @@ struct tb_switch {
  * @remote: Remote port (%NULL if not connected)
  * @xdomain: Remote host (%NULL if not connected)
  * @cap_phy: Offset, zero if not found
+ * @cap_adap: Offset of the adapter specific capability (%0 if not present)
  * @port: Port number on switch
  * @disabled: Disabled by eeprom
  * @dual_link_port: If the switch is connected using two ports, points
@@ -136,6 +137,7 @@ struct tb_port {
 	struct tb_port *remote;
 	struct tb_xdomain *xdomain;
 	int cap_phy;
+	int cap_adap;
 	u8 port;
 	bool disabled;
 	struct tb_port *dual_link_port;
diff --git a/drivers/thunderbolt/tunnel_pci.c b/drivers/thunderbolt/tunnel_pci.c
index 0637537ea53f..2de4edccbd6d 100644
--- a/drivers/thunderbolt/tunnel_pci.c
+++ b/drivers/thunderbolt/tunnel_pci.c
@@ -148,12 +148,9 @@ bool tb_pci_is_invalid(struct tb_pci_tunnel *tunnel)
 static int tb_pci_port_active(struct tb_port *port, bool active)
 {
 	u32 word = active ? 0x80000000 : 0x0;
-	int cap = tb_port_find_cap(port, TB_PORT_CAP_ADAP);
-	if (cap < 0) {
-		tb_port_warn(port, "TB_PORT_CAP_ADAP not found: %d\n", cap);
-		return cap;
-	}
-	return tb_port_write(port, &word, TB_CFG_PORT, cap, 1);
+	if (!port->cap_adap)
+		return -ENXIO;
+	return tb_port_write(port, &word, TB_CFG_PORT, port->cap_adap, 1);
 }
 
 /**
-- 
2.20.1

