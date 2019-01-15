Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8138C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54FD2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570650;
	bh=jG+rAo61gvCU7PLL1KnFP9e45hwXCrfJK9LUonLqKfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=doj5/svPdLr97ATkwbvJDVth+MwiGug4Sxu55mnQf23RZkg3AA6pHNWC/b7v4dvUG
	 HFs5NOREnK68W9/aVWf+cmrRPgtSJL0VbIXBKXzDliNJJxjaGhKWdh9uP0DaGqCe3G
	 XREs0XB3+fJQzoEtnvEwsMSOf2XxHA/dgwj4Sh7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfAOQoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbfAOQoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4CD2054F;
        Tue, 15 Jan 2019 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570646;
        bh=jG+rAo61gvCU7PLL1KnFP9e45hwXCrfJK9LUonLqKfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGsgL5g9Qe/haLsG6hdtCL++NYf5oTyN68XuAuHaW4LKyUYR1Byx9253wyOj83RQ/
         W/3GAaDElTtI/p6Kxj+W7/sAO8BY2ZNs4pxLBiUnjMxg9Re07rhjUDbAyVP8THfhGr
         KEqtoMTGj6exuRFkagPLipUWDJPb8ceKentxct00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.20 02/57] Btrfs: fix deadlock when using free space tree due to block group creation
Date:   Tue, 15 Jan 2019 17:35:43 +0100
Message-Id: <20190115154910.863488970@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit a6d8654d885d7d79a3fb82da64eaa489ca332a82 upstream.

When modifying the free space tree we can end up COWing one of its extent
buffers which in turn might result in allocating a new chunk, which in
turn can result in flushing (finish creation) of pending block groups. If
that happens we can deadlock because creating a pending block group needs
to update the free space tree, and if any of the updates tries to modify
the same extent buffer that we are COWing, we end up in a deadlock since
we try to write lock twice the same extent buffer.

So fix this by skipping pending block group creation if we are COWing an
extent buffer from the free space tree. This is a case missed by commit
5ce555578e091 ("Btrfs: fix deadlock when writing out free space caches").

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202173
Fixes: 5ce555578e091 ("Btrfs: fix deadlock when writing out free space caches")
CC: stable@vger.kernel.org # 4.18+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1015,19 +1015,21 @@ static noinline int __btrfs_cow_block(st
 		parent_start = parent->start;
 
 	/*
-	 * If we are COWing a node/leaf from the extent, chunk or device trees,
-	 * make sure that we do not finish block group creation of pending block
-	 * groups. We do this to avoid a deadlock.
+	 * If we are COWing a node/leaf from the extent, chunk, device or free
+	 * space trees, make sure that we do not finish block group creation of
+	 * pending block groups. We do this to avoid a deadlock.
 	 * COWing can result in allocation of a new chunk, and flushing pending
 	 * block groups (btrfs_create_pending_block_groups()) can be triggered
 	 * when finishing allocation of a new chunk. Creation of a pending block
-	 * group modifies the extent, chunk and device trees, therefore we could
-	 * deadlock with ourselves since we are holding a lock on an extent
-	 * buffer that btrfs_create_pending_block_groups() may try to COW later.
+	 * group modifies the extent, chunk, device and free space trees,
+	 * therefore we could deadlock with ourselves since we are holding a
+	 * lock on an extent buffer that btrfs_create_pending_block_groups() may
+	 * try to COW later.
 	 */
 	if (root == fs_info->extent_root ||
 	    root == fs_info->chunk_root ||
-	    root == fs_info->dev_root)
+	    root == fs_info->dev_root ||
+	    root == fs_info->free_space_root)
 		trans->can_flush_pending_bgs = false;
 
 	cow = btrfs_alloc_tree_block(trans, root, parent_start,


