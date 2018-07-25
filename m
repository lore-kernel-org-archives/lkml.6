Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1734ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844B32064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B32064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeGYJNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:13:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:10644 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbeGYJNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:13:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 01:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="57711709"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2018 01:03:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 595F7172; Wed, 25 Jul 2018 11:03:22 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] thunderbolt: Do not unnecessarily call ICM get route
Date:   Wed, 25 Jul 2018 11:03:17 +0300
Message-Id: <20180725080321.35746-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
References: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
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
2.18.0

