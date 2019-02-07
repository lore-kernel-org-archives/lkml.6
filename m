Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02373C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2452173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGX0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:26:16 -0500
Received: from anholt.net ([50.246.234.109]:58870 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfBGX0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:26:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F30F910A2BFC;
        Thu,  7 Feb 2019 15:26:14 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tVHdxSERm-th; Thu,  7 Feb 2019 15:26:14 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id ED8FB10A0353;
        Thu,  7 Feb 2019 15:26:13 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8745C2FE464C; Thu,  7 Feb 2019 15:26:13 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/v3d: Fix BO stats accounting for dma-buf-imported buffers.
Date:   Thu,  7 Feb 2019 15:26:13 -0800
Message-Id: <20190207232613.24981-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always decrement at GEM free, so make sure we increment at GEM
creation for dma-bufs.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_bo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a08766d39eab..b1766f096c4b 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -282,6 +282,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 			  struct dma_buf_attachment *attach,
 			  struct sg_table *sgt)
 {
+	struct v3d_dev *v3d = to_v3d_dev(dev);
 	struct drm_gem_object *obj;
 	struct v3d_bo *bo;
 
@@ -296,6 +297,11 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 	obj->import_attach = attach;
 	v3d_bo_get_pages(bo);
 
+	mutex_lock(&v3d->bo_lock);
+	v3d->bo_stats.num_allocated++;
+	v3d->bo_stats.pages_allocated += obj->size >> PAGE_SHIFT;
+	mutex_unlock(&v3d->bo_lock);
+
 	v3d_mmu_insert_ptes(bo);
 
 	return obj;
-- 
2.20.0.rc1

