Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E002588E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E002588E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeFYMF0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:05:26 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:48002 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933595AbeFYMFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AA8C15208CB;
        Mon, 25 Jun 2018 14:05:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wLl-RCeHGOIn; Mon, 25 Jun 2018 14:05:15 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3CDF55208BF;
        Mon, 25 Jun 2018 14:05:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 826535208BE;
        Mon, 25 Jun 2018 14:05:12 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 12/24] drm/sun4i: Don't check for panel or bridge on TV TCONs
Date:   Mon, 25 Jun 2018 14:02:52 +0200
Message-Id: <20180625120304.7543-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
sense to check if panel or bridge is connected to them.

Check if TCON has channel 0 and only then check for connected panel or
bridges.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 761687ebacba..a41c7bb0d557 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1178,13 +1178,19 @@ static const struct component_ops sun4i_tcon_ops = {
 static int sun4i_tcon_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	const struct sun4i_tcon_quirks *quirks;
 	struct drm_bridge *bridge;
 	struct drm_panel *panel;
 	int ret;
 
-	ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
-	if (ret == -EPROBE_DEFER)
-		return ret;
+	quirks = of_device_get_match_data(&pdev->dev);
+
+	/* panels and bridges are present only on TCONs with channel 0 */
+	if (quirks->has_channel_0) {
+		ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	}
 
 	return component_add(&pdev->dev, &sun4i_tcon_ops);
 }
-- 
2.18.0

