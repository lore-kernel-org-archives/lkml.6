Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 314D3601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeFFQpy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:45:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:8289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752496AbeFFQpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:45:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="60932382"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v3 3/4] libnvdimm: use dax_write_cache* helpers
Date: Wed,  6 Jun 2018 10:45:14 -0600
Message-Id: <20180606164515.25677-3-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
References: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
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
