Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C33C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC56206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC56206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeIGCVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:21:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728010AbeIGCVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F28CE77886;
        Thu,  6 Sep 2018 21:43:40 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A78ED9464D;
        Thu,  6 Sep 2018 21:43:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] drm/nouveau: Add NV_PRINTK_ONCE and variants
Date:   Thu,  6 Sep 2018 17:43:22 -0400
Message-Id: <20180906214328.24012-3-lyude@redhat.com>
In-Reply-To: <20180906214328.24012-1-lyude@redhat.com>
References: <20180906214328.24012-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 21:43:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 21:43:41 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're about to use this in nouveau_backlight.c. Same thing as
DRM_WARN_ONCE, DRM_INFO_ONCE, etc...

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 6e1acaec3400..d9d687916553 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -244,10 +244,12 @@ void nouveau_drm_device_remove(struct drm_device *dev);
 	struct nouveau_cli *_cli = (c);                                        \
 	dev_##l(_cli->drm->dev->dev, "%s: "f, _cli->name, ##a);                \
 } while(0)
+
 #define NV_FATAL(drm,f,a...) NV_PRINTK(crit, &(drm)->client, f, ##a)
 #define NV_ERROR(drm,f,a...) NV_PRINTK(err, &(drm)->client, f, ##a)
 #define NV_WARN(drm,f,a...) NV_PRINTK(warn, &(drm)->client, f, ##a)
 #define NV_INFO(drm,f,a...) NV_PRINTK(info, &(drm)->client, f, ##a)
+
 #define NV_DEBUG(drm,f,a...) do {                                              \
 	if (unlikely(drm_debug & DRM_UT_DRIVER))                               \
 		NV_PRINTK(info, &(drm)->client, f, ##a);                       \
@@ -257,6 +259,12 @@ void nouveau_drm_device_remove(struct drm_device *dev);
 		NV_PRINTK(info, &(drm)->client, f, ##a);                       \
 } while(0)
 
+#define NV_PRINTK_ONCE(l,c,f,a...) NV_PRINTK(l##_once,c,f, ##a)
+
+#define NV_ERROR_ONCE(drm,f,a...) NV_PRINTK_ONCE(err, &(drm)->client, f, ##a)
+#define NV_WARN_ONCE(drm,f,a...) NV_PRINTK_ONCE(warn, &(drm)->client, f, ##a)
+#define NV_INFO_ONCE(drm,f,a...) NV_PRINTK_ONCE(info, &(drm)->client, f, ##a)
+
 extern int nouveau_modeset;
 
 #endif
-- 
2.17.1

