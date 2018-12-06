Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D7C2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107734;
	bh=Hcp0hT4Jk4GSX8cyNUeD8d8CylbJY11EzQlLhCp46Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bF+S6ibwDR4TOU8jnBIxxJK6nU7Azt+37NHLG0DHwDglVqWDUudwR6a/l06/ul98I
	 RghwSokmNdWFr3rKd+120vZjX1ijVr+JkBOueIG5m8C4ru5gyIaEOzBjyQLctNDYEO
	 GgjAA5b1607DG+TvyBDOR5gwA3SzngAEM+gQjyWE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D7C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbeLFOsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731576AbeLFOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:48:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6559A20661;
        Thu,  6 Dec 2018 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107700;
        bh=Hcp0hT4Jk4GSX8cyNUeD8d8CylbJY11EzQlLhCp46Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVZv40788a5OJX0KzsxClWVN96XchBmzHoC3LQ4lbf6FtKChLeWH0c+Qld3rrmaxn
         enXueDvz2ZAjSSyVjGEQPW5wYgf8AhVZ9+nF+VuneDK4Q/MzOIXdhu7Ndd4GZr298c
         6Xk9/yV7GhZ4ZkHx2p7kfy+wwCNq7cr4ae6ncPHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 079/101] btrfs: tree-checker: Detect invalid and empty essential trees
Date:   Thu,  6 Dec 2018 15:39:18 +0100
Message-Id: <20181206143016.716811151@linuxfoundation.org>
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
[bwh: Backported to 4.9: Pass root instead of fs_info to generic_err()]
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
 


