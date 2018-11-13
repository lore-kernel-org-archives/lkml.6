Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B69C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A623E2251B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs5wYNjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A623E2251B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeKMPrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732103AbeKMPrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:45 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A6522510;
        Tue, 13 Nov 2018 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088278;
        bh=aZ44YYUIpSqiy+YcR9z+AlOWsiug84F1Zyu+IX9GZCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs5wYNjIEdv/HHQm8udimKguQKk/T2ridFP8BzJm7GbLJxDQ8ngy92BHerqR1rKz6
         cClCPTak+Ah3SjgWiTNRSo+7xAeZw8YNYMvEcqcZNXfvRzeWEjKghILOP8xeF8+7Ii
         RbZgY+X7/5HOCzOqCxMwpfharZHnyGY+8h20uevQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 14/39] hfs: prevent btree data loss on root split
Date:   Tue, 13 Nov 2018 00:50:28 -0500
Message-Id: <20181113055053.78352-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
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
index 9a8772465a90..da25c49203cc 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -425,6 +425,10 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
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

