Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA58C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8459E214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYgm4Uk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8459E214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeLDLDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbeLDLDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE70214DA;
        Tue,  4 Dec 2018 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921418;
        bh=iBiGUctwaj/a9ks6zN/5StmSDeksdLU/ijDUIoX8m+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYgm4Uk+X0U5PnjUxL/4hOPmfjRGZ3Ptb6G0/jeaRGCopsJwD0zrceXuQWpsschfk
         VYnDkA/+iPrbNXEy5UIKYqt0P5WlpjNIQjbN58vU4V6dcFQwKCQDNG4wLMnlrXeaYB
         f4n3BGZzPLzTOovFxENWLK9xBIW0qNYLeQ2/Yf84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/146] btrfs: Verify that every chunk has corresponding block group at mount time
Date:   Tue,  4 Dec 2018 11:48:34 +0100
Message-Id: <20181204103727.990828074@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2cb3569ac548..fdc42eddccc2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10092,6 +10092,62 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
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
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -10264,7 +10320,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	}
 
 	init_global_block_rsv(info);
-	ret = 0;
+	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
 	return ret;
-- 
2.17.1



