Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937396AbeE1KaU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161010AbeE1K34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:29:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 051/329] btrfs: Fix out of bounds access in btrfs_search_slot
Date: Mon, 28 May 2018 11:59:40 +0200
Message-Id: <20180528100246.764790967@linuxfoundation.org>
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

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 9ea2c7c9da13c9073e371c046cbbc45481ecb459 ]

When modifying a tree where the root is at BTRFS_MAX_LEVEL - 1 then
the level variable is going to be 7 (this is the max height of the
tree). On the other hand btrfs_cow_block is always called with
"level + 1" as an index into the nodes and slots arrays. This leads to
an out of bounds access. Admittdely this will be benign since an OOB
access of the nodes array will likely read the 0th element from the
slots array, which in this case is going to be 0 (since we start CoW at
the top of the tree). The OOB access into the slots array in turn will
read the 0th and 1st values of the locks array, which would both be 0
at the time. However, this benign behavior relies on the fact that the
path being passed hasn't been initialised, if it has already been used to
query a btree then it could potentially have populated the nodes/slots arrays.

Fix it by explicitly checking if we are at level 7 (the maximum allowed
index in nodes/slots arrays) and explicitly call the CoW routine with
NULL for parent's node/slot.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Fixes-coverity-id: 711515
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2760,6 +2760,8 @@ again:
 		 * contention with the cow code
 		 */
 		if (cow) {
+			bool last_level = (level == (BTRFS_MAX_LEVEL - 1));
+
 			/*
 			 * if we don't really need to cow this block
 			 * then we don't want to set the path blocking,
@@ -2784,9 +2786,13 @@ again:
 			}
 
 			btrfs_set_path_blocking(p);
-			err = btrfs_cow_block(trans, root, b,
-					      p->nodes[level + 1],
-					      p->slots[level + 1], &b);
+			if (last_level)
+				err = btrfs_cow_block(trans, root, b, NULL, 0,
+						      &b);
+			else
+				err = btrfs_cow_block(trans, root, b,
+						      p->nodes[level + 1],
+						      p->slots[level + 1], &b);
 			if (err) {
 				ret = err;
 				goto done;
