Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeC3CTz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 22:19:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45892 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751893AbeC3CTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 22:19:53 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: <oded.gabbay@gmail.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdkfd: Fix the error return code in kfd_ioctl_unmap_memory_from_gpu()
Date: Fri, 30 Mar 2018 02:25:17 +0000
Message-ID: <1522376717-136486-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing NULL pointer to PTR_ERR will result in return value of 0
indicating success which is clearly not what it is intended here.
This patch returns -EINVAL instead.

Fixes: 5ec7e02854b3 ("drm/amdkfd: Add ioctls for GPUVM memory management")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cd679cf..c32a341 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1421,7 +1421,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 
 	pdd = kfd_get_process_device_data(dev, p);
 	if (!pdd) {
-		err = PTR_ERR(pdd);
+		err = -EINVAL;
 		goto bind_process_to_device_failed;
 	}
