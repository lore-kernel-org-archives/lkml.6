Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73727C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3879120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571731;
	bh=Dxq/Ps0fYBpOktw9jDe4y0pR/mPfdpIYnJOz/E5/r7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bSARCLz+EQoBQpv+bnuj8U+6u1KD4lNpV9ygbyca63BvT1uRU8GpgczYeX96J6H0S
	 O8f0tZXuTNgfKA2TgjR6bvyV0MVgC/kkTGHGXSsyhCwGjLLD3Dl3n6Ffym3OTbF507
	 IdUZLr6OcOJeWgyaUXQcHuyYgj/ZrxjIaK6NGxvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbfAORCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731711AbfAOQhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A22D20675;
        Tue, 15 Jan 2019 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570224;
        bh=Dxq/Ps0fYBpOktw9jDe4y0pR/mPfdpIYnJOz/E5/r7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMkdFUNzgeP32LyKxvMWFZfA/EIA0uikEB/NF/6qzHdFgmsb0G+72cUyNf4MLz4/D
         NveyRFSF2kDP3Hbmv59BsMh+BGeXowobZSsUn+HNQkKBW9JLxuZOV8r+lyyb4fav/F
         1qHz+1wPiHYPG4zuRHBGzB0jxXqvRGPFClsUjg+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 02/51] btrfs: cleanup, stop casting for extent_map->lookup everywhere
Date:   Tue, 15 Jan 2019 17:34:58 +0100
Message-Id: <20190115154847.275346189@linuxfoundation.org>
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

From: Jeff Mahoney <jeffm@suse.com>

commit 95617d69326ce386c95e33db7aeb832b45ee9f8f upstream.

Overloading extent_map->bdev to struct map_lookup * might have started out
as a means to an end, but it's a pattern that's used all over the place
now. Let's get rid of the casting and just add a union instead.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/dev-replace.c |    2 +-
 fs/btrfs/extent-tree.c |    2 +-
 fs/btrfs/extent_map.c  |    2 +-
 fs/btrfs/extent_map.h  |   10 +++++++++-
 fs/btrfs/scrub.c       |    2 +-
 fs/btrfs/volumes.c     |   24 ++++++++++++------------
 6 files changed, 25 insertions(+), 17 deletions(-)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -620,7 +620,7 @@ static void btrfs_dev_replace_update_dev
 		em = lookup_extent_mapping(em_tree, start, (u64)-1);
 		if (!em)
 			break;
-		map = (struct map_lookup *)em->bdev;
+		map = em->map_lookup;
 		for (i = 0; i < map->num_stripes; i++)
 			if (srcdev == map->stripes[i].dev)
 				map->stripes[i].dev = tgtdev;
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10388,7 +10388,7 @@ btrfs_start_trans_remove_block_group(str
 	 * more device items and remove one chunk item), but this is done at
 	 * btrfs_remove_chunk() through a call to check_system_chunk().
 	 */
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	num_items = 3 + map->num_stripes;
 	free_extent_map(em);
 
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -76,7 +76,7 @@ void free_extent_map(struct extent_map *
 		WARN_ON(extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
 		if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
-			kfree(em->bdev);
+			kfree(em->map_lookup);
 		kmem_cache_free(extent_map_cache, em);
 	}
 }
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -32,7 +32,15 @@ struct extent_map {
 	u64 block_len;
 	u64 generation;
 	unsigned long flags;
-	struct block_device *bdev;
+	union {
+		struct block_device *bdev;
+
+		/*
+		 * used for chunk mappings
+		 * flags & EXTENT_FLAG_FS_MAPPING must be set
+		 */
+		struct map_lookup *map_lookup;
+	};
 	atomic_t refs;
 	unsigned int compress_type;
 	struct list_head list;
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3460,7 +3460,7 @@ static noinline_for_stack int scrub_chun
 		return ret;
 	}
 
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	if (em->start != chunk_offset)
 		goto out;
 
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1184,7 +1184,7 @@ again:
 		struct map_lookup *map;
 		int i;
 
-		map = (struct map_lookup *)em->bdev;
+		map = em->map_lookup;
 		for (i = 0; i < map->num_stripes; i++) {
 			u64 end;
 
@@ -2757,7 +2757,7 @@ int btrfs_remove_chunk(struct btrfs_tran
 			free_extent_map(em);
 		return -EINVAL;
 	}
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	lock_chunks(root->fs_info->chunk_root);
 	check_system_chunk(trans, extent_root, map->type);
 	unlock_chunks(root->fs_info->chunk_root);
@@ -4731,7 +4731,7 @@ static int __btrfs_alloc_chunk(struct bt
 		goto error;
 	}
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
-	em->bdev = (struct block_device *)map;
+	em->map_lookup = map;
 	em->start = start;
 	em->len = num_bytes;
 	em->block_start = 0;
@@ -4826,7 +4826,7 @@ int btrfs_finish_chunk_alloc(struct btrf
 		return -EINVAL;
 	}
 
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	item_size = btrfs_chunk_item_size(map->num_stripes);
 	stripe_size = em->orig_block_len;
 
@@ -4968,7 +4968,7 @@ int btrfs_chunk_readonly(struct btrfs_ro
 	if (!em)
 		return 1;
 
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	for (i = 0; i < map->num_stripes; i++) {
 		if (map->stripes[i].dev->missing) {
 			miss_ndevs++;
@@ -5048,7 +5048,7 @@ int btrfs_num_copies(struct btrfs_fs_inf
 		return 1;
 	}
 
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1))
 		ret = map->num_stripes;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
@@ -5091,7 +5091,7 @@ unsigned long btrfs_full_stripe_len(stru
 	BUG_ON(!em);
 
 	BUG_ON(em->start > logical || em->start + em->len < logical);
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 		len = map->stripe_len * nr_data_stripes(map);
 	free_extent_map(em);
@@ -5112,7 +5112,7 @@ int btrfs_is_parity_mirror(struct btrfs_
 	BUG_ON(!em);
 
 	BUG_ON(em->start > logical || em->start + em->len < logical);
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 		ret = 1;
 	free_extent_map(em);
@@ -5271,7 +5271,7 @@ static int __btrfs_map_block(struct btrf
 		return -EINVAL;
 	}
 
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 	offset = logical - em->start;
 
 	stripe_len = map->stripe_len;
@@ -5813,7 +5813,7 @@ int btrfs_rmap_block(struct btrfs_mappin
 		free_extent_map(em);
 		return -EIO;
 	}
-	map = (struct map_lookup *)em->bdev;
+	map = em->map_lookup;
 
 	length = em->len;
 	rmap_len = map->stripe_len;
@@ -6249,7 +6249,7 @@ static int read_one_chunk(struct btrfs_r
 	}
 
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
-	em->bdev = (struct block_device *)map;
+	em->map_lookup = map;
 	em->start = logical;
 	em->len = length;
 	em->orig_start = 0;
@@ -6948,7 +6948,7 @@ void btrfs_update_commit_device_bytes_us
 	/* In order to kick the device replace finish process */
 	lock_chunks(root);
 	list_for_each_entry(em, &transaction->pending_chunks, list) {
-		map = (struct map_lookup *)em->bdev;
+		map = em->map_lookup;
 
 		for (i = 0; i < map->num_stripes; i++) {
 			dev = map->stripes[i].dev;


