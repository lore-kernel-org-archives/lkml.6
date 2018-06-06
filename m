Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE4B6601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeFFQpS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:45:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:8289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbeFFQpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:45:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="60932373"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v3 1/4] pmem, libnvdimm: complete REQ_FLUSH => REQ_PREFLUSH
Date: Wed,  6 Jun 2018 10:45:12 -0600
Message-Id: <20180606164515.25677-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the move from REQ_FLUSH to REQ_PREFLUSH that apparently started
way back in v4.8.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 drivers/nvdimm/pmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9d714926ecf5..252adfab1e47 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -164,11 +164,6 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 	return rc;
 }
 
-/* account for REQ_FLUSH rename, replace with REQ_PREFLUSH after v4.8-rc1 */
-#ifndef REQ_FLUSH
-#define REQ_FLUSH REQ_PREFLUSH
-#endif
-
 static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 {
 	blk_status_t rc = 0;
@@ -179,7 +174,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	struct pmem_device *pmem = q->queuedata;
 	struct nd_region *nd_region = to_region(pmem);
 
-	if (bio->bi_opf & REQ_FLUSH)
+	if (bio->bi_opf & REQ_PREFLUSH)
 		nvdimm_flush(nd_region);
 
 	do_acct = nd_iostat_start(bio, &start);
-- 
2.14.4
