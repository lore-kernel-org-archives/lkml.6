Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeEaHoO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:44:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754126AbeEaHn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:43:59 -0400
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
Subject: [PATCH 6/7] iommu/io-pgtable-arm: add support for non-strict mode
Date: Thu, 31 May 2018 15:42:48 +0800
Message-ID: <1527752569-18020-7-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the non-strict mode, now we only tlbi and sync for the strict
mode. But for the non-leaf case, always follow strict mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e0f52db..1a65b7b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -287,7 +287,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep);
+			       arm_lpae_iopte *ptep, int strict);
 
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
@@ -329,7 +329,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
 		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
+		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp, IOMMU_STRICT) != sz))
 			return -EINVAL;
 	}
 
@@ -526,7 +526,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 				       unsigned long iova, size_t size,
 				       arm_lpae_iopte blk_pte, int lvl,
-				       arm_lpae_iopte *ptep)
+				       arm_lpae_iopte *ptep, int strict)
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte pte, *tablep;
@@ -571,15 +571,17 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	}
 
 	if (unmap_idx < 0)
-		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
+		return __arm_lpae_unmap(data, iova, size, lvl, tablep, strict);
+
+	if (strict)
+		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
 
-	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
 	return size;
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep)
+			       arm_lpae_iopte *ptep, int strict)
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
@@ -604,7 +606,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
-		} else {
+		} else if (strict) {
 			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
 		}
 
@@ -615,12 +617,12 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		 * minus the part we want to unmap
 		 */
 		return arm_lpae_split_blk_unmap(data, iova, size, pte,
-						lvl + 1, ptep);
+						lvl + 1, ptep, strict);
 	}
 
 	/* Keep on walkin' */
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
+	return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep, strict);
 }
 
 static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
@@ -633,7 +635,7 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;
 
-	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
+	return __arm_lpae_unmap(data, iova, size, lvl, ptep, strict);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
-- 
1.8.3
