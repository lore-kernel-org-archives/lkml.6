Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeEaHnv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:43:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50150 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754045AbeEaHnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:43:43 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH 0/7] add non-strict mode support for arm-smmu-v3
Date: Thu, 31 May 2018 15:42:42 +0800
Message-ID: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In common, a IOMMU unmap operation follow the below steps:
1. remove the mapping in page table of the specified iova range
2. execute tlbi command to invalid the mapping which is cached in TLB
3. wait for the above tlbi operation to be finished
4. free the IOVA resource
5. free the physical memory resource

This maybe a problem when unmap is very frequently, the combination of tlbi
and wait operation will consume a lot of time. A feasible method is put off
tlbi and iova-free operation, when accumulating to a certain number or
reaching a specified time, execute only one tlbi_all command to clean up
TLB, then free the backup IOVAs. Mark as non-strict mode.

But it must be noted that, although the mapping has already been removed in
the page table, it maybe still exist in TLB. And the freed physical memory
may also be reused for others. So a attacker can persistent access to memory
based on the just freed IOVA, to obtain sensible data or corrupt memory. So
the VFIO should always choose the strict mode.

Some may consider put off physical memory free also, that will still follow
strict mode. But for the map_sg cases, the memory allocation is not controlled
by IOMMU APIs, so it is not enforceable.

Fortunately, Intel and AMD have already applied the non-strict mode, and put
queue_iova() operation into the common file dma-iommu.c., and my work is based
on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
unmap, but Intel and AMD IOMMU drivers are not.

Below is the performance data of strict vs non-strict for NVMe device:
Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
Randomly Write IOPS: 143K(strict) vs 513K(non-strict)


Zhen Lei (7):
  iommu/dma: fix trival coding style mistake
  iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
  iommu: prepare for the non-strict mode support
  iommu/amd: make sure TLB to be flushed before IOVA freed
  iommu/dma: add support for non-strict mode
  iommu/io-pgtable-arm: add support for non-strict mode
  iommu/arm-smmu-v3: add support for non-strict mode

 drivers/iommu/amd_iommu.c          |  2 +-
 drivers/iommu/arm-smmu-v3.c        | 16 ++++++++++++---
 drivers/iommu/arm-smmu.c           |  2 +-
 drivers/iommu/dma-iommu.c          | 41 ++++++++++++++++++++++++++++++--------
 drivers/iommu/io-pgtable-arm-v7s.c |  6 +++---
 drivers/iommu/io-pgtable-arm.c     | 28 ++++++++++++++------------
 drivers/iommu/io-pgtable.h         |  2 +-
 drivers/iommu/ipmmu-vmsa.c         |  2 +-
 drivers/iommu/msm_iommu.c          |  2 +-
 drivers/iommu/mtk_iommu.c          |  2 +-
 drivers/iommu/qcom_iommu.c         |  2 +-
 include/linux/iommu.h              |  5 +++++
 12 files changed, 76 insertions(+), 34 deletions(-)

-- 
1.8.3
