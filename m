Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeDRIkG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:40:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752597AbeDRIkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:40:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>, peterx@redhat.com
Subject: [PATCH v2 1/3] intel-iommu: add some traces for PSIs
Date: Wed, 18 Apr 2018 16:39:51 +0800
Message-Id: <20180418083953.21492-2-peterx@redhat.com>
In-Reply-To: <20180418083953.21492-1-peterx@redhat.com>
References: <20180418083953.21492-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is helpful to debug and triage PSI notification missings.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/dmar.c        | 3 +++
 drivers/iommu/intel-iommu.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9a7ffd13c7f0..62ae26c3f7b7 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1325,6 +1325,9 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	struct qi_desc desc;
 	int ih = 0;
 
+	pr_debug("%s: iommu %d did %u addr 0x%llx order %u type %llx\n",
+		 __func__, iommu->seq_id, did, addr, size_order, type);
+
 	if (cap_write_drain(iommu->cap))
 		dw = 1;
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01cb7d1..a64da83e867c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1396,6 +1396,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 	u64 val = 0, val_iva = 0;
 	unsigned long flag;
 
+	pr_debug("%s: iommu %d did %u addr 0x%llx order %u type %llx\n",
+		 __func__, iommu->seq_id, did, addr, size_order, type);
+
 	switch (type) {
 	case DMA_TLB_GLOBAL_FLUSH:
 		/* global flush doesn't need set IVA_REG */
-- 
2.14.3
