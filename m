Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D01C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8039C208B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8039C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeGDQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:42:30 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25373 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeGDQkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:40:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=rp8EJVzTcuX8lR9mB6h1Fy/LTnM9TEqQv2PF56msvVgptd+GbI3bu9scZm7dcWuD3rAn+6/3IZ3d
    J4RfNSllL4JVtgfxwA2z9dHiJt4kfCOy0d2+w+eOg/TrUFB3ekzK  
Received: from YEHS1XR956R00D1.lenovo.com (123.120.80.137 [123.120.80.137]) by mx.zohomail.com
        with SMTPS id 1530722421855682.5314336088697; Wed, 4 Jul 2018 09:40:21 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, colyli@suse.de, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 4/4] fs/dax: Assign NULL to gfn of dax_direct_access if useless
Date:   Thu,  5 Jul 2018 00:38:23 +0800
Message-Id: <20180704163823.9980-5-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180704163823.9980-1-yehs2007@zoho.com>
References: <20180704163823.9980-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within fs/dax don't need to get gfn from direct_access.
Assigning NULL to gfn of dax_direct_access is more intuitive and simple
than offering a useless local variable.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index aaec72de..aa75dfd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -550,7 +550,6 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 {
 	void *vto, *kaddr;
 	pgoff_t pgoff;
-	pfn_t pfn;
 	long rc;
 	int id;
 
@@ -559,7 +558,7 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, &pfn);
+	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -961,7 +960,6 @@ int __dax_zero_page_range(struct block_device *bdev,
 		pgoff_t pgoff;
 		long rc, id;
 		void *kaddr;
-		pfn_t pfn;
 
 		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
 		if (rc)
@@ -969,7 +967,7 @@ int __dax_zero_page_range(struct block_device *bdev,
 
 		id = dax_read_lock();
 		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr,
-				&pfn);
+				NULL);
 		if (rc < 0) {
 			dax_read_unlock(id);
 			return rc;
@@ -1024,7 +1022,6 @@ int __dax_zero_page_range(struct block_device *bdev,
 		ssize_t map_len;
 		pgoff_t pgoff;
 		void *kaddr;
-		pfn_t pfn;
 
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
@@ -1036,7 +1033,7 @@ int __dax_zero_page_range(struct block_device *bdev,
 			break;
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
-				&kaddr, &pfn);
+				&kaddr, NULL);
 		if (map_len < 0) {
 			ret = map_len;
 			break;
-- 
1.8.3.1


