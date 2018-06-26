Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41ABC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C82638B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872C82638B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeFZR7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:59:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:23715 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754807AbeFZR7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:59:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 10:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="50086620"
Received: from theros.lm.intel.com ([10.232.112.164])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2018 10:59:34 -0700
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Date:   Tue, 26 Jun 2018 11:59:30 -0600
Message-Id: <20180626175932.8899-2-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUEUE_FLAG_DAX is an indication that a given block device supports
filesystem DAX and should not be set for PMEM namespaces which are in "raw"
or "sector" modes.  These namespaces lack struct page and are prevented
from participating in filesystem DAX.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Mike Snitzer <snitzer@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/nvdimm/pmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 68940356cad3..8b1fd7f1a224 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -414,7 +414,8 @@ static int pmem_attach_disk(struct device *dev,
 	blk_queue_logical_block_size(q, pmem_sector_size(ndns));
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	blk_queue_flag_set(QUEUE_FLAG_DAX, q);
+	if (pmem->pfn_flags & PFN_MAP)
+		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 	q->queuedata = pmem;
 
 	disk = alloc_disk_node(0, nid);
-- 
2.14.4

