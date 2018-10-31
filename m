Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80837ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CFB20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CFB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJaMVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:21:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:28220 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJaMVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:21:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="87434960"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 20:24:53 -0700
Subject: [PATCH 3/8] device-dax: Remove multi-resource infrastructure
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Date:   Tue, 30 Oct 2018 20:13:05 -0700
Message-ID: <154095558513.3271337.6460925877189898414.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154095556915.3271337.12581429676272726902.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multi-resource implementation anticipated discontiguous sub-division
support. That has not yet materialized, delete the infrastructure and
related code.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h      |    4 ---
 drivers/dax/device-dax.h       |    3 +-
 drivers/dax/device.c           |   49 +++++++---------------------------------
 drivers/dax/pmem.c             |    3 +-
 tools/testing/nvdimm/dax-dev.c |   16 ++-----------
 5 files changed, 13 insertions(+), 62 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 9b393c218fe4..dbd077653b5c 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -39,14 +39,10 @@ struct dax_region {
  * @region - parent region
  * @dax_dev - core dax functionality
  * @dev - device core
- * @num_resources - number of physical address extents in this device
- * @res - array of physical address ranges
  */
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
 	struct device dev;
-	int num_resources;
-	struct resource res[0];
 };
 #endif
diff --git a/drivers/dax/device-dax.h b/drivers/dax/device-dax.h
index 4f1c69e1b3a2..e9be99584b92 100644
--- a/drivers/dax/device-dax.h
+++ b/drivers/dax/device-dax.h
@@ -19,6 +19,5 @@ struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, unsigned int align, unsigned long flags);
-struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
-		int id, struct resource *res, int count);
+struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id);
 #endif /* __DEVICE_DAX_H__ */
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 811c1015194c..db12e24b8005 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -151,11 +151,7 @@ static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	unsigned long long size = 0;
-	int i;
-
-	for (i = 0; i < dev_dax->num_resources; i++)
-		size += resource_size(&dev_dax->res[i]);
+	unsigned long long size = resource_size(&dev_dax->region->res);
 
 	return sprintf(buf, "%llu\n", size);
 }
@@ -224,21 +220,11 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
 {
-	struct resource *res;
-	/* gcc-4.6.3-nolibc for i386 complains that this is uninitialized */
-	phys_addr_t uninitialized_var(phys);
-	int i;
-
-	for (i = 0; i < dev_dax->num_resources; i++) {
-		res = &dev_dax->res[i];
-		phys = pgoff * PAGE_SIZE + res->start;
-		if (phys >= res->start && phys <= res->end)
-			break;
-		pgoff -= PHYS_PFN(resource_size(res));
-	}
+	struct resource *res = &dev_dax->region->res;
+	phys_addr_t phys;
 
-	if (i < dev_dax->num_resources) {
-		res = &dev_dax->res[i];
+	phys = pgoff * PAGE_SIZE + res->start;
+	if (phys >= res->start && phys <= res->end) {
 		if (phys + size - 1 <= res->end)
 			return phys;
 	}
@@ -608,8 +594,7 @@ static void unregister_dev_dax(void *dev)
 	put_device(dev);
 }
 
-struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
-		int id, struct resource *res, int count)
+struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region, int id)
 {
 	struct device *parent = dax_region->dev;
 	struct dax_device *dax_dev;
@@ -617,29 +602,12 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 	struct inode *inode;
 	struct device *dev;
 	struct cdev *cdev;
-	int rc, i;
+	int rc;
 
-	if (!count)
-		return ERR_PTR(-EINVAL);
-
-	dev_dax = kzalloc(struct_size(dev_dax, res, count), GFP_KERNEL);
+	dev_dax = kzalloc(sizeof(*dev_dax), GFP_KERNEL);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < count; i++) {
-		if (!IS_ALIGNED(res[i].start, dax_region->align)
-				|| !IS_ALIGNED(resource_size(&res[i]),
-					dax_region->align)) {
-			rc = -EINVAL;
-			break;
-		}
-		dev_dax->res[i].start = res[i].start;
-		dev_dax->res[i].end = res[i].end;
-	}
-
-	if (i < count)
-		goto err;
-
 	/*
 	 * No 'host' or dax_operations since there is no access to this
 	 * device outside of mmap of the resulting character device.
@@ -659,7 +627,6 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 	cdev_init(cdev, &dax_fops);
 	cdev->owner = parent->driver->owner;
 
-	dev_dax->num_resources = count;
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->region = dax_region;
 	kref_get(&dax_region->kref);
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index 3afae503fc42..23bc8ed40e84 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -137,8 +137,7 @@ static int dax_pmem_probe(struct device *dev)
 	if (!dax_region)
 		return -ENOMEM;
 
-	/* TODO: support for subdividing a dax region... */
-	dev_dax = devm_create_dev_dax(dax_region, id, &res, 1);
+	dev_dax = devm_create_dev_dax(dax_region, id);
 
 	/* child dev_dax instances now own the lifetime of the dax_region */
 	dax_region_put(dax_region);
diff --git a/tools/testing/nvdimm/dax-dev.c b/tools/testing/nvdimm/dax-dev.c
index 36ee3d8797c3..f36e708265b8 100644
--- a/tools/testing/nvdimm/dax-dev.c
+++ b/tools/testing/nvdimm/dax-dev.c
@@ -17,20 +17,11 @@
 phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
 {
-	struct resource *res;
+	struct resource *res = &dev_dax->region->res;
 	phys_addr_t addr;
-	int i;
 
-	for (i = 0; i < dev_dax->num_resources; i++) {
-		res = &dev_dax->res[i];
-		addr = pgoff * PAGE_SIZE + res->start;
-		if (addr >= res->start && addr <= res->end)
-			break;
-		pgoff -= PHYS_PFN(resource_size(res));
-	}
-
-	if (i < dev_dax->num_resources) {
-		res = &dev_dax->res[i];
+	addr = pgoff * PAGE_SIZE + res->start;
+	if (addr >= res->start && addr <= res->end) {
 		if (addr + size - 1 <= res->end) {
 			if (get_nfit_res(addr)) {
 				struct page *page;
@@ -44,6 +35,5 @@ phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 				return addr;
 		}
 	}
-
 	return -1;
 }

