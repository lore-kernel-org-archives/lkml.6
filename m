Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEAA20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEAA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeH3VVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:21:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbeH3VVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74CE54021FC2;
        Thu, 30 Aug 2018 17:18:00 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-162.rdu2.redhat.com [10.10.124.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2453E2027059;
        Thu, 30 Aug 2018 17:17:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/nouveau: Fix nouveau_connector_ddc_detect()
Date:   Thu, 30 Aug 2018 13:16:28 -0400
Message-Id: <20180830171628.23999-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 30 Aug 2018 17:18:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 30 Aug 2018 17:18:00 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like that when we moved over to using
drm_connector_for_each_possible_encoder() in nouveau, that one rather
important part of this function got dropped by accident:

	/*          Right   v   here */
	for (i = 0; nv_encoder = NULL, i < DRM_CONNECTOR_MAX_ENCODER; i++) {
		int id = connector->encoder_ids[i];
		if (id == 0)
			break;

Since it's rather difficult to notice: the conditional in this loop is
actually:

	nv_encoder = NULL, i < DRM_CONNECTOR_MAX_ENCODER

Meaning that all early breaks result in nv_encoder keeping it's value,
otherwise nv_encoder = NULL. Ugh.

Since this got dropped, nouveau_connector_ddc_detect() now returns an
encoder for every single connector, regardless of whether or not it's
detected:

    [ 1780.056185] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for DP-2

So: fix this to ensure we only return an encoder if we actually found
one, and clean up the rest of the function while we're at it since it's
nearly impossible to read properly.

Changes since v1:
- Don't skip ddc probing for LVDS if we can't switch DDC through
  vga-switcheroo, just do the DDC probing without calling
  vga_switcheroo_lock_ddc() - skeggsb

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: ddba766dd07e ("drm/nouveau: Use drm_connector_for_each_possible_encoder()")
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 49 ++++++++++++---------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 71c3bd8ff9f8..461111aaedc4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -414,9 +414,10 @@ nouveau_connector_ddc_detect(struct drm_connector *connector)
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvkm_gpio *gpio = nvxx_gpio(&drm->client.device);
-	struct nouveau_encoder *nv_encoder = NULL;
+	struct nouveau_encoder *nv_encoder = NULL, *found = NULL;
 	struct drm_encoder *encoder;
-	int i, panel = -ENODEV;
+	int i, ret, panel = -ENODEV;
+	bool switcheroo_ddc = false;
 
 	/* eDP panels need powering on by us (if the VBIOS doesn't default it
 	 * to on) before doing any AUX channel transactions.  LVDS panel power
@@ -433,37 +434,43 @@ nouveau_connector_ddc_detect(struct drm_connector *connector)
 	drm_connector_for_each_possible_encoder(connector, encoder, i) {
 		nv_encoder = nouveau_encoder(encoder);
 
-		if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
-			int ret = nouveau_dp_detect(nv_encoder);
+		switch (nv_encoder->dcb->type) {
+		case DCB_OUTPUT_DP:
+			ret = nouveau_dp_detect(nv_encoder);
 			if (ret == NOUVEAU_DP_MST)
 				return NULL;
-			if (ret == NOUVEAU_DP_SST)
-				break;
-		} else
-		if ((vga_switcheroo_handler_flags() &
-		     VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
-		    nv_encoder->dcb->type == DCB_OUTPUT_LVDS &&
-		    nv_encoder->i2c) {
-			int ret;
-			vga_switcheroo_lock_ddc(dev->pdev);
-			ret = nvkm_probe_i2c(nv_encoder->i2c, 0x50);
-			vga_switcheroo_unlock_ddc(dev->pdev);
-			if (ret)
+			else if (ret == NOUVEAU_DP_SST)
+				found = nv_encoder;
+
+			break;
+		case DCB_OUTPUT_LVDS:
+			switcheroo_ddc = !!(vga_switcheroo_handler_flags() &
+					    VGA_SWITCHEROO_CAN_SWITCH_DDC);
+		/* fall-through */
+		default:
+			if (!nv_encoder->i2c)
 				break;
-		} else
-		if (nv_encoder->i2c) {
+
+			if (switcheroo_ddc)
+				vga_switcheroo_lock_ddc(dev->pdev);
 			if (nvkm_probe_i2c(nv_encoder->i2c, 0x50))
-				break;
+				found = nv_encoder;
+			if (switcheroo_ddc)
+				vga_switcheroo_unlock_ddc(dev->pdev);
+
+			break;
 		}
+		if (found)
+			break;
 	}
 
 	/* eDP panel not detected, restore panel power GPIO to previous
 	 * state to avoid confusing the SOR for other output types.
 	 */
-	if (!nv_encoder && panel == 0)
+	if (!found && panel == 0)
 		nvkm_gpio_set(gpio, 0, DCB_GPIO_PANEL_POWER, 0xff, panel);
 
-	return nv_encoder;
+	return found;
 }
 
 static struct nouveau_encoder *
-- 
2.17.1

