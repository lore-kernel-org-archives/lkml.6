Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9QaQNssGHVsPOgAAmS7hNA
	; Sun, 10 Jun 2018 11:08:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CB149608B8; Sun, 10 Jun 2018 11:08:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 474D3600D0;
	Sun, 10 Jun 2018 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 474D3600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeFJLIm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 07:08:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35191 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753874AbeFJLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 07:08:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 111E44A3AAC54;
        Sun, 10 Jun 2018 19:08:31 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Sun, 10 Jun 2018
 19:08:25 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>,
        "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH v2 4/5] iommu/io-pgtable-arm: add support for non-strict mode
Date: Sun, 10 Jun 2018 19:07:22 +0800
Message-ID: <1528628843-10280-5-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the non-strict mode, now we only tlbi and sync for the strict
mode. But for the non-leaf case, always follow strict mode.

Use the lowest bit of the iova parameter to pass the strict mode:
0, IOMMU_STRICT;
1, IOMMU_NON_STRICT;
Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
other IOMMUs which still use strict mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 010a254..9234db3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -292,7 +292,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,

 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep);
+			       arm_lpae_iopte *ptep, int strict);

 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
@@ -334,7 +334,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);

 		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
+		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp, IOMMU_STRICT) != sz))
 			return -EINVAL;
 	}

@@ -531,7 +531,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 				       unsigned long iova, size_t size,
 				       arm_lpae_iopte blk_pte, int lvl,
-				       arm_lpae_iopte *ptep)
+				       arm_lpae_iopte *ptep, int strict)
 {
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte pte, *tablep;
@@ -576,15 +576,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	}

 	if (unmap_idx < 0)
-		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
+		return __arm_lpae_unmap(data, iova, size, lvl, tablep, strict);

 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+	if (!strict)
+		io_pgtable_tlb_sync(&data->iop);
+
 	return size;
 }

 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep)
+			       arm_lpae_iopte *ptep, int strict)
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
@@ -609,7 +612,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
-		} else {
+		} else if (strict) {
 			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
 		}

@@ -620,25 +623,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
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
 			     size_t size)
 {
+	int strict = ((iova & IOMMU_STRICT_MODE_MASK) == IOMMU_STRICT);
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
 	int lvl = ARM_LPAE_START_LVL(data);

+	iova &= ~IOMMU_STRICT_MODE_MASK;
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;

-	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
+	return __arm_lpae_unmap(data, iova, size, lvl, ptep, strict);
 }

 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
--
1.8.3
