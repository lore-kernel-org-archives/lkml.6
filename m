Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232BAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5784223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5784223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbeKOWL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:11:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeKOWL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:11:59 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0962CBA842BE4;
        Thu, 15 Nov 2018 20:04:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 15 Nov 2018
 20:03:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <Shaoyun.Liu@amd.com>,
        <David.Francis@amd.com>, <ray.huang@amd.com>, <Feifei.Xu@amd.com>,
        <Likun.Gao@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] drm/amdgpu: remove set but not used variable 'ring'
Date:   Thu, 15 Nov 2018 20:00:35 +0800
Message-ID: <20181115120035.4328-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: In function 'psp_v10_0_ring_stop':
drivers/gpu/drm/amd/amdgpu/psp_v10_0.c:230:19: warning:
 variable 'ring' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/psp_v3_1.c: In function 'psp_v3_1_ring_stop':
drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:359:19: warning:
 variable ‘ring’ set but not used [-Wunused-but-set-variable]

It not used since commit
4ef72453311a ("drm/amdgpu: added api for stopping psp ring (v2)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
v2:also remove it in psp_v3_1_ring_stop
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 295c220..d78b430 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -240,12 +240,9 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,
 			       enum psp_ring_type ring_type)
 {
 	int ret = 0;
-	struct psp_ring *ring;
 	unsigned int psp_ring_reg = 0;
 	struct amdgpu_device *adev = psp->adev;
 
-	ring = &psp->km_ring;
-
 	/* Write the ring destroy command to C2PMSG_64 */
 	psp_ring_reg = 3 << 16;
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index e1ebf77..cc5e3ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -356,12 +356,9 @@ static int psp_v3_1_ring_stop(struct psp_context *psp,
 			      enum psp_ring_type ring_type)
 {
 	int ret = 0;
-	struct psp_ring *ring;
 	unsigned int psp_ring_reg = 0;
 	struct amdgpu_device *adev = psp->adev;
 
-	ring = &psp->km_ring;
-
 	/* Write the ring destroy command to C2PMSG_64 */
 	psp_ring_reg = 3 << 16;
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
-- 
2.7.0


