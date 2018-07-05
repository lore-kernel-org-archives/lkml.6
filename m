Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ABF240E9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ABF240E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeGEHAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:00:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:57055 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbeGEG7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:59:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="237968468"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2018 23:59:53 -0700
Subject: [PATCH 10/13] filesystem-dax: Make mount time pfn validation a
 debug check
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 23:49:56 -0700
Message-ID: <153077339595.40830.16578300356324475234.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Do not ask for dax_direct_access() to retrieve a pfn in the
DAX_DRIVER_DEBUG=n case. This avoids an early call to memmap_sync() in
the driver.

Now that QUEUE_FLAG_DAX usage has been fixed the validation of the pfn
is only useful for dax driver developers. It is safe to assume that
pmem, dcssblk, and device-mapper-dax are correct with respect to dax
operation, so only retrieve the pfn for debug builds when qualifying a
new dax driver, if one ever arrives.

The moves the first consumption of a pfn from ->direct_access() to the
first dax mapping fault, rather than initial filesystem mount. I.e. more
time for memmap init to run in the background.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig |   10 ++++++++
 drivers/dax/super.c |   64 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index e0700bf4893a..b32f8827b983 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -9,6 +9,16 @@ menuconfig DAX
 
 if DAX
 
+config DAX_DRIVER_DEBUG
+	bool "DAX: driver debug"
+	help
+	  Enable validation of the page frame objects returned from a
+	  driver's 'direct_access' operation. This validation is
+	  performed relative to the requirements of the FS_DAX and
+	  FS_DAX_LIMITED configuration options. If you are validating
+	  the implementation of a dax device driver say Y otherwise
+	  say N.
+
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 903d9c473749..87b1c55b7c7a 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -72,6 +72,41 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 #endif
 
+static bool validate_dax_pfn(pfn_t *pfn)
+{
+	bool dax_enabled = false;
+
+	/*
+	 * Unless debugging a new dax driver, or new dax architecture
+	 * support there is no need to check the pfn. Delay the kernel's
+	 * first need for a dax pfn until first userspace dax fault.
+	 */
+	if (!pfn)
+		return true;
+
+	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED) && pfn_t_special(*pfn)) {
+		/*
+		 * An arch that has enabled the pmem api should also
+		 * have its drivers support pfn_t_devmap()
+		 *
+		 * This is a developer warning and should not trigger in
+		 * production. dax_flush() will crash since it depends
+		 * on being able to do (page_address(pfn_to_page())).
+		 */
+		WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
+		dax_enabled = true;
+	} else if (pfn_t_devmap(*pfn)) {
+		struct dev_pagemap *pgmap;
+
+		pgmap = get_dev_pagemap(pfn_t_to_pfn(*pfn), NULL);
+		if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
+			dax_enabled = true;
+		put_dev_pagemap(pgmap);
+	}
+
+	return dax_enabled;
+}
+
 /**
  * __bdev_dax_supported() - Check if the device supports dax for filesystem
  * @bdev: block device to check
@@ -85,11 +120,10 @@ EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
 bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	struct dax_device *dax_dev;
-	bool dax_enabled = false;
+	pfn_t _pfn, *pfn;
 	pgoff_t pgoff;
 	int err, id;
 	void *kaddr;
-	pfn_t pfn;
 	long len;
 	char buf[BDEVNAME_SIZE];
 
@@ -113,8 +147,10 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		return false;
 	}
 
+	pfn = IS_ENABLED(DAX_DRIVER_DEBUG) ? &_pfn : NULL;
+
 	id = dax_read_lock();
-	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
+	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, pfn);
 	dax_read_unlock(id);
 
 	put_dax(dax_dev);
@@ -125,27 +161,7 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		return false;
 	}
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED) && pfn_t_special(pfn)) {
-		/*
-		 * An arch that has enabled the pmem api should also
-		 * have its drivers support pfn_t_devmap()
-		 *
-		 * This is a developer warning and should not trigger in
-		 * production. dax_flush() will crash since it depends
-		 * on being able to do (page_address(pfn_to_page())).
-		 */
-		WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
-		dax_enabled = true;
-	} else if (pfn_t_devmap(pfn)) {
-		struct dev_pagemap *pgmap;
-
-		pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
-		if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
-			dax_enabled = true;
-		put_dev_pagemap(pgmap);
-	}
-
-	if (!dax_enabled) {
+	if (!validate_dax_pfn(pfn)) {
 		pr_debug("%s: error: dax support not enabled\n",
 				bdevname(bdev, buf));
 		return false;

