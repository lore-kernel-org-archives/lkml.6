Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7F92086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7F92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKYFsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 00:48:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:36303 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeKYFsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 00:48:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2018 10:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,275,1539673200"; 
   d="scan'208";a="88361859"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 24 Nov 2018 10:59:32 -0800
Subject: [PATCH 2/2] libnvdimm,
 pfn: Pad pfn namespaces relative to other regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Date:   Sat, 24 Nov 2018 10:47:04 -0800
Message-ID: <154308522458.237140.16550557898744466932.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154308521932.237140.13650270234597178173.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154308521932.237140.13650270234597178173.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cfe30b872058 "libnvdimm, pmem: adjust for section collisions with
'System RAM'" enabled Linux to workaround occasions where platform
firmware arranges for "System RAM" and "Persistent Memory" to collide
within a single section boundary. Unfortunately, as reported in this
issue [1], platform firmware can inflict the same collision between
persistent memory regions.

The approach of interrogating iomem_resource does not work in this
case because platform firmware may merge multiple regions into a single
iomem_resource range. Instead provide a method to interrogate regions
that share the same parent bus.

This is a stop-gap until the core-MM can grow support for hotplug on
sub-section boundaries.

[1]: https://github.com/pmem/ndctl/issues/76

Fixes: cfe30b872058 ("libnvdimm, pmem: adjust for section collisions with...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/nd-core.h     |    2 +
 drivers/nvdimm/pfn_devs.c    |   64 ++++++++++++++++++++++++------------------
 drivers/nvdimm/region_devs.c |   41 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 182258f64417..d0c621b32f72 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -111,6 +111,8 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 		struct nd_mapping *nd_mapping, resource_size_t *overlap);
 resource_size_t nd_blk_available_dpa(struct nd_region *nd_region);
 resource_size_t nd_region_available_dpa(struct nd_region *nd_region);
+int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
+		resource_size_t size);
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
 		struct nd_label_id *label_id);
 int alias_dpa_busy(struct device *dev, void *data);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 24c64090169e..6f22272e8d80 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -649,14 +649,47 @@ static u64 phys_pmem_align_down(struct nd_pfn *nd_pfn, u64 phys)
 			ALIGN_DOWN(phys, nd_pfn->align));
 }
 
+/*
+ * Check if pmem collides with 'System RAM', or other regions when
+ * section aligned.  Trim it accordingly.
+ */
+static void trim_pfn_device(struct nd_pfn *nd_pfn, u32 *start_pad, u32 *end_trunc)
+{
+	struct nd_namespace_common *ndns = nd_pfn->ndns;
+	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
+	struct nd_region *nd_region = to_nd_region(nd_pfn->dev.parent);
+	const resource_size_t start = nsio->res.start;
+	const resource_size_t end = start + resource_size(&nsio->res);
+	resource_size_t adjust, size;
+
+	*start_pad = 0;
+	*end_trunc = 0;
+
+	adjust = start - PHYS_SECTION_ALIGN_DOWN(start);
+	size = resource_size(&nsio->res) + adjust;
+	if (region_intersects(start - adjust, size, IORESOURCE_SYSTEM_RAM,
+				IORES_DESC_NONE) == REGION_MIXED
+			|| nd_region_conflict(nd_region, start - adjust, size))
+		*start_pad = PHYS_SECTION_ALIGN_UP(start) - start;
+
+	/* Now check that end of the range does not collide. */
+	adjust = PHYS_SECTION_ALIGN_UP(end) - end;
+	size = resource_size(&nsio->res) + adjust;
+	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
+				IORES_DESC_NONE) == REGION_MIXED
+			|| !IS_ALIGNED(end, nd_pfn->align)
+			|| nd_region_conflict(nd_region, start, size + adjust))
+		*end_trunc = end - phys_pmem_align_down(nd_pfn, end);
+}
+
 static int nd_pfn_init(struct nd_pfn *nd_pfn)
 {
 	u32 dax_label_reserve = is_nd_dax(&nd_pfn->dev) ? SZ_128K : 0;
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
-	u32 start_pad = 0, end_trunc = 0;
+	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	resource_size_t start, size;
-	struct nd_namespace_io *nsio;
 	struct nd_region *nd_region;
+	u32 start_pad, end_trunc;
 	struct nd_pfn_sb *pfn_sb;
 	unsigned long npfns;
 	phys_addr_t offset;
@@ -688,30 +721,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 
 	memset(pfn_sb, 0, sizeof(*pfn_sb));
 
-	/*
-	 * Check if pmem collides with 'System RAM' when section aligned and
-	 * trim it accordingly
-	 */
-	nsio = to_nd_namespace_io(&ndns->dev);
-	start = PHYS_SECTION_ALIGN_DOWN(nsio->res.start);
-	size = resource_size(&nsio->res);
-	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
-				IORES_DESC_NONE) == REGION_MIXED) {
-		start = nsio->res.start;
-		start_pad = PHYS_SECTION_ALIGN_UP(start) - start;
-	}
-
-	start = nsio->res.start;
-	size = PHYS_SECTION_ALIGN_UP(start + size) - start;
-	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
-				IORES_DESC_NONE) == REGION_MIXED
-			|| !IS_ALIGNED(start + resource_size(&nsio->res),
-				nd_pfn->align)) {
-		size = resource_size(&nsio->res);
-		end_trunc = start + size - phys_pmem_align_down(nd_pfn,
-				start + size);
-	}
-
+	trim_pfn_device(nd_pfn, &start_pad, &end_trunc);
 	if (start_pad + end_trunc)
 		dev_info(&nd_pfn->dev, "%s alignment collision, truncate %d bytes\n",
 				dev_name(&ndns->dev), start_pad + end_trunc);
@@ -722,7 +732,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	 * implementation will limit the pfns advertised through
 	 * ->direct_access() to those that are included in the memmap.
 	 */
-	start += start_pad;
+	start = nsio->res.start + start_pad;
 	size = resource_size(&nsio->res);
 	npfns = PFN_SECTION_ALIGN_UP((size - start_pad - end_trunc - SZ_8K)
 			/ PAGE_SIZE);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 174a418cb171..e7377f1028ef 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1184,6 +1184,47 @@ int nvdimm_has_cache(struct nd_region *nd_region)
 }
 EXPORT_SYMBOL_GPL(nvdimm_has_cache);
 
+struct conflict_context {
+	struct nd_region *nd_region;
+	resource_size_t start, size;
+};
+
+static int region_conflict(struct device *dev, void *data)
+{
+	struct nd_region *nd_region;
+	struct conflict_context *ctx = data;
+	resource_size_t res_end, region_end, region_start;
+
+	if (!is_memory(dev))
+		return 0;
+
+	nd_region = to_nd_region(dev);
+	if (nd_region == ctx->nd_region)
+		return 0;
+
+	res_end = ctx->start + ctx->size;
+	region_start = nd_region->ndr_start;
+	region_end = region_start + nd_region->ndr_size;
+	if (ctx->start >= region_start && ctx->start < region_end)
+		return -EBUSY;
+	if (res_end > region_start && res_end <= region_end)
+		return -EBUSY;
+	return 0;
+}
+
+int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
+		resource_size_t size)
+{
+	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nd_region->dev);
+	struct conflict_context ctx = {
+		.nd_region = nd_region,
+		.start = start,
+		.size = size,
+	};
+
+	return device_for_each_child(&nvdimm_bus->dev, &ctx, region_conflict);
+}
+
 void __exit nd_region_devs_exit(void)
 {
 	ida_destroy(&region_ida);

