Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF6C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AF4205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AF4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJIFxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeJIFxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B604630DF6E7;
        Mon,  8 Oct 2018 22:39:37 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABF8E105705C;
        Mon,  8 Oct 2018 22:39:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] drm/i915: Don't unset intel_connector->mst_port
Date:   Mon,  8 Oct 2018 18:39:19 -0400
Message-Id: <20181008223924.1103-4-lyude@redhat.com>
In-Reply-To: <20181008223924.1103-1-lyude@redhat.com>
References: <20181008223924.1103-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 08 Oct 2018 22:39:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we set intel_connector->mst_port to NULL to signify that the
MST port has been removed from the system so that we can prevent further
action on the port such as connector probes, mode probing, etc.
However, we're going to need access to intel_connector->mst_port in
order to fixup ->best_encoder() so that it can always return the correct
encoder for an MST port to prevent legacy DPMS prop changes from
failing. This should be safe, so instead keep intel_connector->mst_port
always set and instead just check the status of
drm_connector->regustered to signify whether or not the connector has
disappeared from the system.

Changes since v2:
- Add a comment to mst_port_gone (Jani Nikula)
- Change mst_port_gone to a u8 instead of a bool, per the kernel bot.
  Apparently bool is discouraged in structs these days
Changes since v4:
- Don't use mst_port_gone at all! Just check if the connector is
  registered or not - Daniel Vetter

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 43db2e9ac575..aa21742d8634 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -307,9 +307,8 @@ static int intel_dp_mst_get_ddc_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	if (!intel_dp) {
+	if (!READ_ONCE(connector->registered))
 		return intel_connector_update_modes(connector, NULL);
-	}
 
 	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr, intel_connector->port);
 	ret = intel_connector_update_modes(connector, edid);
@@ -324,9 +323,10 @@ intel_dp_mst_detect(struct drm_connector *connector, bool force)
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 
-	if (!intel_dp)
+	if (!READ_ONCE(connector->registered))
 		return connector_status_disconnected;
-	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr, intel_connector->port);
+	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
+				      intel_connector->port);
 }
 
 static void
@@ -366,7 +366,7 @@ intel_dp_mst_mode_valid(struct drm_connector *connector,
 	int bpp = 24; /* MST uses fixed bpp */
 	int max_rate, mode_rate, max_lanes, max_link_clock;
 
-	if (!intel_dp)
+	if (!READ_ONCE(connector->registered))
 		return MODE_ERROR;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -398,7 +398,7 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
 
-	if (!intel_dp)
+	if (!READ_ONCE(connector->registered))
 		return NULL;
 	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
@@ -499,7 +499,6 @@ static void intel_dp_register_mst_connector(struct drm_connector *connector)
 static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 					   struct drm_connector *connector)
 {
-	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 
 	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id, connector->name);
@@ -508,10 +507,6 @@ static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (dev_priv->fbdev)
 		drm_fb_helper_remove_one_connector(&dev_priv->fbdev->helper,
 						   connector);
-	/* prevent race with the check in ->detect */
-	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
-	intel_connector->mst_port = NULL;
-	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
 
 	drm_connector_put(connector);
 }
-- 
2.17.1

