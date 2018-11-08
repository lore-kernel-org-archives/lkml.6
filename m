Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F263C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D010420844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcq1jgtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D010420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeKIHgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbeKIHgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038D52146E;
        Thu,  8 Nov 2018 21:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714358;
        bh=Bg/LSBpC+opqEjvKAvRVIfEBxGt4UM045FmBWYZ7Blg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bcq1jgtrLPXn2hIVCY2wGs7z6AtKJeX1/2h7ZlSCTGukiGelVEExFILAZYgpBwl5g
         z+ihR18YDIF7HFja3HENFWIutxCHuS9Kn3y6jAwVqQe5iE0mSb/rrXqcaBZdKg3uDl
         LSWgpZPFJo2nxJzDFMzmZDFQbbM6gU8hI+GvDVDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 033/114] btrfs: dont create or leak aliased root while cleaning up orphans
Date:   Thu,  8 Nov 2018 13:50:48 -0800
Message-Id: <20181108215102.115959896@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 35bbb97fc898aeb874cb7c8b746f091caa359994 ]

commit 909c3a22da3 (Btrfs: fix loading of orphan roots leading to BUG_ON)
avoids the BUG_ON but can add an aliased root to the dead_roots list or
leak the root.

Since we've already been loading roots into the radix tree, we should
use it before looking the root up on disk.

Cc: <stable@vger.kernel.org> # 4.5
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c   |  4 ++--
 fs/btrfs/disk-io.h   |  2 ++
 fs/btrfs/root-tree.c | 27 ++++++++++++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a2001abbe379..120363d0f981 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1608,8 +1608,8 @@ fail:
 	return ret;
 }
 
-static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					       u64 root_id)
+struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
+					u64 root_id)
 {
 	struct btrfs_root *root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index adeb31830b9c..3c9819403487 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -68,6 +68,8 @@ struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 				      struct btrfs_key *location);
 int btrfs_init_fs_root(struct btrfs_root *root);
+struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
+					u64 root_id);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root);
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 2c849b08a91b..6a6efb26d52f 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -272,6 +272,23 @@ int btrfs_find_orphan_roots(struct btrfs_root *tree_root)
 		root_key.objectid = key.offset;
 		key.offset++;
 
+		/*
+		 * The root might have been inserted already, as before we look
+		 * for orphan roots, log replay might have happened, which
+		 * triggers a transaction commit and qgroup accounting, which
+		 * in turn reads and inserts fs roots while doing backref
+		 * walking.
+		 */
+		root = btrfs_lookup_fs_root(tree_root->fs_info,
+					    root_key.objectid);
+		if (root) {
+			WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
+					  &root->state));
+			if (btrfs_root_refs(&root->root_item) == 0)
+				btrfs_add_dead_root(root);
+			continue;
+		}
+
 		root = btrfs_read_fs_root(tree_root, &root_key);
 		err = PTR_ERR_OR_ZERO(root);
 		if (err && err != -ENOENT) {
@@ -310,16 +327,8 @@ int btrfs_find_orphan_roots(struct btrfs_root *tree_root)
 		set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state);
 
 		err = btrfs_insert_fs_root(root->fs_info, root);
-		/*
-		 * The root might have been inserted already, as before we look
-		 * for orphan roots, log replay might have happened, which
-		 * triggers a transaction commit and qgroup accounting, which
-		 * in turn reads and inserts fs roots while doing backref
-		 * walking.
-		 */
-		if (err == -EEXIST)
-			err = 0;
 		if (err) {
+			BUG_ON(err == -EEXIST);
 			btrfs_free_fs_root(root);
 			break;
 		}
-- 
2.17.1



