Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4B420840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4B420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbeHAURx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:17:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404143AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14C47FB6;
        Wed,  1 Aug 2018 16:58:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 105/336] Btrfs: dont return ino to ino cache if inode item removal fails
Date:   Wed,  1 Aug 2018 18:47:20 +0200
Message-Id: <20180801165033.179768624@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit c08db7d8d295a4f3a10faaca376de011afff7950 ]

In btrfs_evict_inode(), if btrfs_truncate_inode_items() fails, the inode
item will still be in the tree but we still return the ino to the ino
cache. That will blow up later when someone tries to allocate that ino,
so don't return it to the cache.

Fixes: 581bb050941b ("Btrfs: Cache free inode numbers in memory")
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5426,13 +5426,18 @@ void btrfs_evict_inode(struct inode *ino
 		trans->block_rsv = rsv;
 
 		ret = btrfs_truncate_inode_items(trans, root, inode, 0, 0);
-		if (ret != -ENOSPC && ret != -EAGAIN)
+		if (ret) {
+			trans->block_rsv = &fs_info->trans_block_rsv;
+			btrfs_end_transaction(trans);
+			btrfs_btree_balance_dirty(fs_info);
+			if (ret != -ENOSPC && ret != -EAGAIN) {
+				btrfs_orphan_del(NULL, BTRFS_I(inode));
+				btrfs_free_block_rsv(fs_info, rsv);
+				goto no_delete;
+			}
+		} else {
 			break;
-
-		trans->block_rsv = &fs_info->trans_block_rsv;
-		btrfs_end_transaction(trans);
-		trans = NULL;
-		btrfs_btree_balance_dirty(fs_info);
+		}
 	}
 
 	btrfs_free_block_rsv(fs_info, rsv);
@@ -5441,12 +5446,8 @@ void btrfs_evict_inode(struct inode *ino
 	 * Errors here aren't a big deal, it just means we leave orphan items
 	 * in the tree.  They will be cleaned up on the next mount.
 	 */
-	if (ret == 0) {
-		trans->block_rsv = root->orphan_block_rsv;
-		btrfs_orphan_del(trans, BTRFS_I(inode));
-	} else {
-		btrfs_orphan_del(NULL, BTRFS_I(inode));
-	}
+	trans->block_rsv = root->orphan_block_rsv;
+	btrfs_orphan_del(trans, BTRFS_I(inode));
 
 	trans->block_rsv = &fs_info->trans_block_rsv;
 	if (!(root == fs_info->tree_root ||


