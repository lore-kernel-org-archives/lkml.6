Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EC3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70FD218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545883467;
	bh=Z89FqDwdD4DpwVPmIpl1nlrkHJYnsPlB0IINmdaBVC8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=imSOhyHIMwssq5rsXl5eeF3zMtgZ5qbgQvMBWbpOYYxkUDNlXp/JC3j/2Nyy/jDM0
	 zTNd5/9s3k8cNitxMHBJAJ3hl+lTb5xlIQMcE0EQIe5BlFE0h27o+aWWbdA394yweP
	 al/X6/2663m/HO8KKNL8Otw5qu2gDjaR7lur53uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeL0EE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeL0EE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:04:26 -0500
Received: from localhost (unknown [104.132.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33822148E;
        Thu, 27 Dec 2018 04:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545883466;
        bh=Z89FqDwdD4DpwVPmIpl1nlrkHJYnsPlB0IINmdaBVC8=;
        h=From:To:Cc:Subject:Date:From;
        b=FTeXY/0fmrkwg1jD4D4fe0HTDJU0VifAw1BjISSKXwP+dYAnfPRmGr3nICbu8mvg+
         LpaHMhb3vEf+kfvhXFU4hSEzU76LBGPfooU5MbGky8IlYM3uxYw1bGWjO0Ezmjvd8Y
         lj1HoRh0EXYG2gS/Gw0vGD+VCbaz4NAIbLF/xUNM=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] f2fs: sanity check of xattr entry size
Date:   Wed, 26 Dec 2018 20:04:24 -0800
Message-Id: <20181227040424.77190-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a security report where f2fs_getxattr() has a hole to expose wrong
memory region when the image is malformed like this.

f2fs_getxattr: entry->e_name_len: 4, size: 12288, buffer_size: 16384, len: 4

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/xattr.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f44b0c38398b..18d5ffbc5e8c 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -288,7 +288,7 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
-				void **base_addr)
+				void **base_addr, int *base_size)
 {
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
@@ -299,8 +299,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	if (!size && !inline_size)
 		return -ENODATA;
 
-	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode),
-			inline_size + size + XATTR_PADDING_SIZE, GFP_NOFS);
+	*base_size = inline_size + size + XATTR_PADDING_SIZE;
+	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
@@ -312,8 +312,10 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 
 		*xe = __find_inline_xattr(inode, txattr_addr, &last_addr,
 						index, len, name);
-		if (*xe)
+		if (*xe) {
+			*base_size = inline_size;
 			goto check;
+		}
 	}
 
 	/* read from xattr node block */
@@ -474,6 +476,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	int error = 0;
 	unsigned int size, len;
 	void *base_addr = NULL;
+	int base_size;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -484,7 +487,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 
 	down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
-				&entry, &base_addr);
+				&entry, &base_addr, &base_size);
 	up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
@@ -498,6 +501,11 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 
 	if (buffer) {
 		char *pval = entry->e_name + entry->e_name_len;
+
+		if (base_size - (pval - (char *)base_addr) < size) {
+			error = -ERANGE;
+			goto out;
+		}
 		memcpy(buffer, pval, size);
 	}
 	error = size;
-- 
2.19.0.605.g01d371f741-goog

