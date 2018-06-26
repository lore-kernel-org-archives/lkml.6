Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B38C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E99A26BA3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E99A26BA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbeFZSA0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:00:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:23718 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754813AbeFZR7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:59:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 10:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="50086622"
Received: from theros.lm.intel.com ([10.232.112.164])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2018 10:59:35 -0700
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 2/3] dax: bdev_dax_supported() check for QUEUE_FLAG_DAX
Date:   Tue, 26 Jun 2018 11:59:31 -0600
Message-Id: <20180626175932.8899-3-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explicit check for QUEUE_FLAG_DAX to __bdev_dax_supported().  This
is needed for DM configurations where the first element in the dm-linear or
dm-stripe target supports DAX, but other elements do not.  Without this
check __bdev_dax_supported() will pass for such devices, letting a
filesystem on that device mount with the DAX option.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Mike Snitzer <snitzer@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/dax/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 903d9c473749..45276abf03aa 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -86,6 +86,7 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	struct dax_device *dax_dev;
 	bool dax_enabled = false;
+	struct request_queue *q;
 	pgoff_t pgoff;
 	int err, id;
 	void *kaddr;
@@ -99,6 +100,13 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		return false;
 	}
 
+	q = bdev_get_queue(bdev);
+	if (!q || !blk_queue_dax(q)) {
+		pr_debug("%s: error: request queue doesn't support dax\n",
+				bdevname(bdev, buf));
+		return false;
+	}
+
 	err = bdev_dax_pgoff(bdev, 0, PAGE_SIZE, &pgoff);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
-- 
2.14.4

