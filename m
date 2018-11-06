Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166DDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC74020827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC74020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbeKFPhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:37:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:53096 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387393AbeKFPhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:37:40 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJuch-0002Eb-4m; Tue, 06 Nov 2018 09:13:59 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ext4: remove code duplication in free_ind_block()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <f1ec9378-6b0f-fdee-392c-bb97187fae12@virtuozzo.com>
Date:   Tue, 6 Nov 2018 09:13:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_ind_block(), free_dind_blocks() and free_tind_blocks() are replaced
by a single recursive function.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/migrate.c | 115 +++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 83 deletions(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 224e136d1c10..754f172b18d4 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -157,100 +157,43 @@ static int extend_credit_for_blkdel(handle_t *handle, struct inode *inode)
 	return retval;
 }
 
-static int free_dind_blocks(handle_t *handle,
-				struct inode *inode, __le32 i_data)
+static int free_ind_blocks(handle_t *handle,
+				struct inode *inode, __le32 i_data, int ind)
 {
-	int i;
-	__le32 *tmp_idata;
-	struct buffer_head *bh;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
-
-	bh = sb_bread(inode->i_sb, le32_to_cpu(i_data));
-	if (!bh)
-		return -EIO;
-
-	tmp_idata = (__le32 *)bh->b_data;
-	for (i = 0; i < max_entries; i++) {
-		if (tmp_idata[i]) {
-			extend_credit_for_blkdel(handle, inode);
-			ext4_free_blocks(handle, inode, NULL,
-					 le32_to_cpu(tmp_idata[i]), 1,
-					 EXT4_FREE_BLOCKS_METADATA |
-					 EXT4_FREE_BLOCKS_FORGET);
-		}
-	}
-	put_bh(bh);
-	extend_credit_for_blkdel(handle, inode);
-	ext4_free_blocks(handle, inode, NULL, le32_to_cpu(i_data), 1,
-			 EXT4_FREE_BLOCKS_METADATA |
-			 EXT4_FREE_BLOCKS_FORGET);
-	return 0;
-}
-
-static int free_tind_blocks(handle_t *handle,
-				struct inode *inode, __le32 i_data)
-{
-	int i, retval = 0;
-	__le32 *tmp_idata;
-	struct buffer_head *bh;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
-
-	bh = sb_bread(inode->i_sb, le32_to_cpu(i_data));
-	if (!bh)
-		return -EIO;
-
-	tmp_idata = (__le32 *)bh->b_data;
-	for (i = 0; i < max_entries; i++) {
-		if (tmp_idata[i]) {
-			retval = free_dind_blocks(handle,
-					inode, tmp_idata[i]);
-			if (retval) {
-				put_bh(bh);
-				return retval;
+	if (ind > 0) {
+		int retval = 0;
+		__le32 *tmp_idata;
+		ext4_lblk_t i, max_entries;
+		struct buffer_head *bh;
+
+		bh = sb_bread(inode->i_sb, le32_to_cpu(i_data));
+		if (!bh)
+			return -EIO;
+
+		tmp_idata = (__le32 *)bh->b_data;
+		max_entries = inode->i_sb->s_blocksize >> 2;
+		for (i = 0; i < max_entries; i++) {
+			if (tmp_idata[i]) {
+				retval = free_ind_blocks(handle,
+						inode, tmp_idata[i], ind - 1);
+				if (retval) {
+					put_bh(bh);
+					return retval;
+				}
 			}
 		}
+		put_bh(bh);
 	}
-	put_bh(bh);
 	extend_credit_for_blkdel(handle, inode);
 	ext4_free_blocks(handle, inode, NULL, le32_to_cpu(i_data), 1,
-			 EXT4_FREE_BLOCKS_METADATA |
-			 EXT4_FREE_BLOCKS_FORGET);
-	return 0;
-}
-
-static int free_ind_block(handle_t *handle, struct inode *inode, __le32 *i_data)
-{
-	int retval;
-
-	/* ei->i_data[EXT4_IND_BLOCK] */
-	if (i_data[0]) {
-		extend_credit_for_blkdel(handle, inode);
-		ext4_free_blocks(handle, inode, NULL,
-				le32_to_cpu(i_data[0]), 1,
-				 EXT4_FREE_BLOCKS_METADATA |
-				 EXT4_FREE_BLOCKS_FORGET);
-	}
-
-	/* ei->i_data[EXT4_DIND_BLOCK] */
-	if (i_data[1]) {
-		retval = free_dind_blocks(handle, inode, i_data[1]);
-		if (retval)
-			return retval;
-	}
-
-	/* ei->i_data[EXT4_TIND_BLOCK] */
-	if (i_data[2]) {
-		retval = free_tind_blocks(handle, inode, i_data[2]);
-		if (retval)
-			return retval;
-	}
+			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 	return 0;
 }
 
 static int ext4_ext_swap_inode_data(handle_t *handle, struct inode *inode,
 						struct inode *tmp_inode)
 {
-	int retval;
+	int i, retval;
 	__le32	i_data[3];
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_inode_info *tmp_ei = EXT4_I(tmp_inode);
@@ -307,7 +250,13 @@ static int ext4_ext_swap_inode_data(handle_t *handle, struct inode *inode,
 	 * We mark the inode dirty after, because we decrement the
 	 * i_blocks when freeing the indirect meta-data blocks
 	 */
-	retval = free_ind_block(handle, inode, i_data);
+	for (i = 0; i < ARRAY_SIZE(i_data); i++) {
+		if (i_data[i]) {
+			retval = free_ind_blocks(handle, inode, i_data[i], i);
+			if (retval)
+				break;
+		}
+	}
 	ext4_mark_inode_dirty(handle, inode);
 
 err_out:
-- 
2.17.1

