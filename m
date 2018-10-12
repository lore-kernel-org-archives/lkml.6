Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131F6C71122
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8D52087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="afUFvTb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8D52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJMDvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56574 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJMDvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:25 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKHBL0031493;
        Fri, 12 Oct 2018 15:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375431;
        bh=zuqDsbgF2rZY4WRbC1kdpxRU0rI1JyqX+nNL6qHtr3E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=afUFvTb5p0Gsx+2nafNJQSz6aA+Cw0xkrP7Wk2ejl3ARfc0gDS5E6bici8oWvF8PR
         gyOYDKFMeb3YvP9mRd2aAMvUhO/mgFsy9v02lRSdFhyR3ry9TXdMt9onGps3oyox5x
         t12AfTekk3P+OVNwgoslHUG9tkUj6ryVHyoq8bqI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKHBRP030172;
        Fri, 12 Oct 2018 15:17:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:11 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7EW000402;
        Fri, 12 Oct 2018 15:17:11 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 2/8] drm/omap: Add ovl checking funcs to dispc_ops
Date:   Fri, 12 Oct 2018 15:16:57 -0500
Message-ID: <20181012201703.29065-3-bparrot@ti.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181012201703.29065-1-bparrot@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to dynamically assign overlays to planes we need to
be able to asses the overlay capabilities.

Add a helper function to be able to retrieve the supported capabilities
of an overlay.

And export the function to check if a fourcc is supported on a given
overlay.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c   | 8 ++++++++
 drivers/gpu/drm/omapdrm/dss/omapdss.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 70c3e3353947..ea8b57003620 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -2499,6 +2499,12 @@ static int dispc_ovl_calc_scaling_44xx(struct dispc_device *dispc,
 	return 0;
 }
 
+static enum omap_overlay_caps dispc_ovl_get_caps(struct dispc_device *dispc,
+						 enum omap_plane_id plane)
+{
+	return dispc->feat->overlay_caps[plane];
+}
+
 #define DIV_FRAC(dividend, divisor) \
 	((dividend) * 100 / (divisor) - ((dividend) / (divisor) * 100))
 
@@ -4757,6 +4763,8 @@ static const struct dispc_ops dispc_ops = {
 	.ovl_enable = dispc_ovl_enable,
 	.ovl_setup = dispc_ovl_setup,
 	.ovl_get_color_modes = dispc_ovl_get_color_modes,
+	.ovl_color_mode_supported = dispc_ovl_color_mode_supported,
+	.ovl_get_caps = dispc_ovl_get_caps,
 	.ovl_get_max_size = dispc_ovl_get_max_size,
 
 	.wb_get_framedone_irq = dispc_wb_get_framedone_irq,
diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 45334d5c618e..b5640e8479dc 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -632,6 +632,10 @@ struct dispc_ops {
 
 	const u32 *(*ovl_get_color_modes)(struct dispc_device *dispc,
 					  enum omap_plane_id plane);
+	bool (*ovl_color_mode_supported)(struct dispc_device *dispc,
+					 enum omap_plane_id plane, u32 fourcc);
+	enum omap_overlay_caps (*ovl_get_caps)(struct dispc_device *dispc,
+					       enum omap_plane_id plane);
 	void (*ovl_get_max_size)(struct dispc_device *dispc,
 				 u16 *width, u16 *height);
 
-- 
2.9.0

