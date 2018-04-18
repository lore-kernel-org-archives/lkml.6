Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeDRIkA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:40:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752597AbeDRIj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:39:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>, peterx@redhat.com
Subject: [PATCH v2 0/3] intel-iommu: fix mapping PSI missing for iommu_map()
Date: Wed, 18 Apr 2018 16:39:50 +0800
Message-Id: <20180418083953.21492-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- cc correct people and iommu list

(PSI stands for: Page Selective Invalidations)

Intel IOMMU has the caching mode to ease emulation of the device.
When that bit is set, we need to send PSIs even for newly mapped
pages.  However current driver is not fully obey the rule.  E.g.,
iommu_map() API will only do the mapping but it never sent the PSIs
before.  That can be problematic to emulated IOMMU devices since
they'll never be able to build up the shadow page tables if without
such information.  This patchset tries to fix the problem.

Patch 1 is a tracing enhancement that helped me to triage the problem.
It might even be useful in the future.

Patch 2 generalized a helper to notify the MAP PSIs.

Patch 3 fixes the real problem by making sure every domain mapping
will trigger the MAP PSI notifications.

Without the patchset, nested device assignment (assign one device
firstly to L1 guest, then to L2 guest) won't work for QEMU.  After
applying the patchset, it works.

Please review.  Thanks.

Peter Xu (3):
  intel-iommu: add some traces for PSIs
  intel-iommu: generalize __mapping_notify_one()
  intel-iommu: fix iotlb psi missing for mappings

 drivers/iommu/dmar.c        |  3 ++
 drivers/iommu/intel-iommu.c | 68 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.14.3
