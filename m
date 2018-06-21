Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C831C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6DD21C3A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZsbVUea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6DD21C3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFUTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeFUTcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:32:21 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9E821C36;
        Thu, 21 Jun 2018 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529609540;
        bh=Bt+ZLxq3r9bNGRpa7sQfk9V9vKf5Y9NpEiwHYipaAkg=;
        h=From:To:Cc:Subject:Date:From;
        b=mZsbVUea/Te+iIFM7861mCMr8X+ZW1aM6hNCWNEtXIsSxKAH0zmcseNsMryNyvPKA
         rz/2J/INQ7u7d9WD0NI1jis7JtT7oU0GhONkpqrH/qIyo/vy8IAuQWhEq5qAeaJc0r
         okFo7PaIVncmw0PZjOR/K476FAjnIApGfxcQ4hUY=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] f2fs: assign REQ_RAHEAD to bio for ->readpages
Date:   Thu, 21 Jun 2018 12:32:13 -0700
Message-Id: <20180621193213.86850-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jens reported, we'd better assign REQ_RAHEAD to bio by the fact that
->readpages is called only from read-ahead.

In Documentation/filesystems/vfs.txt,

readpages: called by the VM to read pages associated with the address_space
  	object. This is essentially just a vector version of
  	readpage.  Instead of just one page, several pages are
  	requested.
	readpages is only used for read-ahead, so read errors are
  	ignored.  If anything goes wrong, feel free to give up.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f931d699287..bc28ae5ae1ad 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -534,7 +534,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 }
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
-							 unsigned nr_pages)
+					unsigned nr_pages, unsigned op_flag)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -546,7 +546,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		return ERR_PTR(-ENOMEM);
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
+	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
 	if (f2fs_encrypted_file(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
@@ -571,7 +571,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 							block_t blkaddr)
 {
-	struct bio *bio = f2fs_grab_read_bio(inode, blkaddr, 1);
+	struct bio *bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
@@ -1421,10 +1421,15 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
+ *
+ * Note that the aops->readpages() function is ONLY used for read-ahead. If
+ * this function ever deviates from doing just read-ahead, it should either
+ * use ->readpage() or do the necessary surgery to decouple ->readpages()
+ * from read-ahead.
  */
 static int f2fs_mpage_readpages(struct address_space *mapping,
 			struct list_head *pages, struct page *page,
-			unsigned nr_pages)
+			unsigned nr_pages, bool is_readahead)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -1514,7 +1519,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			bio = NULL;
 		}
 		if (bio == NULL) {
-			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages);
+			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
+					is_readahead ? REQ_RAHEAD : 0);
 			if (IS_ERR(bio)) {
 				bio = NULL;
 				goto set_error_page;
@@ -1558,7 +1564,7 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1);
+		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1, false);
 	return ret;
 }
 
@@ -1575,7 +1581,7 @@ static int f2fs_read_data_pages(struct file *file,
 	if (f2fs_has_inline_data(inode))
 		return 0;
 
-	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages);
+	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages, true);
 }
 
 static int encrypt_one_page(struct f2fs_io_info *fio)
-- 
2.17.0.441.gb46fe60e1d-goog

