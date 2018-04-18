Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDRK6M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:58:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48896 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeDRK6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:58:11 -0400
From: Xu Yandong <xuyandong2@huawei.com>
To: <alex.williamson@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhang.zhanghailiang@huawei.com>, <wangxinxin.wang@huawei.com>,
        Xu Yandong <xuyandong2@huawei.com>
Subject: [PATCH] vfio iommu type1: no need to check task->mm if task has been destroyed
Date: Wed, 18 Apr 2018 18:55:45 +0800
Message-ID: <20180418105545.13488-1-xuyandong2@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.33.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task structure in vfio_dma struct used to identify the same
task who map it or other task who shares same adress space is
allowed to unmap. But if the task who map it has exited, mm of
the task has been set to null, we should unmap the vfio dma directly.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
Hi all,
When I unplug a vcpu from a VM lanched with a VFIO hostdev device,
I found that the *vfio_dma* mapped by this vcpu task could not be unmaped
in the future, so I send this patch to unmap vfio_dma directly if the
task who mapped it has exited. 

Howerver this patch may introduce a new security risk because any task can 
unmap the *vfio_dma* if the mapper task has exited.  

---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5c212bf..601a353 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -947,7 +947,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		 * Task with same address space who mapped this iova range is
 		 * allowed to unmap the iova range.
 		 */
-		if (dma->task->mm != current->mm)
+		if (dma->task->mm && (dma->task->mm != current->mm))
 			break;
 
 		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
-- 
1.8.3.1
