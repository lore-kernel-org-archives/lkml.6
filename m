Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA95DC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74280208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d7lOWIXJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aX5BEFpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74280208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeKTUX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:23:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeKTUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:23:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0023D607DC; Tue, 20 Nov 2018 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542707710;
        bh=sBbu+0gGeDeVTUJHEDPT+DUyuG8owCDgrf9Y2yTAucc=;
        h=From:To:Cc:Subject:Date:From;
        b=d7lOWIXJMyO6EDDvJH3OynMWI7HzNvw5o/KtXRgWpt7IcnnKoyu7MZ7Utz/AOkaAz
         nNiUBfuWM+cAaw8+GQLQVPBTPEmwvlyQ6CJ+BYmIevpzr3FsjlnXK7AbRtK3M6QGlS
         qyyOnAT7ETEsipT7Hl0Yu9/F4s9ebqdfWT0WDqFk=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FA38607DC;
        Tue, 20 Nov 2018 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542707709;
        bh=sBbu+0gGeDeVTUJHEDPT+DUyuG8owCDgrf9Y2yTAucc=;
        h=From:To:Cc:Subject:Date:From;
        b=aX5BEFpfgvhPappPDG6/snNbc8YlyfJSyMJu95j2BmSmlaPSqpuA5awMNjRHpLTov
         OirFX6HKbgj9rk+HLWdh9ZH2LBCJZvyp4ZQjsnRszQYsIDsmD/hCExJGork+LwjQ3e
         BpIkHyhr/+XVm4zhgEkIV65NOeQm4bKLiB0TuM/0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA38607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     robdclark@gmail.com, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Date:   Tue, 20 Nov 2018 15:24:37 +0530
Message-Id: <20181120095437.29820-1-vivek.gautam@codeaurora.org>
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
---

Tested on an MTP sdm845:
https://github.com/vivekgautam1/linux/tree/v4.19/sdm845-mtp-display-working

 drivers/gpu/drm/msm/msm_gem.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 00c795ced02c..d7a7af610803 100644
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
@@ -107,9 +109,19 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
-		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-			dma_map_sg(dev->dev, msm_obj->sgt->sgl,
-					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+		if (msm_obj->flags & (MSM_BO_WC | MSM_BO_UNCACHED)) {
+			/*
+			 * Fake up the SG table so that dma_sync_sg_*()
+			 * can be used to flush the pages associated with it.
+			 */
+			for_each_sg(msm_obj->sgt->sgl, s,
+				    msm_obj->sgt->nents, i)
+				sg_dma_address(s) = sg_phys(s);
+
+			dma_sync_sg_for_device(dev->dev, msm_obj->sgt->sgl,
+					       msm_obj->sgt->nents,
+					       DMA_TO_DEVICE);
+		}
 	}
 
 	return msm_obj->pages;
@@ -137,10 +149,11 @@ static void put_pages(struct drm_gem_object *obj)
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

