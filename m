Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B66CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC69B20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC69B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeIBLmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:33 -0400
Received: from mailoutvs7.siol.net ([185.57.226.198]:54936 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeIBLmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DC77F520D00;
        Sun,  2 Sep 2018 09:27:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KjFF3qJfGKUF; Sun,  2 Sep 2018 09:27:42 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 66FA9520CDE;
        Sun,  2 Sep 2018 09:27:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id D57FD520CF4;
        Sun,  2 Sep 2018 09:27:39 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 17/27] drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
Date:   Sun,  2 Sep 2018 09:26:33 +0200
Message-Id: <20180902072643.4917-18-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
all. At this point it is not clear whether it is just not necessary or
it would cause some kind of issues.

Add a quirk for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 5 ++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index a5020fe8bd69..16a0c7a88ea8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -153,7 +153,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 	}
 
-	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
+	if (hdmi->quirks->set_rate)
+		drm_encoder_helper_add(encoder,
+				       &sun8i_dw_hdmi_encoder_helper_funcs);
 	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
@@ -220,6 +222,7 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
 
 static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
 	.mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
+	.set_rate = true,
 };
 
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index b718c47e00be..94cf13d09abe 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -172,6 +172,7 @@ struct sun8i_hdmi_phy {
 struct sun8i_dw_hdmi_quirks {
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   const struct drm_display_mode *mode);
+	bool set_rate;
 };
 
 struct sun8i_dw_hdmi {
-- 
2.18.0

