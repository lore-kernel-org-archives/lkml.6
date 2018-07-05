Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9123EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53482240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53482240E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeGEHAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:00:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:44111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753596AbeGEHAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:00:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="55251480"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2018 23:59:58 -0700
Subject: [PATCH 11/13] libnvdimm,
 pmem: Initialize the memmap in the background
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 23:50:01 -0700
Message-ID: <153077340108.40830.8427794791878610916.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrange for the pmem driver to call memmap_sync() when it is asked to
produce a valid pfn. The infrastructure is housed in the 'nd_pfn'
device which implies that the async init support only exists for
platform defined persistent memory, not the legacy / debug memmap=ss!nn
facility.

Another reason to restrict the capability to the 'nd_pfn' device case is
that nd_pfn devices have sysfs infrastructure to communicate the
memmap initialization state to userspace.

The sysfs publication of memmap init state is saved for a later patch.

Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/nd.h             |    2 ++
 drivers/nvdimm/pmem.c           |   16 ++++++++++++----
 drivers/nvdimm/pmem.h           |    1 +
 tools/testing/nvdimm/pmem-dax.c |    7 ++++++-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 32e0364b48b9..ee4f76fb0cb5 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -12,6 +12,7 @@
  */
 #ifndef __ND_H__
 #define __ND_H__
+#include <linux/memmap_async.h>
 #include <linux/libnvdimm.h>
 #include <linux/badblocks.h>
 #include <linux/blkdev.h>
@@ -208,6 +209,7 @@ struct nd_pfn {
 	unsigned long npfns;
 	enum nd_pfn_mode mode;
 	struct nd_pfn_sb *pfn_sb;
+	struct memmap_async_state async;
 	struct nd_namespace_common *ndns;
 };
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c430536320a5..a1158181adc2 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/memmap_async.h>
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
 #include <linux/vmalloc.h>
@@ -228,8 +229,13 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 					PFN_PHYS(nr_pages))))
 		return -EIO;
 	*kaddr = pmem->virt_addr + offset;
-	if (pfn)
+	if (pfn) {
+		struct dev_pagemap *pgmap = &pmem->pgmap;
+		struct memmap_async_state *async = pgmap->async;
+
 		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		memmap_sync(*pfn, nr_pages, async);
+	}
 
 	/*
 	 * If badblocks are present, limit known good range to the
@@ -310,13 +316,15 @@ static void fsdax_pagefree(struct page *page, void *data)
 	wake_up_var(&page->_refcount);
 }
 
-static int setup_pagemap_fsdax(struct device *dev, struct dev_pagemap *pgmap)
+static int setup_pagemap_fsdax(struct device *dev, struct dev_pagemap *pgmap,
+		struct memmap_async_state *async)
 {
 	dev_pagemap_get_ops();
 	if (devm_add_action_or_reset(dev, pmem_release_pgmap_ops, pgmap))
 		return -ENOMEM;
 	pgmap->type = MEMORY_DEVICE_FS_DAX;
 	pgmap->page_free = fsdax_pagefree;
+	pgmap->async = async;
 
 	return 0;
 }
@@ -379,7 +387,7 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	pmem->pgmap.ref = &q->q_usage_counter;
 	if (is_nd_pfn(dev)) {
-		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
+		if (setup_pagemap_fsdax(dev, &pmem->pgmap, &nd_pfn->async))
 			return -ENOMEM;
 		addr = devm_memremap_pages(dev, &pmem->pgmap,
 				pmem_freeze_queue);
@@ -393,7 +401,7 @@ static int pmem_attach_disk(struct device *dev,
 	} else if (pmem_should_map_pages(dev)) {
 		memcpy(&pmem->pgmap.res, &nsio->res, sizeof(pmem->pgmap.res));
 		pmem->pgmap.altmap_valid = false;
-		if (setup_pagemap_fsdax(dev, &pmem->pgmap))
+		if (setup_pagemap_fsdax(dev, &pmem->pgmap, NULL))
 			return -ENOMEM;
 		addr = devm_memremap_pages(dev, &pmem->pgmap,
 				pmem_freeze_queue);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index a64ebc78b5df..93d226ea1006 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NVDIMM_PMEM_H__
 #define __NVDIMM_PMEM_H__
+#include <linux/memmap_async.h>
 #include <linux/badblocks.h>
 #include <linux/types.h>
 #include <linux/pfn_t.h>
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index d4cb5281b30e..63151b75615c 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -42,8 +42,13 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	}
 
 	*kaddr = pmem->virt_addr + offset;
-	if (pfn)
+	if (pfn) {
+		struct dev_pagemap *pgmap = &pmem->pgmap;
+		struct memmap_async_state *async = pgmap->async;
+
 		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		memmap_sync(*pfn, nr_pages, async);
+	}
 
 	/*
 	 * If badblocks are present, limit known good range to the

