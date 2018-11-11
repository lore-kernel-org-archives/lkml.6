Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31681C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF23E2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6GZ8xaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF23E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbeKLJSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388836AbeKLIUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD4B223CB;
        Sun, 11 Nov 2018 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975437;
        bh=IH0PG0jn/FPhCztNK/DjFTv/PkG54dYGEQVHscuAKx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6GZ8xaUTvgo5jObW8bskAJTjqgwP2iIFhojmmgT+ghdFIbVXtFs8uhQ27AMKSABX
         RfBBpCzj575kbzqt6Qr8aqYaq6SuEWJ//wUbroqnl+7J06ZQx4akinyhf9wvLN08N9
         NJTmxdZ8zISIZKPw/5oeThky1/EumB9/bSVtwvOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.18 189/350] f2fs: fix to recover cold bit of inode block during POR
Date:   Sun, 11 Nov 2018 14:20:53 -0800
Message-Id: <20181111221715.934133358@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

commit ef2a007134b4eaa39264c885999f296577bc87d2 upstream.

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/inode.c |    6 ++++++
 fs/f2fs/node.c  |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -287,6 +287,12 @@ static int do_read_inode(struct inode *i
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
 
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2356,7 +2356,7 @@ retry:
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
-	set_cold_node(page, false);
+	set_cold_node(ipage, false);
 
 	src = F2FS_INODE(page);
 	dst = F2FS_INODE(ipage);


