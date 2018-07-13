Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D738ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A4D208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A4D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbeGMRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:22:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729736AbeGMRWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A739406C7AC;
        Fri, 13 Jul 2018 17:06:52 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-125-176.rdu2.redhat.com [10.10.125.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5D5710F1BE0;
        Fri, 13 Jul 2018 17:06:51 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/nouveau: Use drm_connector_list_iter_* for iterating connectors
Date:   Fri, 13 Jul 2018 13:06:32 -0400
Message-Id: <20180713170633.24235-2-lyude@redhat.com>
In-Reply-To: <20180713170633.24235-1-lyude@redhat.com>
References: <20180713170633.24235-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 17:06:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 17:06:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every codepath in nouveau that loops through the connector list
currently does so using the old method, which is prone to race
conditions from MST connectors being created and destroyed. This has
been causing a multitude of problems, including memory corruption from
trying to access connectors that have already been freed!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c |  6 ++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c |  9 +++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h | 14 ++++++++++----
 drivers/gpu/drm/nouveau/nouveau_display.c   | 10 ++++++++--
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index debbbf0fd4bd..408b955e5c39 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -267,6 +267,7 @@ nouveau_backlight_init(struct drm_device *dev)
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvif_device *device = &drm->client.device;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 
 	INIT_LIST_HEAD(&drm->bl_connectors);
 
@@ -275,7 +276,8 @@ nouveau_backlight_init(struct drm_device *dev)
 		return 0;
 	}
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS &&
 		    connector->connector_type != DRM_MODE_CONNECTOR_eDP)
 			continue;
@@ -292,7 +294,7 @@ nouveau_backlight_init(struct drm_device *dev)
 			break;
 		}
 	}
-
+	drm_connector_list_iter_end(&conn_iter);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 7b557c354307..7dc380449232 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1208,14 +1208,19 @@ nouveau_connector_create(struct drm_device *dev, int index)
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_connector *nv_connector = NULL;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 	int type, ret = 0;
 	bool dummy;
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		nv_connector = nouveau_connector(connector);
-		if (nv_connector->index == index)
+		if (nv_connector->index == index) {
+			drm_connector_list_iter_end(&conn_iter);
 			return connector;
+		}
 	}
+	drm_connector_list_iter_end(&conn_iter);
 
 	nv_connector = kzalloc(sizeof(*nv_connector), GFP_KERNEL);
 	if (!nv_connector)
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index a4d1a059bd3d..a8cbb4b56fc7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -65,14 +65,20 @@ nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
 {
 	struct drm_device *dev = nv_crtc->base.dev;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	struct nouveau_connector *nv_connector = NULL;
 	struct drm_crtc *crtc = to_drm_crtc(nv_crtc);
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		if (connector->encoder && connector->encoder->crtc == crtc)
-			return nouveau_connector(connector);
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->encoder && connector->encoder->crtc == crtc) {
+			nv_connector = nouveau_connector(connector);
+			break;
+		}
 	}
+	drm_connector_list_iter_end(&conn_iter);
 
-	return NULL;
+	return nv_connector;
 }
 
 struct drm_connector *
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 774b429142bc..46b8430ef4aa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -404,6 +404,7 @@ nouveau_display_init(struct drm_device *dev)
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 	int ret;
 
 	ret = disp->init(dev);
@@ -411,10 +412,12 @@ nouveau_display_init(struct drm_device *dev)
 		return ret;
 
 	/* enable hotplug interrupts */
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		struct nouveau_connector *conn = nouveau_connector(connector);
 		nvif_notify_get(&conn->hpd);
 	}
+	drm_connector_list_iter_end(&conn_iter);
 
 	/* enable flip completion events */
 	nvif_notify_get(&drm->flip);
@@ -427,6 +430,7 @@ nouveau_display_fini(struct drm_device *dev, bool suspend)
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 
 	if (!suspend) {
 		if (drm_drv_uses_atomic_modeset(dev))
@@ -439,10 +443,12 @@ nouveau_display_fini(struct drm_device *dev, bool suspend)
 	nvif_notify_put(&drm->flip);
 
 	/* disable hotplug interrupts */
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		struct nouveau_connector *conn = nouveau_connector(connector);
 		nvif_notify_put(&conn->hpd);
 	}
+	drm_connector_list_iter_end(&conn_iter);
 
 	drm_kms_helper_poll_disable(dev);
 	disp->fini(dev);
-- 
2.17.1

