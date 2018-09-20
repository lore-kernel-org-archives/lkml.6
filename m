Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95414C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB4B21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHaJB7iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB4B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeIUDgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeIUDgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:36:44 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D95F21533;
        Thu, 20 Sep 2018 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537480269;
        bh=ORpadxJ50UVOVgdfyj1gJdHOVI0/99LxYciMdjOuM4s=;
        h=From:To:Cc:Subject:Date:From;
        b=UHaJB7iUI3Er7D4XgaGA+bKknA9O+5KJDEpXPW1seYMK8CvPeMieHm7jhT+7yTFFV
         3MIHO7sRVLm7PpgD2y1/06Ky6y3NOZrhWfBmPNC2ctiVBu7v+sCO3WOpB+5DJ0sIyT
         g+fUND14gnKt+YlyIXrK4qHveG9FYdrBnf2SN60M=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: update i_size after DIO completion
Date:   Thu, 20 Sep 2018 14:51:08 -0700
Message-Id: <20180920215108.38802-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is related to
ee70daaba82d ("xfs: update i_size after unwritten conversion in dio completion")

If we update i_size during dio_write, dio_read can read out stale data, which
breaks xfstests/465.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 15 +++++++--------
 fs/f2fs/f2fs.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aac426109489..5a80654499c9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -881,7 +881,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	struct f2fs_summary sum;
 	struct node_info ni;
 	block_t old_blkaddr;
-	pgoff_t fofs;
 	blkcnt_t count = 1;
 	int err;
 
@@ -910,12 +909,10 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 					old_blkaddr, old_blkaddr);
 	f2fs_set_data_blkaddr(dn);
 
-	/* update i_size */
-	fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
-							dn->ofs_in_node;
-	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_SHIFT))
-		f2fs_i_size_write(dn->inode,
-				((loff_t)(fofs + 1) << PAGE_SHIFT));
+	/*
+	 * i_size will be updated by direct_IO. Otherwise, we'll get stale
+	 * data from unwritten block via dio_read.
+	 */
 	return 0;
 }
 
@@ -1081,6 +1078,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 					last_ofs_in_node = dn.ofs_in_node;
 				}
 			} else {
+				WARN_ON(flag != F2FS_GET_BLOCK_PRE_DIO &&
+					flag != F2FS_GET_BLOCK_DIO);
 				err = __allocate_data_block(&dn,
 							map->m_seg_type);
 				if (!err)
@@ -1260,7 +1259,7 @@ static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_DEFAULT, NULL,
+						F2FS_GET_BLOCK_DIO, NULL,
 						f2fs_rw_hint_to_seg_type(
 							inode->i_write_hint));
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b5c1f8e3d62f..50af57c6ecf3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -602,6 +602,7 @@ enum {
 	F2FS_GET_BLOCK_DEFAULT,
 	F2FS_GET_BLOCK_FIEMAP,
 	F2FS_GET_BLOCK_BMAP,
+	F2FS_GET_BLOCK_DIO,
 	F2FS_GET_BLOCK_PRE_DIO,
 	F2FS_GET_BLOCK_PRE_AIO,
 	F2FS_GET_BLOCK_PRECACHE,
-- 
2.17.0.441.gb46fe60e1d-goog

