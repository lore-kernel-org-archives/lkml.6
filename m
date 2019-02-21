Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228C6214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfBUF2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:28:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:21332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfBUF2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:28:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 21:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,393,1544515200"; 
   d="scan'208";a="126056461"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2019 21:28:29 -0800
Subject: [PATCH v2] dax: Check the end of the block-device capacity with
 dax_direct_access()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 20 Feb 2019 21:15:51 -0800
Message-ID: <155072611007.2172474.11471824752162528833.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <CAPcyv4jwMx2ohs9QobTohL8jxc5G74XhmY5QFpmiVF9siWLuwA@mail.gmail.com>
References: <CAPcyv4jwMx2ohs9QobTohL8jxc5G74XhmY5QFpmiVF9siWLuwA@mail.gmail.com>
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

Acked-by: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2, simplify the calculation of the sector representing the
last page / pfn of the device.

 drivers/dax/super.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 6e928f37d084..0cb8c30ea278 100644
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
@@ -113,6 +115,14 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		return false;
 	}
 
+	last_page = PFN_DOWN(i_size_read(bdev->bd_inode) - 1) * 8;
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
@@ -121,14 +131,15 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
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
 
@@ -143,13 +154,20 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
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

