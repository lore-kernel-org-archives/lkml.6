Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B47ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4CE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4CE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbeGWNaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:30:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeGWNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:30:15 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 291F1BB3;
        Mon, 23 Jul 2018 12:29:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 21/44] drm/nouveau: Use drm_connector_list_iter_* for iterating connectors
Date:   Mon, 23 Jul 2018 14:24:57 +0200
Message-Id: <20180723122438.511392701@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 22b76bbe089cd901f5260ecb9a3dc41f9edb97a0 upstream.

Every codepath in nouveau that loops through the connector list
currently does so using the old method, which is prone to race
conditions from MST connectors being created and destroyed. This has
been causing a multitude of problems, including memory corruption from
trying to access connectors that have already been freed!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Karol Herbst <karolherbst@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_backlight.c |    6 ++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c |    9 +++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h |   14 ++++++++++----
 drivers/gpu/drm/nouveau/nouveau_display.c   |   10 ++++++++--
 4 files changed, 29 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -267,6 +267,7 @@ nouveau_backlight_init(struct drm_device
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvif_device *device = &drm->client.device;
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 
 	INIT_LIST_HEAD(&drm->bl_connectors);
 
@@ -275,7 +276,8 @@ nouveau_backlight_init(struct drm_device
 		return 0;
 	}
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS &&
 		    connector->connector_type != DRM_MODE_CONNECTOR_eDP)
 			continue;
@@ -292,7 +294,7 @@ nouveau_backlight_init(struct drm_device
 			break;
 		}
 	}
-
+	drm_connector_list_iter_end(&conn_iter);
 
 	return 0;
 }
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1208,14 +1208,19 @@ nouveau_connector_create(struct drm_devi
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
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -65,14 +65,20 @@ nouveau_crtc_connector_get(struct nouvea
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
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -405,6 +405,7 @@ nouveau_display_init(struct drm_device *
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 	int ret;
 
 	ret = disp->init(dev);
@@ -412,10 +413,12 @@ nouveau_display_init(struct drm_device *
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
@@ -428,6 +431,7 @@ nouveau_display_fini(struct drm_device *
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
 
 	if (!suspend) {
 		if (drm_drv_uses_atomic_modeset(dev))
@@ -440,10 +444,12 @@ nouveau_display_fini(struct drm_device *
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


