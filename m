Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeDJSZP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:25:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeDJSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:25:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF3BA60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: amd-gfx@lists.freedesktop.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>, Roger He <Hongbo.He@amd.com>,
        Monk Liu <Monk.Liu@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amdgpu: limit DMA size to PAGE_SIZE for scatter-gather buffers
Date: Tue, 10 Apr 2018 14:25:03 -0400
Message-Id: <1523384705-3976-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is expecing to observe the same number of buffers returned from
dma_map_sg() function compared to sg_alloc_table_from_pages(). This
doesn't hold true universally especially for systems with IOMMU.

IOMMU driver tries to combine buffers into a single DMA address as much
as it can. The right thing is to tell the DMA layer how much combining
IOMMU can do.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e4bb435..02465cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -787,6 +787,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
 
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
+
 	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
 				      ttm->num_pages << PAGE_SHIFT,
 				      GFP_KERNEL);
-- 
2.7.4
