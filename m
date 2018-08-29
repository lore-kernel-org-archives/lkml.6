Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F57BC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D07020658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D07020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeH3C1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:27:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727521AbeH3C1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AB38804B4B9;
        Wed, 29 Aug 2018 22:28:41 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-121-246.rdu2.redhat.com [10.10.121.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA9E4202704E;
        Wed, 29 Aug 2018 22:28:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 4/6] drm/nouveau: s/nouveau_backlight_exit/nouveau_backlight_fini/
Date:   Wed, 29 Aug 2018 18:28:30 -0400
Message-Id: <20180829222834.15590-5-lyude@redhat.com>
In-Reply-To: <20180829222834.15590-1-lyude@redhat.com>
References: <20180829222834.15590-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 22:28:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 22:28:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More consistent with the rest of the codebase, no functional changes
here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 5d0694680f59..f4400a6408b4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -309,7 +309,7 @@ nouveau_backlight_init(struct drm_connector *connector)
 }
 
 void
-nouveau_backlight_exit(struct drm_connector *connector)
+nouveau_backlight_fini(struct drm_connector *connector)
 {
 	struct nouveau_connector *nv_conn = nouveau_connector(connector);
 	struct nouveau_backlight *bl = nv_conn->backlight;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 767e892de9c4..3b288be9c3f7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -911,7 +911,7 @@ nouveau_connector_late_register(struct drm_connector *connector)
 static void
 nouveau_connector_early_unregister(struct drm_connector *connector)
 {
-	nouveau_backlight_exit(connector);
+	nouveau_backlight_fini(connector);
 }
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index 5465ae82fb9f..76e79717e451 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -190,7 +190,7 @@ struct drm_display_mode *nouveau_conn_native_mode(struct drm_connector *);
 
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 extern int nouveau_backlight_init(struct drm_connector *);
-extern void nouveau_backlight_exit(struct drm_connector *);
+extern void nouveau_backlight_fini(struct drm_connector *);
 extern void nouveau_backlight_ctor(void);
 extern void nouveau_backlight_dtor(void);
 #else
@@ -201,7 +201,7 @@ nouveau_backlight_init(struct drm_connector *connector)
 }
 
 static inline void
-nouveau_backlight_exit(struct drm_connector *connector) {
+nouveau_backlight_fini(struct drm_connector *connector) {
 }
 
 static inline void
-- 
2.17.1

