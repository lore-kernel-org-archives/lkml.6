Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B39CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE4320821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE4320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJaSd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:33:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbeJaSd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:33:28 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDF1C407838F0;
        Wed, 31 Oct 2018 17:36:04 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Wed, 31 Oct 2018 17:35:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add to account direct IO
Date:   Wed, 31 Oct 2018 17:35:49 +0800
Message-ID: <20181031093549.97570-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds f2fs_dio_submit_bio() to hook submit_io/end_io functions
in direct IO path, in order to account DIO.

Later, we will add this count into is_idle() to let background GC/Discard
thread be aware of DIO.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/debug.c |  4 ++++
 fs/f2fs/f2fs.h  | 10 ++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a874bedc923..b5c711b35f8e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2601,6 +2601,53 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 	return 0;
 }
 
+static void f2fs_dio_end_io(struct bio *bio)
+{
+	struct f2fs_private_dio *dio = bio->bi_private;
+
+	dec_page_count(F2FS_I_SB(dio->inode),
+			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
+
+	bio->bi_private = dio->orig_private;
+	bio->bi_end_io = dio->orig_end_io;
+
+	kfree(dio);
+
+	bio_endio(bio);
+}
+
+static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
+							loff_t file_offset)
+{
+	struct f2fs_private_dio *dio;
+	bool write = (bio_op(bio) == REQ_OP_WRITE);
+	int err;
+
+	dio = f2fs_kzalloc(F2FS_I_SB(inode),
+			sizeof(struct f2fs_private_dio), GFP_NOFS);
+	if (!dio) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	dio->inode = inode;
+	dio->orig_end_io = bio->bi_end_io;
+	dio->orig_private = bio->bi_private;
+	dio->write = write;
+
+	bio->bi_end_io = f2fs_dio_end_io;
+	bio->bi_private = dio;
+
+	inc_page_count(F2FS_I_SB(inode),
+			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
+
+	submit_bio(bio);
+	return;
+out:
+	bio->bi_error = err;
+	bio_endio(bio);
+}
+
 static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
@@ -2647,7 +2694,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			down_read(&fi->i_gc_rwsem[READ]);
 	}
 
-	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
+	err = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
+			iter, get_data_block_dio, NULL, f2fs_dio_submit_bio,
+			DIO_LOCKING | DIO_SKIP_HOLES);
 
 	if (do_opu)
 		up_read(&fi->i_gc_rwsem[READ]);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index e327eefdbc02..06e72f9c8654 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -53,6 +53,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->vw_cnt = atomic_read(&sbi->vw_cnt);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
 	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
+	si->nr_dio_read = get_pages(sbi, F2FS_DIO_READ);
+	si->nr_dio_write = get_pages(sbi, F2FS_DIO_WRITE);
 	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
 	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
 	si->nr_rd_data = get_pages(sbi, F2FS_RD_DATA);
@@ -374,6 +376,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
+		seq_printf(s, "  - DIO (R: %4d, W: %4d)\n",
+			   si->nr_dio_read, si->nr_dio_write);
 		seq_printf(s, "  - IO_R (Data: %4d, Node: %4d, Meta: %4d\n",
 			   si->nr_rd_data, si->nr_rd_node, si->nr_rd_meta);
 		seq_printf(s, "  - IO_W (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b9cec3f2184c..2363512c0e1c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -957,6 +957,8 @@ enum count_type {
 	F2FS_RD_DATA,
 	F2FS_RD_NODE,
 	F2FS_RD_META,
+	F2FS_DIO_WRITE,
+	F2FS_DIO_READ,
 	NR_COUNT_TYPE,
 };
 
@@ -1336,6 +1338,13 @@ struct f2fs_sb_info {
 	__u32 s_chksum_seed;
 };
 
+struct f2fs_private_dio {
+	struct inode *inode;
+	void *orig_private;
+	bio_end_io_t *orig_end_io;
+	bool write;
+};
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(type)					\
 	printk_ratelimited("%sF2FS-fs : inject %s in %s of %pF\n",	\
@@ -3158,6 +3167,7 @@ struct f2fs_stat_info {
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
 	int nr_rd_data, nr_rd_node, nr_rd_meta;
+	int nr_dio_read, nr_dio_write;
 	unsigned int io_skip_bggc, other_skip_bggc;
 	int nr_flushing, nr_flushed, flush_list_empty;
 	int nr_discarding, nr_discarded;
-- 
2.18.0.rc1

