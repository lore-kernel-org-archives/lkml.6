Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeFBT3F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 15:29:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:12328 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbeFBT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 15:29:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,470,1520924400";
   d="scan'208";a="45934400"
Subject: [PATCH] libnvdimm, e820: Register all pmem resources
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Date: Sat, 02 Jun 2018 12:19:07 -0700
Message-ID: <152796714712.17931.6164610183818441048.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently a mismatch between the resources that will trigger
the e820_pmem driver to register/load and the resources that will
actually be surfaced as pmem ranges. register_e820_pmem() uses
walk_iomem_res_desc() which includes children and siblings. In contrast,
e820_pmem_probe() only considers top level resources. For example the
following resource tree results in the driver being loaded, but no
resources being registered:

    398000000000-39bfffffffff : PCI Bus 0000:ae
      39be00000000-39bf07ffffff : PCI Bus 0000:af
        39be00000000-39beffffffff : 0000:af:00.0
          39be10000000-39beffffffff : Persistent Memory (legacy)

Fix this up to allow definitions of "legacy" pmem ranges anywhere in
system-physical address space. Not that it is a recommended or safe to
define a pmem range in PCI space, but it is useful for debug /
experimentation, and the restriction on being a top-level resource was
arbitrary.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/e820.c |   41 ++++++++++++++++++++++-------------------
 kernel/resource.c     |    1 +
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 6f9a6ffd7cde..521eaf53a52a 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -38,12 +38,27 @@ static int e820_range_to_nid(resource_size_t addr)
 }
 #endif
 
+static int e820_register_one(struct resource *res, void *data)
+{
+	struct nd_region_desc ndr_desc;
+	struct nvdimm_bus *nvdimm_bus = data;
+
+	memset(&ndr_desc, 0, sizeof(ndr_desc));
+	ndr_desc.res = res;
+	ndr_desc.attr_groups = e820_pmem_region_attribute_groups;
+	ndr_desc.numa_node = e820_range_to_nid(res->start);
+	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
+	if (!nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc))
+		return -ENXIO;
+	return 0;
+}
+
 static int e820_pmem_probe(struct platform_device *pdev)
 {
 	static struct nvdimm_bus_descriptor nd_desc;
 	struct device *dev = &pdev->dev;
 	struct nvdimm_bus *nvdimm_bus;
-	struct resource *p;
+	int rc = -ENXIO;
 
 	nd_desc.attr_groups = e820_pmem_attribute_groups;
 	nd_desc.provider_name = "e820";
@@ -53,27 +68,15 @@ static int e820_pmem_probe(struct platform_device *pdev)
 		goto err;
 	platform_set_drvdata(pdev, nvdimm_bus);
 
-	for (p = iomem_resource.child; p ; p = p->sibling) {
-		struct nd_region_desc ndr_desc;
-
-		if (p->desc != IORES_DESC_PERSISTENT_MEMORY_LEGACY)
-			continue;
-
-		memset(&ndr_desc, 0, sizeof(ndr_desc));
-		ndr_desc.res = p;
-		ndr_desc.attr_groups = e820_pmem_region_attribute_groups;
-		ndr_desc.numa_node = e820_range_to_nid(p->start);
-		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
-		if (!nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc))
-			goto err;
-	}
-
+	rc = walk_iomem_res_desc(IORES_DESC_PERSISTENT_MEMORY_LEGACY,
+			IORESOURCE_MEM, 0, -1, nvdimm_bus, e820_register_one);
+	if (rc)
+		goto err;
 	return 0;
-
- err:
+err:
 	nvdimm_bus_unregister(nvdimm_bus);
 	dev_err(dev, "failed to register legacy persistent memory ranges\n");
-	return -ENXIO;
+	return rc;
 }
 
 static struct platform_driver e820_pmem_driver = {
diff --git a/kernel/resource.c b/kernel/resource.c
index 2af6c03858b9..b85f59e8a4b8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -448,6 +448,7 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 
 	return __walk_iomem_res_desc(&res, desc, false, arg, func);
 }
+EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
 /*
  * This function calls the @func callback against all memory ranges of type
