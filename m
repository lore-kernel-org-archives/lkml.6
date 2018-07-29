Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE1C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3491120881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3491120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeG2XhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:37:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51626 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto7-0003WV-7f; Sun, 29 Jul 2018 22:04:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 13/16] btrfs: lift make_bad_inode() into btrfs_iget()
Date:   Sun, 29 Jul 2018 23:04:50 +0100
Message-Id: <20180729220453.13431-13-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we don't need to check is_bad_inode() after the call of
btrfs_read_locked_inode() - it's exactly the same as checking
return value for being non-zero.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9382e0881900..8f0b2592feb0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3777,7 +3777,6 @@ static int btrfs_read_locked_inode(struct inode *inode)
 
 make_bad:
 	btrfs_free_path(path);
-	make_bad_inode(inode);
 	return ret;
 }
 
@@ -5708,12 +5707,13 @@ struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
 		int ret;
 
 		ret = btrfs_read_locked_inode(inode);
-		if (!is_bad_inode(inode)) {
+		if (!ret) {
 			inode_tree_add(inode);
 			unlock_new_inode(inode);
 			if (new)
 				*new = 1;
 		} else {
+			make_bad_inode(inode);
 			unlock_new_inode(inode);
 			iput(inode);
 			ASSERT(ret < 0);
-- 
2.11.0

