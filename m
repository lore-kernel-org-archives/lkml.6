Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09203208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09203208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeHAXDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:03:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeHAXDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:03:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C079140216E5;
        Wed,  1 Aug 2018 21:15:18 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71A992026D68;
        Wed,  1 Aug 2018 21:15:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] drm/nouveau: Respond to HPDs by probing one conn at a time
Date:   Wed,  1 Aug 2018 17:14:56 -0400
Message-Id: <20180801211459.7731-7-lyude@redhat.com>
In-Reply-To: <20180801211459.7731-1-lyude@redhat.com>
References: <20180801211459.7731-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 21:15:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 21:15:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't actually any reason we need to call drm_hpd_irq_event() from
our hotplug handler, as we already know which connector the hotplug
event was fired for. We're also going to need to avoid probing all
connectors needlessly from hotplug handlers anyway so that we can track
when nouveau_connector_detect() is being called from the context of it's
connector's hotplug handler in order to fix the next deadlocking issue.

This is (slightly) faster anyway!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 28 ++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 010d6db14cba..9714e09f17db 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1114,6 +1114,32 @@ nouveau_connector_funcs_lvds = {
 	.atomic_get_property = nouveau_conn_atomic_get_property,
 };
 
+static void
+nouveau_connector_hotplug_probe(struct nouveau_connector *nv_conn)
+{
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_connector *conn = &nv_conn->base;
+	enum drm_connector_status old_status;
+	struct drm_device *dev = conn->dev;
+	bool changed;
+
+	mutex_lock(&dev->mode_config.mutex);
+
+	drm_modeset_acquire_init(&ctx, 0);
+	drm_modeset_lock(&dev->mode_config.connection_mutex, &ctx);
+
+	old_status = conn->status;
+	conn->status = drm_helper_probe_detect(conn, &ctx, true);
+	changed = old_status != conn->status;
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+	mutex_unlock(&dev->mode_config.mutex);
+
+	if (changed)
+		drm_kms_helper_hotplug_event(dev);
+}
+
 static int
 nouveau_connector_hotplug(struct nvif_notify *notify)
 {
@@ -1138,7 +1164,7 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 				nv50_mstm_remove(nv_encoder->dp.mstm);
 		}
 
-		drm_helper_hpd_irq_event(connector->dev);
+		nouveau_connector_hotplug_probe(nv_connector);
 	}
 
 	return NVIF_NOTIFY_KEEP;
-- 
2.17.1

