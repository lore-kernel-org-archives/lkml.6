Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeDRLns (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:43:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42218 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753100AbeDRLnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:45 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
Date: Wed, 18 Apr 2018 12:40:38 +0100
Message-ID: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an iova list associated with a vfio 
iommu. The list is kept updated taking care of iommu apertures,
and reserved regions. Also this series adds checks for any conflict
with existing dma mappings whenever a new device group is attached to
the domain.

User-space can retrieve valid iova ranges using VFIO_IOMMU_GET_INFO
ioctl capability chains. Any dma map request outside the valid iova
range will be rejected.

v5 --> v6

 -Rebased to 4.17-rc1
 -Changed the ordering such that previous patch#7 "iommu/dma: Move
  PCI window region reservation back...")  is now patch #4. This
  will avoid any bisection issues pointed out by Alex.
 -Added Robin's Reviewed-by tag for patch#4

v4 --> v5
Rebased to next-20180315.
 
 -Incorporated the corner case bug fix suggested by Alex to patch #5.
 -Based on suggestions by Alex and Robin, added patch#7. This
  moves the PCI window  reservation back in to DMA specific path.
  This is to fix the issue reported by Eric[1].

Note:
The patch #7 has dependency with [2][3]

1. https://patchwork.kernel.org/patch/10232043/
2. https://patchwork.kernel.org/patch/10216553/
3. https://patchwork.kernel.org/patch/10216555/

v3 --> v4
 Addressed comments received for v3.
 -dma_addr_t instead of phys_addr_t
 -LIST_HEAD() usage.
 -Free up iova_copy list in case of error.
 -updated logic in filling the iova caps info(patch #5)

RFCv2 --> v3
 Removed RFC tag.
 Addressed comments from Alex and Eric:
 - Added comments to make iova list management logic more clear.
 - Use of iova list copy so that original is not altered in
   case of failure.

RFCv1 --> RFCv2
 Addressed comments from Alex:
-Introduced IOVA list management and added checks for conflicts with 
 existing dma map entries during attach/detach.

Shameer Kolothum (7):
  vfio/type1: Introduce iova list and add iommu aperture validity check
  vfio/type1: Check reserve region conflict and update iova list
  vfio/type1: Update iova list on detach
  iommu/dma: Move PCI window region reservation back into dma specific
    path.
  vfio/type1: check dma map request is within a valid iova range
  vfio/type1: Add IOVA range capability support
  vfio/type1: remove duplicate retrieval of reserved regions

 drivers/iommu/dma-iommu.c       |  54 ++---
 drivers/vfio/vfio_iommu_type1.c | 497 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h       |  23 ++
 3 files changed, 533 insertions(+), 41 deletions(-)

-- 
2.7.4
