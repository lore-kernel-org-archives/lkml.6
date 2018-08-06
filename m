Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D3BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B377D208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B377D208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeHFOgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:36:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40109 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730733AbeHFOgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:36:47 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A353BA7BA67F5;
        Mon,  6 Aug 2018 20:27:50 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 20:27:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
Subject: [PATCH v4 3/5] iommu/io-pgtable-arm: add support for non-strict mode
Date:   Mon, 6 Aug 2018 20:27:02 +0800
Message-ID: <1533558424-16748-4-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
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

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 27 ++++++++++++++++++---------
 drivers/iommu/io-pgtable.h     |  3 +++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 010a254..bb61bef 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -292,7 +292,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,

 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep);
+			       arm_lpae_iopte *ptep, bool strict);

 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 				phys_addr_t paddr, arm_lpae_iopte prot,
@@ -319,6 +319,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     arm_lpae_iopte prot, int lvl,
 			     arm_lpae_iopte *ptep)
 {
+	size_t unmapped;
 	arm_lpae_iopte pte = *ptep;

 	if (iopte_leaf(pte, lvl)) {
@@ -334,7 +335,8 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);

 		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
+		unmapped = __arm_lpae_unmap(data, iova, sz, lvl, tblp, true);
+		if (WARN_ON(unmapped != sz))
 			return -EINVAL;
 	}

@@ -576,15 +578,17 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 	}

 	if (unmap_idx < 0)
-		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
+		return __arm_lpae_unmap(data, iova, size, lvl, tablep, true);

 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+	io_pgtable_tlb_sync(&data->iop);
+
 	return size;
 }

 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, int lvl,
-			       arm_lpae_iopte *ptep)
+			       arm_lpae_iopte *ptep, bool strict)
 {
 	arm_lpae_iopte pte;
 	struct io_pgtable *iop = &data->iop;
@@ -609,7 +613,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
-		} else {
+		} else if (strict) {
 			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
 		}

@@ -625,12 +629,13 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,

 	/* Keep on walkin' */
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
+	return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep, strict);
 }

 static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			     size_t size)
 {
+	bool strict;
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
 	int lvl = ARM_LPAE_START_LVL(data);
@@ -638,7 +643,9 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;

-	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
+	strict = !(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT);
+
+	return __arm_lpae_unmap(data, iova, size, lvl, ptep, strict);
 }

 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
@@ -771,7 +778,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;

-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
+			IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;

 	data = arm_lpae_alloc_pgtable(cfg);
@@ -863,7 +871,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 	struct arm_lpae_io_pgtable *data;

 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks & ~IO_PGTABLE_QUIRK_NO_DMA)
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
+		IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;

 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 2df7909..beb14a3 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -71,12 +71,15 @@ struct io_pgtable_cfg {
 	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
 	 *	software-emulated IOMMU), such that pagetable updates need not
 	 *	be treated as explicit DMA data.
+	 * IO_PGTABLE_QUIRK_NON_STRICT: Put off TLBs invalidation and release
+	 *	memory first.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
+	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
--
1.8.3


