Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9807FC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4921900
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357857;
	bh=ucJr2oGxNMnui8W5P/RTwwlB+2nrta14/DJkfAZkQ2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scsuFdH8ZcU4XZgmDJo7P39LoTTVXyUwGe4RzqUkvGMQMa0Lxs5BmQc7F/cpRQgiG
	 BQG3c16Ugw12I1yen791M2W7F37a3JGaBcZGIGTjxUDJOxCl+J8Sf3m7adx8xZaF7w
	 9CT+JdiBEyQlMvRpuRxWgJNpYpol4EthxY2qGkuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfAXTYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfAXTYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8897217D7;
        Thu, 24 Jan 2019 19:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357851;
        bh=ucJr2oGxNMnui8W5P/RTwwlB+2nrta14/DJkfAZkQ2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9IfL5gdJnPB/60m/QmMwXoITo9HGO0+9NxVgProGb1URgDoFhnd02RFrUg7GCumg
         0Zjp0aRMJSFGFP+vD2HijQwGCxvzwyYdpkrQyHFA24J87otu6C9l2ht4udF5mUrowy
         v1FyXfUBegD0klUHA75oOPmDAqdijvAiQrW9Xob4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 011/104] f2fs: fix to avoid reading out encrypted data in page cache
Date:   Thu, 24 Jan 2019 20:19:00 +0100
Message-Id: <20190124190156.143509544@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

commit 78682f79447998369a85f12b6437fa8fdbbdca50 upstream.

For encrypted inode, if user overwrites data of the inode, f2fs will read
encrypted data into page cache, and then do the decryption.

However reader can race with overwriter, and it will see encrypted data
which has not been decrypted by overwriter yet. Fix it by moving decrypting
work to background and keep page non-uptodated until data is decrypted.

Thread A				Thread B
- f2fs_file_write_iter
 - __generic_file_write_iter
  - generic_perform_write
   - f2fs_write_begin
    - f2fs_submit_page_bio
					- generic_file_read_iter
					 - do_generic_file_read
					  - lock_page_killable
					  - unlock_page
					  - copy_page_to_iter
					  hit the encrypted data in updated page
    - lock_page
    - fscrypt_decrypt_page

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4:
 - Keep using f2fs_crypto functions instead of generic fscrypt API
 - Use PAGE_CACHE_SIZE instead of PAGE_SIZE
 - Use submit_bio() instead of __submit_bio()
 - In f2fs_write_begin(), use dn.data_blkaddr instead of blkaddr
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |   89 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -866,6 +866,37 @@ out:
 	return ret;
 }
 
+struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
+							unsigned nr_pages)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_crypto_ctx *ctx = NULL;
+	struct block_device *bdev = sbi->sb->s_bdev;
+	struct bio *bio;
+
+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
+		ctx = f2fs_get_crypto_ctx(inode);
+		if (IS_ERR(ctx))
+			return ERR_CAST(ctx);
+
+		/* wait the page to be moved by cleaning */
+		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
+	}
+
+	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
+	if (!bio) {
+		if (ctx)
+			f2fs_release_crypto_ctx(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+	bio->bi_bdev = bdev;
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blkaddr);
+	bio->bi_end_io = f2fs_read_end_io;
+	bio->bi_private = ctx;
+
+	return bio;
+}
+
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
@@ -884,7 +915,6 @@ static int f2fs_mpage_readpages(struct a
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t block_nr;
-	struct block_device *bdev = inode->i_sb->s_bdev;
 	struct f2fs_map_blocks map;
 
 	map.m_pblk = 0;
@@ -958,31 +988,9 @@ submit_and_realloc:
 			bio = NULL;
 		}
 		if (bio == NULL) {
-			struct f2fs_crypto_ctx *ctx = NULL;
-
-			if (f2fs_encrypted_inode(inode) &&
-					S_ISREG(inode->i_mode)) {
-
-				ctx = f2fs_get_crypto_ctx(inode);
-				if (IS_ERR(ctx))
-					goto set_error_page;
-
-				/* wait the page to be moved by cleaning */
-				f2fs_wait_on_encrypted_page_writeback(
-						F2FS_I_SB(inode), block_nr);
-			}
-
-			bio = bio_alloc(GFP_KERNEL,
-				min_t(int, nr_pages, BIO_MAX_PAGES));
-			if (!bio) {
-				if (ctx)
-					f2fs_release_crypto_ctx(ctx);
+			bio = f2fs_grab_bio(inode, block_nr, nr_pages);
+			if (IS_ERR(bio))
 				goto set_error_page;
-			}
-			bio->bi_bdev = bdev;
-			bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(block_nr);
-			bio->bi_end_io = f2fs_read_end_io;
-			bio->bi_private = ctx;
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
@@ -1482,17 +1490,21 @@ put_next:
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	} else {
-		struct f2fs_io_info fio = {
-			.sbi = sbi,
-			.type = DATA,
-			.rw = READ_SYNC,
-			.blk_addr = dn.data_blkaddr,
-			.page = page,
-			.encrypted_page = NULL,
-		};
-		err = f2fs_submit_page_bio(&fio);
-		if (err)
+		struct bio *bio;
+
+		bio = f2fs_grab_bio(inode, dn.data_blkaddr, 1);
+		if (IS_ERR(bio)) {
+			err = PTR_ERR(bio);
+			goto fail;
+		}
+
+		if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
+			bio_put(bio);
+			err = -EFAULT;
 			goto fail;
+		}
+
+		submit_bio(READ_SYNC, bio);
 
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
@@ -1503,13 +1515,6 @@ put_next:
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
-
-		/* avoid symlink page */
-		if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
-			err = f2fs_decrypt_one(inode, page);
-			if (err)
-				goto fail;
-		}
 	}
 out_update:
 	SetPageUptodate(page);


