Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDBAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A58219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A58219AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbeGFRx3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:29 -0400
Received: from mailoutvs28.siol.net ([185.57.226.219]:41447 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934414AbeGFRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A0AF7520BE8;
        Fri,  6 Jul 2018 19:53:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7rnDl-HF_xKI; Fri,  6 Jul 2018 19:53:23 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2AD565211D8;
        Fri,  6 Jul 2018 19:53:23 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A04875211DC;
        Fri,  6 Jul 2018 19:53:20 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 07/17] drm/sun4i: DW HDMI: Release nodes if error happens during CRTC search
Date:   Fri,  6 Jul 2018 19:51:03 +0200
Message-Id: <20180706175113.26698-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If error happens in sun8i_dw_hdmi_find_possible_crtcs(), nodes are not
released with of_node_put() before returning.

Fix that by calling of_node_put() when necessary. While on it, clean up
the code by using of_graph_get_remote_node() which also lowers number of
cases where error handling has to be performed.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 3459b9ec56c9..21dc9ebad0b4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -53,22 +53,14 @@ static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
 	struct device_node *port, *ep, *remote, *remote_port;
 	u32 crtcs = 0;
 
-	port = of_graph_get_port_by_id(node, 0);
-	if (!port)
-		return 0;
-
-	ep = of_get_next_available_child(port, NULL);
-	if (!ep)
-		return 0;
-
-	remote = of_graph_get_remote_port_parent(ep);
+	remote = of_graph_get_remote_node(node, 0, -1);
 	if (!remote)
 		return 0;
 
 	if (sun8i_dw_hdmi_node_is_tcon_top(remote)) {
 		port = of_graph_get_port_by_id(remote, 4);
 		if (!port)
-			return 0;
+			goto crtcs_exit;
 
 		for_each_child_of_node(port, ep) {
 			remote_port = of_graph_get_remote_port(ep);
@@ -81,6 +73,9 @@ static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
 		crtcs = drm_of_find_possible_crtcs(drm, node);
 	}
 
+crtcs_exit:
+	of_node_put(remote);
+
 	return crtcs;
 }
 
-- 
2.18.0

