Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E39DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E90723F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E90723F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeGDVvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:51:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:57532 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752889AbeGDVvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:51:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="55172418"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2018 14:51:19 -0700
Subject: [PATCH v5 11/11] libnvdimm,
 pmem: Restore page attributes when clearing errors
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     hch@lst.de, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:41:21 -0700
Message-ID: <153074048162.27838.14847952115074744540.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clear_mce_nospec() to restore WB mode for the kernel linear mapping
of a pmem page that was marked 'HWPoison'. A page with 'HWPoison' set
has also been marked UC in PAT (page attribute table) via
set_mce_nospec() to prevent speculative retrievals of poison.

The 'HWPoison' flag is only cleared when overwriting an entire page.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |   26 ++++++++++++++++++++++++++
 drivers/nvdimm/pmem.h |   13 +++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 8b1fd7f1a224..55c7a69751d3 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -20,6 +20,7 @@
 #include <linux/hdreg.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/set_memory.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/badblocks.h>
@@ -51,6 +52,30 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 	return to_nd_region(to_dev(pmem)->parent);
 }
 
+static void hwpoison_clear(struct pmem_device *pmem,
+		phys_addr_t phys, unsigned int len)
+{
+	unsigned long pfn_start, pfn_end, pfn;
+
+	/* only pmem in the linear map supports HWPoison */
+	if (is_vmalloc_addr(pmem->virt_addr))
+		return;
+
+	pfn_start = PHYS_PFN(phys);
+	pfn_end = pfn_start + PHYS_PFN(len);
+	for (pfn = pfn_start; pfn < pfn_end; pfn++) {
+		struct page *page = pfn_to_page(pfn);
+
+		/*
+		 * Note, no need to hold a get_dev_pagemap() reference
+		 * here since we're in the driver I/O path and
+		 * outstanding I/O requests pin the dev_pagemap.
+		 */
+		if (test_and_clear_pmem_poison(page))
+			clear_mce_nospec(pfn);
+	}
+}
+
 static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		phys_addr_t offset, unsigned int len)
 {
@@ -65,6 +90,7 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 	if (cleared < len)
 		rc = BLK_STS_IOERR;
 	if (cleared > 0 && cleared / 512) {
+		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
 		cleared /= 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
 				(unsigned long long) sector, cleared,
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index a64ebc78b5df..59cfe13ea8a8 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NVDIMM_PMEM_H__
 #define __NVDIMM_PMEM_H__
+#include <linux/page-flags.h>
 #include <linux/badblocks.h>
 #include <linux/types.h>
 #include <linux/pfn_t.h>
@@ -27,4 +28,16 @@ struct pmem_device {
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn);
+
+#ifdef CONFIG_MEMORY_FAILURE
+static inline bool test_and_clear_pmem_poison(struct page *page)
+{
+	return TestClearPageHWPoison(page);
+}
+#else
+static inline bool test_and_clear_pmem_poison(struct page *page)
+{
+	return false;
+}
+#endif
 #endif /* __NVDIMM_PMEM_H__ */

