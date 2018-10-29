Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D6C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3201E20664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3201E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJ3AhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:37:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:46106 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbeJ3AhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:37:03 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gH9Pd-0006bb-8a; Mon, 29 Oct 2018 18:25:05 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/7] ext4 resise: extra brelse in
 setup_new_flex_group_blocks()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <yangyongqiang01@baidu.com>,
        Yongqiang Yang <xiaoqiangnk@gmail.com>
Message-ID: <5d2aaeac-2a28-365d-808f-eae2e42218c9@virtuozzo.com>
Date:   Mon, 29 Oct 2018 18:25:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently bh is set to NULL only during first iteration of for cycle,
then this pointer is not cleared after end of using.
Therefore rollback after errors can lead to extra brelse(bh) call,
decrements bh counter and later trigger an unexpected warning in __brelse()

Patch moves brelse() calls in body of cycle to exclude requirement of
brelse() call in rollback.

Fixes 33afdcc5402d ("ext4: add a function which sets up group blocks ...")
#? cc: stable@vger.kernel.org # 3.3+

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/ext4/resize.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index ebbc663d0798..c3fa30878ca8 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -605,7 +605,6 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 		bh = bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err = PTR_ERR(bh);
-			bh = NULL;
 			goto out;
 		}
 		overhead = ext4_group_overhead_blocks(sb, group);
@@ -618,9 +617,9 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 		ext4_mark_bitmap_end(EXT4_B2C(sbi, group_data[i].blocks_count),
 				     sb->s_blocksize * 8, bh->b_data);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
 
 handle_ib:
 		if (bg_flags[i] & EXT4_BG_INODE_UNINIT)
@@ -635,18 +634,16 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 		bh = bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err = PTR_ERR(bh);
-			bh = NULL;
 			goto out;
 		}
 
 		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
 				     sb->s_blocksize * 8, bh->b_data);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
 	}
-	bh = NULL;
 
 	/* Mark group tables in block bitmap */
 	for (j = 0; j < GROUP_TABLE_COUNT; j++) {
@@ -685,7 +682,6 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 	}
 
 out:
-	brelse(bh);
 	err2 = ext4_journal_stop(handle);
 	if (err2 && !err)
 		err = err2;
-- 
2.17.1

