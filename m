Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753818AbeDRElr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 00:41:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753639AbeDRElp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 00:41:45 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        peterx@redhat.com
Subject: [PATCH 1/3] intel-iommu: add some traces for PSIs
Date: Wed, 18 Apr 2018 12:41:28 +0800
Message-Id: <20180418044130.12339-2-peterx@redhat.com>
In-Reply-To: <20180418044130.12339-1-peterx@redhat.com>
References: <20180418044130.12339-1-peterx@redhat.com>
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
