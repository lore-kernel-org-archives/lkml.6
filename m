Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122A92147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A92147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeKVCoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:44:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeKVCob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:44:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EBC5827E7B1
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv5 2/6] drm/omap: populate DSI platform bus earlier
Date:   Wed, 21 Nov 2018 17:09:12 +0100
Message-Id: <20181121160916.22017-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121160916.22017-1-sebastian.reichel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the changes from 4.20 the DSI encoder tries to find the
attached panel before populating the DSI bus. If the panel is
not found -EPROBE_DEFER is returned, so the DSI bus is never
populated and the panel never added.

Fix this by populating the DSI bus before searching for the
video sink in dsi_init_output().

Fixes: 27d624527d992 ("drm/omap: dss: Acquire next dssdev at probe time")
Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 0a485c5b982e..00a9c2ab9e6c 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -5418,9 +5418,15 @@ static int dsi_probe(struct platform_device *pdev)
 		dsi->num_lanes_supported = 3;
 	}
 
+	r = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (r) {
+		DSSERR("Failed to populate DSI child devices: %d\n", r);
+		goto err_pm_disable;
+	}
+
 	r = dsi_init_output(dsi);
 	if (r)
-		goto err_pm_disable;
+		goto err_of_depopulate;
 
 	r = dsi_probe_of(dsi);
 	if (r) {
@@ -5428,22 +5434,16 @@ static int dsi_probe(struct platform_device *pdev)
 		goto err_uninit_output;
 	}
 
-	r = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (r) {
-		DSSERR("Failed to populate DSI child devices: %d\n", r);
-		goto err_uninit_output;
-	}
-
 	r = component_add(&pdev->dev, &dsi_component_ops);
 	if (r)
-		goto err_of_depopulate;
+		goto err_uninit_output;
 
 	return 0;
 
-err_of_depopulate:
-	of_platform_depopulate(dev);
 err_uninit_output:
 	dsi_uninit_output(dsi);
+err_of_depopulate:
+	of_platform_depopulate(dev);
 err_pm_disable:
 	pm_runtime_disable(dev);
 	return r;
-- 
2.19.1

