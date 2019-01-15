Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96620C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6480220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571713;
	bh=PB5dxtiMjFpDB25kw4cSlAxE3E2y0DI07ggh/tQYdF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BvNZ67owibEKeqDfZlrDxPPHPihIE6Ve+avwfHNGLWREepN+wTHI8mFEorM1FUx5
	 gnpBuKBd2GLv8Bo0y2EnDvjl+KTkK4d0nc5VY3hP5M1iw8vALOyTHPB5BpfAxJjjvw
	 Gv5XIz5m+SMze+CQyfdwaJP9NjPtE4DleQyWEgTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfAORBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731813AbfAOQhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B9220883;
        Tue, 15 Jan 2019 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570240;
        bh=PB5dxtiMjFpDB25kw4cSlAxE3E2y0DI07ggh/tQYdF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHmKS5FD5hzEwTX4U4La2fphd9iwsx/OvdwPzajp5rk82Mp14xaQk+lceZcEOGfOE
         t7RW7uTQzJk+46n9cbRPfoHLmqDG4pYMG+UkZJ2rCGHNXQ+NJ9MWliKDIY2y0ULX+p
         BhyOq6lP5J5E//K/zJNXC/j9lLTOYOl+FUSjQH54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 08/51] Btrfs: check btree nodes nritems
Date:   Tue, 15 Jan 2019 17:35:04 +0100
Message-Id: <20190115154848.174868858@linuxfoundation.org>
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

commit 053ab70f0604224c7893b43f9d9d5efa283580d6 upstream.

When btree node (level = 1) has nritems which equals to zero,
we can end up with panic due to insert_ptr()'s

BUG_ON(slot > nritems);

where slot is 1 and nritems is 0, as copy_for_split() calls
insert_ptr(.., path->slots[1] + 1, ...);

A invalid value results in the whole mess, this adds the check
for btree's node nritems so that we stop reading block when
when something is wrong.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -609,6 +609,19 @@ static noinline int check_leaf(struct bt
 	return 0;
 }
 
+static int check_node(struct btrfs_root *root, struct extent_buffer *node)
+{
+	unsigned long nr = btrfs_header_nritems(node);
+
+	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(root)) {
+		btrfs_crit(root->fs_info,
+			   "corrupt node: block %llu root %llu nritems %lu",
+			   node->start, root->objectid, nr);
+		return -EIO;
+	}
+	return 0;
+}
+
 static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 				      u64 phy_offset, struct page *page,
 				      u64 start, u64 end, int mirror)
@@ -680,6 +693,9 @@ static int btree_readpage_end_io_hook(st
 		ret = -EIO;
 	}
 
+	if (found_level > 0 && check_node(root, eb))
+		ret = -EIO;
+
 	if (!ret)
 		set_extent_buffer_uptodate(eb);
 err:


