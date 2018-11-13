Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1845DC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BA622520
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHrVU2wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BA622520
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbeKMPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733182AbeKMPtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:49:23 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FD822525;
        Tue, 13 Nov 2018 05:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088376;
        bh=yyPooav/5YMIwjliDVDwtbyhMNBSJNjl/ieLCBBtkbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHrVU2wSGqErYYsn9ijJbBXie0qBmyERh/xUmnsXPLdfspBtkNToQy8fHsh4J8r+v
         U0SrDllxJyrh1cfiQGvJs1Wsb7m+Qic5OGTDcuTT9bSqKjmltxj5JGme7Uk2h008we
         tq2xSPWAaojTtm10gWGe5BvnN7oY2gNh/9s51QF4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 3/9] hfs: prevent btree data loss on root split
Date:   Tue, 13 Nov 2018 00:52:46 -0500
Message-Id: <20181113055252.79406-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055252.79406-1-sashal@kernel.org>
References: <20181113055252.79406-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit d057c036672f33d43a5f7344acbb08cf3a8a0c09 ]

This bug is triggered whenever hfs_brec_update_parent() needs to split
the root node.  The height of the btree is not increased, which leaves
the new node orphaned and its records lost.  It is not possible for this
to happen on a valid hfs filesystem because the index nodes have fixed
length keys.

For reasons I ignore, the hfs module does have support for a number of
hfsplus features.  A corrupt btree header may report variable length
keys and trigger this bug, so it's better to fix it.

Link: http://lkml.kernel.org/r/9750b1415685c4adca10766895f6d5ef12babdb0.1535682463.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/brec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 2a6f3c67cb3f..2e713673df42 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -424,6 +424,10 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	if (new_node) {
 		__be32 cnid;
 
+		if (!new_node->parent) {
+			hfs_btree_inc_height(tree);
+			new_node->parent = tree->root;
+		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key, 14);
-- 
2.17.1

