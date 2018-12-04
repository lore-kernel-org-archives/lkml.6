Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC162C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C44020851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MzmcWjcp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ylv5kElf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C44020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeLDLXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:23:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeLDLBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDC9A60C48; Tue,  4 Dec 2018 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543921297;
        bh=aG47hPrUtkIFO8UrwSawSQHFhcbfIBFOCLq2tXO9NV4=;
        h=From:To:Cc:Subject:Date:From;
        b=MzmcWjcpSZPlfZ9dIwWtHHrUED5jtUagijf0OxnPdn52WU2q8pQsxWyk/SqmXtqbi
         AK9Hcq1XIHaETY0bev1OGaNPROTnBSXqBo06ppYw2MosnFF4vKXZeMrh0rKWN7fcCe
         RJKwwr0enZ4LujZo55296pxYB7n/3L397K62NLXM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC8976028B;
        Tue,  4 Dec 2018 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543921293;
        bh=aG47hPrUtkIFO8UrwSawSQHFhcbfIBFOCLq2tXO9NV4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ylv5kElf6q59YkyycLhlnssr+9x5W9Drsy0kZjnQnQMrcWxZuZ8yWo4hAaSYaD2vK
         cJQyrcTz+p+VYtCkPwu5ceNR3u4/eUlj4SRs+FF57R5QJOYfFgcv+fcGdXSlDG9Pt2
         WThIsBuKX5lJRXQlhcVT/A+KZbBwlJ62gFNJFoGg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC8976028B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, will.deacon@arm.com,
        iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, linux-arm-msm@vger.kernel.org,
        pdaly@codeaurora.org, pratikp@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date:   Tue,  4 Dec 2018 16:31:22 +0530
Message-Id: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SoCs have an additional level of cache called as
System cache, aka. Last level cache (LLC). This cache sits right
before the DDR, and is tightly coupled with the memory controller.
The cache is available to all the clients present in the SoC system.
The clients request their slices from this system cache, make it
active, and can then start using it.
For these clients with smmu, to start using the system cache for
buffers and, related page tables [1], memory attributes need to be
set accordingly.
This change updates the MAIR and TCR configurations with correct
attributes to use this system cache.

To explain a little about memory attribute requirements here:

Non-coherent I/O devices can't look-up into inner caches. However,
coherent I/O devices can. But both can allocate in the system cache
based on system policy and configured memory attributes in page
tables.
CPUs can access both inner and outer caches (including system cache,
aka. Last level cache), and can allocate into system cache too
based on memory attributes, and system policy.

Further looking at memory types, we have following -
a) Normal uncached :- MAIR 0x44, inner non-cacheable,
                      outer non-cacheable;
b) Normal cached :-   MAIR 0xff, inner read write-back non-transient,
                      outer read write-back non-transient;
                      attribute setting for coherenet I/O devices.

and, for non-coherent i/o devices that can allocate in system cache
another type gets added -
c) Normal sys-cached/non-inner-cached :-
                      MAIR 0xf4, inner non-cacheable,
                      outer read write-back non-transient

So, CPU will automatically use the system cache for memory marked as
normal cached. The normal sys-cached is downgraded to normal non-cached
memory for CPUs.
Coherent I/O devices can use system cache by marking the memory as
normal cached.
Non-coherent I/O devices, to use system cache, should mark the memory as
normal sys-cached in page tables.

This change is a realisation of following changes
from downstream msm-4.9:
iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]

[1] https://patchwork.kernel.org/patch/10302791/
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

Changes since v1:
 - Addressed Tomasz's comments for basing the change on
   "NO_INNER_CACHE" concept for non-coherent I/O devices
   rather than capturing "SYS_CACHE". This is to indicate
   clearly the intent of non-coherent I/O devices that
   can't access inner caches.

 drivers/iommu/arm-smmu.c       | 15 +++++++++++++++
 drivers/iommu/dma-iommu.c      |  3 +++
 drivers/iommu/io-pgtable-arm.c | 22 +++++++++++++++++-----
 drivers/iommu/io-pgtable.h     |  5 +++++
 include/linux/iommu.h          |  3 +++
 5 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ba18d89d4732..047f7ff95b0d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -255,6 +255,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+	bool				no_inner_cache;
 };
 
 struct arm_smmu_option_prop {
@@ -897,6 +898,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
+	if (smmu_domain->no_inner_cache)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NO_IC;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
@@ -1579,6 +1583,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_NO_IC:
+			*((int *)data) = smmu_domain->no_inner_cache;
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1619,6 +1626,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_NO_IC:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+			if (*((int *)data))
+				smmu_domain->no_inner_cache = true;
+			break;
 		default:
 			ret = -ENODEV;
 		}
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b04753b204..87c3d59c4a6c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -354,6 +354,9 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 {
 	int prot = coherent ? IOMMU_CACHE : 0;
 
+	if (!coherent && (attrs & DOMAIN_ATTR_NO_IC))
+		prot |= IOMMU_NO_IC;
+
 	if (attrs & DMA_ATTR_PRIVILEGED)
 		prot |= IOMMU_PRIV;
 
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 237cacd4a62b..815b86067bcc 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -168,10 +168,12 @@
 #define ARM_LPAE_MAIR_ATTR_MASK		0xff
 #define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
 #define ARM_LPAE_MAIR_ATTR_NC		0x44
+#define ARM_LPAE_MAIR_ATTR_NO_IC	0xf4
 #define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
 #define ARM_LPAE_MAIR_ATTR_IDX_NC	0
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
+#define ARM_LPAE_MAIR_ATTR_IDX_NO_IC	3
 
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
@@ -443,6 +445,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_NO_IC)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_NO_IC
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	} else {
 		pte = ARM_LPAE_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
@@ -780,7 +785,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_NO_IC))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -788,9 +794,13 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* TCR */
-	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_IC)
+		reg = ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT;
+	else
+		reg = ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT;
+
+	reg |= (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
+	       (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
@@ -842,7 +852,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	      (ARM_LPAE_MAIR_ATTR_WBRWA
 	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
 	      (ARM_LPAE_MAIR_ATTR_DEVICE
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
+	      (ARM_LPAE_MAIR_ATTR_NO_IC
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NO_IC));
 
 	cfg->arm_lpae_s1_cfg.mair[0] = reg;
 	cfg->arm_lpae_s1_cfg.mair[1] = 0;
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 47d5ae559329..450a4adf9052 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -75,6 +75,10 @@ struct io_pgtable_cfg {
 	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
 	 *	on unmap, for DMA domains using the flush queue mechanism for
 	 *	delayed invalidation.
+	 *
+	 * IO_PGTABLE_QUIRK_NO_IC: Override the attributes to use only the outer
+	 *      cache, and not inner cache for non-coherent devices doing normal
+	 *      sys-cached memory.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -82,6 +86,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
+	#define IO_PGTABLE_QUIRK_NO_IC		BIT(6)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..c30ee7f8d82d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,8 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
+/* Don't use inner caches */
+#define IOMMU_NO_IC	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
@@ -125,6 +127,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_NO_IC,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

