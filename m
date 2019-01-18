Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333442054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfAROoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:44:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46055 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfAROn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:43:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 81D3A20C59; Fri, 18 Jan 2019 15:43:54 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 86ABB20DF8;
        Fri, 18 Jan 2019 15:43:53 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v5 20/23] drm/sun4i: Make COEF_RDY conditional
Date:   Fri, 18 Jan 2019 15:43:25 +0100
Message-Id: <20190118144328.20649-21-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
References: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The COEF_RDY bit isn't found in all the SoCs featuring some variant of the
frontend.

Add it to our quirks structure.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 9 +++++----
 drivers/gpu/drm/sun4i/sun4i_frontend.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 7a1095b004d4..86c5033102b9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -96,10 +96,11 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 			     sun4i_frontend_vert_coef[i]);
 	}
 
-	regmap_write_bits(frontend->regs,
-			  SUN4I_FRONTEND_FRM_CTRL_REG,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY,
-			  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY);
+	if (frontend->data->has_coef_rdy)
+		regmap_write_bits(frontend->regs,
+				  SUN4I_FRONTEND_FRM_CTRL_REG,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY,
+				  SUN4I_FRONTEND_FRM_CTRL_COEF_RDY);
 }
 
 int sun4i_frontend_init(struct sun4i_frontend *frontend)
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 01e68bb11c98..e332bc1c6b68 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -114,6 +114,7 @@ struct reset_control;
 
 struct sun4i_frontend_data {
 	bool	has_coef_access_ctrl;
+	bool	has_coef_rdy;
 };
 
 struct sun4i_frontend {
-- 
2.20.1

