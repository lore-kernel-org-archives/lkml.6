Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77393C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DC1222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfBLVh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:37:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:57721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfBLVhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:37:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 13:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="299238388"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 13:37:23 -0800
Subject: [PATCH 1/7] libnvdimm/pfn: Account for PAGE_SIZE > info-block-size
 in nd_pfn_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, linux-fsdevel@vger.kernel.org
Date:   Tue, 12 Feb 2019 13:24:46 -0800
Message-ID: <155000668608.348031.18233783401856221451.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to "libnvdimm: Fix altmap reservation size calculation" provide
for a reservation of a full page worth of info block space at info-block
establishment time.  Typically there is already slack in the padding
from honoring the default 2MB alignment, but provide for a reservation
for corner case configurations that would otherwise fit.

Cc: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pfn_devs.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 7760c1b91853..ba74a341da5d 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -580,6 +580,11 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nd_pfn_probe);
 
+static u32 info_block_reserve(void)
+{
+	return ALIGN(SZ_8K, PAGE_SIZE);
+}
+
 /*
  * We hotplug memory at section granularity, pad the reserved area from
  * the previous section base to the namespace base address.
@@ -593,7 +598,7 @@ static unsigned long init_altmap_base(resource_size_t base)
 
 static unsigned long init_altmap_reserve(resource_size_t base)
 {
-	unsigned long reserve = PFN_UP(SZ_8K);
+	unsigned long reserve = info_block_reserve() >> PAGE_SHIFT;
 	unsigned long base_pfn = PHYS_PFN(base);
 
 	reserve += base_pfn - PFN_SECTION_ALIGN_DOWN(base_pfn);
@@ -608,6 +613,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 	u64 offset = le64_to_cpu(pfn_sb->dataoff);
 	u32 start_pad = __le32_to_cpu(pfn_sb->start_pad);
 	u32 end_trunc = __le32_to_cpu(pfn_sb->end_trunc);
+	u32 reserve = info_block_reserve();
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	resource_size_t base = nsio->res.start + start_pad;
@@ -621,7 +627,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 	res->end -= end_trunc;
 
 	if (nd_pfn->mode == PFN_MODE_RAM) {
-		if (offset < SZ_8K)
+		if (offset < reserve)
 			return -EINVAL;
 		nd_pfn->npfns = le64_to_cpu(pfn_sb->npfns);
 		pgmap->altmap_valid = false;
@@ -634,7 +640,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 					le64_to_cpu(nd_pfn->pfn_sb->npfns),
 					nd_pfn->npfns);
 		memcpy(altmap, &__altmap, sizeof(*altmap));
-		altmap->free = PHYS_PFN(offset - SZ_8K);
+		altmap->free = PHYS_PFN(offset - reserve);
 		altmap->alloc = 0;
 		pgmap->altmap_valid = true;
 	} else
@@ -687,9 +693,9 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	u32 dax_label_reserve = is_nd_dax(&nd_pfn->dev) ? SZ_128K : 0;
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
+	u32 start_pad, end_trunc, reserve = info_block_reserve();
 	resource_size_t start, size;
 	struct nd_region *nd_region;
-	u32 start_pad, end_trunc;
 	struct nd_pfn_sb *pfn_sb;
 	unsigned long npfns;
 	phys_addr_t offset;
@@ -734,7 +740,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	 */
 	start = nsio->res.start + start_pad;
 	size = resource_size(&nsio->res);
-	npfns = PFN_SECTION_ALIGN_UP((size - start_pad - end_trunc - SZ_8K)
+	npfns = PFN_SECTION_ALIGN_UP((size - start_pad - end_trunc - reserve)
 			/ PAGE_SIZE);
 	if (nd_pfn->mode == PFN_MODE_PMEM) {
 		/*
@@ -742,10 +748,10 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 */
-		offset = ALIGN(start + SZ_8K + 64 * npfns + dax_label_reserve,
+		offset = ALIGN(start + reserve + 64 * npfns + dax_label_reserve,
 				max(nd_pfn->align, PMD_SIZE)) - start;
 	} else if (nd_pfn->mode == PFN_MODE_RAM)
-		offset = ALIGN(start + SZ_8K + dax_label_reserve,
+		offset = ALIGN(start + reserve + dax_label_reserve,
 				nd_pfn->align) - start;
 	else
 		return -ENXIO;

