Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B60C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41620652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfARMVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfARMU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F9342D4B7E;
        Fri, 18 Jan 2019 12:20:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3A865D967;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 70D244F972; Fri, 18 Jan 2019 13:20:23 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 21/23] drm/qxl: add qxl_add_mode helper function
Date:   Fri, 18 Jan 2019 13:20:18 +0100
Message-Id: <20190118122020.27596-22-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Jan 2019 12:20:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to add custom video modes to a connector.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 84 +++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index fed2ea018d..926fcb49b2 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -212,15 +212,36 @@ static int qxl_check_framebuffer(struct qxl_device *qdev,
 	return qxl_check_mode(qdev, bo->surf.width, bo->surf.height);
 }
 
-static int qxl_add_monitors_config_modes(struct drm_connector *connector,
-                                         unsigned *pwidth,
-                                         unsigned *pheight)
+static int qxl_add_mode(struct drm_connector *connector,
+			unsigned int width,
+			unsigned int height,
+			bool preferred)
+{
+	struct drm_device *dev = connector->dev;
+	struct qxl_device *qdev = dev->dev_private;
+	struct drm_display_mode *mode = NULL;
+	int rc;
+
+	rc = qxl_check_mode(qdev, width, height);
+	if (rc != 0)
+		return 0;
+
+	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (preferred)
+		mode->type |= DRM_MODE_TYPE_PREFERRED;
+	mode->hdisplay = width;
+	mode->vdisplay = height;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+	return 1;
+}
+
+static int qxl_add_monitors_config_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 	struct qxl_device *qdev = dev->dev_private;
 	struct qxl_output *output = drm_connector_to_qxl_output(connector);
 	int h = output->index;
-	struct drm_display_mode *mode = NULL;
 	struct qxl_head *head;
 
 	if (!qdev->monitors_config)
@@ -235,19 +256,7 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector,
 	head = &qdev->client_monitors_config->heads[h];
 	DRM_DEBUG_KMS("head %d is %dx%d\n", h, head->width, head->height);
 
-	mode = drm_cvt_mode(dev, head->width, head->height, 60, false, false,
-			    false);
-	mode->type |= DRM_MODE_TYPE_PREFERRED;
-	mode->hdisplay = head->width;
-	mode->vdisplay = head->height;
-	drm_mode_set_name(mode);
-	*pwidth = head->width;
-	*pheight = head->height;
-	drm_mode_probed_add(connector, mode);
-	/* remember the last custom size for mode validation */
-	qdev->monitors_config_width = mode->hdisplay;
-	qdev->monitors_config_height = mode->vdisplay;
-	return 1;
+	return qxl_add_mode(connector, head->width, head->height, true);
 }
 
 static struct mode_size {
@@ -273,22 +282,16 @@ static struct mode_size {
 	{1920, 1200}
 };
 
-static int qxl_add_common_modes(struct drm_connector *connector,
-                                unsigned int pwidth,
-                                unsigned int pheight)
+static int qxl_add_common_modes(struct drm_connector *connector)
 {
-	struct drm_device *dev = connector->dev;
-	struct drm_display_mode *mode = NULL;
-	int i;
+	int i, ret = 0;
 
-	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h,
-				    60, false, false, false);
-		if (common_modes[i].w == pwidth && common_modes[i].h == pheight)
-			mode->type |= DRM_MODE_TYPE_PREFERRED;
-		drm_mode_probed_add(connector, mode);
-	}
-	return i - 1;
+	for (i = 0; i < ARRAY_SIZE(common_modes); i++)
+		ret += qxl_add_mode(connector,
+				    common_modes[i].w,
+				    common_modes[i].h,
+				    false);
+	return ret;
 }
 
 static void qxl_send_monitors_config(struct qxl_device *qdev)
@@ -991,14 +994,25 @@ static int qdev_crtc_init(struct drm_device *dev, int crtc_id)
 
 static int qxl_conn_get_modes(struct drm_connector *connector)
 {
+	struct drm_device *dev = connector->dev;
+	struct qxl_device *qdev = dev->dev_private;
+	struct qxl_output *output = drm_connector_to_qxl_output(connector);
 	unsigned int pwidth = 1024;
 	unsigned int pheight = 768;
 	int ret = 0;
 
-	ret = qxl_add_monitors_config_modes(connector, &pwidth, &pheight);
-	if (ret < 0)
-		return ret;
-	ret += qxl_add_common_modes(connector, pwidth, pheight);
+	if (qdev->client_monitors_config) {
+		struct qxl_head *head;
+		head = &qdev->client_monitors_config->heads[output->index];
+		if (head->width)
+			pwidth = head->width;
+		if (head->height)
+			pheight = head->height;
+	}
+
+	ret += qxl_add_common_modes(connector);
+	ret += qxl_add_monitors_config_modes(connector);
+	drm_set_preferred_mode(connector, pwidth, pheight);
 	return ret;
 }
 
-- 
2.9.3

