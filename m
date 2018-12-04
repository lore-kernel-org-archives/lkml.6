Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06AEC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2C820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTbWg45V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2C820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeLDLUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeLDLDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0152087F;
        Tue,  4 Dec 2018 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921421;
        bh=R4mzaICfOqnGpEJTPuQVAG8MEhYlOOLWbVw6fmnva/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTbWg45VKqyjzQC+LcffoRvBvSE8nxfOoyaS9KRMV6UZVjx4zj0eXEQdHZFdKIbSC
         vyBkNUet461Nga7TuaJTwK3eP20miwQ36wXL2Pk16lsAl88JMuoOVN1bQKoyF7NdjQ
         q2h6dvqWAj547b1dtdUnPW1nW7i6jIew0wo5bPyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/146] btrfs: Refactor check_leaf function for later expansion
Date:   Tue,  4 Dec 2018 11:48:35 +0100
Message-Id: <20181204103728.033382562@linuxfoundation.org>
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

commit c3267bbaa9cae09b62960eafe33ad19196803285 upstream.

Current check_leaf() function does a good job checking key order and
item offset/size.

However it only checks from slot 0 to the last but one slot, this is
good but makes later expansion hard.

So this refactoring iterates from slot 0 to the last slot.
For key comparison, it uses a key with all 0 as initial key, so all
valid keys should be larger than that.

And for item size/offset checks, it compares current item end with
previous item offset.
For slot 0, use leaf end as a special case.

This makes later item/key offset checks and item size checks easier to
be implemented.

Also, makes check_leaf() to return -EUCLEAN other than -EIO to indicate
error.

Signed-off-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 50 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e67cee73c53..4a1e63df1183 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -554,8 +554,9 @@ static noinline int check_leaf(struct btrfs_root *root,
 			       struct extent_buffer *leaf)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	/* No valid key type is 0, so all key should be larger than this key */
+	struct btrfs_key prev_key = {0, 0, 0};
 	struct btrfs_key key;
-	struct btrfs_key leaf_key;
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
 
@@ -588,7 +589,7 @@ static noinline int check_leaf(struct btrfs_root *root,
 				CORRUPT("non-root leaf's nritems is 0",
 					leaf, check_root, 0);
 				free_extent_buffer(eb);
-				return -EIO;
+				return -EUCLEAN;
 			}
 			free_extent_buffer(eb);
 		}
@@ -598,28 +599,23 @@ static noinline int check_leaf(struct btrfs_root *root,
 	if (nritems == 0)
 		return 0;
 
-	/* Check the 0 item */
-	if (btrfs_item_offset_nr(leaf, 0) + btrfs_item_size_nr(leaf, 0) !=
-	    BTRFS_LEAF_DATA_SIZE(fs_info)) {
-		CORRUPT("invalid item offset size pair", leaf, root, 0);
-		return -EIO;
-	}
-
 	/*
-	 * Check to make sure each items keys are in the correct order and their
-	 * offsets make sense.  We only have to loop through nritems-1 because
-	 * we check the current slot against the next slot, which verifies the
-	 * next slot's offset+size makes sense and that the current's slot
-	 * offset is correct.
+	 * Check the following things to make sure this is a good leaf, and
+	 * leaf users won't need to bother with similar sanity checks:
+	 *
+	 * 1) key order
+	 * 2) item offset and size
+	 *    No overlap, no hole, all inside the leaf.
 	 */
-	for (slot = 0; slot < nritems - 1; slot++) {
-		btrfs_item_key_to_cpu(leaf, &leaf_key, slot);
-		btrfs_item_key_to_cpu(leaf, &key, slot + 1);
+	for (slot = 0; slot < nritems; slot++) {
+		u32 item_end_expected;
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
 
 		/* Make sure the keys are in the right order */
-		if (btrfs_comp_cpu_keys(&leaf_key, &key) >= 0) {
+		if (btrfs_comp_cpu_keys(&prev_key, &key) >= 0) {
 			CORRUPT("bad key order", leaf, root, slot);
-			return -EIO;
+			return -EUCLEAN;
 		}
 
 		/*
@@ -627,10 +623,14 @@ static noinline int check_leaf(struct btrfs_root *root,
 		 * item data starts at the end of the leaf and grows towards the
 		 * front.
 		 */
-		if (btrfs_item_offset_nr(leaf, slot) !=
-			btrfs_item_end_nr(leaf, slot + 1)) {
+		if (slot == 0)
+			item_end_expected = BTRFS_LEAF_DATA_SIZE(fs_info);
+		else
+			item_end_expected = btrfs_item_offset_nr(leaf,
+								 slot - 1);
+		if (btrfs_item_end_nr(leaf, slot) != item_end_expected) {
 			CORRUPT("slot offset bad", leaf, root, slot);
-			return -EIO;
+			return -EUCLEAN;
 		}
 
 		/*
@@ -641,8 +641,12 @@ static noinline int check_leaf(struct btrfs_root *root,
 		if (btrfs_item_end_nr(leaf, slot) >
 		    BTRFS_LEAF_DATA_SIZE(fs_info)) {
 			CORRUPT("slot end outside of leaf", leaf, root, slot);
-			return -EIO;
+			return -EUCLEAN;
 		}
+
+		prev_key.objectid = key.objectid;
+		prev_key.type = key.type;
+		prev_key.offset = key.offset;
 	}
 
 	return 0;
-- 
2.17.1



