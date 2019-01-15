Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5409EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CB42087E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570238;
	bh=AFph+3DnTGJ8KVB6uAkRLpjnK2AhBmxFoO9KX+bRHBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSwNw+i9lawcxDc3Qt9as/Da5IGhoQn4O9fuXAHytDBZ/5l04Ppa6fbqMG9e194qo
	 I1JRmlU5NpkuYEd97GO5ahm63C8YTR/6YUuKRSVxumtNoeHHcRKpcolgatHfXs6NEK
	 beouzwTd9UB+A3ud0zOzgBp5SEZI8VG/U+X+VWxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfAOQhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbfAOQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B3A20859;
        Tue, 15 Jan 2019 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570231;
        bh=AFph+3DnTGJ8KVB6uAkRLpjnK2AhBmxFoO9KX+bRHBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqQ9K8q0FEMvcDE0gyhFwcjVkXB4EljHk8JjjAPT8+FRw0wF5TkzJKc7AloAPzoKB
         SbWHCPSrQ6OTu03XehanXAtVhswZi5aXRwlZxlNYCs6AzaJBdm3+ZWSyVUc7yP+xEw
         JV7zQoBHDc+hFDTHMDMQbfmdjlRJVi9LilkGggD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 05/51] Btrfs: check inconsistence between chunk and block group
Date:   Tue, 15 Jan 2019 17:35:01 +0100
Message-Id: <20190115154847.722648865@linuxfoundation.org>
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

commit 6fb37b756acce6d6e045f79c3764206033f617b4 upstream.

With btrfs-corrupt-block, one can drop one chunk item and mounting
will end up with a panic in btrfs_full_stripe_len().

This doesn't not remove the BUG_ON, but instead checks it a bit
earlier when we find the block group item.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9502,7 +9502,22 @@ static int find_first_block_group(struct
 
 		if (found_key.objectid >= key->objectid &&
 		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			ret = 0;
+			struct extent_map_tree *em_tree;
+			struct extent_map *em;
+
+			em_tree = &root->fs_info->mapping_tree.map_tree;
+			read_lock(&em_tree->lock);
+			em = lookup_extent_mapping(em_tree, found_key.objectid,
+						   found_key.offset);
+			read_unlock(&em_tree->lock);
+			if (!em) {
+				btrfs_err(root->fs_info,
+			"logical %llu len %llu found bg but no related chunk",
+					  found_key.objectid, found_key.offset);
+				ret = -ENOENT;
+			} else {
+				ret = 0;
+			}
 			goto out;
 		}
 		path->slots[0]++;


