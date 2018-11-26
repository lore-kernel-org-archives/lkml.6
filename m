Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5C7208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YKVEjrQx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PClPV00H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5C7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeK0Icx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:32:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0Icw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:32:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65FB660227; Mon, 26 Nov 2018 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543268242;
        bh=0FOm2CAkJ8g9btAVbOAh7SfSITWkFjG+CZ+dl/+Ip4M=;
        h=From:To:Cc:Subject:Date:From;
        b=YKVEjrQxE/lGjPoUnl63tpTlR9n9O5AnQZ7LYpIKO/uYEYDJT+1XPNPIGzx+3w2gk
         mjt+jq4tovqsaV2e+VPqVDG0izUqpJiJj9RDLXJhoip/uQ7Fc3w2Umf65o2eVNw0eb
         UmNqzQa5s1yzmwu39cwct6+Zn+/SxvYRbk3Q3xwg=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDD3160227;
        Mon, 26 Nov 2018 21:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543268241;
        bh=0FOm2CAkJ8g9btAVbOAh7SfSITWkFjG+CZ+dl/+Ip4M=;
        h=From:To:Cc:Subject:Date:From;
        b=PClPV00Hr+Wukorsy+9oCeu+zsRoNYJSFgfdlzDqIc/E2D/+wap6N1R+v93dhBi6u
         VBPgULOmfRVS/aGwzi9LMaLfMMU49DeazKkhFAMGtZ1KG4TVt13hyD89ITzeqtF2nm
         67/EUFUSmtdx0EIhoamxp28S4rP95f208ubgLN/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDD3160227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     airlied@linux.ie, robdclark@gmail.com
Cc:     tfiga@chromium.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Date:   Tue, 27 Nov 2018 03:07:10 +0530
Message-Id: <20181126213710.3084-1-vivek.gautam@codeaurora.org>
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
Cc: Jordan Crouse <jcrouse@codeaurora.org> 
Cc: Sean Paul <seanpaul@chromium.org>
---

Changes since v1:
 - Addressed Jordan's and Tomasz's comments for
   - moving sg dma addresses preparation out of the coditional
     check to the main path so we do it irrespective of whether
     the buffer is cached or uncached.
   - Enhance the comment to explain this dma addresses prepartion.

 drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 00c795ced02c..1811ac23a31c 100644
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
@@ -104,12 +106,21 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			return ptr;
 		}
 
-		/* For non-cached buffers, ensure the new pages are clean
+		/*
+		 * dma_sync_sg_*() flush the physical pages, so point
+		 * sg->dma_address to the physical ones for the right behavior.
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
+					       DMA_TO_DEVICE);
 	}
 
 	return msm_obj->pages;
@@ -133,14 +144,16 @@ static void put_pages(struct drm_gem_object *obj)
 
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
+						    DMA_FROM_DEVICE);
 
 			sg_free_table(msm_obj->sgt);
 			kfree(msm_obj->sgt);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

