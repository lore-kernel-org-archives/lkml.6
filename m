Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90742C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600762080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600762080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeKLGAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:00:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52460 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731019AbeKLGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:00:43 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000lJ-1L; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Tz-EQ; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Josef Bacik" <jbacik@fb.com>,
        "David Sterba" <dsterba@suse.com>, "Omar Sandoval" <osandov@fb.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.814531006@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 090/366] Btrfs: don't return ino to ino cache if
 inode item removal fails
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit c08db7d8d295a4f3a10faaca376de011afff7950 upstream.

In btrfs_evict_inode(), if btrfs_truncate_inode_items() fails, the inode
item will still be in the tree but we still return the ino to the ino
cache. That will blow up later when someone tries to allocate that ino,
so don't return it to the cache.

Fixes: 581bb050941b ("Btrfs: Cache free inode numbers in memory")
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - Pass inode, not btrfs_inode, to btrfs_orphan_del()
 - Pass btrfs_root, not btrfs_fs_info, to btrfs_free_block_rsv()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4908,13 +4908,18 @@ void btrfs_evict_inode(struct inode *ino
 		trans->block_rsv = rsv;
 
 		ret = btrfs_truncate_inode_items(trans, root, inode, 0, 0);
-		if (ret != -ENOSPC)
+		if (ret) {
+			trans->block_rsv = &root->fs_info->trans_block_rsv;
+			btrfs_end_transaction(trans, root);
+			btrfs_btree_balance_dirty(root);
+			if (ret != -ENOSPC) {
+				btrfs_orphan_del(NULL, inode);
+				btrfs_free_block_rsv(root, rsv);
+				goto no_delete;
+			}
+		} else {
 			break;
-
-		trans->block_rsv = &root->fs_info->trans_block_rsv;
-		btrfs_end_transaction(trans, root);
-		trans = NULL;
-		btrfs_btree_balance_dirty(root);
+		}
 	}
 
 	btrfs_free_block_rsv(root, rsv);
@@ -4923,12 +4928,8 @@ void btrfs_evict_inode(struct inode *ino
 	 * Errors here aren't a big deal, it just means we leave orphan items
 	 * in the tree.  They will be cleaned up on the next mount.
 	 */
-	if (ret == 0) {
-		trans->block_rsv = root->orphan_block_rsv;
-		btrfs_orphan_del(trans, inode);
-	} else {
-		btrfs_orphan_del(NULL, inode);
-	}
+	trans->block_rsv = root->orphan_block_rsv;
+	btrfs_orphan_del(trans, inode);
 
 	trans->block_rsv = &root->fs_info->trans_block_rsv;
 	if (!(root == root->fs_info->tree_root ||

