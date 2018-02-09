Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeBIMLF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:11:05 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:55555 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeBIMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:11:03 -0500
X-Google-Smtp-Source: AH8x226i8/qUD4MXEmDxFIJC5WFUn74TrNglXJgM4VlIeNmu58CuyUHRqQljb2pBu9I0kxeG6oN4wA==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: daniel@ffwll.ch, airlied@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH] gpu/drm/udl: Replace struct_mutex with driver private lock
Date: Fri,  9 Feb 2018 17:40:56 +0530
Message-Id: <1518178256-17157-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->struct_mutex is the Big DRM Lock and the only bit where
it’s mandatory is serializing GEM buffer object destruction.
Which unfortunately means drivers have to keep track of that
lock and either call unreference or unreference_locked
depending upon context. Core GEM doesn’t have a need for
struct_mutex any more since kernel 4.8.

For drivers that need struct_mutex it should be replaced by a driver
private lock.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/gpu/drm/udl/udl_dmabuf.c | 5 +++--
 drivers/gpu/drm/udl/udl_drv.h    | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c b/drivers/gpu/drm/udl/udl_dmabuf.c
index 2867ed1..120d2d9 100644
--- a/drivers/gpu/drm/udl/udl_dmabuf.c
+++ b/drivers/gpu/drm/udl/udl_dmabuf.c
@@ -76,6 +76,7 @@ static struct sg_table *udl_map_dma_buf(struct dma_buf_attachment *attach,
 	struct udl_drm_dmabuf_attachment *udl_attach = attach->priv;
 	struct udl_gem_object *obj = to_udl_bo(attach->dmabuf->priv);
 	struct drm_device *dev = obj->base.dev;
+	struct udl_device *udl = dev->dev_private;
 	struct scatterlist *rd, *wr;
 	struct sg_table *sgt = NULL;
 	unsigned int i;
@@ -112,7 +113,7 @@ static struct sg_table *udl_map_dma_buf(struct dma_buf_attachment *attach,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	mutex_lock(&dev->struct_mutex);
+	mutex_lock(&udl->urbs.plock);
 
 	rd = obj->sg->sgl;
 	wr = sgt->sgl;
@@ -137,7 +138,7 @@ static struct sg_table *udl_map_dma_buf(struct dma_buf_attachment *attach,
 	attach->priv = udl_attach;
 
 err_unlock:
-	mutex_unlock(&dev->struct_mutex);
+	mutex_unlock(&udl->urbs.plock);
 	return sgt;
 }
 
diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 2a75ab8..24cca17 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -39,6 +39,7 @@ struct urb_node {
 
 struct urb_list {
 	struct list_head list;
+	struct mutex plock;
 	spinlock_t lock;
 	struct semaphore limit_sem;
 	int available;
-- 
2.7.4
