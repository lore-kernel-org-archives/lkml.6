Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E80C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478E620675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571710;
	bh=HTb0oqmdE3XMlFuqv9sJhGgQIHA9w+Zq8jXkmdR6Wkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qMI1erA7CpMlh9/H7pl7Gw/80NHHJz8NAtnneQ7pon+H+PKl8NuBV9p9UwF8RhLgl
	 YA9rCpLbpaLRlspLCBrStNJXeRinw/zn+JlR2yfsbtAc6w5b1Z7x/Fy0aUju753nyx
	 imnUH/9cGlUPxj0shmPN0o0hvDnwcEzSSSCY1Oqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfAOQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731799AbfAOQhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E8020868;
        Tue, 15 Jan 2019 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570237;
        bh=HTb0oqmdE3XMlFuqv9sJhGgQIHA9w+Zq8jXkmdR6Wkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge5JChNckti4njv8CbF40A56da5J0xgbNbbF+P8Qun5o36Yscb9gYaPy13fD0iwht
         sfgQhh8r+rZHNkNw+yNy5rYraMNNted1vfAxqxnNL5arRKhDI0ux9qilKPbAJ0z4qu
         mxoRSy59W81ZHSR4HCgTHwKzQkhdkrFULEBORxlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 07/51] Btrfs: detect corruption when non-root leaf has zero item
Date:   Tue, 15 Jan 2019 17:35:03 +0100
Message-Id: <20190115154848.020620898@linuxfoundation.org>
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

commit 1ba98d086fe3a14d6a31f2f66dbab70c45d00f63 upstream.

Right now we treat leaf which has zero item as a valid one
because we could have an empty tree, that is, a root that is
also a leaf without any item, however, in the same case but
when the leaf is not a root, we can end up with hitting the
BUG_ON(1) in btrfs_extend_item() called by
setup_inline_extent_backref().

This makes us check the situation as a corruption if leaf is
not its own root.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -535,8 +535,29 @@ static noinline int check_leaf(struct bt
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
 
-	if (nritems == 0)
+	if (nritems == 0) {
+		struct btrfs_root *check_root;
+
+		key.objectid = btrfs_header_owner(leaf);
+		key.type = BTRFS_ROOT_ITEM_KEY;
+		key.offset = (u64)-1;
+
+		check_root = btrfs_get_fs_root(root->fs_info, &key, false);
+		/*
+		 * The only reason we also check NULL here is that during
+		 * open_ctree() some roots has not yet been set up.
+		 */
+		if (!IS_ERR_OR_NULL(check_root)) {
+			/* if leaf is the root, then it's fine */
+			if (leaf->start !=
+			    btrfs_root_bytenr(&check_root->root_item)) {
+				CORRUPT("non-root leaf's nritems is 0",
+					leaf, root, 0);
+				return -EIO;
+			}
+		}
 		return 0;
+	}
 
 	/* Check the 0 item */
 	if (btrfs_item_offset_nr(leaf, 0) + btrfs_item_size_nr(leaf, 0) !=


