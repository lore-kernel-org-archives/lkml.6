Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325B120844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfBFNTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:19:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:45127 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfBFNRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="131998014"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2019 05:17:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 41D0B85B; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
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
Subject: [PATCH v2 18/28] thunderbolt: Scan only valid NULL adapter ports in hotplug
Date:   Wed,  6 Feb 2019 16:17:28 +0300
Message-Id: <20190206131738.43696-19-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only way to expand Thunderbolt topology is through the NULL adapter
ports (typically ports 1, 2, 3 and 4). There is no point handling
Thunderbolt hotplug events on any other port.

Add a helper function (tb_port_is_null()) that can be used to determine
if the port is NULL port, and use it in software connection manager code
when hotplug event is handled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 10 ++++++----
 drivers/thunderbolt/tb.h |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index f2b23b290b63..a450bebfeb92 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -344,10 +344,12 @@ static void tb_handle_hotplug(struct work_struct *work)
 		tb_port_info(port,
 			     "got plug event for connected port, ignoring\n");
 	} else {
-		tb_port_info(port, "hotplug: scanning\n");
-		tb_scan_port(port);
-		if (!port->remote)
-			tb_port_info(port, "hotplug: no switch found\n");
+		if (tb_port_is_null(port)) {
+			tb_port_info(port, "hotplug: scanning\n");
+			tb_scan_port(port);
+			if (!port->remote)
+				tb_port_info(port, "hotplug: no switch found\n");
+		}
 	}
 out:
 	mutex_unlock(&tb->lock);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5a0b831a37ad..8906ee0a8a6a 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -286,6 +286,11 @@ static inline struct tb_port *tb_port_at(u64 route, struct tb_switch *sw)
 	return &sw->ports[port];
 }
 
+static inline bool tb_port_is_null(const struct tb_port *port)
+{
+	return port->port && port->config.type == TB_TYPE_PORT;
+}
+
 static inline int tb_sw_read(struct tb_switch *sw, void *buffer,
 			     enum tb_cfg_space space, u32 offset, u32 length)
 {
-- 
2.20.1

