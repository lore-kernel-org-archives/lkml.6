Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0081020844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfBFNWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:22:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:26743 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfBFNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136336017"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 05:17:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D6D4A43A; Wed,  6 Feb 2019 15:17:38 +0200 (EET)
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
Subject: [PATCH v2 08/28] thunderbolt: Properly disable path
Date:   Wed,  6 Feb 2019 16:17:18 +0300
Message-Id: <20190206131738.43696-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to wait until all buffers have been drained before the path can
be considered disabled. Do this for every hop in a path. Also if the
switch is physically disconnected, do not bother disabling it anymore
(it is not present anyway).

This adds another bit field to struct tb_regs_hop even if we are trying
to get rid of them but we can clean them up another day.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/path.c    | 44 ++++++++++++++++++++++++++++++++---
 drivers/thunderbolt/tb_regs.h |  3 ++-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index a11956522bac..48cb15ff4446 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -7,6 +7,8 @@
 
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
 
 #include "tb.h"
 
@@ -74,13 +76,49 @@ static void __tb_path_deallocate_nfc(struct tb_path *path, int first_hop)
 	}
 }
 
+static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index)
+{
+	struct tb_regs_hop hop;
+	ktime_t timeout;
+	int ret;
+
+	if (port->sw->is_unplugged)
+		return 0;
+
+	/* Disable the path */
+	ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hop_index, 2);
+	if (ret)
+		return ret;
+
+	hop.enable = 0;
+
+	ret = tb_port_write(port, &hop, TB_CFG_HOPS, 2 * hop_index, 2);
+	if (ret)
+		return ret;
+
+	/* Wait until it is drained */
+	timeout = ktime_add_ms(ktime_get(), 500);
+	do {
+		ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hop_index, 2);
+		if (ret)
+			return ret;
+
+		if (!hop.pending)
+			return 0;
+
+		usleep_range(10, 20);
+	} while (ktime_before(ktime_get(), timeout));
+
+	return -ETIMEDOUT;
+}
+
 static void __tb_path_deactivate_hops(struct tb_path *path, int first_hop)
 {
 	int i, res;
-	struct tb_regs_hop hop = { };
+
 	for (i = first_hop; i < path->path_length; i++) {
-		res = tb_port_write(path->hops[i].in_port, &hop, TB_CFG_HOPS,
-				    2 * path->hops[i].in_hop_index, 2);
+		res = __tb_path_deactivate_hop(path->hops[i].in_port,
+					       path->hops[i].in_hop_index);
 		if (res)
 			tb_port_warn(path->hops[i].in_port,
 				     "hop deactivation failed for hop %d, index %d\n",
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 1ab6e0fb31c0..82ac4ec8757f 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -234,7 +234,8 @@ struct tb_regs_hop {
 	bool egress_fc:1;
 	bool ingress_shared_buffer:1;
 	bool egress_shared_buffer:1;
-	u32 unknown3:4; /* set to zero */
+	bool pending:1;
+	u32 unknown3:3; /* set to zero */
 } __packed;
 
 /* Common link controller registers */
-- 
2.20.1

