Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 217AF601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbeFFQpi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:45:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:8289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752667AbeFFQpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:45:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="60932386"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v3 4/4] libnvdimm: don't flush power-fail protected CPU caches
Date: Wed,  6 Jun 2018 10:45:15 -0600
Message-Id: <20180606164515.25677-4-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
References: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit:

5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")

intended to make sure that deep flush was always available even on
platforms which support a power-fail protected CPU cache.  An unintended
side effect of this change was that we also lost the ability to skip
flushing CPU caches on those power-fail protected CPU cache.

Fix this by skipping the low level cache flushing in dax_flush() if we have
CPU caches which are power-fail protected.  The user can still override this
behavior by manually setting the write_cache state of a namespace.  See
libndctl's ndctl_namespace_write_cache_is_enabled(),
ndctl_namespace_enable_write_cache() and
ndctl_namespace_disable_write_cache() functions.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: 5fdf8e5ba566 ("libnvdimm: re-enable deep flush for pmem devices via fsync()")
---
 drivers/nvdimm/region_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index a612be6f019d..ec3543b83330 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1132,7 +1132,8 @@ EXPORT_SYMBOL_GPL(nvdimm_has_flush);
 
 int nvdimm_has_cache(struct nd_region *nd_region)
 {
-	return is_nd_pmem(&nd_region->dev);
+	return is_nd_pmem(&nd_region->dev) &&
+		!test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags);
 }
 EXPORT_SYMBOL_GPL(nvdimm_has_cache);
 
-- 
2.14.4
