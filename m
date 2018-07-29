Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F96C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0320881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B0320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51646 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto7-0003Wi-FT; Sun, 29 Jul 2018 22:04:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 15/16] adfs: don't put inodes into icache
Date:   Sun, 29 Jul 2018 23:04:52 +0100
Message-Id: <20180729220453.13431-15-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We never look them up in there; inode_fake_hash() will make them appear
hashed for mark_inode_dirty() purposes.  And don't leave them around
until memory pressure kicks them out - we never look them up again.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/adfs/inode.c | 2 +-
 fs/adfs/super.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index c836c425ca94..e91028d4340a 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -287,7 +287,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 		ADFS_I(inode)->mmu_private = inode->i_size;
 	}
 
-	insert_inode_hash(inode);
+	inode_fake_hash(inode);
 
 out:
 	return inode;
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 71fa525d63a0..7e099a7a4eb1 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -291,6 +291,7 @@ static void destroy_inodecache(void)
 static const struct super_operations adfs_sops = {
 	.alloc_inode	= adfs_alloc_inode,
 	.destroy_inode	= adfs_destroy_inode,
+	.drop_inode	= generic_delete_inode,
 	.write_inode	= adfs_write_inode,
 	.put_super	= adfs_put_super,
 	.statfs		= adfs_statfs,
-- 
2.11.0

