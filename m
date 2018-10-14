Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AEDC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074372087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074372087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeJNX25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:28:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37286 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:28:56 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMB-0004cm-Vz; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000FY-3j; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Qu Wenruo" <wqu@suse.com>,
        "David Sterba" <dsterba@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.937406057@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 084/366] btrfs: tests/qgroup: Fix wrong tree backref
 level
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 3c0efdf03b2d127f0e40e30db4e7aa0429b1b79a upstream.

The extent tree of the test fs is like the following:

 BTRFS info (device (null)): leaf 16327509003777336587 total ptrs 1 free space 3919
  item 0 key (4096 168 4096) itemoff 3944 itemsize 51
          extent refs 1 gen 1 flags 2
          tree block key (68719476736 0 0) level 1
                                           ^^^^^^^
          ref#0: tree block backref root 5

And it's using an empty tree for fs tree, so there is no way that its
level can be 1.

For REAL (created by mkfs) fs tree backref with no skinny metadata, the
result should look like:

 item 3 key (30408704 EXTENT_ITEM 4096) itemoff 3845 itemsize 51
         refs 1 gen 4 flags TREE_BLOCK
         tree block key (256 INODE_ITEM 0) level 0
                                           ^^^^^^^
         tree block backref root 5

Fix the level to 0, so it won't break later tree level checker.

Fixes: faa2dbf004e8 ("Btrfs: add sanity tests for new qgroup accounting code")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/tests/qgroup-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -69,7 +69,7 @@ static int insert_normal_tree_ref(struct
 	btrfs_set_extent_generation(leaf, item, 1);
 	btrfs_set_extent_flags(leaf, item, BTRFS_EXTENT_FLAG_TREE_BLOCK);
 	block_info = (struct btrfs_tree_block_info *)(item + 1);
-	btrfs_set_tree_block_level(leaf, block_info, 1);
+	btrfs_set_tree_block_level(leaf, block_info, 0);
 	iref = (struct btrfs_extent_inline_ref *)(block_info + 1);
 	if (parent > 0) {
 		btrfs_set_extent_inline_ref_type(leaf, iref,

