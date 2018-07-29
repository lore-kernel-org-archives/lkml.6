Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E595C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D30920881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D30920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbeG2XhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:37:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003Vs-LR; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH 08/16] btrfs: btrfs_iget() never returns an is_bad_inode() inode.
Date:   Sun, 29 Jul 2018 23:04:45 +0100
Message-Id: <20180729220453.13431-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

just get rid of pointless checks

Cc: Chris Mason <clm@fb.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/free-space-cache.c | 4 ----
 fs/btrfs/relocation.c       | 7 ++-----
 fs/btrfs/tree-log.c         | 6 +-----
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d5f80cb300be..79f03b3bbbd4 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -71,10 +71,6 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	inode = btrfs_iget(fs_info->sb, &location, root, NULL);
 	if (IS_ERR(inode))
 		return inode;
-	if (is_bad_inode(inode)) {
-		iput(inode);
-		return ERR_PTR(-ENOENT);
-	}
 
 	mapping_set_gfp_mask(inode->i_mapping,
 			mapping_gfp_constraint(inode->i_mapping,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 879b76fa881a..f6e8dc134e44 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3563,11 +3563,8 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 	key.offset = 0;
 
 	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
-	if (IS_ERR(inode) || is_bad_inode(inode)) {
-		if (!IS_ERR(inode))
-			iput(inode);
+	if (IS_ERR(inode))
 		return -ENOENT;
-	}
 
 truncate:
 	ret = btrfs_check_trunc_cache_free_space(fs_info,
@@ -4284,7 +4281,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
-	BUG_ON(IS_ERR(inode) || is_bad_inode(inode));
+	BUG_ON(IS_ERR(inode));
 	BTRFS_I(inode)->index_cnt = group->key.objectid;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f8220ec02036..fcfbe1d8584a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -545,12 +545,8 @@ static noinline struct inode *read_one_inode(struct btrfs_root *root,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(root->fs_info->sb, &key, root, NULL);
-	if (IS_ERR(inode)) {
+	if (IS_ERR(inode))
 		inode = NULL;
-	} else if (is_bad_inode(inode)) {
-		iput(inode);
-		inode = NULL;
-	}
 	return inode;
 }
 
-- 
2.11.0

