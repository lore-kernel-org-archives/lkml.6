Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC386C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EC820868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570247;
	bh=QjB6eByvT+SGcK5dXSzNwQ7aVN/PLSROfvZ931sAP6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vmjRBkFSfEWK7Vd1joIu9PIcPFLW4SMV0M4potzAqx9doYb0P4eLhns0IuRbQun/I
	 VW2sp7nee20X+TsUZdBJnXWQJGAaFAmAp3vTKYsP03WbkBnUy3s6acKXtKDnf0whJF
	 5Z2l9tXi+JIQBc/Bx1zaBHSGt6ez/6Iu6K8XeO/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfAOQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbfAOQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD54620873;
        Tue, 15 Jan 2019 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570243;
        bh=QjB6eByvT+SGcK5dXSzNwQ7aVN/PLSROfvZ931sAP6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vkY5Ve6B1W8JIL94Uc5D4yqg5vjlUkwkhiXvqQFLz489v4i9P1b/3zVhEU84ofwdM
         98NeSIx9EkZ0QYJzXK2kad0l041K5ERnkYcrZM+6NC2mPGSyzExSMaFSp3lt9Cwp4c
         I/c8MkbySCppVExV0nj8K/yocLkC9VUf0rePWLIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        Liu Bo <bo.li.liu@oracle.com>,
        Filipe Manana <fdmanana@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 09/51] Btrfs: fix BUG_ON in btrfs_mark_buffer_dirty
Date:   Tue, 15 Jan 2019 17:35:05 +0100
Message-Id: <20190115154848.318175535@linuxfoundation.org>
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

commit ef85b25e982b5bba1530b936e283ef129f02ab9d upstream.

This can only happen with CONFIG_BTRFS_FS_CHECK_INTEGRITY=y.

Commit 1ba98d0 ("Btrfs: detect corruption when non-root leaf has zero item")
assumes that a leaf is its root when leaf->bytenr == btrfs_root_bytenr(root),
however, we should not use btrfs_root_bytenr(root) since it's mainly got
updated during committing transaction.  So the check can fail when doing
COW on this leaf while it is a root.

This changes to use "if (leaf == btrfs_root_node(root))" instead, just like
how we check whether leaf is a root in __btrfs_cow_block().

Fixes: 1ba98d086fe3 (Btrfs: detect corruption when non-root leaf has zero item)
Reported-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -548,13 +548,17 @@ static noinline int check_leaf(struct bt
 		 * open_ctree() some roots has not yet been set up.
 		 */
 		if (!IS_ERR_OR_NULL(check_root)) {
+			struct extent_buffer *eb;
+
+			eb = btrfs_root_node(check_root);
 			/* if leaf is the root, then it's fine */
-			if (leaf->start !=
-			    btrfs_root_bytenr(&check_root->root_item)) {
+			if (leaf != eb) {
 				CORRUPT("non-root leaf's nritems is 0",
-					leaf, root, 0);
+					leaf, check_root, 0);
+				free_extent_buffer(eb);
 				return -EIO;
 			}
+			free_extent_buffer(eb);
 		}
 		return 0;
 	}


