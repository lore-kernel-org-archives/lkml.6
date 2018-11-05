Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01099C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35BE20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35BE20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeKEUWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:22:21 -0500
Received: from relay.sw.ru ([185.231.240.75]:47536 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbeKEUWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:22:21 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJcey-0007O4-UB; Mon, 05 Nov 2018 14:03:09 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] ext4: remove code duplication in
 update_ind/bind/tind_extent_range
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-kernel@vger.kernel.org
References: <E88DA3F6-D339-44D6-95A8-75256A8F57CC@dilger.ca>
Message-ID: <bcd63c24-4a5c-8c75-554d-af0f80d1edf7@virtuozzo.com>
Date:   Mon, 5 Nov 2018 14:03:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E88DA3F6-D339-44D6-95A8-75256A8F57CC@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_ind/bind/tind_extent_page() differs by one variable and can be
replaced by unified function. These functions are called by similar way
and their caller function can be simplified too.

v2: minor style changes, thanks to Andreas Dilger

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/migrate.c | 112 ++++++++++------------------------------------
 1 file changed, 24 insertions(+), 88 deletions(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 61a9d1927817..224e136d1c10 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -109,12 +109,13 @@ static int update_extent_range(handle_t *handle, struct inode *inode,
 
 static int update_ind_extent_range(handle_t *handle, struct inode *inode,
 				   ext4_fsblk_t pblock,
-				   struct migrate_struct *lb)
+				   struct migrate_struct *lb,
+				   ext4_lblk_t inc)
 {
 	struct buffer_head *bh;
 	__le32 *i_data;
 	int i, retval = 0;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
+	ext4_lblk_t max_entries = inode->i_sb->s_blocksize >> 2;
 
 	bh = sb_bread(inode->i_sb, pblock);
 	if (!bh)
@@ -128,67 +129,7 @@ static int update_ind_extent_range(handle_t *handle, struct inode *inode,
 			if (retval)
 				break;
 		} else {
-			lb->curr_block++;
-		}
-	}
-	put_bh(bh);
-	return retval;
-
-}
-
-static int update_dind_extent_range(handle_t *handle, struct inode *inode,
-				    ext4_fsblk_t pblock,
-				    struct migrate_struct *lb)
-{
-	struct buffer_head *bh;
-	__le32 *i_data;
-	int i, retval = 0;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
-
-	bh = sb_bread(inode->i_sb, pblock);
-	if (!bh)
-		return -EIO;
-
-	i_data = (__le32 *)bh->b_data;
-	for (i = 0; i < max_entries; i++) {
-		if (i_data[i]) {
-			retval = update_ind_extent_range(handle, inode,
-						le32_to_cpu(i_data[i]), lb);
-			if (retval)
-				break;
-		} else {
-			/* Only update the file block number */
-			lb->curr_block += max_entries;
-		}
-	}
-	put_bh(bh);
-	return retval;
-
-}
-
-static int update_tind_extent_range(handle_t *handle, struct inode *inode,
-				    ext4_fsblk_t pblock,
-				    struct migrate_struct *lb)
-{
-	struct buffer_head *bh;
-	__le32 *i_data;
-	int i, retval = 0;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
-
-	bh = sb_bread(inode->i_sb, pblock);
-	if (!bh)
-		return -EIO;
-
-	i_data = (__le32 *)bh->b_data;
-	for (i = 0; i < max_entries; i++) {
-		if (i_data[i]) {
-			retval = update_dind_extent_range(handle, inode,
-						le32_to_cpu(i_data[i]), lb);
-			if (retval)
-				break;
-		} else {
-			/* Only update the file block number */
-			lb->curr_block += max_entries * max_entries;
+			lb->curr_block += inc;
 		}
 	}
 	put_bh(bh);
@@ -433,7 +374,7 @@ int ext4_ext_migrate(struct inode *inode)
 	struct ext4_inode_info *ei;
 	struct inode *tmp_inode = NULL;
 	struct migrate_struct lb;
-	unsigned long max_entries;
+	ext4_lblk_t max_entries, inc, mult;
 	__u32 goal;
 	uid_t owner[2];
 
@@ -523,34 +464,29 @@ int ext4_ext_migrate(struct inode *inode)
 
 	/* 32 bit block address 4 bytes */
 	max_entries = inode->i_sb->s_blocksize >> 2;
-	for (i = 0; i < EXT4_NDIR_BLOCKS; i++) {
+
+	inc = 1; mult = 1;
+	for (i = 0; i < EXT4_N_BLOCKS; i++) {
+		inc *= mult;
+		if (i == EXT4_IND_BLOCK)
+			mult = max_entries;
+
 		if (i_data[i]) {
-			retval = update_extent_range(handle, tmp_inode,
+			if (i < EXT4_IND_BLOCK)
+				retval = update_extent_range(handle, tmp_inode,
 						le32_to_cpu(i_data[i]), &lb);
+			else
+				retval = update_ind_extent_range(handle,
+						tmp_inode,
+						le32_to_cpu(i_data[i]),
+						&lb, inc);
 			if (retval)
 				goto err_out;
-		} else
-			lb.curr_block++;
-	}
-	if (i_data[EXT4_IND_BLOCK]) {
-		retval = update_ind_extent_range(handle, tmp_inode,
-				le32_to_cpu(i_data[EXT4_IND_BLOCK]), &lb);
-			if (retval)
-				goto err_out;
-	} else
-		lb.curr_block += max_entries;
-	if (i_data[EXT4_DIND_BLOCK]) {
-		retval = update_dind_extent_range(handle, tmp_inode,
-				le32_to_cpu(i_data[EXT4_DIND_BLOCK]), &lb);
-			if (retval)
-				goto err_out;
-	} else
-		lb.curr_block += max_entries * max_entries;
-	if (i_data[EXT4_TIND_BLOCK]) {
-		retval = update_tind_extent_range(handle, tmp_inode,
-				le32_to_cpu(i_data[EXT4_TIND_BLOCK]), &lb);
-			if (retval)
-				goto err_out;
+
+		} else {
+			if (i < EXT4_TIND_BLOCK)
+				lb.curr_block += inc * mult;
+		}
 	}
 	/*
 	 * Build the last extent
-- 
2.17.1

