Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeC1NP3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:15:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57876 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753278AbeC1NP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:15:28 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: <oded.gabbay@gmail.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdgpu: fix error return code in amdgpu_amdkfd_gpuvm_create_process_vm()
Date: Wed, 28 Mar 2018 13:20:56 +0000
Message-ID: <1522243256-94061-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return error code -ENOMEM from the eviction fence create fail
error handling case instead of 0, as done elsewhere in this function.

Fixes: a46a2cd103a8 ("drm/amdgpu: Add GPUVM memory management functions for KFD")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a12a165..c5c9c6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -846,6 +846,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
 						   current->mm);
 		if (!info->eviction_fence) {
 			pr_err("Failed to create eviction fence\n");
+			ret = -ENOMEM;
 			goto create_evict_fence_fail;
 		}
