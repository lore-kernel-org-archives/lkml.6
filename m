Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396F1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0984214DA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0984214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032430AbeGAQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:43:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032052AbeGAQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9AD21AD8;
        Sun,  1 Jul 2018 16:43:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.17 159/220] f2fs: dont use GFP_ZERO for page caches
Date:   Sun,  1 Jul 2018 18:23:03 +0200
Message-Id: <20180701160914.924376126@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

commit 81114baa835b59ed02d14aa1d67f91ea874077cd upstream.

Related to https://lkml.org/lkml/2018/4/8/661

Sometimes, we need to write meta data to new allocated block address,
then we will allocate a zeroed page in inner inode's address space, and
fill partial data in it, and leave other place with zero value which means
some fields are initial status.

There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
I have just checked them, for both of them, we can avoid using __GFP_ZERO,
and do initialization by ourselves to avoid unneeded/redundant zeroing
from mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/checkpoint.c |    4 +++-
 fs/f2fs/inode.c      |    4 ++--
 fs/f2fs/segment.c    |    3 +++
 fs/f2fs/segment.h    |    1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -100,8 +100,10 @@ repeat:
 	 * readonly and make sure do not write checkpoint with non-uptodate
 	 * meta page.
 	 */
-	if (unlikely(!PageUptodate(page)))
+	if (unlikely(!PageUptodate(page))) {
+		memset(page_address(page), 0, PAGE_SIZE);
 		f2fs_stop_checkpoint(sbi, false);
+	}
 out:
 	return page;
 }
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -320,10 +320,10 @@ struct inode *f2fs_iget(struct super_blo
 make_now:
 	if (ino == F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_node_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (ino == F2FS_META_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_meta_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2020,6 +2020,7 @@ static void write_current_sum_page(struc
 	struct f2fs_summary_block *dst;
 
 	dst = (struct f2fs_summary_block *)page_address(page);
+	memset(dst, 0, PAGE_SIZE);
 
 	mutex_lock(&curseg->curseg_mutex);
 
@@ -3116,6 +3117,7 @@ static void write_compacted_summaries(st
 
 	page = grab_meta_page(sbi, blkaddr++);
 	kaddr = (unsigned char *)page_address(page);
+	memset(kaddr, 0, PAGE_SIZE);
 
 	/* Step 1: write nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -3140,6 +3142,7 @@ static void write_compacted_summaries(st
 			if (!page) {
 				page = grab_meta_page(sbi, blkaddr++);
 				kaddr = (unsigned char *)page_address(page);
+				memset(kaddr, 0, PAGE_SIZE);
 				written_size = 0;
 			}
 			summary = (struct f2fs_summary *)(kaddr + written_size);
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -375,6 +375,7 @@ static inline void seg_info_to_sit_page(
 	int i;
 
 	raw_sit = (struct f2fs_sit_block *)page_address(page);
+	memset(raw_sit, 0, PAGE_SIZE);
 	for (i = 0; i < end - start; i++) {
 		rs = &raw_sit->entries[i];
 		se = get_seg_entry(sbi, start + i);


