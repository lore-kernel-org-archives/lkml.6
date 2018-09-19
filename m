Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40AECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7487A21524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7487A21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbeITEtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeITEts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E4B13082AF1;
        Wed, 19 Sep 2018 23:09:36 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-250.rdu2.redhat.com [10.10.122.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16C0D2010D64;
        Wed, 19 Sep 2018 23:09:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] drm/i915: Fix intel_dp_mst_best_encoder()
Date:   Wed, 19 Sep 2018 19:09:02 -0400
Message-Id: <20180919230913.16894-6-lyude@redhat.com>
In-Reply-To: <20180919230913.16894-1-lyude@redhat.com>
References: <20180919230913.16894-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Sep 2018 23:09:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, i915 appears to rely on blocking modesets on
no-longer-present MSTB ports by simply returning NULL for
->best_encoder(), which in turn causes any new atomic commits that don't
disable the CRTC to fail. This is wrong however, since we still want to
allow userspace to disable CRTCs on no-longer-present MSTB ports by
changing the DPMS state to off and this still requires that we retrieve
an encoder.

So, fix this by always returning a valid encoder regardless of the state
of the MST port. Additionally, make intel_dp_mst_atomic_check() simply
rely on drm_dp_mst_connector_atomic_check() to prevent new modesets on
no-longer-present MSTB ports.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index a366f32b048a..2b798d4592f0 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -106,14 +106,21 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 }
 
 static int intel_dp_mst_atomic_check(struct drm_connector *connector,
-		struct drm_connector_state *new_conn_state)
+				     struct drm_connector_state *new_conn_state)
 {
 	struct drm_atomic_state *state = new_conn_state->state;
 	struct drm_connector_state *old_conn_state;
 	struct drm_crtc *old_crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_dp_mst_topology_mgr *mgr =
+		&to_intel_connector(connector)->mst_port->mst_mgr;
 	int slots, ret = 0;
 
+	ret = drm_dp_mst_connector_atomic_check(connector, new_conn_state,
+						mgr);
+	if (ret)
+		return ret;
+
 	old_conn_state = drm_atomic_get_old_connector_state(state, connector);
 	old_crtc = old_conn_state->crtc;
 	if (!old_crtc)
@@ -122,12 +129,6 @@ static int intel_dp_mst_atomic_check(struct drm_connector *connector,
 	crtc_state = drm_atomic_get_new_crtc_state(state, old_crtc);
 	slots = to_intel_crtc_state(crtc_state)->dp_m_n.tu;
 	if (drm_atomic_crtc_needs_modeset(crtc_state) && slots > 0) {
-		struct drm_dp_mst_topology_mgr *mgr;
-		struct drm_encoder *old_encoder;
-
-		old_encoder = old_conn_state->best_encoder;
-		mgr = &enc_to_mst(old_encoder)->primary->dp.mst_mgr;
-
 		ret = drm_dp_atomic_release_vcpi_slots(state, mgr, slots);
 		if (ret)
 			DRM_DEBUG_KMS("failed releasing %d vcpi slots:%d\n", slots, ret);
@@ -407,8 +408,6 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
 
-	if (intel_connector->mst_port_gone)
-		return NULL;
 	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
 
-- 
2.17.1

