Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C6FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F0520879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F0520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeLNB1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbeLNB1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8013307EAA5;
        Fri, 14 Dec 2018 01:27:03 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 571386012B;
        Fri, 14 Dec 2018 01:27:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [WIP PATCH 10/15] drm/nouveau: Stop unsetting mstc->port, use malloc refs
Date:   Thu, 13 Dec 2018 20:25:39 -0500
Message-Id: <20181214012604.13746-11-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Dec 2018 01:27:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as we did for i915, but for nouveau this time. Additionally, we
grab a malloc reference to the port that lasts for the entire lifetime
of nv50_mstc, which gives us the guarantee that mstc->port will always
point to valid memory for as long as the mstc stays around.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 982054bbcc8b..157d208d37b5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -709,8 +709,7 @@ nv50_msto_cleanup(struct nv50_msto *msto)
 
 	NV_ATOMIC(drm, "%s: msto cleanup\n", msto->encoder.name);
 
-	if (mstc->port)
-		drm_dp_mst_deallocate_vcpi(&mstm->mgr, mstc->port);
+	drm_dp_mst_deallocate_vcpi(&mstm->mgr, mstc->port);
 
 	msto->mstc = NULL;
 	msto->head = NULL;
@@ -735,7 +734,7 @@ nv50_msto_prepare(struct nv50_msto *msto)
 	};
 
 	NV_ATOMIC(drm, "%s: msto prepare\n", msto->encoder.name);
-	if (mstc->port && mstc->port->vcpi.vcpi > 0) {
+	if (mstc->port->vcpi.vcpi > 0) {
 		struct drm_dp_payload *payload = nv50_msto_payload(msto);
 		if (payload) {
 			args.vcpi.start_slot = payload->start_slot;
@@ -832,8 +831,7 @@ nv50_msto_disable(struct drm_encoder *encoder)
 	struct nv50_mstc *mstc = msto->mstc;
 	struct nv50_mstm *mstm = mstc->mstm;
 
-	if (mstc->port)
-		drm_dp_mst_reset_vcpi_slots(&mstm->mgr, mstc->port);
+	drm_dp_mst_reset_vcpi_slots(&mstm->mgr, mstc->port);
 
 	mstm->outp->update(mstm->outp, msto->head->base.index, NULL, 0, 0);
 	mstm->modified = true;
@@ -945,7 +943,7 @@ nv50_mstc_detect(struct drm_connector *connector, bool force)
 	enum drm_connector_status conn_status;
 	int ret;
 
-	if (!mstc->port)
+	if (drm_connector_is_unregistered(connector))
 		return connector_status_disconnected;
 
 	ret = pm_runtime_get_sync(connector->dev->dev);
@@ -966,8 +964,7 @@ nv50_mstc_destroy(struct drm_connector *connector)
 	struct nv50_mstc *mstc = nv50_mstc(connector);
 
 	drm_connector_cleanup(&mstc->connector);
-	if (mstc->port)
-		drm_dp_mst_put_port_malloc(mstc->port);
+	drm_dp_mst_put_port_malloc(mstc->port);
 
 	kfree(mstc);
 }
@@ -1081,11 +1078,6 @@ nv50_mstm_destroy_connector(struct drm_dp_mst_topology_mgr *mgr,
 
 	drm_fb_helper_remove_one_connector(&drm->fbcon->helper, &mstc->connector);
 
-	drm_modeset_lock(&drm->dev->mode_config.connection_mutex, NULL);
-	drm_dp_mst_put_port_malloc(mstc->port);
-	mstc->port = NULL;
-	drm_modeset_unlock(&drm->dev->mode_config.connection_mutex);
-
 	drm_connector_put(&mstc->connector);
 }
 
-- 
2.19.2

