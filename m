Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2740C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B502420852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B502420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936092AbeFRLHi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:07:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:37633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933537AbeFRLHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 04:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="65472672"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2018 04:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8BC09182; Mon, 18 Jun 2018 14:07:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/5] thunderbolt: Do not unnecessarily call ICM get route
Date:   Mon, 18 Jun 2018 14:07:28 +0300
Message-Id: <20180618110731.57427-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This command is not really fast and can make resume time slower. We only
need to get route again if the link was changed and during initial
device connected message.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 500911f16498..ad4eeaa59b16 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -534,20 +534,13 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	ret = icm->get_route(tb, link, depth, &route);
-	if (ret) {
-		tb_err(tb, "failed to find route string for switch at %u.%u\n",
-		       link, depth);
-		return;
-	}
-
 	sw = tb_switch_find_by_uuid(tb, &pkg->ep_uuid);
 	if (sw) {
 		u8 phy_port, sw_phy_port;
 
 		parent_sw = tb_to_switch(sw->dev.parent);
-		sw_phy_port = phy_port_from_route(tb_route(sw), sw->depth);
-		phy_port = phy_port_from_route(route, depth);
+		sw_phy_port = tb_phy_port_from_link(sw->link);
+		phy_port = tb_phy_port_from_link(link);
 
 		/*
 		 * On resume ICM will send us connected events for the
@@ -559,6 +552,22 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		 */
 		if (sw->depth == depth && sw_phy_port == phy_port &&
 		    !!sw->authorized == authorized) {
+			/*
+			 * It was enumerated through another link so update
+			 * route string accordingly.
+			 */
+			if (sw->link != link) {
+				ret = icm->get_route(tb, link, depth, &route);
+				if (ret) {
+					tb_err(tb, "failed to update route string for switch at %u.%u\n",
+					       link, depth);
+					tb_switch_put(sw);
+					return;
+				}
+			} else {
+				route = tb_route(sw);
+			}
+
 			update_switch(parent_sw, sw, route, pkg->connection_id,
 				      pkg->connection_key, link, depth, boot);
 			tb_switch_put(sw);
@@ -607,6 +616,14 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
+	ret = icm->get_route(tb, link, depth, &route);
+	if (ret) {
+		tb_err(tb, "failed to find route string for switch at %u.%u\n",
+		       link, depth);
+		tb_switch_put(parent_sw);
+		return;
+	}
+
 	add_switch(parent_sw, route, &pkg->ep_uuid, pkg->connection_id,
 		   pkg->connection_key, link, depth, security_level,
 		   authorized, boot);
-- 
2.17.1

