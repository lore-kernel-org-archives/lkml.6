Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96A9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605FA20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605FA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH3C1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:27:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727539AbeH3C1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:27:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48BBF4023351;
        Wed, 29 Aug 2018 22:28:42 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-121-246.rdu2.redhat.com [10.10.121.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D46CC202704E;
        Wed, 29 Aug 2018 22:28:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Jeffery Miller <jmiller@neverware.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 6/6] drm/nouveau: Refactor nvXX_backlight_init()
Date:   Wed, 29 Aug 2018 18:28:32 -0400
Message-Id: <20180829222834.15590-7-lyude@redhat.com>
In-Reply-To: <20180829222834.15590-1-lyude@redhat.com>
References: <20180829222834.15590-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 29 Aug 2018 22:28:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 29 Aug 2018 22:28:42 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's literally no difference between any of the backlight init
functions besides the backlight properties they set and the backlight
callbacks that they set, so move all of the duplicated backlight init
code out of there and into nouveau_backlight_init().

This gets rid of a lot of copy pasta!

Changes since v1:
- Some of the pre-refactor callbacks were storing nv_encoder in callback
  data for the backlight devices that they registered, as opposed to
  nouveau_drm. This got missed and caused some bugs that didn't
  originally appear on my setup (NULL kernel derefs) for some reason.
  So, fix this by finding the nouveau_encoder in
  nouveau_backlight_init(), and using that as the callback data for all
  gens instead even if they don't care about the encoder.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jeffery Miller <jmiller@neverware.com>
Cc: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 160 +++++++++-----------
 1 file changed, 72 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 01d08acac2f0..5f5be6368aed 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -65,7 +65,8 @@ nouveau_get_backlight_name(char backlight_name[BL_NAME_SIZE],
 static int
 nv40_get_intensity(struct backlight_device *bd)
 {
-	struct nouveau_drm *drm = bl_get_data(bd);
+	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
+	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
 	int val = (nvif_rd32(device, NV40_PMC_BACKLIGHT) &
 		   NV40_PMC_BACKLIGHT_MASK) >> 16;
@@ -76,7 +77,8 @@ nv40_get_intensity(struct backlight_device *bd)
 static int
 nv40_set_intensity(struct backlight_device *bd)
 {
-	struct nouveau_drm *drm = bl_get_data(bd);
+	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
+	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
 	int val = bd->props.brightness;
 	int reg = nvif_rd32(device, NV40_PMC_BACKLIGHT);
@@ -94,48 +96,20 @@ static const struct backlight_ops nv40_bl_ops = {
 };
 
 static int
-nv40_backlight_init(struct drm_connector *connector)
+nv40_backlight_init(struct nouveau_encoder *encoder,
+		    struct backlight_properties *props,
+		    const struct backlight_ops **ops)
 {
-	struct nouveau_drm *drm = nouveau_drm(connector->dev);
-	struct nouveau_backlight *bl;
+	struct nouveau_drm *drm = nouveau_drm(encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	struct backlight_properties props;
-	char backlight_name[BL_NAME_SIZE];
-	int ret = 0;
 
 	if (!(nvif_rd32(device, NV40_PMC_BACKLIGHT) & NV40_PMC_BACKLIGHT_MASK))
-		return 0;
-
-	bl = kzalloc(sizeof(*bl), GFP_KERNEL);
-	if (!bl)
-		return -ENOMEM;
-
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = 31;
-	if (!nouveau_get_backlight_name(backlight_name, bl)) {
-		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
-		goto fail_alloc;
-	}
-
-	bl->dev = backlight_device_register(backlight_name, connector->kdev,
-					    drm, &nv40_bl_ops, &props);
-	if (IS_ERR(bl->dev)) {
-		if (bl->id >= 0)
-			ida_simple_remove(&bl_ida, bl->id);
-
-		ret = PTR_ERR(bl->dev);
-		goto fail_alloc;
-	}
-
-	nouveau_connector(connector)->backlight = bl;
-	bl->dev->props.brightness = nv40_get_intensity(bl->dev);
-	backlight_update_status(bl->dev);
+		return -ENODEV;
 
+	props->type = BACKLIGHT_RAW;
+	props->max_brightness = 31;
+	*ops = &nv40_bl_ops;
 	return 0;
-fail_alloc:
-	kfree(bl);
-	return ret;
 }
 
 static int
@@ -221,92 +195,102 @@ static const struct backlight_ops nva3_bl_ops = {
 };
 
 static int
-nv50_backlight_init(struct drm_connector *connector)
+nv50_backlight_init(struct nouveau_encoder *nv_encoder,
+		    struct backlight_properties *props,
+		    const struct backlight_ops **ops)
 {
-	struct nouveau_drm *drm = nouveau_drm(connector->dev);
+	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	struct nouveau_encoder *nv_encoder;
-	struct nouveau_backlight *bl;
-	struct backlight_properties props;
-	const struct backlight_ops *ops;
-	char backlight_name[BL_NAME_SIZE];
-	int ret = 0;
-
-	nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
-	if (!nv_encoder) {
-		nv_encoder = find_encoder(connector, DCB_OUTPUT_DP);
-		if (!nv_encoder)
-			return -ENODEV;
-	}
 
 	if (!nvif_rd32(device, NV50_PDISP_SOR_PWM_CTL(ffs(nv_encoder->dcb->or) - 1)))
-		return 0;
-
-	bl = kzalloc(sizeof(*bl), GFP_KERNEL);
-	if (!bl)
-		return -ENOMEM;
+		return -ENODEV;
 
 	if (drm->client.device.info.chipset <= 0xa0 ||
 	    drm->client.device.info.chipset == 0xaa ||
 	    drm->client.device.info.chipset == 0xac)
-		ops = &nv50_bl_ops;
+		*ops = &nv50_bl_ops;
 	else
-		ops = &nva3_bl_ops;
+		*ops = &nva3_bl_ops;
 
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = 100;
-	if (!nouveau_get_backlight_name(backlight_name, bl)) {
-		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
-		goto fail_alloc;
-	}
+	props->type = BACKLIGHT_RAW;
+	props->max_brightness = 100;
 
-	bl->dev = backlight_device_register(backlight_name, connector->kdev,
-					    nv_encoder, ops, &props);
-	if (IS_ERR(bl->dev)) {
-		if (bl->id >= 0)
-			ida_simple_remove(&bl_ida, bl->id);
-
-		ret = PTR_ERR(bl->dev);
-		goto fail_alloc;
-	}
-
-	nouveau_connector(connector)->backlight = bl;
-	bl->dev->props.brightness = bl->dev->ops->get_brightness(bl->dev);
-	backlight_update_status(bl->dev);
 	return 0;
-
-fail_alloc:
-	kfree(bl);
-	return ret;
 }
 
 int
 nouveau_backlight_init(struct drm_connector *connector)
 {
 	struct nouveau_drm *drm = nouveau_drm(connector->dev);
+	struct nouveau_backlight *bl;
+	struct nouveau_encoder *nv_encoder = NULL;
 	struct nvif_device *device = &drm->client.device;
+	char backlight_name[BL_NAME_SIZE];
+	struct backlight_properties props = {0};
+	const struct backlight_ops *ops;
+	int ret;
 
 	if (apple_gmux_present()) {
 		NV_INFO_ONCE(drm, "Apple GMUX detected: not registering Nouveau backlight interface\n");
 		return 0;
 	}
 
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS &&
-	    connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)
+		nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
+	else if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
+		nv_encoder = find_encoder(connector, DCB_OUTPUT_DP);
+	else
+		return 0;
+
+	if (!nv_encoder)
 		return 0;
 
 	switch (device->info.family) {
 	case NV_DEVICE_INFO_V0_CURIE:
-		return nv40_backlight_init(connector);
+		ret = nv40_backlight_init(nv_encoder, &props, &ops);
+		break;
 	case NV_DEVICE_INFO_V0_TESLA:
 	case NV_DEVICE_INFO_V0_FERMI:
 	case NV_DEVICE_INFO_V0_KEPLER:
 	case NV_DEVICE_INFO_V0_MAXWELL:
-		return nv50_backlight_init(connector);
+		ret = nv50_backlight_init(nv_encoder, &props, &ops);
+		break;
 	default:
 		return 0;
 	}
+
+	if (ret == -ENODEV)
+		return 0;
+	else if (ret)
+		return ret;
+
+	bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+	if (!bl)
+		return -ENOMEM;
+
+	if (!nouveau_get_backlight_name(backlight_name, bl)) {
+		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
+		goto fail_alloc;
+	}
+
+	bl->dev = backlight_device_register(backlight_name, connector->kdev,
+					    nv_encoder, ops, &props);
+	if (IS_ERR(bl->dev)) {
+		if (bl->id >= 0)
+			ida_simple_remove(&bl_ida, bl->id);
+		ret = PTR_ERR(bl->dev);
+		goto fail_alloc;
+	}
+
+	nouveau_connector(connector)->backlight = bl;
+	bl->dev->props.brightness = bl->dev->ops->get_brightness(bl->dev);
+	backlight_update_status(bl->dev);
+
+	return 0;
+
+fail_alloc:
+	kfree(bl);
+	return ret;
 }
 
 void
-- 
2.17.1

