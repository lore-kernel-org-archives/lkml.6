Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbeCUXKT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:10:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:14149 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754200AbeCUXGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:06:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="26466592"
Subject: [PATCH v7 03/14] block, dax: remove dead code in blkdev_writepages()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jeff Moyer <jmoyer@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Date: Wed, 21 Mar 2018 15:57:27 -0700
Message-ID: <152167304720.5268.4517441516790980453.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152167302988.5268.4370226749268662682.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152167302988.5268.4370226749268662682.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Block device inodes never have S_DAX set, so kill the check for DAX and
diversion to dax_writeback_mapping_range().

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/block_dev.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fe09ef9c21f3..846ee2d31781 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1946,11 +1946,6 @@ static int blkdev_releasepage(struct page *page, gfp_t wait)
 static int blkdev_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
-	if (dax_mapping(mapping)) {
-		struct block_device *bdev = I_BDEV(mapping->host);
-
-		return dax_writeback_mapping_range(mapping, bdev, wbc);
-	}
 	return generic_writepages(mapping, wbc);
 }
 
