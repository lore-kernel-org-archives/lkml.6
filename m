Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47895C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C761218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfBFNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:17:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:26743 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfBFNRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="120384281"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2019 05:17:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9B7EF10E; Wed,  6 Feb 2019 15:17:38 +0200 (EET)
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
Subject: [PATCH v2 02/28] thunderbolt: Do not allocate switch if depth is greater than 6
Date:   Wed,  6 Feb 2019 16:17:12 +0300
Message-Id: <20190206131738.43696-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maximum depth in Thunderbolt topology is 6 so make sure it is not
possible to allocate switches that exceed the depth limit.

While at it update tb_switch_alloc() to use upper/lower_32_bits()
following tb_switch_alloc_safe_mode().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c    |  5 ++---
 drivers/thunderbolt/switch.c | 18 ++++++++++++------
 drivers/thunderbolt/tb.h     |  1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e3fc920af682..041e7ab0efd3 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -42,7 +42,6 @@
 #define ICM_TIMEOUT			5000	/* ms */
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
-#define ICM_MAX_DEPTH			6
 
 /**
  * struct icm - Internal connection manager private data
@@ -709,7 +708,7 @@ icm_fr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
 
-	if (link > ICM_MAX_LINK || depth > ICM_MAX_DEPTH) {
+	if (link > ICM_MAX_LINK || depth > TB_SWITCH_MAX_DEPTH) {
 		tb_warn(tb, "invalid topology %u.%u, ignoring\n", link, depth);
 		return;
 	}
@@ -739,7 +738,7 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
 
-	if (link > ICM_MAX_LINK || depth > ICM_MAX_DEPTH) {
+	if (link > ICM_MAX_LINK || depth > TB_SWITCH_MAX_DEPTH) {
 		tb_warn(tb, "invalid topology %u.%u, ignoring\n", link, depth);
 		return;
 	}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index cd96994dc094..a90d21abed88 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1155,10 +1155,16 @@ static int tb_switch_get_generation(struct tb_switch *sw)
 struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 				  u64 route)
 {
-	int i;
-	int cap;
 	struct tb_switch *sw;
-	int upstream_port = tb_cfg_get_upstream_port(tb->ctl, route);
+	int upstream_port;
+	int i, cap, depth;
+
+	/* Make sure we do not exceed maximum topology limit */
+	depth = tb_route_length(route);
+	if (depth > TB_SWITCH_MAX_DEPTH)
+		return NULL;
+
+	upstream_port = tb_cfg_get_upstream_port(tb->ctl, route);
 	if (upstream_port < 0)
 		return NULL;
 
@@ -1175,9 +1181,9 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 
 	/* configure switch */
 	sw->config.upstream_port_number = upstream_port;
-	sw->config.depth = tb_route_length(route);
-	sw->config.route_lo = route;
-	sw->config.route_hi = route >> 32;
+	sw->config.depth = depth;
+	sw->config.route_hi = upper_32_bits(route);
+	sw->config.route_lo = lower_32_bits(route);
 	sw->config.enabled = 0;
 
 	/* initialize ports */
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 52584c4003e3..5faec5a8eb98 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -43,6 +43,7 @@ struct tb_switch_nvm {
 };
 
 #define TB_SWITCH_KEY_SIZE		32
+#define TB_SWITCH_MAX_DEPTH		6
 
 /**
  * struct tb_switch - a thunderbolt switch
-- 
2.20.1

