Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEC7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD70020857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="huj3Z1Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD70020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIEJuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:50:03 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56286 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeIEJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:50:02 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 055AB5C0817;
        Wed,  5 Sep 2018 07:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536124895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uK/GQdVH7PkUQsL+YoVMx2UuUPh+rzLHDJjMZD7LfN4=;
        b=huj3Z1Wddp7tH6U/gLlO4BEjJ4PtwA0TFp8Iro7ax/dgrGbF+Z7Xr5u683u08/yNQL+C1m
        gyROqwL0BLWn2e9WNiPUN1+qzFfCQAVckcD+h1nXZmTRdOAH14VG13FK2kM59MOP82P9hw
        krypeJ3GTPaGSDkjxaTOeHM9zuW24fs=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/6] drm/bridge: allow to specify data-enable polarity
Date:   Tue,  4 Sep 2018 22:21:09 -0700
Message-Id: <20180905052113.21262-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905052113.21262-1-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support boards with a passive RGB to VGA bridge which require a low
active data-enable polarity.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Alternatively a new dt binding could be introduced for dumb VGA bridges
requiring low active data enable... However, also other polarities might
need a specific polarity, hence this generic approach might be better.

 drivers/gpu/drm/bridge/dumb-vga-dac.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 7a5c24967115..2b8c3d629f2f 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -179,6 +179,7 @@ static struct i2c_adapter *dumb_vga_retrieve_ddc(struct device *dev)
 static int dumb_vga_probe(struct platform_device *pdev)
 {
 	struct dumb_vga *vga;
+	u32 de;
 
 	vga = devm_kzalloc(&pdev->dev, sizeof(*vga), GFP_KERNEL);
 	if (!vga)
@@ -194,6 +195,23 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "No vdd regulator found: %d\n", ret);
 	}
 
+	vga->bridge.funcs = &dumb_vga_bridge_funcs;
+	vga->bridge.of_node = pdev->dev.of_node;
+	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
+
+	if (!vga->bridge.timings &&
+	    !of_property_read_u32(pdev->dev.of_node, "de-active", &de)) {
+		struct drm_bridge_timings *timings;
+
+		timings = devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
+		if (!timings)
+			return -ENOMEM;
+
+		timings->bus_flags = de ? DRM_BUS_FLAG_DE_HIGH :
+					DRM_BUS_FLAG_DE_LOW;
+		vga->bridge.timings = timings;
+	}
+
 	vga->ddc = dumb_vga_retrieve_ddc(&pdev->dev);
 	if (IS_ERR(vga->ddc)) {
 		if (PTR_ERR(vga->ddc) == -ENODEV) {
@@ -205,10 +223,6 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		}
 	}
 
-	vga->bridge.funcs = &dumb_vga_bridge_funcs;
-	vga->bridge.of_node = pdev->dev.of_node;
-	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
-
 	drm_bridge_add(&vga->bridge);
 
 	return 0;
-- 
2.18.0

