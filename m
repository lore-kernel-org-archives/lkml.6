Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADF2C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A7E20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A7E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJEGaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEGaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:30:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A6578553D;
        Thu,  4 Oct 2018 23:34:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B0A367C7E;
        Thu,  4 Oct 2018 23:34:11 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] drm/i915: Leave intel_conn->mst_port set, use mst_port_gone instead
Date:   Thu,  4 Oct 2018 19:33:48 -0400
Message-Id: <20181004233353.5388-4-lyude@redhat.com>
In-Reply-To: <20181004233353.5388-1-lyude@redhat.com>
References: <20181004233353.5388-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 04 Oct 2018 23:34:12 +0000 (UTC)
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
always set and instead add intel_connector->mst_port_gone in order to
signify whether or not the connector has disappeared from the system.

Changes since v2:
- Add a comment to mst_port_gone (Jani Nikula)
- Change mst_port_gone to a u8 instead of a bool, per the kernel bot.
  Apparently bool is discouraged in structs these days

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 14 +++++++-------
 drivers/gpu/drm/i915/intel_drv.h    |  6 ++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 4ecd65375603..fcb9b87b9339 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -311,9 +311,8 @@ static int intel_dp_mst_get_ddc_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	if (!intel_dp) {
+	if (intel_connector->mst_port_gone)
 		return intel_connector_update_modes(connector, NULL);
-	}
 
 	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr, intel_connector->port);
 	ret = intel_connector_update_modes(connector, edid);
@@ -328,9 +327,10 @@ intel_dp_mst_detect(struct drm_connector *connector, bool force)
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 
-	if (!intel_dp)
+	if (intel_connector->mst_port_gone)
 		return connector_status_disconnected;
-	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr, intel_connector->port);
+	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
+				      intel_connector->port);
 }
 
 static void
@@ -370,7 +370,7 @@ intel_dp_mst_mode_valid(struct drm_connector *connector,
 	int bpp = 24; /* MST uses fixed bpp */
 	int max_rate, mode_rate, max_lanes, max_link_clock;
 
-	if (!intel_dp)
+	if (intel_connector->mst_port_gone)
 		return MODE_ERROR;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -402,7 +402,7 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
 
-	if (!intel_dp)
+	if (intel_connector->mst_port_gone)
 		return NULL;
 	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
@@ -514,7 +514,7 @@ static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 						   connector);
 	/* prevent race with the check in ->detect */
 	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
-	intel_connector->mst_port = NULL;
+	intel_connector->mst_port_gone = true;
 	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
 
 	drm_connector_put(connector);
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 8fc61e96754f..8261d4579452 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -410,6 +410,12 @@ struct intel_connector {
 
 	struct intel_dp *mst_port;
 
+	/*
+	 * Set to 1 if this is an MST connector that was removed from the
+	 * system and unregistered from sysfs
+	 */
+	u8 mst_port_gone;
+
 	/* Work struct to schedule a uevent on link train failure */
 	struct work_struct modeset_retry_work;
 
-- 
2.17.1

