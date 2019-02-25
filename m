Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA2C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AE520578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130719;
	bh=nk7ixvIMDn8ESec8wrvDp4VFL4dd54Bqox5yKp9e32Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nn3tZJ4i3TIXbR4WK/y2ql29K6zzqMRVQ2t6glF5JCz35Fz96s2lRwdw1rHCZqb0E
	 LI1u/CZ87DXCl523JQn3Bky7EpDQ90zHRQlVXqEL0nXhAkNACmoceu2KWm8t5293Qe
	 yEIT2I2fkw0TZHJNiD5GnXQP8gx6SMfmamdbvsRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfBYVgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732813AbfBYVgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B979120578;
        Mon, 25 Feb 2019 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130609;
        bh=nk7ixvIMDn8ESec8wrvDp4VFL4dd54Bqox5yKp9e32Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lmca75rQxG+NOfoFtaJXrTuEHa0BFhWfrIsG9RQOJGhZrAW03GbTYG6AjLFZ33H3c
         mh4ilvJG1NX1/YXD+dAxod50B7gADebmzN1UrPrTwO4KCKnMCi/SXO4X+dUj1618Nd
         84Hm9xC7JSV9monsC5UkW4vR2vtns/Dgf6uDiIIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.20 174/183] staging: erofs: {dir,inode,super}.c: rectify BUG_ONs
Date:   Mon, 25 Feb 2019 22:12:27 +0100
Message-Id: <20190225195124.475116046@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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
@@ -133,7 +133,13 @@ static int fill_inline_data(struct inode
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
@@ -171,7 +177,7 @@ static int fill_inode(struct inode *inod
 		return PTR_ERR(page);
 	}
 
-	BUG_ON(!PageUptodate(page));
+	DBG_BUGON(!PageUptodate(page));
 	data = page_address(page);
 
 	err = read_inode(inode, data + ofs);
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -40,7 +40,6 @@ static int __init erofs_init_inode_cache
 
 static void erofs_exit_inode_cache(void)
 {
-	BUG_ON(erofs_inode_cachep == NULL);
 	kmem_cache_destroy(erofs_inode_cachep);
 }
 
@@ -303,8 +302,8 @@ static int managed_cache_releasepage(str
 	int ret = 1;	/* 0 - busy */
 	struct address_space *const mapping = page->mapping;
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(mapping->a_ops != &managed_cache_aops);
+	DBG_BUGON(!PageLocked(page));
+	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
 
 	if (PagePrivate(page))
 		ret = erofs_try_to_free_cached_page(mapping, page);
@@ -317,10 +316,10 @@ static void managed_cache_invalidatepage
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
@@ -649,7 +648,7 @@ static int erofs_remount(struct super_bl
 	unsigned int org_inject_rate = erofs_get_fault_rate(sbi);
 	int err;
 
-	BUG_ON(!sb_rdonly(sb));
+	DBG_BUGON(!sb_rdonly(sb));
 	err = parse_options(sb, data);
 	if (err)
 		goto out;


