Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD0D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131240;
	bh=zYulZzizImlMqHjwsWSBb3yg0b2EX6Csg321Q4GpWJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fyoGw4BQW7NeNNODr+H/rvWHxYdV7yDivduy8yY3viNh3Ne2dT+4bvOYTW8wQVwlO
	 I9Gm9qz+03qJLpVmVDx8o+67m3WsGyXH00YjgteF5COaNEjJJFvXVfFk/svJ1IZnyn
	 QhHPPS//4bzeU5h64e7Eu/bI8nNaP2udlKKXNEvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfBYVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbfBYV1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349F62146F;
        Mon, 25 Feb 2019 21:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130063;
        bh=zYulZzizImlMqHjwsWSBb3yg0b2EX6Csg321Q4GpWJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vH1JTY+nR+L1pGQUO+2EdlfoPri71BknG/v0rpnC5u76uT/tQNULZf4uQEE65AfH7
         iG+CgYw/3lNtoKnawSIXyGOmQ1Yyjbu2CtkcDEzgpazBwJBrIK2qmji25a9JFBxi1i
         HD2PaQ5CvDjZvXCfgYkENpzPI1BL+koIhktMQh4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 142/152] staging: erofs: {dir,inode,super}.c: rectify BUG_ONs
Date:   Mon, 25 Feb 2019 22:12:14 +0100
Message-Id: <20190225195054.063515110@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 8b987bca2d09649683cbe496419a011df8c08493 upstream.

remove all redundant BUG_ONs, and turn the rest
useful usages to DBG_BUGONs.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/dir.c   |    7 +++++--
 drivers/staging/erofs/inode.c |   10 ++++++++--
 drivers/staging/erofs/super.c |   13 ++++++-------
 3 files changed, 19 insertions(+), 11 deletions(-)

--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -53,8 +53,11 @@ static int erofs_fill_dentries(struct di
 			strnlen(de_name, maxsize - nameoff) :
 			le16_to_cpu(de[1].nameoff) - nameoff;
 
-		/* the corrupted directory found */
-		BUG_ON(de_namelen < 0);
+		/* a corrupted entry is found */
+		if (unlikely(de_namelen < 0)) {
+			DBG_BUGON(1);
+			return -EIO;
+		}
 
 #ifdef CONFIG_EROFS_FS_DEBUG
 		dbg_namelen = min(EROFS_NAME_LEN - 1, de_namelen);
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -132,7 +132,13 @@ static int fill_inline_data(struct inode
 			return -ENOMEM;
 
 		m_pofs += vi->inode_isize + vi->xattr_isize;
-		BUG_ON(m_pofs + inode->i_size > PAGE_SIZE);
+
+		/* inline symlink data shouldn't across page boundary as well */
+		if (unlikely(m_pofs + inode->i_size > PAGE_SIZE)) {
+			DBG_BUGON(1);
+			kfree(lnk);
+			return -EIO;
+		}
 
 		/* get in-page inline data */
 		memcpy(lnk, data + m_pofs, inode->i_size);
@@ -170,7 +176,7 @@ static int fill_inode(struct inode *inod
 		return PTR_ERR(page);
 	}
 
-	BUG_ON(!PageUptodate(page));
+	DBG_BUGON(!PageUptodate(page));
 	data = page_address(page);
 
 	err = read_inode(inode, data + ofs);
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -40,7 +40,6 @@ static int erofs_init_inode_cache(void)
 
 static void erofs_exit_inode_cache(void)
 {
-	BUG_ON(erofs_inode_cachep == NULL);
 	kmem_cache_destroy(erofs_inode_cachep);
 }
 
@@ -265,8 +264,8 @@ static int managed_cache_releasepage(str
 	int ret = 1;	/* 0 - busy */
 	struct address_space *const mapping = page->mapping;
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(mapping->a_ops != &managed_cache_aops);
+	DBG_BUGON(!PageLocked(page));
+	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
 
 	if (PagePrivate(page))
 		ret = erofs_try_to_free_cached_page(mapping, page);
@@ -279,10 +278,10 @@ static void managed_cache_invalidatepage
 {
 	const unsigned int stop = length + offset;
 
-	BUG_ON(!PageLocked(page));
+	DBG_BUGON(!PageLocked(page));
 
-	/* Check for overflow */
-	BUG_ON(stop > PAGE_SIZE || stop < length);
+	/* Check for potential overflow in debug mode */
+	DBG_BUGON(stop > PAGE_SIZE || stop < length);
 
 	if (offset == 0 && stop == PAGE_SIZE)
 		while (!managed_cache_releasepage(page, GFP_NOFS))
@@ -619,7 +618,7 @@ static int erofs_show_options(struct seq
 
 static int erofs_remount(struct super_block *sb, int *flags, char *data)
 {
-	BUG_ON(!sb_rdonly(sb));
+	DBG_BUGON(!sb_rdonly(sb));
 
 	*flags |= SB_RDONLY;
 	return 0;


