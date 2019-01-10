Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F92C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80B72173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfAJIRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:17:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfAJIRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:17:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3393B7A19B;
        Thu, 10 Jan 2019 08:17:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C39B95C224;
        Thu, 10 Jan 2019 08:17:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F017116E03; Thu, 10 Jan 2019 09:17:50 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/qxl: drop prime import/export callbacks
Date:   Thu, 10 Jan 2019 09:17:50 +0100
Message-Id: <20190110081750.11358-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 10 Jan 2019 08:17:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
userspace.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c   |  4 ----
 drivers/gpu/drm/qxl/qxl_prime.c | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 13c8a662f9..ccb090f3ab 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -250,14 +250,10 @@ static struct drm_driver qxl_driver = {
 #if defined(CONFIG_DEBUG_FS)
 	.debugfs_init = qxl_debugfs_init,
 #endif
-	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_import = drm_gem_prime_import,
 	.gem_prime_pin = qxl_gem_prime_pin,
 	.gem_prime_unpin = qxl_gem_prime_unpin,
-	.gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
-	.gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
 	.gem_prime_vmap = qxl_gem_prime_vmap,
 	.gem_prime_vunmap = qxl_gem_prime_vunmap,
 	.gem_prime_mmap = qxl_gem_prime_mmap,
diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index a55dece118..df65d3c1a7 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -38,20 +38,6 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
 	WARN_ONCE(1, "not implemented");
 }
 
-struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
-{
-	WARN_ONCE(1, "not implemented");
-	return ERR_PTR(-ENOSYS);
-}
-
-struct drm_gem_object *qxl_gem_prime_import_sg_table(
-	struct drm_device *dev, struct dma_buf_attachment *attach,
-	struct sg_table *table)
-{
-	WARN_ONCE(1, "not implemented");
-	return ERR_PTR(-ENOSYS);
-}
-
 void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	WARN_ONCE(1, "not implemented");
-- 
2.9.3

