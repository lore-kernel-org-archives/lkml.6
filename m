Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E95C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324E020868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570262;
	bh=QcXfen9aQgYi15kJQqv0CwyppH3+38GS55F5Tu+IhPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QJEUGPByhOXKowOkLMvWVcfuPLMHh+NBkACqk24KNtbvHnyG/zBlw4v2bNOa1Bj9j
	 OCLZCV2936QwzMSOeGtmjKx+XD8Rm6EFbkHY4Z35LXv3cHJthn0Qc5gumU+EyThsa3
	 DxWibXLRGWemZvDcU4oWhmNTgbzYccc/4jZszlo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfAOQhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbfAOQhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B287020873;
        Tue, 15 Jan 2019 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570257;
        bh=QcXfen9aQgYi15kJQqv0CwyppH3+38GS55F5Tu+IhPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSFgmIG73Bx/g0hgbSiwbCK6nLAAUhtqrZMBe8xiE03B2/i1EiQxJh5jPCan92f6g
         5ggFAVRiThuw6Yxm6hh+ref0sWTLJ++3SCNA2Ub0OKNBZrUFH52EotSrE7psRHVVdN
         T7aVOLQ/KgvsBCaEVVt2VJpCAnvzXGRlI3R3XcQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 27/51] btrfs: tree-checker: Detect invalid and empty essential trees
Date:   Tue, 15 Jan 2019 17:35:23 +0100
Message-Id: <20190115154850.539778691@linuxfoundation.org>
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

commit ba480dd4db9f1798541eb2d1c423fc95feee8d36 upstream.

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
[bwh: Backported to 4.4: Pass root instead of fs_info to generic_err()]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -456,9 +456,22 @@ static int check_leaf(struct btrfs_root
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
+			generic_err(root, leaf, 0,
+			"invalid root, root %llu must never be empty",
+				    owner);
+			return -EUCLEAN;
+		}
+		key.objectid = owner;
 		key.type = BTRFS_ROOT_ITEM_KEY;
 		key.offset = (u64)-1;
 


