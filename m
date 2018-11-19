Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F68BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B3021104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="atN6wG1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B3021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeKTDDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbeKTDDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:03:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD154206BA;
        Mon, 19 Nov 2018 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645553;
        bh=k8BoKETUzD/udOlmmnfNnLMM3ggWU/n8S3cH0K8fjPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atN6wG1v56cCXmHPy40Tjj/jESgn0CVizbrIchJelyuOP+X9emPT9WVM3XjMUOSf8
         vUn8qOxLiCRDwgI1jX2LUAjs6c3U+EEAZdphUxNfh1NVs79Q9HN68BpcpWNh2GcyKX
         klIOym00foI6vOKe+Q717C9hMq3lEjiwCJLlORa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.19 187/205] drm/i915: Dont unset intel_connector->mst_port
Date:   Mon, 19 Nov 2018 17:28:14 +0100
Message-Id: <20181119162641.715574423@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 80c188695a77eddaa6e8885510ff4ef59fd478c3 upstream.

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
Link: https://patchwork.freedesktop.org/patch/msgid/20181008232437.5571-4-lyude@redhat.com
(cherry picked from commit 6ed5bb1fbad34382c8cfe9a9bf737e9a43053df5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp_mst.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -311,9 +311,8 @@ static int intel_dp_mst_get_ddc_modes(st
 	struct edid *edid;
 	int ret;
 
-	if (!intel_dp) {
+	if (!READ_ONCE(connector->registered))
 		return intel_connector_update_modes(connector, NULL);
-	}
 
 	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr, intel_connector->port);
 	ret = intel_connector_update_modes(connector, edid);
@@ -328,9 +327,10 @@ intel_dp_mst_detect(struct drm_connector
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
@@ -370,7 +370,7 @@ intel_dp_mst_mode_valid(struct drm_conne
 	int bpp = 24; /* MST uses fixed bpp */
 	int max_rate, mode_rate, max_lanes, max_link_clock;
 
-	if (!intel_dp)
+	if (!READ_ONCE(connector->registered))
 		return MODE_ERROR;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -402,7 +402,7 @@ static struct drm_encoder *intel_mst_ato
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
 
-	if (!intel_dp)
+	if (!READ_ONCE(connector->registered))
 		return NULL;
 	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
@@ -503,7 +503,6 @@ static void intel_dp_register_mst_connec
 static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 					   struct drm_connector *connector)
 {
-	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 
 	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id, connector->name);
@@ -512,10 +511,6 @@ static void intel_dp_destroy_mst_connect
 	if (dev_priv->fbdev)
 		drm_fb_helper_remove_one_connector(&dev_priv->fbdev->helper,
 						   connector);
-	/* prevent race with the check in ->detect */
-	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
-	intel_connector->mst_port = NULL;
-	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
 
 	drm_connector_put(connector);
 }


