Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BEBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5698620838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895330;
	bh=MOYvTlkN5XYRkqPMyjzQEJ10dI/USLtgUhUO3pRGLb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/Zg/DikuD9wKxBHaiQX+G6IY5N1+cDOcfD3lJC909bvRBQRqY6QWMEkJrXQ9dw4f
	 H+DqebPqUGUwdmLtOOoikeNjlvxonZicsGr9GH9xLH0RBkFjPEZYmJCUYAcWpQG6I2
	 5W8gqD0WVyXlXYYOiPqPqIjNiiywas6QQGzkZ8Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfBKO2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbfBKO2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5772920821;
        Mon, 11 Feb 2019 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895323;
        bh=MOYvTlkN5XYRkqPMyjzQEJ10dI/USLtgUhUO3pRGLb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqpLrwSR7bmylQJmb9rZ8K4d6cbxJ7QK7W55UEgfONJrguEGxLiF2s5bKU+0zEa4m
         ZEtWavrFP+GTrh/hbpd6pGWs+yIG/t81kf0EjKtSvce0PXc3snoVGu+ZjiAi5COf8Z
         OiNbpe71h+50gxy0hCxmIRTLPqoqj7aH3fieN464=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 167/352] f2fs: fix to reorder set_page_dirty and wait_on_page_writeback
Date:   Mon, 11 Feb 2019 15:16:34 +0100
Message-Id: <20190211141857.629447978@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 8d64d365aed355b2e2465d19ba61df02462fff4d ]

This patch reorders flow from

- update page
- set_page_dirty
- wait_on_page_writeback

to

- wait_on_page_writeback
- update page
- set_page_dirty

The reason is:
- set_page_dirty will increase reference of dirty page, the reference
should be cleared before wait_on_page_writeback to keep its consistency.
- some devices need stable page during page writebacking, so we
should not change page's data.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 7 ++++---
 fs/f2fs/gc.c         | 5 +++--
 fs/f2fs/node.c       | 5 +++--
 fs/f2fs/segment.c    | 3 ++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9c28ea439e0b..e5719fcac47d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1290,11 +1290,12 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
 	int err;
 
-	memcpy(page_address(page), src, PAGE_SIZE);
-	set_page_dirty(page);
-
 	f2fs_wait_on_page_writeback(page, META, true);
 	f2fs_bug_on(sbi, PageWriteback(page));
+
+	memcpy(page_address(page), src, PAGE_SIZE);
+
+	set_page_dirty(page);
 	if (unlikely(!clear_page_dirty_for_io(page)))
 		f2fs_bug_on(sbi, 1);
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c96e7c6354ef..74f72dccab57 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -812,8 +812,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 write_page:
-	set_page_dirty(fio.encrypted_page);
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
+	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
 
@@ -907,8 +907,9 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		bool is_dirty = PageDirty(page);
 
 retry:
-		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
+
+		set_page_dirty(page);
 		if (clear_page_dirty_for_io(page)) {
 			inode_dec_dirty_pages(inode);
 			f2fs_remove_dirty_inode(inode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 88be946dedd4..33fb3f8aeafa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1598,10 +1598,11 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 			.for_reclaim = 0,
 		};
 
-		set_page_dirty(node_page);
 		f2fs_wait_on_page_writeback(node_page, NODE, true);
-
 		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
+
+		set_page_dirty(node_page);
+
 		if (!clear_page_dirty_for_io(node_page)) {
 			err = -EAGAIN;
 			goto out_page;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6edcf8391dd3..8f3578c5230e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -387,8 +387,9 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
 		if (page->mapping == inode->i_mapping) {
 			trace_f2fs_commit_inmem_page(page, INMEM);
 
-			set_page_dirty(page);
 			f2fs_wait_on_page_writeback(page, DATA, true);
+
+			set_page_dirty(page);
 			if (clear_page_dirty_for_io(page)) {
 				inode_dec_dirty_pages(inode);
 				f2fs_remove_dirty_inode(inode);
-- 
2.19.1



