Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE47C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4360E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4360E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeIMTK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:10:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeIMTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:10:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6F5CD1D;
        Thu, 13 Sep 2018 14:01:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 137/197] btrfs: tree-checker: Detect invalid and empty essential trees
Date:   Thu, 13 Sep 2018 15:31:26 +0200
Message-Id: <20180913131847.035490862@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit ba480dd4db9f1798541eb2d1c423fc95feee8d36 ]

A crafted image has empty root tree block, which will later cause NULL
pointer dereference.

The following trees should never be empty:
1) Tree root
   Must contain at least root items for extent tree, device tree and fs
   tree

2) Chunk tree
   Or we can't even bootstrap as it contains the mapping.

3) Fs tree
   At least inode item for top level inode (.).

4) Device tree
   Dev extents for chunks

5) Extent tree
   Must have corresponding extent for each chunk.

If any of them is empty, we are sure the fs is corrupted and no need to
mount it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199847
Reported-by: Xu Wen <wen.xu@gatech.edu>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Tested-by: Gu Jinxiang <gujx@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -396,9 +396,22 @@ static int check_leaf(struct btrfs_fs_in
 	 * skip this check for relocation trees.
 	 */
 	if (nritems == 0 && !btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_RELOC)) {
+		u64 owner = btrfs_header_owner(leaf);
 		struct btrfs_root *check_root;
 
-		key.objectid = btrfs_header_owner(leaf);
+		/* These trees must never be empty */
+		if (owner == BTRFS_ROOT_TREE_OBJECTID ||
+		    owner == BTRFS_CHUNK_TREE_OBJECTID ||
+		    owner == BTRFS_EXTENT_TREE_OBJECTID ||
+		    owner == BTRFS_DEV_TREE_OBJECTID ||
+		    owner == BTRFS_FS_TREE_OBJECTID ||
+		    owner == BTRFS_DATA_RELOC_TREE_OBJECTID) {
+			generic_err(fs_info, leaf, 0,
+			"invalid root, root %llu must never be empty",
+				    owner);
+			return -EUCLEAN;
+		}
+		key.objectid = owner;
 		key.type = BTRFS_ROOT_ITEM_KEY;
 		key.offset = (u64)-1;
 


