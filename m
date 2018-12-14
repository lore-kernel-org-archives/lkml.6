Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F735C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127962075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127962075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeLNB1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbeLNB1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFF209B308;
        Fri, 14 Dec 2018 01:27:19 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7ABC60139;
        Fri, 14 Dec 2018 01:27:14 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Karol Herbst <karolherbst@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 15/15] drm/nouveau: Use atomic VCPI helpers for MST
Date:   Thu, 13 Dec 2018 20:25:44 -0500
Message-Id: <20181214012604.13746-16-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Dec 2018 01:27:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nouveau uses the yolo method of setting up MST displays: it
uses the old VCPI helpers (drm_dp_find_vcpi_slots()) for computing the
display configuration. These helpers don't take care to make sure they
take a reference to the mstb port that they're checking, and
additionally don't actually check whether or not the topology still has
enough bandwidth to provide the VCPI tokens required.

So, drop usage of the old helpers and move entirely over to the atomic
helpers.

Changes since v5:
 - Update nv50_msto_atomic_check() and nv50_mstc_atomic_check() to the
   new requirements for drm_dp_atomic_find_vcpi_slots() and
   drm_dp_atomic_release_vcpi_slots()

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 52 ++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 67f7bf97e5d9..df696008d205 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -762,16 +762,22 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
 		       struct drm_crtc_state *crtc_state,
 		       struct drm_connector_state *conn_state)
 {
-	struct nv50_mstc *mstc = nv50_mstc(conn_state->connector);
+	struct drm_atomic_state *state = crtc_state->state;
+	struct drm_connector *connector = conn_state->connector;
+	struct nv50_mstc *mstc = nv50_mstc(connector);
 	struct nv50_mstm *mstm = mstc->mstm;
-	int bpp = conn_state->connector->display_info.bpc * 3;
+	int bpp = connector->display_info.bpc * 3;
 	int slots;
 
-	mstc->pbn = drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock, bpp);
+	mstc->pbn = drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock,
+					 bpp);
 
-	slots = drm_dp_find_vcpi_slots(&mstm->mgr, mstc->pbn);
-	if (slots < 0)
-		return slots;
+	if (crtc_state->connectors_changed || crtc_state->mode_changed) {
+		slots = drm_dp_atomic_find_vcpi_slots(state, &mstm->mgr,
+						      mstc->port, mstc->pbn);
+		if (slots < 0)
+			return slots;
+	}
 
 	return nv50_outp_atomic_check_view(encoder, crtc_state, conn_state,
 					   mstc->native);
@@ -934,12 +940,42 @@ nv50_mstc_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
+static int
+nv50_mstc_atomic_check(struct drm_connector *connector,
+		       struct drm_connector_state *new_conn_state)
+{
+	struct drm_atomic_state *state = new_conn_state->state;
+	struct nv50_mstc *mstc = nv50_mstc(connector);
+	struct drm_dp_mst_topology_mgr *mgr = &mstc->mstm->mgr;
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_crtc_state *old_crtc_state;
+	struct drm_crtc *new_crtc = new_conn_state->crtc,
+			*old_crtc = old_conn_state->crtc;
+
+	if (!old_crtc)
+		return 0;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, old_crtc);
+	if (!old_crtc_state || !old_crtc_state->enable)
+		return 0;
+
+	if (new_crtc)
+		return 0;
+
+	/* This connector will be left without an enabled CRTC, so its VCPI
+	 * must be released here
+	 */
+	return drm_dp_atomic_release_vcpi_slots(state, mgr, mstc->port);
+}
+
 static const struct drm_connector_helper_funcs
 nv50_mstc_help = {
 	.get_modes = nv50_mstc_get_modes,
 	.mode_valid = nv50_mstc_mode_valid,
 	.best_encoder = nv50_mstc_best_encoder,
 	.atomic_best_encoder = nv50_mstc_atomic_best_encoder,
+	.atomic_check = nv50_mstc_atomic_check,
 };
 
 static enum drm_connector_status
@@ -2121,6 +2157,10 @@ nv50_disp_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 			return ret;
 	}
 
+	ret = drm_dp_mst_atomic_check(state);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.19.2

