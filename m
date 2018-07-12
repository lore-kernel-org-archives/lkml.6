Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0638FC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B083520842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B083520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGLRY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:24:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbeGLRY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A04E94074475;
        Thu, 12 Jul 2018 17:14:00 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-214.rdu2.redhat.com [10.10.120.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C6601C678;
        Thu, 12 Jul 2018 17:13:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Archit Taneja <architt@codeaurora.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Don't forget to label dp_aux devices
Date:   Thu, 12 Jul 2018 13:13:52 -0400
Message-Id: <20180712171356.10227-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 12 Jul 2018 17:14:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 12 Jul 2018 17:14:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes debugging with DP tracing a lot harder to interpret, so name
each i2c based off the name of the encoder that it's for

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv04/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 12 ++++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h |  3 ++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
index 501d2d290e9c..45ff1872d894 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
@@ -64,7 +64,7 @@ nv04_display_create(struct drm_device *dev)
 	for (i = 0; i < dcb->entries; i++) {
 		struct dcb_output *dcbent = &dcb->entry[i];
 
-		connector = nouveau_connector_create(dev, dcbent->connector);
+		connector = nouveau_connector_create(dev, dcbent);
 		if (IS_ERR(connector))
 			continue;
 
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 9382e99a0bc7..4f8d51590bbb 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2198,7 +2198,7 @@ nv50_display_create(struct drm_device *dev)
 
 	/* create encoder/connector objects based on VBIOS DCB table */
 	for (i = 0, dcbe = &dcb->entry[0]; i < dcb->entries; i++, dcbe++) {
-		connector = nouveau_connector_create(dev, dcbe->connector);
+		connector = nouveau_connector_create(dev, dcbe);
 		if (IS_ERR(connector))
 			continue;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 7b557c354307..0c5cc600c973 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -408,8 +408,10 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	kfree(nv_connector->edid);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-	if (nv_connector->aux.transfer)
+	if (nv_connector->aux.transfer) {
 		drm_dp_aux_unregister(&nv_connector->aux);
+		kfree(nv_connector->aux.name);
+	}
 	kfree(connector);
 }
 
@@ -1201,13 +1203,16 @@ drm_conntype_from_dcb(enum dcb_connector_type dcb)
 }
 
 struct drm_connector *
-nouveau_connector_create(struct drm_device *dev, int index)
+nouveau_connector_create(struct drm_device *dev,
+			 const struct dcb_output *dcbe)
 {
 	const struct drm_connector_funcs *funcs = &nouveau_connector_funcs;
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_connector *nv_connector = NULL;
 	struct drm_connector *connector;
+	char aux_name[48] = {0};
+	int index = dcbe->connector;
 	int type, ret = 0;
 	bool dummy;
 
@@ -1306,6 +1311,9 @@ nouveau_connector_create(struct drm_device *dev, int index)
 	case DRM_MODE_CONNECTOR_eDP:
 		nv_connector->aux.dev = dev->dev;
 		nv_connector->aux.transfer = nouveau_connector_aux_xfer;
+		snprintf(aux_name, sizeof(aux_name), "sor-%04x-%04x",
+			 dcbe->hasht, dcbe->hashm);
+		nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
 		ret = drm_dp_aux_register(&nv_connector->aux);
 		if (ret) {
 			NV_ERROR(drm, "failed to register aux channel\n");
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index a4d1a059bd3d..2c5cb51c7c33 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -35,6 +35,7 @@
 #include "nouveau_crtc.h"
 
 struct nvkm_i2c_port;
+struct dcb_output;
 
 struct nouveau_connector {
 	struct drm_connector base;
@@ -76,7 +77,7 @@ nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
 }
 
 struct drm_connector *
-nouveau_connector_create(struct drm_device *, int index);
+nouveau_connector_create(struct drm_device *, const struct dcb_output *);
 
 extern int nouveau_tv_disable;
 extern int nouveau_ignorelid;
-- 
2.17.1

