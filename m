Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44189C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D7A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfAXHTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:19:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfAXHTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:19:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BD867D928E56315E96BE;
        Thu, 24 Jan 2019 15:19:01 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 24 Jan 2019 15:18:53 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to check inline_xattr_size boundary correctly
Date:   Thu, 24 Jan 2019 15:18:47 +0800
Message-ID: <20190124071847.114407-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use below condition to check inline_xattr_size boundary:

	if (!F2FS_OPTION(sbi).inline_xattr_size ||
		F2FS_OPTION(sbi).inline_xattr_size >=
				DEF_ADDRS_PER_INODE -
				F2FS_TOTAL_EXTRA_ATTR_SIZE -
				DEF_INLINE_RESERVED_SIZE -
				DEF_MIN_INLINE_SIZE)

There is there problems in that check:
- we should allow inline_xattr_size equaling to min size of inline
{data,dentry} area.
- F2FS_TOTAL_EXTRA_ATTR_SIZE and inline_xattr_size are based on
different size unit, previous one is 4 bytes, latter one is 1 bytes.
- DEF_MIN_INLINE_SIZE only indicate min size of inline data area,
however, we need to consider min size of inline dentry area as well,
minimal inline dentry should at least contain two entries: '.' and
'..', so that min inline_dentry size is 40 bytes.

.bitmap		1 * 1 = 1
.reserved	1 * 1 = 1
.dentry		11 * 2 = 22
.filename	8 * 2 = 16
total		40

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h          |  1 -
 fs/f2fs/super.c         | 10 +++++-----
 include/linux/f2fs_fs.h | 13 +++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dc8498e3d03c..88faf36badaf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -458,7 +458,6 @@ struct f2fs_flush_device {
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
-#define DEF_MIN_INLINE_SIZE		1
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a212ae2aac7c..7e5312e4bc85 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -863,11 +863,11 @@ static int parse_options(struct super_block *sb, char *options)
 			return -EINVAL;
 		}
 		if (!F2FS_OPTION(sbi).inline_xattr_size ||
-			F2FS_OPTION(sbi).inline_xattr_size >=
-					DEF_ADDRS_PER_INODE -
-					F2FS_TOTAL_EXTRA_ATTR_SIZE -
-					DEF_INLINE_RESERVED_SIZE -
-					DEF_MIN_INLINE_SIZE) {
+			F2FS_OPTION(sbi).inline_xattr_size >
+				DEF_ADDRS_PER_INODE -
+				F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
+				DEF_INLINE_RESERVED_SIZE -
+				MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
 			f2fs_msg(sb, KERN_ERR,
 					"inline xattr size is out of range");
 			return -EINVAL;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..c524ad7d31da 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -489,12 +489,12 @@ typedef __le32	f2fs_hash_t;
 
 /*
  * space utilization of regular dentry and inline dentry (w/o extra reservation)
- *		regular dentry			inline dentry
- * bitmap	1 * 27 = 27			1 * 23 = 23
- * reserved	1 * 3 = 3			1 * 7 = 7
- * dentry	11 * 214 = 2354			11 * 182 = 2002
- * filename	8 * 214 = 1712			8 * 182 = 1456
- * total	4096				3488
+ *		regular dentry		inline dentry (def)	inline dentry (min)
+ * bitmap	1 * 27 = 27		1 * 23 = 23		1 * 1 = 1
+ * reserved	1 * 3 = 3		1 * 7 = 7		1 * 1 = 1
+ * dentry	11 * 214 = 2354		11 * 182 = 2002		11 * 2 = 22
+ * filename	8 * 214 = 1712		8 * 182 = 1456		8 * 2 = 16
+ * total	4096			3488			40
  *
  * Note: there are more reserved space in inline dentry than in regular
  * dentry, when converting inline dentry we should handle this carefully.
@@ -506,6 +506,7 @@ typedef __le32	f2fs_hash_t;
 #define SIZE_OF_RESERVED	(PAGE_SIZE - ((SIZE_OF_DIR_ENTRY + \
 				F2FS_SLOT_LEN) * \
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
+#define MIN_INLINE_DENTRY_SIZE		40	/* just include '.' and '..' entries */
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
 struct f2fs_dir_entry {
-- 
2.18.0.rc1

