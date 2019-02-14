Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C13C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF64B222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550160523;
	bh=o1ToH3JOVsGIE59XdWWEVWezRYGwsWsjI8bVOVVEYBI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sOYI+n8kMMFj3Mgw7DlsEMic84Mqw0pxzy218r2JTCU/v3j6rvNxaBJb+vtsRvlCO
	 Hb4YCaubZ/1xxk+4rnrAtNSuoRBl3JjIf063Ote7rkcIL7IUAfeuqUdXWmpBYLUotG
	 4U18wUCZWy/oGhW3heq2+IhgmA+D5O5OLvrxegPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407844AbfBNQIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbfBNQIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:08:41 -0500
Received: from localhost.localdomain (unknown [49.77.183.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F08222DC;
        Thu, 14 Feb 2019 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550160520;
        bh=o1ToH3JOVsGIE59XdWWEVWezRYGwsWsjI8bVOVVEYBI=;
        h=From:To:Cc:Subject:Date:From;
        b=vU90lYh02q3LXRXHoFRguBqUtGOFyHBqGTg/C0a/VDxRTVmv3b/hj/I6t1sd0z7gg
         j2PtRxs7MsxPacRupmxZdtQI02XjKK8Wjayj2JXozdYFudjFmocZISQdl3BgA4ek2F
         erwcWEH7pweWxH8XW9LNTEgGox0j82WBZ+Ra2+/o=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to check inline_xattr_size boundary correctly
Date:   Fri, 15 Feb 2019 00:08:25 +0800
Message-Id: <20190214160825.4973-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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
v2:
- fix lower bound check, inline xattr size should be larger than
xattr_header's size at least.

 fs/f2fs/f2fs.h          |  1 -
 fs/f2fs/super.c         | 13 +++++++------
 include/linux/f2fs_fs.h | 13 +++++++------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8c928cd72b61..83df26b427b1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -459,7 +459,6 @@ struct f2fs_flush_device {
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
-#define DEF_MIN_INLINE_SIZE		1
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83bbe7424fc1..be8be445c6ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -834,12 +834,13 @@ static int parse_options(struct super_block *sb, char *options)
 					"set with inline_xattr option");
 			return -EINVAL;
 		}
-		if (!F2FS_OPTION(sbi).inline_xattr_size ||
-			F2FS_OPTION(sbi).inline_xattr_size >=
-					DEF_ADDRS_PER_INODE -
-					F2FS_TOTAL_EXTRA_ATTR_SIZE -
-					DEF_INLINE_RESERVED_SIZE -
-					DEF_MIN_INLINE_SIZE) {
+		if (F2FS_OPTION(sbi).inline_xattr_size <
+			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
+			F2FS_OPTION(sbi).inline_xattr_size >
+			DEF_ADDRS_PER_INODE -
+			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
+			DEF_INLINE_RESERVED_SIZE -
+			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
 			f2fs_msg(sb, KERN_ERR,
 					"inline xattr size is out of range");
 			return -EINVAL;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 8d57aaee8166..666db8eb71e0 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -490,12 +490,12 @@ typedef __le32	f2fs_hash_t;
 
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
@@ -507,6 +507,7 @@ typedef __le32	f2fs_hash_t;
 #define SIZE_OF_RESERVED	(PAGE_SIZE - ((SIZE_OF_DIR_ENTRY + \
 				F2FS_SLOT_LEN) * \
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
+#define MIN_INLINE_DENTRY_SIZE		40	/* just include '.' and '..' entries */
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
 struct f2fs_dir_entry {
-- 
2.18.0

