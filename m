Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C022087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C022087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbeITVyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:54 -0400
Received: from foss.arm.com ([217.140.101.70]:48600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731135AbeITVyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86C1315BF;
        Thu, 20 Sep 2018 09:10:42 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCF613F557;
        Thu, 20 Sep 2018 09:10:40 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 4/7] iommu/io-pgtable-arm: Add support for non-strict mode
Date:   Thu, 20 Sep 2018 17:10:24 +0100
Message-Id: <9a666d63a96ab97dc53df2a64b3a8d22a0986423.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Non-strict mode is simply a case of skipping 'regular' leaf TLBIs, since
the sync is already factored out into ops->iotlb_sync at the core API
level. Non-leaf invalidations where we change the page table structure
itself still have to be issued synchronously in order to maintain walk
caches correctly.

To save having to reason about it too much, make sure the invalidation
in arm_lpae_split_blk_unmap() just performs its own unconditional sync
to minimise the window in which we're technically violating the break-
before-make requirement on a live mapping. This might work out redundant
with an outer-level sync for strict unmaps, but we'll never be splitting
blocks on a DMA fastpath anyway.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: tweak comment, commit message, split_blk_unmap logic and barriers]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8: Add barrier for the fiddly cross-cpu flush case

 drivers/iommu/io-pgtable-arm.c | 14 ++++++++++++--
 drivers/iommu/io-pgtable.h     |  5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 2f79efd16a05..237cacd4a62b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -576,6 +576,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		tablep = iopte_deref(pte, data);
 	} else if (unmap_idx >= 0) {
 		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+		io_pgtable_tlb_sync(&data->iop);
 		return size;
 	}
 
@@ -609,6 +610,13 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
+		} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
+			/*
+			 * Order the PTE update against queueing the IOVA, to
+			 * guarantee that a flush callback from a different CPU
+			 * has observed it before the TLBIALL can be issued.
+			 */
+			smp_wmb();
 		} else {
 			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
 		}
@@ -771,7 +779,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;
 
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
+			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -863,7 +872,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
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

