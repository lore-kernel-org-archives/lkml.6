Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F89C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6199A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6199A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbeKPJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:17:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47512 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:17:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DDE8F27E75C
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv4 4/6] drm/omap: fix incorrect union usage
Date:   Fri, 16 Nov 2018 00:06:43 +0100
Message-Id: <20181115230645.15748-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115230645.15748-1-sebastian.reichel@collabora.com>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
union works, it won't be NULL if dsi.set_config is set. This means
dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
resulting in a NULL dereference. Also the dereference happens while
console is locked, so kernel hangs without any debug output (can be
avoided by fbmem's lockless_register_fb=1 parameter).

This fixes the issue by exiting early if the output type definitely
has no hdmi_set operations.

Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 32bbe3a80e7d..ba0099f0644c 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -122,6 +122,14 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 
 	dssdev = omap_encoder->output;
 
+	/* The following operations access dssdev->ops->hdmi, which is a union
+	 * also used by DSI. This ensures, that the field does not have data
+	 * for DSI (or any other future output type).
+	 */
+	if (dssdev->output_type != OMAP_DISPLAY_TYPE_HDMI &&
+	    dssdev->output_type != OMAP_DISPLAY_TYPE_DVI)
+		return;
+
 	if (dssdev->ops->hdmi.set_hdmi_mode)
 		dssdev->ops->hdmi.set_hdmi_mode(dssdev, hdmi_mode);
 
-- 
2.19.1

