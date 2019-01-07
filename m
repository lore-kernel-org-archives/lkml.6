Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E92CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C812147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864964;
	bh=bPhC9xg5l96XF0a00geWPw6p5VKPJkKSoOeiiHRbN+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DxQfjCe/q+qWYkpLk8B26B2RCrKThjWolaiP8lA9gd+3VXlu1RIuUBeRfMQSx9M83
	 sEjJbwdZmahapV4QJ7NQPFU0hlpSkVS7oUJF5oF5belImr1c/7njC4cNAMpb3fnmfp
	 7SVU1EKai4gf427cSWO5c5Dzvq0jpLdOz6vYnudA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAGMmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbfAGMmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134BD20449;
        Mon,  7 Jan 2019 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864959;
        bh=bPhC9xg5l96XF0a00geWPw6p5VKPJkKSoOeiiHRbN+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZf6+bp5KEhLoyOcx1SEtLuOF2Eh4Xg90XIadsqn0Q6YsH8FufoOksJNgGod7NBaY
         kLbANpYcO7F3D9At3aPpIGtFkb0I5/cuifBsZZELL3eCj9py3OwNs/SYLjU4J5ARNj
         1jOWJZ3+nqX/tGapdkWg4YyZHgpMbURki3j9T0QE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.20 108/145] f2fs: sanity check of xattr entry size
Date:   Mon,  7 Jan 2019 13:32:25 +0100
Message-Id: <20190107104451.352529485@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 64beba0558fce7b59e9a8a7afd77290e82a22163 upstream.

There is a security report where f2fs_getxattr() has a hole to expose wrong
memory region when the image is malformed like this.

f2fs_getxattr: entry->e_name_len: 4, size: 12288, buffer_size: 16384, len: 4

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/xattr.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -288,7 +288,7 @@ static int read_xattr_block(struct inode
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
-				void **base_addr)
+				void **base_addr, int *base_size)
 {
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
@@ -299,8 +299,8 @@ static int lookup_all_xattrs(struct inod
 	if (!size && !inline_size)
 		return -ENODATA;
 
-	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode),
-			inline_size + size + XATTR_PADDING_SIZE, GFP_NOFS);
+	*base_size = inline_size + size + XATTR_PADDING_SIZE;
+	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
@@ -312,8 +312,10 @@ static int lookup_all_xattrs(struct inod
 
 		*xe = __find_inline_xattr(inode, txattr_addr, &last_addr,
 						index, len, name);
-		if (*xe)
+		if (*xe) {
+			*base_size = inline_size;
 			goto check;
+		}
 	}
 
 	/* read from xattr node block */
@@ -474,6 +476,7 @@ int f2fs_getxattr(struct inode *inode, i
 	int error = 0;
 	unsigned int size, len;
 	void *base_addr = NULL;
+	int base_size;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -484,7 +487,7 @@ int f2fs_getxattr(struct inode *inode, i
 
 	down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
-				&entry, &base_addr);
+				&entry, &base_addr, &base_size);
 	up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
@@ -498,6 +501,11 @@ int f2fs_getxattr(struct inode *inode, i
 
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


