Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87788C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AD4218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357950;
	bh=8mFqKPOe7Y+JALyEeWKD1ueQdXzS/jtK9MnOn4Xq6+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWpHmAEwQyYRQSGMuSussmSZCY8svduH20yELni5WDmHChzjsCKPmog2wcXQHmmli
	 TEM47Cj+mzC9/dH8ucHpaxqOm8e//p+EAW/8JgX+gFVtFh11z0eNDRYt3qgck5ehva
	 vcLciwgUu5nbd5efRBJN8XP4RHJDtixXOpIQs95s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfAXTZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfAXTZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96282217D7;
        Thu, 24 Jan 2019 19:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357945;
        bh=8mFqKPOe7Y+JALyEeWKD1ueQdXzS/jtK9MnOn4Xq6+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jf/LeGaQS9QnKExIwuojJzBl3FBSv7UNxOB0S568y0p03zqcPmBL29j102o6JG0uM
         8oOSXRPo47PvEPrbEizPNcJb5Y/beXydpkantljDOvLW8vxm6LmtUq3Bylcgrd7ofQ
         gaYnGWmsZUwFU+/zATsCz07a4Qbe0++f0jao0Go0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 009/104] f2fs: factor out fsync inode entry operations
Date:   Thu, 24 Jan 2019 20:18:58 +0100
Message-Id: <20190124190155.892910889@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

commit 3f8ab270855b0b461995da5dc48dce9461c85d94 upstream.

Factor out fsync inode entry operations into {add,del}_fsync_inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/recovery.c |   59 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -67,6 +67,28 @@ static struct fsync_inode_entry *get_fsy
 	return NULL;
 }
 
+static struct fsync_inode_entry *add_fsync_inode(struct list_head *head,
+							struct inode *inode)
+{
+	struct fsync_inode_entry *entry;
+
+	entry = kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
+	if (!entry)
+		return NULL;
+
+	entry->inode = inode;
+	list_add_tail(&entry->list, head);
+
+	return entry;
+}
+
+static void del_fsync_inode(struct fsync_inode_entry *entry)
+{
+	iput(entry->inode);
+	list_del(&entry->list);
+	kmem_cache_free(fsync_entry_slab, entry);
+}
+
 static int recover_dentry(struct inode *inode, struct page *ipage)
 {
 	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
@@ -172,6 +194,7 @@ static int find_fsync_dnodes(struct f2fs
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
+	struct inode *inode;
 	struct page *page = NULL;
 	block_t blkaddr;
 	int err = 0;
@@ -204,27 +227,27 @@ static int find_fsync_dnodes(struct f2fs
 					break;
 			}
 
-			/* add this fsync inode to the list */
-			entry = kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
-			if (!entry) {
-				err = -ENOMEM;
-				break;
-			}
 			/*
 			 * CP | dnode(F) | inode(DF)
 			 * For this case, we should not give up now.
 			 */
-			entry->inode = f2fs_iget(sbi->sb, ino_of_node(page));
-			if (IS_ERR(entry->inode)) {
-				err = PTR_ERR(entry->inode);
-				kmem_cache_free(fsync_entry_slab, entry);
+			inode = f2fs_iget(sbi->sb, ino_of_node(page));
+			if (IS_ERR(inode)) {
+				err = PTR_ERR(inode);
 				if (err == -ENOENT) {
 					err = 0;
 					goto next;
 				}
 				break;
 			}
-			list_add_tail(&entry->list, head);
+
+			/* add this fsync inode to the list */
+			entry = add_fsync_inode(head, inode);
+			if (!entry) {
+				err = -ENOMEM;
+				iput(inode);
+				break;
+			}
 		}
 		entry->blkaddr = blkaddr;
 
@@ -248,11 +271,8 @@ static void destroy_fsync_dnodes(struct
 {
 	struct fsync_inode_entry *entry, *tmp;
 
-	list_for_each_entry_safe(entry, tmp, head, list) {
-		iput(entry->inode);
-		list_del(&entry->list);
-		kmem_cache_free(fsync_entry_slab, entry);
-	}
+	list_for_each_entry_safe(entry, tmp, head, list)
+		del_fsync_inode(entry);
 }
 
 static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
@@ -509,11 +529,8 @@ static int recover_data(struct f2fs_sb_i
 			break;
 		}
 
-		if (entry->blkaddr == blkaddr) {
-			iput(entry->inode);
-			list_del(&entry->list);
-			kmem_cache_free(fsync_entry_slab, entry);
-		}
+		if (entry->blkaddr == blkaddr)
+			del_fsync_inode(entry);
 next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);


