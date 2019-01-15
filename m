Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7766EC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38720208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570220;
	bh=qM4CY6q59Ifs5EZOs727p1o6Pi8GTLs8gr/8U2hL0Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1FwgkGKuWMivaDkDCPlM26yLB6jkhwIMLjHbhQgMaXC/8ZIL6OAkoy38KPRoNlEO+
	 lAdNe1WewmWtA6WJrFJVBSDU/0jtYXTqumKtWKGYflJbMV2oseO7hFdTbevUezy3gh
	 eYHxULsl5LZbu0AI+SOUbPh4P/HY2iVQc7LmumEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfAOQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbfAOQg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:36:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5CA42087E;
        Tue, 15 Jan 2019 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570216;
        bh=qM4CY6q59Ifs5EZOs727p1o6Pi8GTLs8gr/8U2hL0Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUBehUNZvZHTKwbK97HQcZFxnT5K8d6/zwmVGNtN0P0fddtASVfnYxDv03jSQxVeW
         2UOstLXzZMH8ThmcBI8LcpQ/FdwUVXH0/KfNxVlUVZRr9Uv96TtKR3Pb4RUFjePI5M
         A/zaXrOfTLUW8z/HenyhjeNf7xE9KyJFQgv/rZFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 12/51] Btrfs: kill BUG_ON in run_delayed_tree_ref
Date:   Tue, 15 Jan 2019 17:35:08 +0100
Message-Id: <20190115154848.674979352@linuxfoundation.org>
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

commit 02794222c4132ac003e7281fb71f4ec1645ffc87 upstream.

In a corrupted btrfs image, we can come across this BUG_ON and
get an unreponsive system, but if we return errors instead,
its caller can handle everything gracefully by aborting the current
transaction.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2342,7 +2342,13 @@ static int run_delayed_tree_ref(struct b
 		ins.type = BTRFS_EXTENT_ITEM_KEY;
 	}
 
-	BUG_ON(node->ref_mod != 1);
+	if (node->ref_mod != 1) {
+		btrfs_err(root->fs_info,
+	"btree block(%llu) has %d references rather than 1: action %d ref_root %llu parent %llu",
+			  node->bytenr, node->ref_mod, node->action, ref_root,
+			  parent);
+		return -EIO;
+	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		BUG_ON(!extent_op || !extent_op->update_flags);
 		ret = alloc_reserved_tree_block(trans, root,


