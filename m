Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A62C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488BE20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570259;
	bh=D1HAUYLdYk3dGIyr+jmZxeTDBoejfX3mmmNNdSBuN0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lLU/Q6Se4lg5xTQ/cq4NEgNYNlf5bISMk6i8Rpoy9LTslrBKw6VsU4QhNLcRa8Ad/
	 Yk54xBth+H4ev+sZmyY+J5GGPdtLJARwEjvR4TLmZNwBT+mNBr+8zdaRkM8DcCpxjY
	 GSxzNnSmsrVnX1A0qlxtEZIjFlY9O68Pl+dU4f20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfAOQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731876AbfAOQhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372F320675;
        Tue, 15 Jan 2019 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570254;
        bh=D1HAUYLdYk3dGIyr+jmZxeTDBoejfX3mmmNNdSBuN0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjalHtZTnwz3TOO3EiwP+OVocAa8l4/ZMZwBpwiRcRxVcxvcKyk/tzrNtOYcgAFsf
         eFd2exS76Ui2/w2zHeHeNfWVNZtt1OCNh5zYf16AESPw4Tb1dxc+ZmrsHi4baZ75bM
         v0g9uokxMrmhQBU11Y48IAPFRHdAgo5MFwIK5qAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 26/51] btrfs: tree-checker: Verify block_group_item
Date:   Tue, 15 Jan 2019 17:35:22 +0100
Message-Id: <20190115154850.401370379@linuxfoundation.org>
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
[bwh: Backported to 4.4:
 - In check_leaf_item(), pass root->fs_info to check_block_group_item()
 - Include <linux/sizes.h> (in ctree.h, to match upstream)
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.h        |    1 
 fs/btrfs/tree-checker.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c      |    2 
 fs/btrfs/volumes.h      |    2 
 4 files changed, 104 insertions(+), 1 deletion(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -35,6 +35,7 @@
 #include <linux/btrfs.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#include <linux/sizes.h>
 #include "extent_io.h"
 #include "extent_map.h"
 #include "async-thread.h"
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -31,6 +31,7 @@
 #include "disk-io.h"
 #include "compression.h"
 #include "hash.h"
+#include "volumes.h"
 
 #define CORRUPT(reason, eb, root, slot)					\
 	btrfs_crit(root->fs_info,					\
@@ -312,6 +313,102 @@ static int check_dir_item(struct btrfs_r
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
@@ -333,6 +430,9 @@ static int check_leaf_item(struct btrfs_
 	case BTRFS_XATTR_ITEM_KEY:
 		ret = check_dir_item(root, leaf, key, slot);
 		break;
+	case BTRFS_BLOCK_GROUP_ITEM_KEY:
+		ret = check_block_group_item(root->fs_info, leaf, key, slot);
+		break;
 	}
 	return ret;
 }
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4540,7 +4540,7 @@ static int __btrfs_alloc_chunk(struct bt
 
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
 		max_stripe_size = 1024 * 1024 * 1024;
-		max_chunk_size = 10 * max_stripe_size;
+		max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
 		if (!devs_max)
 			devs_max = BTRFS_MAX_DEVS(info->chunk_root);
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -24,6 +24,8 @@
 #include <linux/btrfs.h>
 #include "async-thread.h"
 
+#define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
+
 extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	(64 * 1024)


