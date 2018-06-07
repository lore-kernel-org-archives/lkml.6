Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1vZJAIxLGVskXAAAmS7hNA
	; Thu, 07 Jun 2018 15:14:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 387286063F; Thu,  7 Jun 2018 15:14:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 92C9060290;
	Thu,  7 Jun 2018 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92C9060290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935987AbeFGPOM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:14:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41424 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935066AbeFGPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbV-0005hO-Rh; Thu, 07 Jun 2018 15:09:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003At-3k; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Liu Bo" <bo.li.liu@oracle.com>,
        "Anand Jain" <anand.jain@oracle.com>,
        "David Sterba" <dsterba@suse.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.739649291@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 315/410] btrfs: use proper endianness accessors for
 super_copy
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.

The fs_info::super_copy is a byte copy of the on-disk structure and all
members must use the accessor macros/functions to obtain the right
value.  This was missing in update_super_roots and in sysfs readers.

Moving between opposite endianness hosts will report bogus numbers in
sysfs, and mount may fail as the root will not be restored correctly. If
the filesystem is always used on a same endian host, this will not be a
problem.

Fix this by using the btrfs_set_super...() functions to set
fs_info::super_copy values, and for the sysfs, use the cached
fs_info::nodesize/sectorsize values.

Fixes: df93589a17378 ("btrfs: export more from FS_INFO to sysfs")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - btrfs_fs_info doesn't have cached nodesize or sectorsize fields, so use
   the accessor functions
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -406,7 +406,7 @@ static ssize_t btrfs_nodesize_show(struc
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_nodesize(fs_info->super_copy));
 }
 
 BTRFS_ATTR_RW(nodesize, 0444, btrfs_nodesize_show, btrfs_no_store);
@@ -416,7 +416,7 @@ static ssize_t btrfs_sectorsize_show(str
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_sectorsize(fs_info->super_copy));
 }
 
 BTRFS_ATTR_RW(sectorsize, 0444, btrfs_sectorsize_show, btrfs_no_store);
@@ -426,7 +426,7 @@ static ssize_t btrfs_clone_alignment_sho
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", btrfs_super_sectorsize(fs_info->super_copy));
 }
 
 BTRFS_ATTR_RW(clone_alignment, 0444, btrfs_clone_alignment_show, btrfs_no_store);
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1428,19 +1428,23 @@ static void update_super_roots(struct bt
 
 	super = root->fs_info->super_copy;
 
+	/* update latest btrfs_super_block::chunk_root refs */
 	root_item = &root->fs_info->chunk_root->root_item;
-	super->chunk_root = root_item->bytenr;
-	super->chunk_root_generation = root_item->generation;
-	super->chunk_root_level = root_item->level;
+	btrfs_set_super_chunk_root(super, root_item->bytenr);
+	btrfs_set_super_chunk_root_generation(super, root_item->generation);
+	btrfs_set_super_chunk_root_level(super, root_item->level);
 
+	/* update latest btrfs_super_block::root refs */
 	root_item = &root->fs_info->tree_root->root_item;
-	super->root = root_item->bytenr;
-	super->generation = root_item->generation;
-	super->root_level = root_item->level;
+	btrfs_set_super_root(super, root_item->bytenr);
+	btrfs_set_super_generation(super, root_item->generation);
+	btrfs_set_super_root_level(super, root_item->level);
+
 	if (btrfs_test_opt(root, SPACE_CACHE))
-		super->cache_generation = root_item->generation;
+		btrfs_set_super_cache_generation(super, root_item->generation);
 	if (root->fs_info->update_uuid_tree_gen)
-		super->uuid_tree_generation = root_item->generation;
+		btrfs_set_super_uuid_tree_generation(super,
+						     root_item->generation);
 }
 
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
