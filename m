Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04486C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A7420873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A7420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeK0IzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:55:04 -0500
Received: from anholt.net ([50.246.234.109]:38392 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeK0IzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:55:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8D84410A0F9D;
        Mon, 26 Nov 2018 13:59:31 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id M8lPBfkDUjIt; Mon, 26 Nov 2018 13:59:29 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CA11110A0D70;
        Mon, 26 Nov 2018 13:59:29 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 4190F2FE1FE6; Mon, 26 Nov 2018 13:59:29 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/2] drm/vkms: Drop custom vkms_dumb_map().
Date:   Mon, 26 Nov 2018 13:59:28 -0800
Message-Id: <20181126215929.20546-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same as the default drm_gem_dumb_map_offset()
implementation, except that this one missed the ban on userspace
mapping an imported dmabuf (which seems like intended common behavior
for drivers).

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vkms/vkms_drv.c |  1 -
 drivers/gpu/drm/vkms/vkms_drv.h |  3 ---
 drivers/gpu/drm/vkms/vkms_gem.c | 26 --------------------------
 3 files changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index a3d57e0f5ee5..83087877565c 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -68,7 +68,6 @@ static struct drm_driver vkms_driver = {
 	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
 	.dumb_create		= vkms_dumb_create,
-	.dumb_map_offset	= vkms_dumb_map,
 	.gem_vm_ops		= &vkms_gem_vm_ops,
 	.gem_free_object_unlocked = vkms_gem_free_object,
 	.get_vblank_timestamp	= vkms_get_vblank_timestamp,
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 1c93990693e3..e4469cd3d254 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -127,9 +127,6 @@ vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 		     struct drm_mode_create_dumb *args);
 
-int vkms_dumb_map(struct drm_file *file, struct drm_device *dev,
-		  u32 handle, u64 *offset);
-
 void vkms_gem_free_object(struct drm_gem_object *obj);
 
 int vkms_gem_vmap(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index d04e988b4cbe..80311daed47a 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -153,32 +153,6 @@ int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 	return 0;
 }
 
-int vkms_dumb_map(struct drm_file *file, struct drm_device *dev,
-		  u32 handle, u64 *offset)
-{
-	struct drm_gem_object *obj;
-	int ret;
-
-	obj = drm_gem_object_lookup(file, handle);
-	if (!obj)
-		return -ENOENT;
-
-	if (!obj->filp) {
-		ret = -EINVAL;
-		goto unref;
-	}
-
-	ret = drm_gem_create_mmap_offset(obj);
-	if (ret)
-		goto unref;
-
-	*offset = drm_vma_node_offset_addr(&obj->vma_node);
-unref:
-	drm_gem_object_put_unlocked(obj);
-
-	return ret;
-}
-
 static struct page **_get_pages(struct vkms_gem_object *vkms_obj)
 {
 	struct drm_gem_object *gem_obj = &vkms_obj->gem;
-- 
2.20.0.rc1

