Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56053222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfBLVhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:37:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:16717 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732531AbfBLVhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:37:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 13:37:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="117400830"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2019 13:37:34 -0800
Subject: [PATCH 3/7] dax: Check the end of the block-device capacity with
 dax_direct_access()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 12 Feb 2019 13:24:56 -0800
Message-ID: <155000669646.348031.16690970886357498896.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The checks in __bdev_dax_supported() helped mitigate a potential data
corruption bug in the pmem driver's handling of section alignment
padding. Strengthen the checks, including checking the end of the range,
to validate the dev_pagemap, Xarray entries, and sector-to-pfn
translation established for pmem namespaces.

Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 6e928f37d084..a27395cfcec6 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -86,12 +86,14 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	struct dax_device *dax_dev;
 	bool dax_enabled = false;
+	pgoff_t pgoff, pgoff_end;
 	struct request_queue *q;
-	pgoff_t pgoff;
-	int err, id;
-	pfn_t pfn;
-	long len;
 	char buf[BDEVNAME_SIZE];
+	void *kaddr, *end_kaddr;
+	pfn_t pfn, end_pfn;
+	sector_t last_page;
+	long len, len2;
+	int err, id;
 
 	if (blocksize != PAGE_SIZE) {
 		pr_debug("%s: error: unsupported blocksize for dax\n",
@@ -113,6 +115,15 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		return false;
 	}
 
+	last_page = ALIGN_DOWN(part_nr_sects_read(bdev->bd_part)
+			- PAGE_SIZE / 512, PAGE_SIZE / 512);
+	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
+	if (err) {
+		pr_debug("%s: error: unaligned partition for dax\n",
+				bdevname(bdev, buf));
+		return false;
+	}
+
 	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
 	if (!dax_dev) {
 		pr_debug("%s: error: device does not support dax\n",
@@ -121,14 +132,15 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 	}
 
 	id = dax_read_lock();
-	len = dax_direct_access(dax_dev, pgoff, 1, NULL, &pfn);
+	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
+	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
 	dax_read_unlock(id);
 
 	put_dax(dax_dev);
 
-	if (len < 1) {
+	if (len < 1 || len2 < 1) {
 		pr_debug("%s: error: dax access failed (%ld)\n",
-				bdevname(bdev, buf), len);
+				bdevname(bdev, buf), len < 1 ? len : len2);
 		return false;
 	}
 
@@ -143,13 +155,20 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		 */
 		WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
 		dax_enabled = true;
-	} else if (pfn_t_devmap(pfn)) {
-		struct dev_pagemap *pgmap;
+	} else if (pfn_t_devmap(pfn) && pfn_t_devmap(end_pfn)) {
+		struct dev_pagemap *pgmap, *end_pgmap;
 
 		pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
-		if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
+		end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
+		if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
+				&& pfn_t_to_page(pfn)->pgmap == pgmap
+				&& pfn_t_to_page(end_pfn)->pgmap == pgmap
+				&& pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
+				&& pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))
 			dax_enabled = true;
 		put_dev_pagemap(pgmap);
+		put_dev_pagemap(end_pgmap);
+
 	}
 
 	if (!dax_enabled) {

