Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6CE2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6CE2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbeKVCoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:44:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeKVCod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:44:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8AD0727E758
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv5 3/6] drm/omap: don't check dispc timings for DSI
Date:   Wed, 21 Nov 2018 17:09:13 +0100
Message-Id: <20181121160916.22017-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121160916.22017-1-sebastian.reichel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While most display types only forward their VM to the DISPC, this
is not true for DSI. DSI calculates the VM for DISPC based on its
own, but it's not identical. Actually the DSI VM is not even a valid
DISPC VM making this check fail. Let's restore the old behaviour
and avoid checking the DISPC VM for DSI here.

Fixes: 7c27fa57ef31 ("drm/omap: Call dispc timings check operation directly")
Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 8 +++++---
 drivers/gpu/drm/omapdrm/omap_encoder.c   | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index b81302c4bf9e..5c776d6211e1 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -280,9 +280,11 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 	drm_display_mode_to_videomode(mode, &vm);
 	mode->vrefresh = drm_mode_vrefresh(mode);
 
-	r = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
-	if (r)
-		goto done;
+	if (omap_connector->display->type != OMAP_DISPLAY_TYPE_DSI) {
+		r = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
+		if (r)
+			goto done;
+	}
 
 	for (dssdev = omap_connector->output; dssdev; dssdev = dssdev->next) {
 		if (!dssdev->ops->check_timings)
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 452e625f6ce3..32bbe3a80e7d 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -170,9 +170,11 @@ static int omap_encoder_atomic_check(struct drm_encoder *encoder,
 
 	drm_display_mode_to_videomode(&crtc_state->mode, &vm);
 
-	ret = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
-	if (ret)
-		goto done;
+	if (omap_encoder->display->type != OMAP_DISPLAY_TYPE_DSI) {
+		ret = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
+		if (ret)
+			goto done;
+	}
 
 	for (dssdev = omap_encoder->output; dssdev; dssdev = dssdev->next) {
 		if (!dssdev->ops->check_timings)
-- 
2.19.1

