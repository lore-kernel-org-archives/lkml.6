Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D82ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B520BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9B520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeGQA3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:29:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729613AbeGQA3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F2C281A4EB9;
        Tue, 17 Jul 2018 00:00:00 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C878A2026D65;
        Mon, 16 Jul 2018 23:59:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/nouveau: Add missing RPM get/put() when probing connectors
Date:   Mon, 16 Jul 2018 19:59:27 -0400
Message-Id: <20180716235936.11268-4-lyude@redhat.com>
In-Reply-To: <20180716235936.11268-1-lyude@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 17 Jul 2018 00:00:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 17 Jul 2018 00:00:00 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the GPU is guaranteed to be on when a hotplug has been received,
the same assertion does not hold true if a connector probe has been
started by userspace without having had received a sysfs event. So
ensure that any connector probing keeps the GPU alive for the duration
of the probe.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 21 +++++++++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h |  3 +++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index ea2a886854fe..0f283ca75189 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -858,7 +858,7 @@ static const struct drm_connector_funcs
 nv50_mstc = {
 	.reset = nouveau_conn_reset,
 	.detect = nv50_mstc_detect,
-	.fill_modes = drm_helper_probe_single_connector_modes,
+	.fill_modes = nouveau_connector_probe_single_connector_modes,
 	.destroy = nv50_mstc_destroy,
 	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
 	.atomic_destroy_state = nouveau_conn_atomic_destroy_state,
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 2a45b4c2ceb0..feb142fb7a8a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -770,6 +770,23 @@ nouveau_connector_force(struct drm_connector *connector)
 	nouveau_connector_set_encoder(connector, nv_encoder);
 }
 
+int
+nouveau_connector_probe_single_connector_modes(struct drm_connector *connector,
+					       uint32_t maxX, uint32_t maxY)
+{
+	struct device *dev = connector->dev->dev;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (WARN_ON(ret < 0 && ret != -EACCES))
+		return 0;
+
+	ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
+
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
 static int
 nouveau_connector_set_property(struct drm_connector *connector,
 			       struct drm_property *property, uint64_t value)
@@ -1088,7 +1105,7 @@ nouveau_connector_funcs = {
 	.reset = nouveau_conn_reset,
 	.detect = nouveau_connector_detect,
 	.force = nouveau_connector_force,
-	.fill_modes = drm_helper_probe_single_connector_modes,
+	.fill_modes = nouveau_connector_probe_single_connector_modes,
 	.set_property = nouveau_connector_set_property,
 	.destroy = nouveau_connector_destroy,
 	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
@@ -1103,7 +1120,7 @@ nouveau_connector_funcs_lvds = {
 	.reset = nouveau_conn_reset,
 	.detect = nouveau_connector_detect_lvds,
 	.force = nouveau_connector_force,
-	.fill_modes = drm_helper_probe_single_connector_modes,
+	.fill_modes = nouveau_connector_probe_single_connector_modes,
 	.set_property = nouveau_connector_set_property,
 	.destroy = nouveau_connector_destroy,
 	.atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index 2d9d35a146a4..e9ffc6eebda2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -106,6 +106,9 @@ nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
 
 struct drm_connector *
 nouveau_connector_create(struct drm_device *, const struct dcb_output *);
+int
+nouveau_connector_probe_single_connector_modes(struct drm_connector *,
+					       uint32_t, uint32_t);
 
 extern int nouveau_tv_disable;
 extern int nouveau_ignorelid;
-- 
2.17.1

