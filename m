Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F22C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861C820868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570234;
	bh=myDkjw52/+bzII35myzNdXLTwQ6munWQRRj2sh67E5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NWlQ3r6D9gDHwI6RzohkYCsKUUPRz0iK/eb7YwkOkDDGV+Bm4Ti41ozWNiC7Hpfk9
	 Z4Jpb8y69qRtqhqe1/UUMJ/lJSD/+34wpDCK0te0W2h9dHdigqrbb4knSB/7pIjsAB
	 ay0H8ulJJf4WGoYle4wTRjl7RyXua2ZdwrZKy6kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfAOQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbfAOQhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0052087E;
        Tue, 15 Jan 2019 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570229;
        bh=myDkjw52/+bzII35myzNdXLTwQ6munWQRRj2sh67E5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXIZlNO2enMUkEzdivP34ZFeRHZhiJ5SFSNjIDv/HlMd+xXLYlszFhKKFnvhIWtxe
         B/aMlyMj+5rsF9kpCmyOjCGQIgH8dwveSb2pV3YOu9O08jTpPKmzlWwxWq6DxcrNo9
         GQSS5FDs5WlX407n6tjMAeFCaPyBlXySy/qNc2yA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        David Sterba <dsterba@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 04/51] Btrfs: add validadtion checks for chunk loading
Date:   Tue, 15 Jan 2019 17:35:00 +0100
Message-Id: <20190115154847.555748833@linuxfoundation.org>
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

commit e06cd3dd7cea50e87663a88acdfdb7ac1c53a5ca upstream.

To prevent fuzzed filesystem images from panic the whole system,
we need various validation checks to refuse to mount such an image
if btrfs finds any invalid value during loading chunks, including
both sys_array and regular chunks.

Note that these checks may not be sufficient to cover all corner cases,
feel free to add more checks.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Reported-by: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   82 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 15 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6208,27 +6208,23 @@ struct btrfs_device *btrfs_alloc_device(
 	return dev;
 }
 
-static int read_one_chunk(struct btrfs_root *root, struct btrfs_key *key,
-			  struct extent_buffer *leaf,
-			  struct btrfs_chunk *chunk)
+/* Return -EIO if any error, otherwise return 0. */
+static int btrfs_check_chunk_valid(struct btrfs_root *root,
+				   struct extent_buffer *leaf,
+				   struct btrfs_chunk *chunk, u64 logical)
 {
-	struct btrfs_mapping_tree *map_tree = &root->fs_info->mapping_tree;
-	struct map_lookup *map;
-	struct extent_map *em;
-	u64 logical;
 	u64 length;
 	u64 stripe_len;
-	u64 devid;
-	u8 uuid[BTRFS_UUID_SIZE];
-	int num_stripes;
-	int ret;
-	int i;
+	u16 num_stripes;
+	u16 sub_stripes;
+	u64 type;
 
-	logical = key->offset;
 	length = btrfs_chunk_length(leaf, chunk);
 	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
-	/* Validation check */
+	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
+	type = btrfs_chunk_type(leaf, chunk);
+
 	if (!num_stripes) {
 		btrfs_err(root->fs_info, "invalid chunk num_stripes: %u",
 			  num_stripes);
@@ -6239,6 +6235,11 @@ static int read_one_chunk(struct btrfs_r
 			  "invalid chunk logical %llu", logical);
 		return -EIO;
 	}
+	if (btrfs_chunk_sector_size(leaf, chunk) != root->sectorsize) {
+		btrfs_err(root->fs_info, "invalid chunk sectorsize %u",
+			  btrfs_chunk_sector_size(leaf, chunk));
+		return -EIO;
+	}
 	if (!length || !IS_ALIGNED(length, root->sectorsize)) {
 		btrfs_err(root->fs_info,
 			"invalid chunk length %llu", length);
@@ -6250,13 +6251,54 @@ static int read_one_chunk(struct btrfs_r
 		return -EIO;
 	}
 	if (~(BTRFS_BLOCK_GROUP_TYPE_MASK | BTRFS_BLOCK_GROUP_PROFILE_MASK) &
-	    btrfs_chunk_type(leaf, chunk)) {
+	    type) {
 		btrfs_err(root->fs_info, "unrecognized chunk type: %llu",
 			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
 			    BTRFS_BLOCK_GROUP_PROFILE_MASK) &
 			  btrfs_chunk_type(leaf, chunk));
 		return -EIO;
 	}
+	if ((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes < 1) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
+	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes > 2) ||
+	    ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
+	     num_stripes != 1)) {
+		btrfs_err(root->fs_info,
+			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
+			num_stripes, sub_stripes,
+			type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int read_one_chunk(struct btrfs_root *root, struct btrfs_key *key,
+			  struct extent_buffer *leaf,
+			  struct btrfs_chunk *chunk)
+{
+	struct btrfs_mapping_tree *map_tree = &root->fs_info->mapping_tree;
+	struct map_lookup *map;
+	struct extent_map *em;
+	u64 logical;
+	u64 length;
+	u64 stripe_len;
+	u64 devid;
+	u8 uuid[BTRFS_UUID_SIZE];
+	int num_stripes;
+	int ret;
+	int i;
+
+	logical = key->offset;
+	length = btrfs_chunk_length(leaf, chunk);
+	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
+	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+
+	ret = btrfs_check_chunk_valid(root, leaf, chunk, logical);
+	if (ret)
+		return ret;
 
 	read_lock(&map_tree->map_tree.lock);
 	em = lookup_extent_mapping(&map_tree->map_tree, logical, 1);
@@ -6504,6 +6546,7 @@ int btrfs_read_sys_array(struct btrfs_ro
 	u32 array_size;
 	u32 len = 0;
 	u32 cur_offset;
+	u64 type;
 	struct btrfs_key key;
 
 	ASSERT(BTRFS_SUPER_INFO_SIZE <= root->nodesize);
@@ -6569,6 +6612,15 @@ int btrfs_read_sys_array(struct btrfs_ro
 				ret = -EIO;
 				break;
 			}
+
+			type = btrfs_chunk_type(sb, chunk);
+			if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
+				btrfs_err(root->fs_info,
+			    "invalid chunk type %llu in sys_array at offset %u",
+					type, cur_offset);
+				ret = -EIO;
+				break;
+			}
 
 			len = btrfs_chunk_item_size(num_stripes);
 			if (cur_offset + len > array_size)


