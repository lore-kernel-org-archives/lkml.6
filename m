Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD730C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672922083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672922083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIGQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:29:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbeIGQ37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:29:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50357C3B03E5F;
        Fri,  7 Sep 2018 19:49:20 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Fri, 7 Sep 2018 19:49:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: plug readahead IO in readdir()
Date:   Fri, 7 Sep 2018 19:49:07 +0800
Message-ID: <20180907114907.48740-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a plug to merge readahead IO in readdir(), expecting it can
reduce bio count before submitting to block layer.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index ecc3a4e2be96..bd0348cc860f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -784,9 +784,15 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct f2fs_dir_entry *de = NULL;
 	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
+	struct blk_plug plug;
+	bool readdir_ra = sbi->readdir_ra == 1;
+	int err = 0;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
+	if (readdir_ra)
+		blk_start_plug(&plug);
+
 	while (bit_pos < d->max) {
 		bit_pos = find_next_bit_le(d->bitmap, d->max, bit_pos);
 		if (bit_pos >= d->max)
@@ -806,29 +812,33 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		if (f2fs_encrypted_inode(d->inode)) {
 			int save_len = fstr->len;
-			int err;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
 						(u32)de->hash_code, 0,
 						&de_name, fstr);
 			if (err)
-				return err;
+				goto out;
 
 			de_name = *fstr;
 			fstr->len = save_len;
 		}
 
 		if (!dir_emit(ctx, de_name.name, de_name.len,
-					le32_to_cpu(de->ino), d_type))
-			return 1;
+					le32_to_cpu(de->ino), d_type)) {
+			err = 1;
+			goto out;
+		}
 
-		if (sbi->readdir_ra == 1)
+		if (readdir_ra)
 			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
 	}
-	return 0;
+out:
+	if (readdir_ra)
+		blk_finish_plug(&plug);
+	return err;
 }
 
 static int f2fs_readdir(struct file *file, struct dir_context *ctx)
-- 
2.18.0.rc1

