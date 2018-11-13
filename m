Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A76C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CED22510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcH7m4fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CED22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeKMPsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732580AbeKMPsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:31 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0802422512;
        Tue, 13 Nov 2018 05:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088324;
        bh=aZ44YYUIpSqiy+YcR9z+AlOWsiug84F1Zyu+IX9GZCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcH7m4fA7oeq7WN8B029mGRT4k1nbxTWuTffGG5Nv/cmw2M4kplDFSqJ/sMajksF0
         WhkLO3e+zqUGa4jdvdsr9V5TEvVRSsISiKUePcW5BPBwU/kP4x5y8GH1BIcAUHDO80
         o4xBzDognqw9qzaOIUoQLxso6bJwR1LdkB33YU7I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/26] hfs: prevent btree data loss on root split
Date:   Tue, 13 Nov 2018 00:51:34 -0500
Message-Id: <20181113055150.78773-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
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

