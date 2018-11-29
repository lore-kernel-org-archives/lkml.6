Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3745DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE99520989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YuGbiPJR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hVUigHyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE99520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeK3BIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:08:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37904 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeK3BIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:08:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EB1360C4B; Thu, 29 Nov 2018 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543500206;
        bh=sxFMD/76Jtw6QWug0AqQn7YNLlWUypjhsnIqJ7q7kGo=;
        h=From:To:Cc:Subject:Date:From;
        b=YuGbiPJRGHcqqPOTAWvIgFxea/I/HgehayrvIvX7PUZkfYDWNKaMNEoByE2gZPmR2
         LDoL/1072uuZ7x07UWl00tuJWaFw8LEXq4pP33KNW/2niqU7FRZPhSUv7dQpoIPdMd
         5bzLmus5uBt3pC5iPXq2jzcShtHGQWvpi/xwHMjk=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC48D60B73;
        Thu, 29 Nov 2018 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543500205;
        bh=sxFMD/76Jtw6QWug0AqQn7YNLlWUypjhsnIqJ7q7kGo=;
        h=From:To:Cc:Subject:Date:From;
        b=hVUigHytcaPBCb0n1dEC/hySpyBg4FbT7LvzzhZU8MOn1KSmIC/RMDPF/Y0ABEBzB
         /VQ4mgAHeoaspCzKSayVkf41Ehn2wij5glpVjpWpo4fh/BUwwuX1OnRPUOhKwF4ve6
         FjKODYh8RN3yTgUbvgcBcw6n8X/9IwevUohRkN5Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC48D60B73
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     airlied@linux.ie, robdclark@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, tfiga@chromium.org,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Date:   Thu, 29 Nov 2018 19:33:15 +0530
Message-Id: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg() expects a DMA domain. However, the drm devices
have been traditionally using unmanaged iommu domain which
is non-dma type. Using dma mapping APIs with that domain is bad.

Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
to do the cache maintenance.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Tomasz Figa <tfiga@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Sean Paul <seanpaul@chromium.org>
---

Changes since v2:
 - Addressed Tomasz's comment to keep DMA_BIDIRECTIONAL dma direction
   flag intact.
 - Updated comment for sg's dma-address assignment as per Tomasz'
   suggestion.

 drivers/gpu/drm/msm/msm_gem.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 00c795ced02c..7048e9fe00c6 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -81,6 +81,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		struct drm_device *dev = obj->dev;
 		struct page **p;
 		int npages = obj->size >> PAGE_SHIFT;
+		struct scatterlist *s;
+		int i;
 
 		if (use_pages(obj))
 			p = drm_gem_get_pages(obj);
@@ -104,12 +106,23 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			return ptr;
 		}
 
-		/* For non-cached buffers, ensure the new pages are clean
+		/*
+		 * Some implementations of the DMA mapping ops expect
+		 * physical addresses of the pages to be stored as DMA
+		 * addresses of the sglist entries. To work around it,
+		 * set them here explicitly.
+		 */
+		for_each_sg(msm_obj->sgt->sgl, s, msm_obj->sgt->nents, i)
+			sg_dma_address(s) = sg_phys(s);
+
+		/*
+		 * For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
-		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-			dma_map_sg(dev->dev, msm_obj->sgt->sgl,
-					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
+			dma_sync_sg_for_device(dev->dev, msm_obj->sgt->sgl,
+					       msm_obj->sgt->nents,
+					       DMA_BIDIRECTIONAL);
 	}
 
 	return msm_obj->pages;
@@ -133,14 +146,16 @@ static void put_pages(struct drm_gem_object *obj)
 
 	if (msm_obj->pages) {
 		if (msm_obj->sgt) {
-			/* For non-cached buffers, ensure the new
+			/*
+			 * For non-cached buffers, ensure the new
 			 * pages are clean because display controller,
 			 * GPU, etc. are not coherent:
 			 */
-			if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-				dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
-					     msm_obj->sgt->nents,
-					     DMA_BIDIRECTIONAL);
+			if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED))
+				dma_sync_sg_for_cpu(obj->dev->dev,
+						    msm_obj->sgt->sgl,
+						    msm_obj->sgt->nents,
+						    DMA_BIDIRECTIONAL);
 
 			sg_free_table(msm_obj->sgt);
 			kfree(msm_obj->sgt);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

