Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E46B2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E46B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeLJRTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:19:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5217C2BEAE;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04CFE600D6;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 814A722426A; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 31/52] dax: Pass dax_dev to dax_writeback_mapping_range()
Date:   Mon, 10 Dec 2018 12:12:57 -0500
Message-Id: <20181210171318.16998-32-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
is searched from that bdev name.

virtio-fs does not have a bdev. So pass in dax_dev also to
dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
used otherwise dax_dev is searched using bdev.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            | 16 ++++++++++------
 fs/ext4/inode.c     |  2 +-
 fs/xfs/xfs_aops.c   |  2 +-
 include/linux/dax.h |  6 ++++--
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6431c3aba182..1ae3a60c17d4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -911,12 +911,12 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
  * on persistent storage prior to completion of the operation.
  */
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc)
 {
 	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
 	struct inode *inode = mapping->host;
 	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
-	struct dax_device *dax_dev;
 	void *entry;
 	int ret = 0;
 	unsigned int scanned = 0;
@@ -927,9 +927,12 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
-	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
-	if (!dax_dev)
-		return -EIO;
+	if (bdev) {
+		WARN_ON(dax_dev);
+		dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+		if (!dax_dev)
+			return -EIO;
+	}
 
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
 
@@ -951,7 +954,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
-	put_dax(dax_dev);
+	if (bdev)
+		put_dax(dax_dev);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
 	return ret;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 22a9d8159720..3569c260a3bd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2978,7 +2978,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	percpu_down_read(&sbi->s_journal_flag_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
-	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
+	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, NULL, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
 	percpu_up_read(&sbi->s_journal_flag_rwsem);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 338b9d9984e0..b1947beec50a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -951,7 +951,7 @@ xfs_dax_writepages(
 {
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
 	return dax_writeback_mapping_range(mapping,
-			xfs_find_bdev_for_inode(mapping->host), wbc);
+			xfs_find_bdev_for_inode(mapping->host), NULL, wbc);
 }
 
 STATIC int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 450b28db9533..a8461841f148 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -85,7 +85,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc);
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 bool dax_lock_mapping_entry(struct page *page);
@@ -117,7 +118,8 @@ static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 }
 
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.13.6

