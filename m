Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162402AbeE1Khq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161688AbeE1Kh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:37:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 249/329] btrfs: tests/qgroup: Fix wrong tree backref level
Date: Mon, 28 May 2018 12:02:58 +0200
Message-Id: <20180528100302.698448504@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 3c0efdf03b2d127f0e40e30db4e7aa0429b1b79a ]

The extent tree of the test fs is like the following:

 BTRFS info (device (null)): leaf 16327509003777336587 total ptrs 1 free space 3919
  item 0 key (4096 168 4096) itemoff 3944 itemsize 51
          extent refs 1 gen 1 flags 2
          tree block key (68719476736 0 0) level 1
                                           ^^^^^^^
          ref#0: tree block backref root 5

And it's using an empty tree for fs tree, so there is no way that its
level can be 1.

For REAL (created by mkfs) fs tree backref with no skinny metadata, the
result should look like:

 item 3 key (30408704 EXTENT_ITEM 4096) itemoff 3845 itemsize 51
         refs 1 gen 4 flags TREE_BLOCK
         tree block key (256 INODE_ITEM 0) level 0
                                           ^^^^^^^
         tree block backref root 5

Fix the level to 0, so it won't break later tree level checker.

Fixes: faa2dbf004e8 ("Btrfs: add sanity tests for new qgroup accounting code")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tests/qgroup-tests.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -63,7 +63,7 @@ static int insert_normal_tree_ref(struct
 	btrfs_set_extent_generation(leaf, item, 1);
 	btrfs_set_extent_flags(leaf, item, BTRFS_EXTENT_FLAG_TREE_BLOCK);
 	block_info = (struct btrfs_tree_block_info *)(item + 1);
-	btrfs_set_tree_block_level(leaf, block_info, 1);
+	btrfs_set_tree_block_level(leaf, block_info, 0);
 	iref = (struct btrfs_extent_inline_ref *)(block_info + 1);
 	if (parent > 0) {
 		btrfs_set_extent_inline_ref_type(leaf, iref,
