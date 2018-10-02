Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F31C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E622089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E622089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeJBULa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeJBUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:28 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9643C4D;
        Tue,  2 Oct 2018 13:28:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 093/228] drm/omap: gem: Fix mm_list locking
Date:   Tue,  2 Oct 2018 06:23:10 -0700
Message-Id: <20181002132505.637714377@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit 5117bd898e8c0a31e8ab3a9b8523aecf0706e997 ]

- None of the list walkings where protected.

- Switch to a mutex since the list walking at device resume time can
  sleep when pinning buffers through the tiler.

Only thing we need to be careful with here is that while we walk the
list we can't unreference any gem objects, since the final unref would
result in a recursive deadlock. But the only functions that walk the
list is the device resume and debugfs dumping, so all safe.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_debugfs.c |    2 ++
 drivers/gpu/drm/omapdrm/omap_drv.c     |    2 +-
 drivers/gpu/drm/omapdrm/omap_drv.h     |    2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c     |   15 +++++++++------
 4 files changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
+++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
@@ -37,7 +37,9 @@ static int gem_show(struct seq_file *m,
 		return ret;
 
 	seq_printf(m, "All Objects:\n");
+	mutex_lock(&priv->list_lock);
 	omap_gem_describe_objects(&priv->obj_list, m);
+	mutex_unlock(&priv->list_lock);
 
 	mutex_unlock(&dev->struct_mutex);
 
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -540,7 +540,7 @@ static int omapdrm_init(struct omap_drm_
 	priv->omaprev = soc ? (unsigned int)soc->data : 0;
 	priv->wq = alloc_ordered_workqueue("omapdrm", 0);
 
-	spin_lock_init(&priv->list_lock);
+	mutex_init(&priv->list_lock);
 	INIT_LIST_HEAD(&priv->obj_list);
 
 	/* Allocate and initialize the DRM device. */
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -71,7 +71,7 @@ struct omap_drm_private {
 	struct workqueue_struct *wq;
 
 	/* lock for obj_list below */
-	spinlock_t list_lock;
+	struct mutex list_lock;
 
 	/* list of GEM objects: */
 	struct list_head obj_list;
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1001,6 +1001,7 @@ int omap_gem_resume(struct drm_device *d
 	struct omap_gem_object *omap_obj;
 	int ret = 0;
 
+	mutex_lock(&priv->list_lock);
 	list_for_each_entry(omap_obj, &priv->obj_list, mm_list) {
 		if (omap_obj->block) {
 			struct drm_gem_object *obj = &omap_obj->base;
@@ -1012,12 +1013,14 @@ int omap_gem_resume(struct drm_device *d
 					omap_obj->roll, true);
 			if (ret) {
 				dev_err(dev->dev, "could not repin: %d\n", ret);
-				return ret;
+				goto done;
 			}
 		}
 	}
 
-	return 0;
+done:
+	mutex_unlock(&priv->list_lock);
+	return ret;
 }
 #endif
 
@@ -1085,9 +1088,9 @@ void omap_gem_free_object(struct drm_gem
 
 	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
 
-	spin_lock(&priv->list_lock);
+	mutex_lock(&priv->list_lock);
 	list_del(&omap_obj->mm_list);
-	spin_unlock(&priv->list_lock);
+	mutex_unlock(&priv->list_lock);
 
 	/* this means the object is still pinned.. which really should
 	 * not happen.  I think..
@@ -1206,9 +1209,9 @@ struct drm_gem_object *omap_gem_new(stru
 			goto err_release;
 	}
 
-	spin_lock(&priv->list_lock);
+	mutex_lock(&priv->list_lock);
 	list_add(&omap_obj->mm_list, &priv->obj_list);
-	spin_unlock(&priv->list_lock);
+	mutex_unlock(&priv->list_lock);
 
 	return obj;
 


