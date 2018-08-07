Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A8521757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A8521757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHGXtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:49:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeHGXtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:49:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECDF140241C3;
        Tue,  7 Aug 2018 21:32:54 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8B071C664;
        Tue,  7 Aug 2018 21:32:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Don't forget to cancel hpd_work on suspend/unload
Date:   Tue,  7 Aug 2018 17:32:48 -0400
Message-Id: <20180807213249.1118-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 21:32:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 21:32:55 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there's nothing in nouveau that actually cancels this work
struct. So, cancel it on suspend/unload. Otherwise, if we're unlucky
enough hpd_work might try to keep running up until the system is
suspended.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 9 ++++++---
 drivers/gpu/drm/nouveau/nouveau_display.h | 2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index ec7861457b84..1ba3f152cfcb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -425,7 +425,7 @@ nouveau_display_init(struct drm_device *dev)
 }
 
 void
-nouveau_display_fini(struct drm_device *dev, bool suspend)
+nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime)
 {
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -450,6 +450,9 @@ nouveau_display_fini(struct drm_device *dev, bool suspend)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
+	if (!runtime)
+		cancel_work_sync(&drm->hpd_work);
+
 	drm_kms_helper_poll_disable(dev);
 	disp->fini(dev);
 }
@@ -618,11 +621,11 @@ nouveau_display_suspend(struct drm_device *dev, bool runtime)
 			}
 		}
 
-		nouveau_display_fini(dev, true);
+		nouveau_display_fini(dev, true, runtime);
 		return 0;
 	}
 
-	nouveau_display_fini(dev, true);
+	nouveau_display_fini(dev, true, runtime);
 
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct nouveau_framebuffer *nouveau_fb;
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
index 54aa7c3fa42d..ff92b54ce448 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.h
+++ b/drivers/gpu/drm/nouveau/nouveau_display.h
@@ -62,7 +62,7 @@ nouveau_display(struct drm_device *dev)
 int  nouveau_display_create(struct drm_device *dev);
 void nouveau_display_destroy(struct drm_device *dev);
 int  nouveau_display_init(struct drm_device *dev);
-void nouveau_display_fini(struct drm_device *dev, bool suspend);
+void nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime);
 int  nouveau_display_suspend(struct drm_device *dev, bool runtime);
 void nouveau_display_resume(struct drm_device *dev, bool runtime);
 int  nouveau_display_vblank_enable(struct drm_device *, unsigned int);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index f5d3158f0378..20d4ab647cf7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -629,7 +629,7 @@ nouveau_drm_unload(struct drm_device *dev)
 	nouveau_debugfs_fini(drm);
 
 	if (dev->mode_config.num_crtc)
-		nouveau_display_fini(dev, false);
+		nouveau_display_fini(dev, false, false);
 	nouveau_display_destroy(dev);
 
 	nouveau_bios_takedown(dev);
-- 
2.17.1

