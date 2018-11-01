Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B472C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073962081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073962081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeKBBQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:16:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeKBBQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:16:29 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:8109:92c0:207d:3d24:60ad:a75d:194d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 75B3E2726B9;
        Thu,  1 Nov 2018 16:12:51 +0000 (GMT)
From:   Robert Foss <robert.foss@collabora.com>
To:     robdclark@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Robert Foss <robert.foss@collabora.com>
Subject: [PATCH v1] drm/msm: Move fence put to where failure occurs
Date:   Thu,  1 Nov 2018 17:12:28 +0100
Message-Id: <20181101161228.19432-1-robert.foss@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dma_fence_wait fails to wait for a supplied in-fence in
msm_ioctl_gem_submit, make sure we release that in-fence.

Also remove this dma_fence_put() from the 'out' label.

Signed-off-by: Robert Foss <robert.foss@collabora.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index a90aedd6883a..3e7704af5b24 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -411,7 +411,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_file_private *ctx = file->driver_priv;
 	struct msm_gem_submit *submit;
 	struct msm_gpu *gpu = priv->gpu;
-	struct dma_fence *in_fence = NULL;
 	struct sync_file *sync_file = NULL;
 	struct msm_gpu_submitqueue *queue;
 	struct msm_ringbuffer *ring;
@@ -444,7 +443,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	ring = gpu->rb[queue->prio];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
-		in_fence = sync_file_get_fence(args->fence_fd);
+		struct dma_fence *in_fence = sync_file_get_fence(
+			args->fence_fd);
 
 		if (!in_fence)
 			return -EINVAL;
@@ -455,8 +455,10 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		 */
 		if (!dma_fence_match_context(in_fence, ring->fctx->context)) {
 			ret = dma_fence_wait(in_fence, true);
-			if (ret)
+			if (ret) {
+				dma_fence_put(in_fence);
 				return ret;
+			}
 		}
 	}
 
@@ -583,8 +585,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	}
 
 out:
-	if (in_fence)
-		dma_fence_put(in_fence);
 	submit_cleanup(submit);
 	if (ret)
 		msm_gem_submit_free(submit);
-- 
2.17.1

