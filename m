Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A8E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690741;
	bh=BsBsx5tZ3GiNajUHy90FCIP/Eo4uZ6ag333SN4GtzKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dtxILIcoJQDcV+ndqh3EGgCQwLaHSrPq0oUMAmTJ1YBrcHYMmXiBipthEqSQabsBV
	 kGgJk3tUNitzJu2GD3ZgEfKJ43qjGMq9tJWtf0peog/BLP7U9xQa/KR7kTT8w2HDtE
	 kKtDKjF9pecQ5dbPULJkAByxejzafX04BCiLpeDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfA1PwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbfA1PwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8541121741;
        Mon, 28 Jan 2019 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690735;
        bh=BsBsx5tZ3GiNajUHy90FCIP/Eo4uZ6ag333SN4GtzKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMe5cVoVytFRVb+J+MRN2RZey5SHFDP6yxAQJnIe49oMqQkZ5DKyEiLeQ/kuKKjrK
         YtpkR99BiSKSUVX2rOvjSHSCpnv+raIvqAkJPLpEo+MKCgWfJ+bPgrTmpTrqpBvgWF
         mpZsLJnkKXDXp5hx+MZKMgWGOjcvMII3JrvH0EbU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.20 178/304] f2fs: fix to reorder set_page_dirty and wait_on_page_writeback
Date:   Mon, 28 Jan 2019 10:41:35 -0500
Message-Id: <20190128154341.47195-178-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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

