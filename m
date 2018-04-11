Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeDKWLd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 18:11:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeDKWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 18:11:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CE3660386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: amd-gfx@lists.freedesktop.org, sulrich@codeaurora.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Pixel Ding <Pixel.Ding@amd.com>, Horace Chen <horace.chen@amd.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3] drm/amdgpu: limit DMA size to PAGE_SIZE for scatter-gather buffers
Date: Wed, 11 Apr 2018 18:11:22 -0400
Message-Id: <1523484684-10426-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is expecing to observe the same number of buffers returned from
dma_map_sg() function compared to sg_alloc_table_from_pages(). This
doesn't hold true universally especially for systems with IOMMU.

The hardware actually needs the dma_address on a page by page basis.
Joining multiple consecutive pages into one entry is just additional
overhead which we don't need.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af1b879..91abe1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1948,6 +1948,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* init the mode config */
 	drm_mode_config_init(adev->ddev);
 
+	/* limit scatter-gather buffer size to PAGE_SIZE */
+	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
+
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
 		/* failed in exclusive mode due to timeout */
-- 
2.7.4
