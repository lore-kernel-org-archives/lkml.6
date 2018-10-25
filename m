Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4BE2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScqBIEU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4BE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeJYWsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeJYWsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:01 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6278620848;
        Thu, 25 Oct 2018 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476904;
        bh=tlUXlnoj6w3CplAgfE3DLeu/Z+YwhtYZtRA42P+0sXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScqBIEU6UX4Eu8/P6etBOhFoEDuA0iOC8wBVWLBHlVQrGt8CMR4gE9CBNkUD3sD1r
         Q26XeL7EelB0cbh/Abj5wC6D9xCaE7OT1aMvi6xFuqWeegrbRAC+RCOysVtSfZaaqd
         9CMVFr6IUGvmLyxuWUXH92Ya+2Ht+LhhUOYnANfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qu Wenruo <quwenruo@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 26/98] btrfs: fiemap: Cache and merge fiemap extent before submit it to user
Date:   Thu, 25 Oct 2018 10:13:11 -0400
Message-Id: <20181025141423.213774-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <quwenruo@cn.fujitsu.com>

[ Upstream commit 4751832da990a927c37526ae67b9226ea01eb99e ]

[BUG]
Cycle mount btrfs can cause fiemap to return different result.
Like:
 # mount /dev/vdb5 /mnt/btrfs
 # dd if=/dev/zero bs=16K count=4 oflag=dsync of=/mnt/btrfs/file
 # xfs_io -c "fiemap -v" /mnt/btrfs/file
 /mnt/test/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        25088..25215       128   0x1
 # umount /mnt/btrfs
 # mount /dev/vdb5 /mnt/btrfs
 # xfs_io -c "fiemap -v" /mnt/btrfs/file
 /mnt/test/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..31]:         25088..25119        32   0x0
   1: [32..63]:        25120..25151        32   0x0
   2: [64..95]:        25152..25183        32   0x0
   3: [96..127]:       25184..25215        32   0x1
But after above fiemap, we get correct merged result if we call fiemap
again.
 # xfs_io -c "fiemap -v" /mnt/btrfs/file
 /mnt/test/file:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        25088..25215       128   0x1

[REASON]
Btrfs will try to merge extent map when inserting new extent map.

btrfs_fiemap(start=0 len=(u64)-1)
|- extent_fiemap(start=0 len=(u64)-1)
   |- get_extent_skip_holes(start=0 len=64k)
   |  |- btrfs_get_extent_fiemap(start=0 len=64k)
   |     |- btrfs_get_extent(start=0 len=64k)
   |        |  Found on-disk (ino, EXTENT_DATA, 0)
   |        |- add_extent_mapping()
   |        |- Return (em->start=0, len=16k)
   |
   |- fiemap_fill_next_extent(logic=0 phys=X len=16k)
   |
   |- get_extent_skip_holes(start=0 len=64k)
   |  |- btrfs_get_extent_fiemap(start=0 len=64k)
   |     |- btrfs_get_extent(start=16k len=48k)
   |        |  Found on-disk (ino, EXTENT_DATA, 16k)
   |        |- add_extent_mapping()
   |        |  |- try_merge_map()
   |        |     Merge with previous em start=0 len=16k
   |        |     resulting em start=0 len=32k
   |        |- Return (em->start=0, len=32K)    << Merged result
   |- Stripe off the unrelated range (0~16K) of return em
   |- fiemap_fill_next_extent(logic=16K phys=X+16K len=16K)
      ^^^ Causing split fiemap extent.

And since in add_extent_mapping(), em is already merged, in next
fiemap() call, we will get merged result.

[FIX]
Here we introduce a new structure, fiemap_cache, which records previous
fiemap extent.

And will always try to merge current fiemap_cache result before calling
fiemap_fill_next_extent().
Only when we failed to merge current fiemap extent with cached one, we
will call fiemap_fill_next_extent() to submit cached one.

So by this method, we can merge all fiemap extents.

It can also be done in fs/ioctl.c, however the problem is if
fieinfo->fi_extents_max == 0, we have no space to cache previous fiemap
extent.
So I choose to merge it in btrfs.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 124 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2b96ca68dc10..5feaef9bcbda 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4377,6 +4377,123 @@ static struct extent_map *get_extent_skip_holes(struct inode *inode,
 	return NULL;
 }
 
+/*
+ * To cache previous fiemap extent
+ *
+ * Will be used for merging fiemap extent
+ */
+struct fiemap_cache {
+	u64 offset;
+	u64 phys;
+	u64 len;
+	u32 flags;
+	bool cached;
+};
+
+/*
+ * Helper to submit fiemap extent.
+ *
+ * Will try to merge current fiemap extent specified by @offset, @phys,
+ * @len and @flags with cached one.
+ * And only when we fails to merge, cached one will be submitted as
+ * fiemap extent.
+ *
+ * Return value is the same as fiemap_fill_next_extent().
+ */
+static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
+				struct fiemap_cache *cache,
+				u64 offset, u64 phys, u64 len, u32 flags)
+{
+	int ret = 0;
+
+	if (!cache->cached)
+		goto assign;
+
+	/*
+	 * Sanity check, extent_fiemap() should have ensured that new
+	 * fiemap extent won't overlap with cahced one.
+	 * Not recoverable.
+	 *
+	 * NOTE: Physical address can overlap, due to compression
+	 */
+	if (cache->offset + cache->len > offset) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	/*
+	 * Only merges fiemap extents if
+	 * 1) Their logical addresses are continuous
+	 *
+	 * 2) Their physical addresses are continuous
+	 *    So truly compressed (physical size smaller than logical size)
+	 *    extents won't get merged with each other
+	 *
+	 * 3) Share same flags except FIEMAP_EXTENT_LAST
+	 *    So regular extent won't get merged with prealloc extent
+	 */
+	if (cache->offset + cache->len  == offset &&
+	    cache->phys + cache->len == phys  &&
+	    (cache->flags & ~FIEMAP_EXTENT_LAST) ==
+			(flags & ~FIEMAP_EXTENT_LAST)) {
+		cache->len += len;
+		cache->flags |= flags;
+		goto try_submit_last;
+	}
+
+	/* Not mergeable, need to submit cached one */
+	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
+				      cache->len, cache->flags);
+	cache->cached = false;
+	if (ret)
+		return ret;
+assign:
+	cache->cached = true;
+	cache->offset = offset;
+	cache->phys = phys;
+	cache->len = len;
+	cache->flags = flags;
+try_submit_last:
+	if (cache->flags & FIEMAP_EXTENT_LAST) {
+		ret = fiemap_fill_next_extent(fieinfo, cache->offset,
+				cache->phys, cache->len, cache->flags);
+		cache->cached = false;
+	}
+	return ret;
+}
+
+/*
+ * Sanity check for fiemap cache
+ *
+ * All fiemap cache should be submitted by emit_fiemap_extent()
+ * Iteration should be terminated either by last fiemap extent or
+ * fieinfo->fi_extents_max.
+ * So no cached fiemap should exist.
+ */
+static int check_fiemap_cache(struct btrfs_fs_info *fs_info,
+			       struct fiemap_extent_info *fieinfo,
+			       struct fiemap_cache *cache)
+{
+	int ret;
+
+	if (!cache->cached)
+		return 0;
+
+	/* Small and recoverbale problem, only to info developer */
+#ifdef CONFIG_BTRFS_DEBUG
+	WARN_ON(1);
+#endif
+	btrfs_warn(fs_info,
+		   "unhandled fiemap cache detected: offset=%llu phys=%llu len=%llu flags=0x%x",
+		   cache->offset, cache->phys, cache->len, cache->flags);
+	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
+				      cache->len, cache->flags);
+	cache->cached = false;
+	if (ret > 0)
+		ret = 0;
+	return ret;
+}
+
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len, get_extent_t *get_extent)
 {
@@ -4394,6 +4511,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct fiemap_cache cache = { 0 };
 	int end = 0;
 	u64 em_start = 0;
 	u64 em_len = 0;
@@ -4573,8 +4691,8 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_LAST;
 			end = 1;
 		}
-		ret = fiemap_fill_next_extent(fieinfo, em_start, disko,
-					      em_len, flags);
+		ret = emit_fiemap_extent(fieinfo, &cache, em_start, disko,
+					   em_len, flags);
 		if (ret) {
 			if (ret == 1)
 				ret = 0;
@@ -4582,6 +4700,8 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 	}
 out_free:
+	if (!ret)
+		ret = check_fiemap_cache(root->fs_info, fieinfo, &cache);
 	free_extent_map(em);
 out:
 	btrfs_free_path(path);
-- 
2.17.1

