Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D17C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFFF213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsYPZZkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFFF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCVVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeJCVVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:21:42 -0400
Received: from localhost.localdomain (unknown [58.212.179.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F7C2089F;
        Wed,  3 Oct 2018 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538577183;
        bh=XEJoJbwdC+19oO5hVCX5UFjgcCJK786ziLNq9AESBPc=;
        h=From:To:Cc:Subject:Date:From;
        b=bsYPZZkQL1Z3YelGWCCAuTSDH6+DIk3VCxzQp/d3GeoT5nwuwVL1M61nblHb4aHV3
         XMwT6THBqa+Jl93//86TTIKqRRNal98zFjHUtprZQOxJMtN1aKtH0Xbw0VyUThwVOE
         rETkrxg4rZz8X3XCH7oQ0VuCl/tE00PYgFhrB9NU=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] f2fs: fix to recover cold bit of inode block during POR
Date:   Wed,  3 Oct 2018 22:32:44 +0800
Message-Id: <20181003143244.6645-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Testcase to reproduce this bug:
1. mkfs.f2fs /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr +A /mnt/f2fs/file
6. xfs_io -f /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. chattr -A /mnt/f2fs/file
11. xfs_io -f /mnt/f2fs/file -c "fsync"
12. umount /mnt/f2fs
13. mount -t f2fs /dev/sdd /mnt/f2fs
14. lsattr /mnt/f2fs/file

-----------------N- /mnt/f2fs/file

But actually, we expect the corrct result is:

-------A---------N- /mnt/f2fs/file

The reason is in step 9) we missed to recover cold bit flag in inode
block, so later, in fsync, we will skip write inode block due to below
condition check, result in lossing data in another SPOR.

f2fs_fsync_node_pages()
	if (!IS_DNODE(page) || !is_cold_node(page))
		continue;

Note that, I guess that some non-dir inode has already lost cold bit
during POR, so in order to reenable recovery for those inode, let's
try to recover cold bit in f2fs_iget() to save more fsynced data.

Fixes: c56675750d7c ("f2fs: remove unneeded set_cold_node()")
Cc: <stable@vger.kernel.org> 4.17+
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- call set_page_dirty to recalculate checksum.
 fs/f2fs/inode.c | 6 ++++++
 fs/f2fs/node.c  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 86e7333d60c1..4edfa03f3807 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -365,6 +365,12 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
 
+	/* try to recover cold bit for non-dir inode */
+	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_page)) {
+		set_cold_node(node_page, false);
+		set_page_dirty(node_page);
+	}
+
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b1e3ff8147f6..033ce067509e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2542,7 +2542,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
-	set_cold_node(page, false);
+	set_cold_node(ipage, false);
 
 	src = F2FS_INODE(page);
 	dst = F2FS_INODE(ipage);
-- 
2.18.0

