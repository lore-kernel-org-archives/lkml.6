Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486AFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085562147E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085562147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934519AbeGFRxo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:44 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:41548 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934092AbeGFRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 38F5E5211D8;
        Fri,  6 Jul 2018 19:53:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R2NkfTPjkus8; Fri,  6 Jul 2018 19:53:33 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 972A552099D;
        Fri,  6 Jul 2018 19:53:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 1377F5211E0;
        Fri,  6 Jul 2018 19:53:31 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 11/17] drm/sun4i: tcon: Add another way for matching mixers with tcon
Date:   Fri,  6 Jul 2018 19:51:07 +0200
Message-Id: <20180706175113.26698-12-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till now, new way of matching engines with TCONs was reading their
respective ids and match them by those ids. However, with introduction
of TCON TOP, that might not be so straightforward anymore.
- there might be more TCONs that engines (mixers)
- TCON ids might have non-consecutive ids

Workaround that by matching mixer id with TCON index from TCON list.

For example, R40 has 2 mixers and 4 TCONs. Board designer can choose
2 outputs, which are connected to any of those 4 TCONs. As long as there
are only 2 TCONs enabled in DT, using index in list as alternative id,
will allow to match them with mixer 0 and 1.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 51 ++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3fb084f802e2..44ec3a3d4d64 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -35,6 +35,7 @@
 #include "sun4i_rgb.h"
 #include "sun4i_tcon.h"
 #include "sun6i_mipi_dsi.h"
+#include "sun8i_tcon_top.h"
 #include "sunxi_engine.h"
 
 static struct drm_connector *sun4i_tcon_get_connector(const struct drm_encoder *encoder)
@@ -880,6 +881,36 @@ static struct sunxi_engine *sun4i_tcon_get_engine_by_id(struct sun4i_drv *drv,
 	return ERR_PTR(-EINVAL);
 }
 
+static bool sun4i_tcon_connected_to_tcon_top(struct device_node *node)
+{
+	struct device_node *remote;
+	bool ret = false;
+
+	remote = of_graph_get_remote_node(node, 0, -1);
+	if (remote) {
+		ret = !!of_match_node(sun8i_tcon_top_of_table, remote);
+		of_node_put(remote);
+	}
+
+	return ret;
+}
+
+static int sun4i_tcon_get_index(struct sun4i_drv *drv)
+{
+	struct list_head *pos;
+	int size = 0;
+
+	/*
+	 * Because TCON is added to the list at the end of the probe
+	 * (after this function is called), index of the current TCON
+	 * will be same as current TCON list size.
+	 */
+	list_for_each(pos, &drv->tcon_list)
+		++size;
+
+	return size;
+}
+
 /*
  * On SoCs with the old display pipeline design (Display Engine 1.0),
  * we assumed the TCON was always tied to just one backend. However
@@ -928,8 +959,24 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
 	 * connections between the backend and TCON?
 	 */
 	if (of_get_child_count(port) > 1) {
-		/* Get our ID directly from an upstream endpoint */
-		int id = sun4i_tcon_of_get_id_from_port(port);
+		int id;
+
+		/*
+		 * When pipeline has the same number of TCONs and engines which
+		 * are represented by frontends/backends (DE1) or mixers (DE2),
+		 * we match them by their respective IDs. However, if pipeline
+		 * contains TCON TOP, chances are that there are either more
+		 * TCONs than engines (R40) or TCONs with non-consecutive ids.
+		 * (H6). In that case it's easier just use TCON index in list
+		 * as an id. That means that on R40, any 2 TCONs can be enabled
+		 * in DT out of 4 (there are 2 mixers). Due to the design of
+		 * TCON TOP, remaining 2 TCONs can't be connected to anything
+		 * anyway.
+		 */
+		if (sun4i_tcon_connected_to_tcon_top(node))
+			id = sun4i_tcon_get_index(drv);
+		else
+			id = sun4i_tcon_of_get_id_from_port(port);
 
 		/* Get our engine by matching our ID */
 		engine = sun4i_tcon_get_engine_by_id(drv, id);
-- 
2.18.0

