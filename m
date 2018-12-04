Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF5C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C03214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vpHaZzxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C03214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeLDLCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeLDLCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F125214ED;
        Tue,  4 Dec 2018 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921353;
        bh=dvw/EjmC54CfFMcstFHuFPBdFG8UYUMPJVWF0VFmfKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpHaZzxlbYYuFAyzYvjJ2yE5zuJ5WKK8NPOCVYiVhSQL7YiRVdJTu3V7b1iylJUnS
         mt5S84o/mqWpUGukLj+AeM/o2SG0rDZBgAJfoQj/u1NN85nlS9diX9qaTaemUq4RM8
         TkRG7e/iqzhZIjKQurNbN+zONE55MQWn4t38N4Bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/146] btrfs: tree-checker: Verify block_group_item
Date:   Tue,  4 Dec 2018 11:48:45 +0100
Message-Id: <20181204103728.434374849@linuxfoundation.org>
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

commit fce466eab7ac6baa9d2dcd88abcf945be3d4a089 upstream.

A crafted image with invalid block group items could make free space cache
code to cause panic.

We could detect such invalid block group item by checking:
1) Item size
   Known fixed value.
2) Block group size (key.offset)
   We have an upper limit on block group item (10G)
3) Chunk objectid
   Known fixed value.
4) Type
   Only 4 valid type values, DATA, METADATA, SYSTEM and DATA|METADATA.
   No more than 1 bit set for profile type.
5) Used space
   No more than the block group size.

This should allow btrfs to detect and refuse to mount the crafted image.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199849
Reported-by: Xu Wen <wen.xu@gatech.edu>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Gu Jinxiang <gujx@cn.fujitsu.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Gu Jinxiang <gujx@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.14:
 - In check_leaf_item(), pass root->fs_info to check_block_group_item()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 100 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c      |   2 +-
 fs/btrfs/volumes.h      |   2 +
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f7e7a455b710..cf9b10a07134 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -31,6 +31,7 @@
 #include "disk-io.h"
 #include "compression.h"
 #include "hash.h"
+#include "volumes.h"
 
 #define CORRUPT(reason, eb, root, slot)					\
 	btrfs_crit(root->fs_info,					\
@@ -312,6 +313,102 @@ static int check_dir_item(struct btrfs_root *root,
 	return 0;
 }
 
+__printf(4, 5)
+__cold
+static void block_group_err(const struct btrfs_fs_info *fs_info,
+			    const struct extent_buffer *eb, int slot,
+			    const char *fmt, ...)
+{
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+	"corrupt %s: root=%llu block=%llu slot=%d bg_start=%llu bg_len=%llu, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+		key.objectid, key.offset, &vaf);
+	va_end(args);
+}
+
+static int check_block_group_item(struct btrfs_fs_info *fs_info,
+				  struct extent_buffer *leaf,
+				  struct btrfs_key *key, int slot)
+{
+	struct btrfs_block_group_item bgi;
+	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u64 flags;
+	u64 type;
+
+	/*
+	 * Here we don't really care about alignment since extent allocator can
+	 * handle it.  We care more about the size, as if one block group is
+	 * larger than maximum size, it's must be some obvious corruption.
+	 */
+	if (key->offset > BTRFS_MAX_DATA_CHUNK_SIZE || key->offset == 0) {
+		block_group_err(fs_info, leaf, slot,
+			"invalid block group size, have %llu expect (0, %llu]",
+				key->offset, BTRFS_MAX_DATA_CHUNK_SIZE);
+		return -EUCLEAN;
+	}
+
+	if (item_size != sizeof(bgi)) {
+		block_group_err(fs_info, leaf, slot,
+			"invalid item size, have %u expect %zu",
+				item_size, sizeof(bgi));
+		return -EUCLEAN;
+	}
+
+	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(bgi));
+	if (btrfs_block_group_chunk_objectid(&bgi) !=
+	    BTRFS_FIRST_CHUNK_TREE_OBJECTID) {
+		block_group_err(fs_info, leaf, slot,
+		"invalid block group chunk objectid, have %llu expect %llu",
+				btrfs_block_group_chunk_objectid(&bgi),
+				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+
+	if (btrfs_block_group_used(&bgi) > key->offset) {
+		block_group_err(fs_info, leaf, slot,
+			"invalid block group used, have %llu expect [0, %llu)",
+				btrfs_block_group_used(&bgi), key->offset);
+		return -EUCLEAN;
+	}
+
+	flags = btrfs_block_group_flags(&bgi);
+	if (hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) > 1) {
+		block_group_err(fs_info, leaf, slot,
+"invalid profile flags, have 0x%llx (%lu bits set) expect no more than 1 bit set",
+			flags & BTRFS_BLOCK_GROUP_PROFILE_MASK,
+			hweight64(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK));
+		return -EUCLEAN;
+	}
+
+	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
+	if (type != BTRFS_BLOCK_GROUP_DATA &&
+	    type != BTRFS_BLOCK_GROUP_METADATA &&
+	    type != BTRFS_BLOCK_GROUP_SYSTEM &&
+	    type != (BTRFS_BLOCK_GROUP_METADATA |
+			   BTRFS_BLOCK_GROUP_DATA)) {
+		block_group_err(fs_info, leaf, slot,
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llu or 0x%llx",
+			type, hweight64(type),
+			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
+			BTRFS_BLOCK_GROUP_SYSTEM,
+			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -333,6 +430,9 @@ static int check_leaf_item(struct btrfs_root *root,
 	case BTRFS_XATTR_ITEM_KEY:
 		ret = check_dir_item(root, leaf, key, slot);
 		break;
+	case BTRFS_BLOCK_GROUP_ITEM_KEY:
+		ret = check_block_group_item(root->fs_info, leaf, key, slot);
+		break;
 	}
 	return ret;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cfd5728e7519..9663b6aa2a56 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4647,7 +4647,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
 		max_stripe_size = SZ_1G;
-		max_chunk_size = 10 * max_stripe_size;
+		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
 		if (!devs_max)
 			devs_max = BTRFS_MAX_DEVS(info->chunk_root);
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c5dd48eb7b3d..76fb6e84f201 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -24,6 +24,8 @@
 #include <linux/btrfs.h>
 #include "async-thread.h"
 
+#define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
+
 extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
-- 
2.17.1



