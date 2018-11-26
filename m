Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAD_ENC_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7EE21479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aziKDl5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7EE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeKZVva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668752089F;
        Mon, 26 Nov 2018 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229864;
        bh=7Hd6Dt3DmAdCdfbq7TCO/RreanY7vlWNxc6udsB/ETw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aziKDl5J/RRl7WBLiYLvmwTOAtvM+l8PHovLOtKucMFCO/nAT/3C4njJBtRCoT65k
         0I6SZXAuutSBdZSg4ZMAjAtf78X4hQiIfui9CrKFhaqSs+lViTLKnRgtFNBIvap+Tj
         BarPxoxMpexiG6X+FlJtEdjItXlqWJxEs6e8Cqbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/46] hfs: prevent btree data loss on root split
Date:   Mon, 26 Nov 2018 11:50:52 +0100
Message-Id: <20181126105045.966457422@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -424,6 +424,10 @@ skip:
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



