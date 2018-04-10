Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeDJVAL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:00:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:00:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DC2160249
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
        Felix Kuehling <Felix.Kuehling@amd.com>, Monk Liu <Monk.Liu@amd.com>,
        Roger He <Hongbo.He@amd.com>, Jim Qu <Jim.Qu@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Huang Rui <ray.huang@amd.com>, Tom St Denis <tom.stdenis@amd.com>,
        David Panariti <David.Panariti@amd.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for scatter-gather buffers
Date: Tue, 10 Apr 2018 16:59:55 -0400
Message-Id: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8e28270..1b031eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -851,7 +851,7 @@ static int gmc_v6_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		dev_warn(adev->dev, "amdgpu: No coherent DMA available.\n");
 	}
-
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 	r = gmc_v6_0_init_microcode(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to load mc firmware!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 86e9d682..0a4b2cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -999,6 +999,7 @@ static int gmc_v7_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		pr_warn("amdgpu: No coherent DMA available\n");
 	}
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 
 	r = gmc_v7_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9a813d8..b171529 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1096,6 +1096,7 @@ static int gmc_v8_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		pr_warn("amdgpu: No coherent DMA available\n");
 	}
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 
 	r = gmc_v8_0_init_microcode(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3b7e7af..36e658ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -855,6 +855,7 @@ static int gmc_v9_0_sw_init(void *handle)
 		pci_set_consistent_dma_mask(adev->pdev, DMA_BIT_MASK(32));
 		printk(KERN_WARNING "amdgpu: No coherent DMA available.\n");
 	}
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
 
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
-- 
2.7.4
