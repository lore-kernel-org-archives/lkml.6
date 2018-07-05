Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8427C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B68240E7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B68240E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeGEG7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:59:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:36394 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbeGEG7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:59:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="64559174"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2018 23:59:48 -0700
Subject: [PATCH 09/13] fs/dax: Assign NULL to pfn of dax_direct_access if
 useless
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Huaisheng Ye <yehs1@lenovo.com>, Jan Kara <jack@suse.cz>,
        vishal.l.verma@intel.com, hch@lst.de, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 23:49:50 -0700
Message-ID: <153077339083.40830.7002878534903996422.stgit@dwillia2-desk3.amr.corp.intel.com>
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

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within fs/dax don't need to get pfn from direct_access.
Assigning NULL to pfn of dax_direct_access is more intuitive and simple
than offering a useless local variable.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 641192808bb6..28264ff4e343 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -647,7 +647,6 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 {
 	void *vto, *kaddr;
 	pgoff_t pgoff;
-	pfn_t pfn;
 	long rc;
 	int id;
 
@@ -656,7 +655,7 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, &pfn);
+	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1052,15 +1051,13 @@ int __dax_zero_page_range(struct block_device *bdev,
 		pgoff_t pgoff;
 		long rc, id;
 		void *kaddr;
-		pfn_t pfn;
 
 		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
 		if (rc)
 			return rc;
 
 		id = dax_read_lock();
-		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr,
-				&pfn);
+		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 		if (rc < 0) {
 			dax_read_unlock(id);
 			return rc;
@@ -1116,7 +1113,6 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ssize_t map_len;
 		pgoff_t pgoff;
 		void *kaddr;
-		pfn_t pfn;
 
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -1128,7 +1124,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-				&kaddr, &pfn);
+				&kaddr, NULL);
 		if (map_len < 0) {
 			ret = map_len;
 			break;

