Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0538FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C769D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570224;
	bh=NVP8jDQuu7KQRpJnSFON8JLFCoLXG/cuxI5+n5HInJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSeCjk2Llb8lKXy4Qt7S5MPxLY3MVLaZXFaAtx/ef+KNm3zAt6rvCQKdhoJKmWX0Q
	 hhAw9DoqSeWUR4XLDxRSItuvz8zQdOFo4bj2wc9LgCx5P/xiQbOxcaiZBQiJ83Fyas
	 SNglDQQdn//zemDVL+r9+yaB3LsfmrQxcy2Cgt/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfAOQhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731711AbfAOQg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5555F20896;
        Tue, 15 Jan 2019 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570218;
        bh=NVP8jDQuu7KQRpJnSFON8JLFCoLXG/cuxI5+n5HInJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCmvd1YfRndlxX5Cn/i0VWVi9/rEX2aljbyevYGTUq4KZmA4shMfA8doMdn7TrbWF
         WoKM/XAQUJ5GYzCf41e6PdhzYmc1APmd2hRyfbkpr36fPg3cF9tEZVpsM9l75jujJx
         ZsWTe7LKwZlmv7+wzlmv/vMV0Rtc1kv/AeMQXzlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 13/51] Btrfs: memset to avoid stale content in btree leaf
Date:   Tue, 15 Jan 2019 17:35:09 +0100
Message-Id: <20190115154848.798198143@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 851cd173f06045816528176001cf82948282029c upstream.

This is an additional patch to
"Btrfs: memset to avoid stale content in btree node block".

This uses memset to initialize the unused space in a leaf to avoid
potential stale content, which may be incurred by pushing items
between sibling leaves.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c     |   14 --------------
 fs/btrfs/ctree.h     |   15 +++++++++++++++
 fs/btrfs/extent_io.c |   18 +++++++++++++-----
 3 files changed, 28 insertions(+), 19 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1726,20 +1726,6 @@ int btrfs_realloc_node(struct btrfs_tran
 	return err;
 }
 
-/*
- * The leaf data grows from end-to-front in the node.
- * this returns the address of the start of the last item,
- * which is the stop of the leaf data stack
- */
-static inline unsigned int leaf_data_end(struct btrfs_root *root,
-					 struct extent_buffer *leaf)
-{
-	u32 nr = btrfs_header_nritems(leaf);
-	if (nr == 0)
-		return BTRFS_LEAF_DATA_SIZE(root);
-	return btrfs_item_offset_nr(leaf, nr - 1);
-}
-
 
 /*
  * search for key in the extent_buffer.  The items start at offset p,
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3158,6 +3158,21 @@ static inline unsigned long btrfs_leaf_d
 	return offsetof(struct btrfs_leaf, items);
 }
 
+/*
+ * The leaf data grows from end-to-front in the node.
+ * this returns the address of the start of the last item,
+ * which is the stop of the leaf data stack
+ */
+static inline unsigned int leaf_data_end(struct btrfs_root *root,
+					 struct extent_buffer *leaf)
+{
+	u32 nr = btrfs_header_nritems(leaf);
+
+	if (nr == 0)
+		return BTRFS_LEAF_DATA_SIZE(root);
+	return btrfs_item_offset_nr(leaf, nr - 1);
+}
+
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_bytenr,
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3847,8 +3847,10 @@ static noinline_for_stack int write_one_
 	struct block_device *bdev = fs_info->fs_devices->latest_bdev;
 	struct extent_io_tree *tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 	u64 offset = eb->start;
+	u32 nritems;
 	unsigned long i, num_pages;
 	unsigned long bio_flags = 0;
+	unsigned long start, end;
 	int rw = (epd->sync_io ? WRITE_SYNC : WRITE) | REQ_META;
 	int ret = 0;
 
@@ -3858,15 +3860,21 @@ static noinline_for_stack int write_one_
 	if (btrfs_header_owner(eb) == BTRFS_TREE_LOG_OBJECTID)
 		bio_flags = EXTENT_BIO_TREE_LOG;
 
-	/* set btree node beyond nritems with 0 to avoid stale content */
+	/* set btree blocks beyond nritems with 0 to avoid stale content. */
+	nritems = btrfs_header_nritems(eb);
 	if (btrfs_header_level(eb) > 0) {
-		u32 nritems;
-		unsigned long end;
-
-		nritems = btrfs_header_nritems(eb);
 		end = btrfs_node_key_ptr_offset(nritems);
 
 		memset_extent_buffer(eb, 0, end, eb->len - end);
+	} else {
+		/*
+		 * leaf:
+		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
+		 */
+		start = btrfs_item_nr_offset(nritems);
+		end = btrfs_leaf_data(eb) +
+		      leaf_data_end(fs_info->tree_root, eb);
+		memset_extent_buffer(eb, 0, start, end - start);
 	}
 
 	for (i = 0; i < num_pages; i++) {


