Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C71C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5A214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcFVq2Ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E5A214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeLDLCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbeLDLCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0BE21536;
        Tue,  4 Dec 2018 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921343;
        bh=l30MuosTXsNKQftTf2XOKvBBqYufD1eksCDbWXsdQI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcFVq2TaVN4NuVGnyz33g3oEC0NwWs3x8qGCaQBScX4UYuDAm55+mm255jE9eI8bq
         bInHLAtjkiAbJdfU36UlF9Aa+sjH3S9y4bNxpmAKGXWLMl5LxHcciYJKNibFThVUSb
         7OMukbHLefXdUPZsq+bGnwDldhH4f3XlL69PrW7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>,
        "Lakshmipathi.G" <lakshmipathi.g@gmail.com>,
        Qu Wenruo <wqu@suse.com>, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 035/146] btrfs: tree-checker: Fix false panic for sanity test
Date:   Tue,  4 Dec 2018 11:48:41 +0100
Message-Id: <20181204103728.272938894@linuxfoundation.org>
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

commit 69fc6cbbac542c349b3d350d10f6e394c253c81d upstream.

[BUG]
If we run btrfs with CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y, it will
instantly cause kernel panic like:

------
...
assertion failed: 0, file: fs/btrfs/disk-io.c, line: 3853
...
Call Trace:
 btrfs_mark_buffer_dirty+0x187/0x1f0 [btrfs]
 setup_items_for_insert+0x385/0x650 [btrfs]
 __btrfs_drop_extents+0x129a/0x1870 [btrfs]
...
-----

[Cause]
Btrfs will call btrfs_check_leaf() in btrfs_mark_buffer_dirty() to check
if the leaf is valid with CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y.

However quite some btrfs_mark_buffer_dirty() callers(*) don't really
initialize its item data but only initialize its item pointers, leaving
item data uninitialized.

This makes tree-checker catch uninitialized data as error, causing
such panic.

*: These callers include but not limited to
setup_items_for_insert()
btrfs_split_item()
btrfs_expand_item()

[Fix]
Add a new parameter @check_item_data to btrfs_check_leaf().
With @check_item_data set to false, item data check will be skipped and
fallback to old btrfs_check_leaf() behavior.

So we can still get early warning if we screw up item pointers, and
avoid false panic.

Cc: Filipe Manana <fdmanana@gmail.com>
Reported-by: Lakshmipathi.G <lakshmipathi.g@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c      | 10 ++++++++--
 fs/btrfs/tree-checker.c | 27 ++++++++++++++++++++++-----
 fs/btrfs/tree-checker.h | 14 +++++++++++++-
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2df5e906db08..e42673477c25 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -610,7 +610,7 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	 * that we don't try and read the other copies of this block, just
 	 * return -EIO.
 	 */
-	if (found_level == 0 && btrfs_check_leaf(root, eb)) {
+	if (found_level == 0 && btrfs_check_leaf_full(root, eb)) {
 		set_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret = -EIO;
 	}
@@ -3870,7 +3870,13 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 					 buf->len,
 					 fs_info->dirty_metadata_batch);
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-	if (btrfs_header_level(buf) == 0 && btrfs_check_leaf(root, buf)) {
+	/*
+	 * Since btrfs_mark_buffer_dirty() can be called with item pointer set
+	 * but item data not updated.
+	 * So here we should only check item pointers, not item data.
+	 */
+	if (btrfs_header_level(buf) == 0 &&
+	    btrfs_check_leaf_relaxed(root, buf)) {
 		btrfs_print_leaf(buf);
 		ASSERT(0);
 	}
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 5acdf3355a3f..ff4fa8f905d3 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -195,7 +195,8 @@ static int check_leaf_item(struct btrfs_root *root,
 	return ret;
 }
 
-int btrfs_check_leaf(struct btrfs_root *root, struct extent_buffer *leaf)
+static int check_leaf(struct btrfs_root *root, struct extent_buffer *leaf,
+		      bool check_item_data)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	/* No valid key type is 0, so all key should be larger than this key */
@@ -299,10 +300,15 @@ int btrfs_check_leaf(struct btrfs_root *root, struct extent_buffer *leaf)
 			return -EUCLEAN;
 		}
 
-		/* Check if the item size and content meet other criteria */
-		ret = check_leaf_item(root, leaf, &key, slot);
-		if (ret < 0)
-			return ret;
+		if (check_item_data) {
+			/*
+			 * Check if the item size and content meet other
+			 * criteria
+			 */
+			ret = check_leaf_item(root, leaf, &key, slot);
+			if (ret < 0)
+				return ret;
+		}
 
 		prev_key.objectid = key.objectid;
 		prev_key.type = key.type;
@@ -312,6 +318,17 @@ int btrfs_check_leaf(struct btrfs_root *root, struct extent_buffer *leaf)
 	return 0;
 }
 
+int btrfs_check_leaf_full(struct btrfs_root *root, struct extent_buffer *leaf)
+{
+	return check_leaf(root, leaf, true);
+}
+
+int btrfs_check_leaf_relaxed(struct btrfs_root *root,
+			     struct extent_buffer *leaf)
+{
+	return check_leaf(root, leaf, false);
+}
+
 int btrfs_check_node(struct btrfs_root *root, struct extent_buffer *node)
 {
 	unsigned long nr = btrfs_header_nritems(node);
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 96c486e95d70..3d53e8d6fda0 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -20,7 +20,19 @@
 #include "ctree.h"
 #include "extent_io.h"
 
-int btrfs_check_leaf(struct btrfs_root *root, struct extent_buffer *leaf);
+/*
+ * Comprehensive leaf checker.
+ * Will check not only the item pointers, but also every possible member
+ * in item data.
+ */
+int btrfs_check_leaf_full(struct btrfs_root *root, struct extent_buffer *leaf);
+
+/*
+ * Less strict leaf checker.
+ * Will only check item pointers, not reading item data.
+ */
+int btrfs_check_leaf_relaxed(struct btrfs_root *root,
+			     struct extent_buffer *leaf);
 int btrfs_check_node(struct btrfs_root *root, struct extent_buffer *node);
 
 #endif
-- 
2.17.1



