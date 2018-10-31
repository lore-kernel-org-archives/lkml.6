Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D179FC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B3420821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B3420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeJaMU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:20:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:42125 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJaMU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:20:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="270169706"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2018 20:24:48 -0700
Subject: [PATCH 2/8] device-dax: Kill dax_region base
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
Date:   Tue, 30 Oct 2018 20:13:00 -0700
Message-ID: <154095558001.3271337.4593586036083228319.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Nothing consumes this attribute of a region and devres otherwise
remembers the value for de-allocation purposes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    2 --
 drivers/dax/device-dax.h  |    5 ++---
 drivers/dax/device.c      |    3 +--
 drivers/dax/pmem.c        |    2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index d1b36a42132f..9b393c218fe4 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -19,7 +19,6 @@
 /**
  * struct dax_region - mapping infrastructure for dax devices
  * @id: kernel-wide unique region for a memory range
- * @base: linear address corresponding to @res
  * @kref: to pin while other agents have a need to do lookups
  * @dev: parent device backing this region
  * @align: allocation and mapping alignment for child dax devices
@@ -28,7 +27,6 @@
  */
 struct dax_region {
 	int id;
-	void *base;
 	struct kref kref;
 	struct device *dev;
 	unsigned int align;
diff --git a/drivers/dax/device-dax.h b/drivers/dax/device-dax.h
index 688b051750bd..4f1c69e1b3a2 100644
--- a/drivers/dax/device-dax.h
+++ b/drivers/dax/device-dax.h
@@ -17,9 +17,8 @@ struct dev_dax;
 struct resource;
 struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
-struct dax_region *alloc_dax_region(struct device *parent,
-		int region_id, struct resource *res, unsigned int align,
-		void *addr, unsigned long flags);
+struct dax_region *alloc_dax_region(struct device *parent, int region_id,
+		struct resource *res, unsigned int align, unsigned long flags);
 struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 		int id, struct resource *res, int count);
 #endif /* __DEVICE_DAX_H__ */
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index a5a670c1cd58..811c1015194c 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -100,7 +100,7 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct resource *res, unsigned int align, void *addr,
+		struct resource *res, unsigned int align,
 		unsigned long pfn_flags)
 {
 	struct dax_region *dax_region;
@@ -130,7 +130,6 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 	dax_region->id = region_id;
 	dax_region->align = align;
 	dax_region->dev = parent;
-	dax_region->base = addr;
 	if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
 		kfree(dax_region);
 		return NULL;
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index 99e2aace8078..3afae503fc42 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -133,7 +133,7 @@ static int dax_pmem_probe(struct device *dev)
 		return -EINVAL;
 
 	dax_region = alloc_dax_region(dev, region_id, &res,
-			le32_to_cpu(pfn_sb->align), addr, PFN_DEV|PFN_MAP);
+			le32_to_cpu(pfn_sb->align), PFN_DEV|PFN_MAP);
 	if (!dax_region)
 		return -ENOMEM;
 

