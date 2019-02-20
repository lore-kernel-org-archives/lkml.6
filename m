Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA36020645
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfBTVDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:03:55 -0500
Received: from anholt.net ([50.246.234.109]:51848 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfBTVDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:03:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 612C110A047F;
        Wed, 20 Feb 2019 13:03:50 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OTQv1H3piqCp; Wed, 20 Feb 2019 13:03:48 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E385510A2D1F;
        Wed, 20 Feb 2019 13:03:44 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9E2352FE464F; Wed, 20 Feb 2019 13:03:43 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4/7] drm/vc4: Use drm_printer for the debugfs and runtime bo stats output.
Date:   Wed, 20 Feb 2019 13:03:40 -0800
Message-Id: <20190220210343.28157-4-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220210343.28157-1-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now I can extend the stats without more copy and pasting between the
two.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 48 +++++++++++-------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 8c509d560bf0..88ebd681d7eb 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -40,7 +40,7 @@ static bool is_user_label(int label)
 	return label >= VC4_BO_TYPE_COUNT;
 }
 
-static void vc4_bo_stats_dump(struct vc4_dev *vc4)
+static void vc4_bo_stats_print(struct drm_printer *p, struct vc4_dev *vc4)
 {
 	int i;
 
@@ -48,21 +48,21 @@ static void vc4_bo_stats_dump(struct vc4_dev *vc4)
 		if (!vc4->bo_labels[i].num_allocated)
 			continue;
 
-		DRM_INFO("%30s: %6dkb BOs (%d)\n",
-			 vc4->bo_labels[i].name,
-			 vc4->bo_labels[i].size_allocated / 1024,
-			 vc4->bo_labels[i].num_allocated);
+		drm_printf(p, "%30s: %6dkb BOs (%d)\n",
+			   vc4->bo_labels[i].name,
+			   vc4->bo_labels[i].size_allocated / 1024,
+			   vc4->bo_labels[i].num_allocated);
 	}
 
 	mutex_lock(&vc4->purgeable.lock);
 	if (vc4->purgeable.num)
-		DRM_INFO("%30s: %6zdkb BOs (%d)\n", "userspace BO cache",
-			 vc4->purgeable.size / 1024, vc4->purgeable.num);
+		drm_printf(p, "%30s: %6zdkb BOs (%d)\n", "userspace BO cache",
+			   vc4->purgeable.size / 1024, vc4->purgeable.num);
 
 	if (vc4->purgeable.purged_num)
-		DRM_INFO("%30s: %6zdkb BOs (%d)\n", "total purged BO",
-			 vc4->purgeable.purged_size / 1024,
-			 vc4->purgeable.purged_num);
+		drm_printf(p, "%30s: %6zdkb BOs (%d)\n", "total purged BO",
+			   vc4->purgeable.purged_size / 1024,
+			   vc4->purgeable.purged_num);
 	mutex_unlock(&vc4->purgeable.lock);
 }
 
@@ -71,30 +71,9 @@ static int vc4_bo_stats_debugfs(struct seq_file *m, void *unused)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int i;
-
-	mutex_lock(&vc4->bo_lock);
-	for (i = 0; i < vc4->num_labels; i++) {
-		if (!vc4->bo_labels[i].num_allocated)
-			continue;
-
-		seq_printf(m, "%30s: %6dkb BOs (%d)\n",
-			   vc4->bo_labels[i].name,
-			   vc4->bo_labels[i].size_allocated / 1024,
-			   vc4->bo_labels[i].num_allocated);
-	}
-	mutex_unlock(&vc4->bo_lock);
+	struct drm_printer p = drm_seq_file_printer(m);
 
-	mutex_lock(&vc4->purgeable.lock);
-	if (vc4->purgeable.num)
-		seq_printf(m, "%30s: %6zdkb BOs (%d)\n", "userspace BO cache",
-			   vc4->purgeable.size / 1024, vc4->purgeable.num);
-
-	if (vc4->purgeable.purged_num)
-		seq_printf(m, "%30s: %6zdkb BOs (%d)\n", "total purged BO",
-			   vc4->purgeable.purged_size / 1024,
-			   vc4->purgeable.purged_num);
-	mutex_unlock(&vc4->purgeable.lock);
+	vc4_bo_stats_print(&p, vc4);
 
 	return 0;
 }
@@ -473,8 +452,9 @@ struct vc4_bo *vc4_bo_create(struct drm_device *dev, size_t unaligned_size,
 	}
 
 	if (IS_ERR(cma_obj)) {
+		struct drm_printer p = drm_info_printer(vc4->dev->dev);
 		DRM_ERROR("Failed to allocate from CMA:\n");
-		vc4_bo_stats_dump(vc4);
+		vc4_bo_stats_print(&p, vc4);
 		return ERR_PTR(-ENOMEM);
 	}
 	bo = to_vc4_bo(&cma_obj->base);
-- 
2.20.1

