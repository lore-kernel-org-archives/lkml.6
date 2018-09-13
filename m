Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B5FC6192
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20AA2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20AA2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeIMVxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:53:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51124 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeIMVw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:52:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA4C1682;
        Thu, 13 Sep 2018 09:42:42 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B03C83F703;
        Thu, 13 Sep 2018 09:42:40 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v6 3/7] iommu/io-pgtable-arm: Add support for non-strict mode
Date:   Thu, 13 Sep 2018 17:42:20 +0100
Message-Id: <842302266d7a079e78ac6db3739be8dbf8a5cdab.1536856828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536856828.git.robin.murphy@arm.com>
References: <cover.1536856828.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

To support non-strict mode, now we only TLBI and sync for strict mode,
except for non-leaf invalidations since page table updates themselves
must always be synchronous.

To save having to reason about it too much, make sure the invalidation
in arm_lpae_split_blk_unmap() just performs its own unconditional sync
to minimise the window in which we're technically violating the break-
before-make requirement on a live mapping. This might work out redundant
with an outer-level sync for strict unmaps, but we'll never be splitting
blocks on a DMA fastpath anyway.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: tweak comment, commit message, and split_blk_unmap logic]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 9 ++++++---
 drivers/iommu/io-pgtable.h     | 5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 2f79efd16a05..5b915aab7fd3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -576,6 +576,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		tablep = iopte_deref(pte, data);
 	} else if (unmap_idx >= 0) {
 		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+		io_pgtable_tlb_sync(&data->iop);
 		return size;
 	}
 
@@ -609,7 +610,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
-		} else {
+		} else if (!(iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT)) {
 			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
 		}
 
@@ -771,7 +772,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;
 
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
+			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -863,7 +865,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	/* The NS quirk doesn't apply at stage 2 */
-	if (cfg->quirks & ~IO_PGTABLE_QUIRK_NO_DMA)
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
+			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 2df79093cad9..47d5ae559329 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -71,12 +71,17 @@ struct io_pgtable_cfg {
 	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
 	 *	software-emulated IOMMU), such that pagetable updates need not
 	 *	be treated as explicit DMA data.
+	 *
+	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
+	 *	on unmap, for DMA domains using the flush queue mechanism for
+	 *	delayed invalidation.
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
2.19.0.dirty

