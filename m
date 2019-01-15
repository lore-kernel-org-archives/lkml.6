Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB67C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAE520675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570276;
	bh=P2GdARO/DBDOPmLqA4nUV2aae268klKglv9IYj3dSdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBvHezcb2OC8w4i5Ag1zObw7vERsQeEx1ybMFuTPcU+r8FLgR3lPYFQpyUNb8P8g3
	 cuR0eg9TMbB+o9byR+8CcG8I5z5UdmyH6HzECk5jZAO94f4dYIWxt7UE3zCH6zDcU1
	 bb3MTKR//lI9NQ6SMFzId5b3GH4YN2Gtw/emKEfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfAOQhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731941AbfAOQht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E96F20873;
        Tue, 15 Jan 2019 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570269;
        bh=P2GdARO/DBDOPmLqA4nUV2aae268klKglv9IYj3dSdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUYWN69+bh04xUr3J9yArtGtILJ3NiskNLt+j1AF3ugqX23BJbZRAUZtvkTjr1xpD
         /HBRKZbr2OF2DASjomqzecqudUcnglUUiijmA5EpsS+zVSkKMSPlSuPA/h5HzZUNdz
         4PJeG8AhBeAOSI+kYadzqVkHMpWFVbgmrchAls4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 31/51] btrfs: tree-checker: Check level for leaves and nodes
Date:   Tue, 15 Jan 2019 17:35:27 +0100
Message-Id: <20190115154851.024231032@linuxfoundation.org>
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

commit f556faa46eb4e96d0d0772e74ecf66781e132f72 upstream.

Although we have tree level check at tree read runtime, it's completely
based on its parent level.
We still need to do accurate level check to avoid invalid tree blocks
sneak into kernel space.

The check itself is simple, for leaf its level should always be 0.
For nodes its level should be in range [1, BTRFS_MAX_LEVEL - 1].

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Su Yue <suy.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.4:
 - Pass root instead of fs_info to generic_err()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -447,6 +447,13 @@ static int check_leaf(struct btrfs_root
 	u32 nritems = btrfs_header_nritems(leaf);
 	int slot;
 
+	if (btrfs_header_level(leaf) != 0) {
+		generic_err(root, leaf, 0,
+			"invalid level for leaf, have %d expect 0",
+			btrfs_header_level(leaf));
+		return -EUCLEAN;
+	}
+
 	/*
 	 * Extent buffers from a relocation tree have a owner field that
 	 * corresponds to the subvolume tree they are based on. So just from an
@@ -589,9 +596,16 @@ int btrfs_check_node(struct btrfs_root *
 	unsigned long nr = btrfs_header_nritems(node);
 	struct btrfs_key key, next_key;
 	int slot;
+	int level = btrfs_header_level(node);
 	u64 bytenr;
 	int ret = 0;
 
+	if (level <= 0 || level >= BTRFS_MAX_LEVEL) {
+		generic_err(root, node, 0,
+			"invalid level for node, have %d expect [1, %d]",
+			level, BTRFS_MAX_LEVEL - 1);
+		return -EUCLEAN;
+	}
 	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(root)) {
 		btrfs_crit(root->fs_info,
 "corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%zu]",


