Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33091C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB9E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570272;
	bh=NXsKZRlCCFDIGP25H8oxoGkcmp/LssNI36FC3Y66Jxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VSKjfRLkeke4IYXU4Y9cY2Lz8k1qKDVnl0H90a7cXneAHZaxS+nQmjKH3u9NmnsN2
	 0lYEJNTS8pwVqQe1+fLnXD3B4knol7FnnyoM3IV+WGVe7RRhDLrgu7vGVi69ebIm5v
	 HJ4iV+dj6WToAxJqq4OIJE6IGPgrLXO+ZHKnTI2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfAOQhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731932AbfAOQhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEC920675;
        Tue, 15 Jan 2019 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570266;
        bh=NXsKZRlCCFDIGP25H8oxoGkcmp/LssNI36FC3Y66Jxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+mupA3snLdFiWwqae/G3AQ1q3xr+GPHrckDccf++aykw7jiuEk7SejhkU1vla9YD
         vCLZgkNXISdiHFcjr5LYjOuX7VXD9Tcc5rB+Vi1e4JM6fho5S7xgQMakOrfNnNV4Yn
         hJK+OdiYRCqwnYbXdz0GXAqX15aHiwXbwdVQZcIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 30/51] btrfs: Verify that every chunk has corresponding block group at mount time
Date:   Tue, 15 Jan 2019 17:35:26 +0100
Message-Id: <20190115154850.828189872@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

commit 7ef49515fa6727cb4b6f2f5b0ffbc5fc20a9f8c6 upstream.

If a crafted image has missing block group items, it could cause
unexpected behavior and breaks the assumption of 1:1 chunk<->block group
mapping.

Although we have the block group -> chunk mapping check, we still need
chunk -> block group mapping check.

This patch will do extra check to ensure each chunk has its
corresponding block group.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199847
Reported-by: Xu Wen <wen.xu@gatech.edu>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Gu Jinxiang <gujx@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9765,6 +9765,62 @@ btrfs_create_block_group_cache(struct bt
 	return cache;
 }
 
+
+/*
+ * Iterate all chunks and verify that each of them has the corresponding block
+ * group
+ */
+static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct btrfs_block_group_cache *bg;
+	u64 start = 0;
+	int ret = 0;
+
+	while (1) {
+		read_lock(&map_tree->map_tree.lock);
+		/*
+		 * lookup_extent_mapping will return the first extent map
+		 * intersecting the range, so setting @len to 1 is enough to
+		 * get the first chunk.
+		 */
+		em = lookup_extent_mapping(&map_tree->map_tree, start, 1);
+		read_unlock(&map_tree->map_tree.lock);
+		if (!em)
+			break;
+
+		bg = btrfs_lookup_block_group(fs_info, em->start);
+		if (!bg) {
+			btrfs_err(fs_info,
+	"chunk start=%llu len=%llu doesn't have corresponding block group",
+				     em->start, em->len);
+			ret = -EUCLEAN;
+			free_extent_map(em);
+			break;
+		}
+		if (bg->key.objectid != em->start ||
+		    bg->key.offset != em->len ||
+		    (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
+		    (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+			btrfs_err(fs_info,
+"chunk start=%llu len=%llu flags=0x%llx doesn't match block group start=%llu len=%llu flags=0x%llx",
+				em->start, em->len,
+				em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK,
+				bg->key.objectid, bg->key.offset,
+				bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
+			ret = -EUCLEAN;
+			free_extent_map(em);
+			btrfs_put_block_group(bg);
+			break;
+		}
+		start = em->start + em->len;
+		free_extent_map(em);
+		btrfs_put_block_group(bg);
+	}
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_root *root)
 {
 	struct btrfs_path *path;
@@ -9951,7 +10007,7 @@ int btrfs_read_block_groups(struct btrfs
 	}
 
 	init_global_block_rsv(info);
-	ret = 0;
+	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
 	return ret;


