Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C48C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6952082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OftnCbYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6952082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJBWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJBWKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:10:39 -0400
Received: from localhost.localdomain (unknown [121.237.253.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A36220666;
        Tue,  2 Oct 2018 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538494003;
        bh=MZqY8sXQLZvKR/2HzPW2OgWlMhkOieqM3m0uXIpgrxM=;
        h=From:To:Cc:Subject:Date:From;
        b=OftnCbYpOgSYtn2P/081OTCynUbyJzvdjVToCvLcGAvh5LQsxraLoo8g1AVK1vito
         Grcd8a11NUEbMsibOcypDWheAJGLQwn77y91FZvDeItFZPH9v5wPHq3kEkWt0zeBBn
         ryZOuoifSBLPk8a0Kv0RQwIdTyk2zzJjFankqvKU=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        stable@vger.kernel.org
Subject: [PATCH] f2fs: fix to recover cold bit of inode block during POR
Date:   Tue,  2 Oct 2018 11:13:24 +0800
Message-Id: <20181002031324.12517-1-chao@kernel.org>
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
 fs/f2fs/inode.c | 4 ++++
 fs/f2fs/node.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3c278e63d1a3..4ce4d6b298f9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -365,6 +365,10 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
 
+	/* try to recover cold bit for non-dir inode */
+	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_page))
+		set_cold_node(node_page, false);
+
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3cf18eb12f0..b1edc7525597 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2549,7 +2549,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
-	set_cold_node(page, false);
+	set_cold_node(ipage, false);
 
 	src = F2FS_INODE(page);
 	dst = F2FS_INODE(ipage);
-- 
2.18.0

