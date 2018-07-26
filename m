Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A09A20891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A09A20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbeGZNlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:41:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730160AbeGZNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:41:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0FDCE8595E92;
        Thu, 26 Jul 2018 20:24:39 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:24:34 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 06/25] staging: erofs: add directory operations
Date:   Thu, 26 Jul 2018 20:21:49 +0800
Message-ID: <1532607728-103372-7-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds functions for directory, mainly readdir.

Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/dir.c | 145 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 drivers/staging/erofs/dir.c

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
new file mode 100644
index 0000000..be6ae3b
--- /dev/null
+++ b/drivers/staging/erofs/dir.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/drivers/staging/erofs/dir.c
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of the Linux
+ * distribution for more details.
+ */
+#include "internal.h"
+
+static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
+	[EROFS_FT_UNKNOWN]	= DT_UNKNOWN,
+	[EROFS_FT_REG_FILE]	= DT_REG,
+	[EROFS_FT_DIR]		= DT_DIR,
+	[EROFS_FT_CHRDEV]	= DT_CHR,
+	[EROFS_FT_BLKDEV]	= DT_BLK,
+	[EROFS_FT_FIFO]		= DT_FIFO,
+	[EROFS_FT_SOCK]		= DT_SOCK,
+	[EROFS_FT_SYMLINK]	= DT_LNK,
+};
+
+static int erofs_fill_dentries(struct dir_context *ctx,
+	void *dentry_blk, unsigned *ofs,
+	unsigned nameoff, unsigned maxsize)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + nameoff;
+
+	de = dentry_blk + *ofs;
+	while (de < end) {
+		const char *de_name;
+		int de_namelen;
+		unsigned char d_type;
+#ifdef CONFIG_EROFS_FS_DEBUG
+		unsigned dbg_namelen;
+		unsigned char dbg_namebuf[EROFS_NAME_LEN];
+#endif
+
+		if (unlikely(de->file_type < EROFS_FT_MAX))
+			d_type = erofs_filetype_table[de->file_type];
+		else
+			d_type = DT_UNKNOWN;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		de_namelen = unlikely(de + 1 >= end) ?
+			/* last directory entry */
+			strnlen(de_name, maxsize - nameoff) :
+			le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* the corrupted directory found */
+		BUG_ON(de_namelen < 0);
+
+#ifdef CONFIG_EROFS_FS_DEBUG
+		dbg_namelen = min(EROFS_NAME_LEN - 1, de_namelen);
+		memcpy(dbg_namebuf, de_name, dbg_namelen);
+		dbg_namebuf[dbg_namelen] = '\0';
+
+		debugln("%s, found de_name %s de_len %d d_type %d", __func__,
+			dbg_namebuf, de_namelen, d_type);
+#endif
+
+		if (!dir_emit(ctx, de_name, de_namelen,
+					le64_to_cpu(de->nid), d_type))
+			/* stoped by some reason */
+			return 1;
+		++de;
+		*ofs += sizeof(struct erofs_dirent);
+	}
+	*ofs = maxsize;
+	return 0;
+}
+
+static int erofs_readdir(struct file *f, struct dir_context *ctx)
+{
+	struct inode *dir = file_inode(f);
+	struct address_space *mapping = dir->i_mapping;
+	const size_t dirsize = i_size_read(dir);
+	unsigned i = ctx->pos / EROFS_BLKSIZ;
+	unsigned ofs = ctx->pos % EROFS_BLKSIZ;
+	int err = 0;
+	bool initial = true;
+
+	while (ctx->pos < dirsize) {
+		struct page *dentry_page;
+		struct erofs_dirent *de;
+		unsigned nameoff, maxsize;
+
+		dentry_page = read_mapping_page(mapping, i, NULL);
+		if (IS_ERR(dentry_page))
+			continue;
+
+		lock_page(dentry_page);
+		de = (struct erofs_dirent *)kmap(dentry_page);
+
+		nameoff = le16_to_cpu(de->nameoff);
+
+		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
+			nameoff >= PAGE_SIZE)) {
+			errln("%s, invalid de[0].nameoff %u",
+				__func__, nameoff);
+
+			err = -EIO;
+			goto skip_this;
+		}
+
+		maxsize = min_t(unsigned, dirsize - ctx->pos + ofs, PAGE_SIZE);
+
+		/* search dirents at the arbitrary position */
+		if (unlikely(initial)) {
+			initial = false;
+
+			ofs = roundup(ofs, sizeof(struct erofs_dirent));
+			if (unlikely(ofs >= nameoff))
+				goto skip_this;
+		}
+
+		err = erofs_fill_dentries(ctx, de, &ofs, nameoff, maxsize);
+skip_this:
+		kunmap(dentry_page);
+
+		unlock_page(dentry_page);
+		put_page(dentry_page);
+
+		ctx->pos = blknr_to_addr(i) + ofs;
+
+		if (unlikely(err))
+			break;
+		++i;
+		ofs = 0;
+	}
+	return err < 0 ? err : 0;
+}
+
+const struct file_operations erofs_dir_fops = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate	= erofs_readdir,
+};
+
-- 
1.9.1

