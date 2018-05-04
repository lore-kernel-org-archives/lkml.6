Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeEDCfE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:35:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeEDCfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:35:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>, peterx@redhat.com
Subject: [PATCH v3 0/2] iommu/vt-d: Fix mapping PSI missing for iommu_map()
Date: Fri,  4 May 2018 10:34:51 +0800
Message-Id: <20180504023453.25682-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- drop the pr_debug patch [Joerg]
- rename all the subjects as suggested [Joerg]
- rebase

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

Patch 1 introduces a helper to notify the MAP PSIs.

Patch 2 fixes the real problem by making sure every domain mapping
will trigger the MAP PSI notifications.

Without the patchset, nested device assignment (assign one device
firstly to L1 guest, then to L2 guest) won't work for QEMU.  After
applying the patchset, it works.

Please review.  Thanks.

Peter Xu (2):
  iommu/vt-d: Introduce __mapping_notify_one()
  iommu/vt-d: Fix iotlb psi missing for mappings

 drivers/iommu/intel-iommu.c | 65 ++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 19 deletions(-)

-- 
2.17.0
