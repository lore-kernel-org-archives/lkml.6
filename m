Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B812175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfA2PFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:05:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:51758 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfA2PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="295379818"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2019 07:01:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BDB117A8; Tue, 29 Jan 2019 17:01:44 +0200 (EET)
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
Subject: [PATCH 12/28] thunderbolt: Add functions for allocating and releasing hop IDs
Date:   Tue, 29 Jan 2019 18:01:27 +0300
Message-Id: <20190129150143.12681-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each port has a separate path configuration space that is used for
finding the next hop (switch) in the path. Hop ID is an index to this
configuration space and hop IDs 0 - 7 are reserved.

In order to get next available hop ID for each direction we provide two
pairs of helper functions that can be used to allocate and release hop
IDs for a given port.

While there remove obsolete TODO comment.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 87 +++++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tb.h     |  8 ++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 93b26c901637..ae366c252c74 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -601,11 +601,88 @@ static int tb_init_port(struct tb_port *port)
 
 	tb_dump_port(port->sw->tb, &port->config);
 
-	/* TODO: Read dual link port, DP port and more from EEPROM. */
+	/* Control port does not need Hop ID allocation */
+	if (port->port) {
+		ida_init(&port->in_hopids);
+		ida_init(&port->out_hopids);
+	}
+
 	return 0;
 
 }
 
+static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
+			       int max_hopid)
+{
+	int port_max_hopid;
+	struct ida *ida;
+
+	if (in) {
+		port_max_hopid = port->config.max_in_hop_id;
+		ida = &port->in_hopids;
+	} else {
+		port_max_hopid = port->config.max_out_hop_id;
+		ida = &port->out_hopids;
+	}
+
+	/* Hop IDs 0-7 are reserved */
+	if (min_hopid < 8)
+		min_hopid = 8;
+
+	if (max_hopid < 0 || max_hopid > port_max_hopid)
+		max_hopid = port_max_hopid;
+
+	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
+}
+
+/**
+ * tb_port_alloc_in_hopid() - Allocate input hop ID from port
+ * @port: Port to allocate hop ID for
+ * @min_hopid: Minimum acceptable input hop ID
+ * @max_hopid: Maximum acceptable input hop ID
+ *
+ * Return: Hop ID between @min_hopid and @max_hopid or negative errno in
+ * case of error.
+ */
+int tb_port_alloc_in_hopid(struct tb_port *port, int min_hopid, int max_hopid)
+{
+	return tb_port_alloc_hopid(port, true, min_hopid, max_hopid);
+}
+
+/**
+ * tb_port_alloc_out_hopid() - Allocate output hop ID from port
+ * @port: Port to allocate hop ID for
+ * @min_hopid: Minimum acceptable output hop ID
+ * @max_hopid: Maximum acceptable output hop ID
+ *
+ * Return: Hop ID between @min_hopid and @max_hopid or negative errno in
+ * case of error.
+ */
+int tb_port_alloc_out_hopid(struct tb_port *port, int min_hopid, int max_hopid)
+{
+	return tb_port_alloc_hopid(port, false, min_hopid, max_hopid);
+}
+
+/**
+ * tb_port_release_in_hopid() - Release allocated input hop ID from port
+ * @port: Port whose hop ID to release
+ * @hopid: Hop ID to release
+ */
+void tb_port_release_in_hopid(struct tb_port *port, int hopid)
+{
+	ida_simple_remove(&port->in_hopids, hopid);
+}
+
+/**
+ * tb_port_release_out_hopid() - Release allocated output hop ID from port
+ * @port: Port whose hop ID to release
+ * @hopid: Hop ID to release
+ */
+void tb_port_release_out_hopid(struct tb_port *port, int hopid)
+{
+	ida_simple_remove(&port->out_hopids, hopid);
+}
+
 /**
  * tb_pci_port_enable() - Enable PCIe adapter port
  * @port: PCIe port to enable
@@ -1080,9 +1157,17 @@ static const struct attribute_group *switch_groups[] = {
 static void tb_switch_release(struct device *dev)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
+	int i;
 
 	dma_port_free(sw->dma_port);
 
+	for (i = 1; i <= sw->config.max_port_number; i++) {
+		if (!sw->ports[i].disabled) {
+			ida_destroy(&sw->ports[i].in_hopids);
+			ida_destroy(&sw->ports[i].out_hopids);
+		}
+	}
+
 	kfree(sw->uuid);
 	kfree(sw->device_name);
 	kfree(sw->vendor_name);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index ca7e78190920..a4f835c4bdc2 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -131,6 +131,8 @@ struct tb_switch {
  * @dual_link_port: If the switch is connected using two ports, points
  *		    to the other port.
  * @link_nr: Is this primary or secondary port on the dual_link.
+ * @in_hopids: Currently allocated input hopids
+ * @out_hopids: Currently allocated output hopids
  */
 struct tb_port {
 	struct tb_regs_port_header config;
@@ -143,6 +145,8 @@ struct tb_port {
 	bool disabled;
 	struct tb_port *dual_link_port;
 	u8 link_nr:1;
+	struct ida in_hopids;
+	struct ida out_hopids;
 };
 
 /**
@@ -440,6 +444,10 @@ static inline struct tb_switch *tb_to_switch(struct device *dev)
 int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged);
 int tb_port_add_nfc_credits(struct tb_port *port, int credits);
 int tb_port_clear_counter(struct tb_port *port, int counter);
+int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
+void tb_port_release_in_hopid(struct tb_port *port, int hopid);
+int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
+void tb_port_release_out_hopid(struct tb_port *port, int hopid);
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
-- 
2.20.1

