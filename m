Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32132C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F221479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107613;
	bh=+DylAd28Gc7pBFWbFZcPlCsWtMY21Ry4GIhI75BMj6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sx1z09z+b8AqkPu5CtLTe+Pn6mehoJ3CcUhJJYCCem/DuCjgz6zqqOc/M4IwGuELD
	 jR/6L1G5R2xeYJQjyeLj/BOTFEeYrq8sI+dAZpnGZlLCZHW9EY8fjCnbN0Co8bBI06
	 zo4Prhzu3OXCHDPCMVWr4Gdn8By7kK2wJqKdRNFk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38F221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbeLFOqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbeLFOqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381C22146D;
        Thu,  6 Dec 2018 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107607;
        bh=+DylAd28Gc7pBFWbFZcPlCsWtMY21Ry4GIhI75BMj6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFrHwbNT36tlQNlph6UVTOAeFwnxYqibTaZ2dfL1jWqmGsWTACeNcqt/eQ1nG/i1x
         7meRlAQ+OziRcGVBXLO8OzRXkklyS6vRJ8DSv260bTPUFaA6tSaoWjwM0onwcdjtSh
         09zAL00e4/DlPeoUnibIDk1LfTu9mNDmfP8jZ9Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 069/101] btrfs: Add sanity check for EXTENT_DATA when reading out leaf
Date:   Thu,  6 Dec 2018 15:39:08 +0100
Message-Id: <20181206143015.852393717@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <quwenruo.btrfs@gmx.com>

commit 40c3c40947324d9f40bf47830c92c59a9bbadf4a upstream.

Add extra checks for item with EXTENT_DATA type.  This checks the
following thing:

0) Key offset
   All key offsets must be aligned to sectorsize.
   Inline extent must have 0 for key offset.

1) Item size
   Uncompressed inline file extent size must match item size.
   (Compressed inline file extent has no information about its on-disk size.)
   Regular/preallocated file extent size must be a fixed value.

2) Every member of regular file extent item
   Including alignment for bytenr and offset, possible value for
   compression/encryption/type.

3) Type/compression/encode must be one of the valid values.

This should be the most comprehensive and strict check in the context
of btrfs_item for EXTENT_DATA.

Signed-off-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ switch to BTRFS_FILE_EXTENT_TYPES, similar to what
  BTRFS_COMPRESS_TYPES does ]
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.9: Use root->sectorsize instead of
 root->fs_info->sectorsize]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c              |  103 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h |    1 
 2 files changed, 104 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -544,6 +544,100 @@ static int check_tree_block_fsid(struct
 		   btrfs_header_level(eb) == 0 ? "leaf" : "node",\
 		   reason, btrfs_header_bytenr(eb), root->objectid, slot)
 
+static int check_extent_data_item(struct btrfs_root *root,
+				  struct extent_buffer *leaf,
+				  struct btrfs_key *key, int slot)
+{
+	struct btrfs_file_extent_item *fi;
+	u32 sectorsize = root->sectorsize;
+	u32 item_size = btrfs_item_size_nr(leaf, slot);
+
+	if (!IS_ALIGNED(key->offset, sectorsize)) {
+		CORRUPT("unaligned key offset for file extent",
+			leaf, root, slot);
+		return -EUCLEAN;
+	}
+
+	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+
+	if (btrfs_file_extent_type(leaf, fi) > BTRFS_FILE_EXTENT_TYPES) {
+		CORRUPT("invalid file extent type", leaf, root, slot);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * Support for new compression/encrption must introduce incompat flag,
+	 * and must be caught in open_ctree().
+	 */
+	if (btrfs_file_extent_compression(leaf, fi) > BTRFS_COMPRESS_TYPES) {
+		CORRUPT("invalid file extent compression", leaf, root, slot);
+		return -EUCLEAN;
+	}
+	if (btrfs_file_extent_encryption(leaf, fi)) {
+		CORRUPT("invalid file extent encryption", leaf, root, slot);
+		return -EUCLEAN;
+	}
+	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
+		/* Inline extent must have 0 as key offset */
+		if (key->offset) {
+			CORRUPT("inline extent has non-zero key offset",
+				leaf, root, slot);
+			return -EUCLEAN;
+		}
+
+		/* Compressed inline extent has no on-disk size, skip it */
+		if (btrfs_file_extent_compression(leaf, fi) !=
+		    BTRFS_COMPRESS_NONE)
+			return 0;
+
+		/* Uncompressed inline extent size must match item size */
+		if (item_size != BTRFS_FILE_EXTENT_INLINE_DATA_START +
+		    btrfs_file_extent_ram_bytes(leaf, fi)) {
+			CORRUPT("plaintext inline extent has invalid size",
+				leaf, root, slot);
+			return -EUCLEAN;
+		}
+		return 0;
+	}
+
+	/* Regular or preallocated extent has fixed item size */
+	if (item_size != sizeof(*fi)) {
+		CORRUPT(
+		"regluar or preallocated extent data item size is invalid",
+			leaf, root, slot);
+		return -EUCLEAN;
+	}
+	if (!IS_ALIGNED(btrfs_file_extent_ram_bytes(leaf, fi), sectorsize) ||
+	    !IS_ALIGNED(btrfs_file_extent_disk_bytenr(leaf, fi), sectorsize) ||
+	    !IS_ALIGNED(btrfs_file_extent_disk_num_bytes(leaf, fi), sectorsize) ||
+	    !IS_ALIGNED(btrfs_file_extent_offset(leaf, fi), sectorsize) ||
+	    !IS_ALIGNED(btrfs_file_extent_num_bytes(leaf, fi), sectorsize)) {
+		CORRUPT(
+		"regular or preallocated extent data item has unaligned value",
+			leaf, root, slot);
+		return -EUCLEAN;
+	}
+
+	return 0;
+}
+
+/*
+ * Common point to switch the item-specific validation.
+ */
+static int check_leaf_item(struct btrfs_root *root,
+			   struct extent_buffer *leaf,
+			   struct btrfs_key *key, int slot)
+{
+	int ret = 0;
+
+	switch (key->type) {
+	case BTRFS_EXTENT_DATA_KEY:
+		ret = check_extent_data_item(root, leaf, key, slot);
+		break;
+	}
+	return ret;
+}
+
 static noinline int check_leaf(struct btrfs_root *root,
 			       struct extent_buffer *leaf)
 {
@@ -599,9 +693,13 @@ static noinline int check_leaf(struct bt
 	 * 1) key order
 	 * 2) item offset and size
 	 *    No overlap, no hole, all inside the leaf.
+	 * 3) item content
+	 *    If possible, do comprehensive sanity check.
+	 *    NOTE: All checks must only rely on the item data itself.
 	 */
 	for (slot = 0; slot < nritems; slot++) {
 		u32 item_end_expected;
+		int ret;
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
@@ -644,6 +742,11 @@ static noinline int check_leaf(struct bt
 			return -EUCLEAN;
 		}
 
+		/* Check if the item size and content meet other criteria */
+		ret = check_leaf_item(root, leaf, &key, slot);
+		if (ret < 0)
+			return ret;
+
 		prev_key.objectid = key.objectid;
 		prev_key.type = key.type;
 		prev_key.offset = key.offset;
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -730,6 +730,7 @@ struct btrfs_balance_item {
 #define BTRFS_FILE_EXTENT_INLINE 0
 #define BTRFS_FILE_EXTENT_REG 1
 #define BTRFS_FILE_EXTENT_PREALLOC 2
+#define BTRFS_FILE_EXTENT_TYPES	2
 
 struct btrfs_file_extent_item {
 	/*


