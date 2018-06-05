Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeFEU7D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:59:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:25418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeFEU7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:59:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="234933759"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH 1/2] libnvdimm: use dax_write_cache* helpers
Date: Tue,  5 Jun 2018 14:58:40 -0600
Message-Id: <20180605205841.15878-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dax_write_cache() and dax_write_cache_enabled() instead of open coding
the bit operations.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 drivers/dax/super.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 2b2332b605e4..c2c46f96b18c 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -182,8 +182,7 @@ static ssize_t write_cache_show(struct device *dev,
 	if (!dax_dev)
 		return -ENXIO;
 
-	rc = sprintf(buf, "%d\n", !!test_bit(DAXDEV_WRITE_CACHE,
-				&dax_dev->flags));
+	rc = sprintf(buf, "%d\n", !!dax_write_cache_enabled(dax_dev));
 	put_dax(dax_dev);
 	return rc;
 }
@@ -201,10 +200,8 @@ static ssize_t write_cache_store(struct device *dev,
 
 	if (rc)
 		len = rc;
-	else if (write_cache)
-		set_bit(DAXDEV_WRITE_CACHE, &dax_dev->flags);
 	else
-		clear_bit(DAXDEV_WRITE_CACHE, &dax_dev->flags);
+		dax_write_cache(dax_dev, write_cache);
 
 	put_dax(dax_dev);
 	return len;
@@ -286,7 +283,7 @@ EXPORT_SYMBOL_GPL(dax_copy_from_iter);
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 {
-	if (unlikely(!test_bit(DAXDEV_WRITE_CACHE, &dax_dev->flags)))
+	if (unlikely(!dax_write_cache_enabled(dax_dev)))
 		return;
 
 	arch_wb_cache_pmem(addr, size);
-- 
2.14.4
