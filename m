Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66C5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE5120844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfBFNVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:21:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:28027 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbfBFNRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="318109338"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2019 05:17:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0D5136AD; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
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
Subject: [PATCH v2 13/28] thunderbolt: Add helper function to iterate from one port to another
Date:   Wed,  6 Feb 2019 16:17:23 +0300
Message-Id: <20190206131738.43696-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to be able to walk from one port to another when we are creating
paths where there are multiple switches between two ports. For this
reason introduce a new function tb_port_get_next() and a new macro
tb_for_each_port().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 60 ++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h     |  6 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 320f64ebe8b8..23b6bae8362e 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -683,6 +683,66 @@ void tb_port_release_out_hopid(struct tb_port *port, int hopid)
 	ida_simple_remove(&port->out_hopids, hopid);
 }
 
+/**
+ * tb_port_get_next() - Return next port for given port
+ * @start: Start port of the walk
+ * @end: End port of the walk
+ * @prev: Previous port (%NULL if this is the first)
+ *
+ * This function can be used to walk from one port to another if they
+ * are connected through zero or more switches. If the @prev is dual
+ * link port, the function follows that link and returns another end on
+ * that same link.
+ *
+ * If the walk cannot be continued, returns %NULL.
+ *
+ * Domain tb->lock must be held when this function is called.
+ */
+struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
+				 struct tb_port *prev)
+{
+	struct tb_port *port, *next;
+
+	if (!prev)
+		return start;
+
+	if (prev->sw == end->sw) {
+		if (prev != end)
+			return end;
+		return NULL;
+	}
+
+	/* Switch back to use primary links for walking */
+	if (prev->dual_link_port && prev->link_nr)
+		port = prev->dual_link_port;
+	else
+		port = prev;
+
+	if (start->sw->config.depth < end->sw->config.depth) {
+		if (port->remote &&
+		    port->remote->sw->config.depth > port->sw->config.depth)
+			next = port->remote;
+		else
+			next = tb_port_at(tb_route(end->sw), port->sw);
+	} else if (start->sw->config.depth > end->sw->config.depth) {
+		if (tb_is_upstream_port(port))
+			next = port->remote;
+		else
+			next = tb_upstream_port(port->sw);
+	} else {
+		/* Must be the same switch then */
+		if (start->sw != end->sw)
+			return NULL;
+		return end;
+	}
+
+	/* If prev was dual link return another end of that link then */
+	if (next->dual_link_port && next->link_nr != prev->link_nr)
+		return next->dual_link_port;
+
+	return next;
+}
+
 /**
  * tb_pci_port_enable() - Enable PCIe adapter port
  * @port: PCIe port to enable
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index bfa1cee193fd..683725915ff7 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -447,6 +447,12 @@ int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_in_hopid(struct tb_port *port, int hopid);
 int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_out_hopid(struct tb_port *port, int hopid);
+struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
+				 struct tb_port *prev);
+
+#define tb_for_each_port(port, start, end)			\
+	for (port = tb_port_get_next(start, end, NULL); port;	\
+	     port = tb_port_get_next(start, end, port))
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap);
-- 
2.20.1

