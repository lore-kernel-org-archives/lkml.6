Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD5C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2066720881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2066720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbeG2XiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:38:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51618 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003Vy-O7; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH 09/16] btrfs: IS_ERR(p) && PTR_ERR(p) == n is a weird way to spell p == ERR_PTR(n)
Date:   Sun, 29 Jul 2018 23:04:46 +0100
Message-Id: <20180729220453.13431-9-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Cc: Chris Mason <clm@fb.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/tree-log.c    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ff5f6c719976..feb0348dbcbf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -680,7 +680,7 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
 				  BTRFS_RESERVE_NO_FLUSH, true);
-	if (IS_ERR(trans) && PTR_ERR(trans) == -ENOENT)
+	if (trans == ERR_PTR(-ENOENT))
 		btrfs_wait_for_commit(root->fs_info, 0);
 
 	return trans;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fcfbe1d8584a..2c13e8155ff1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2116,7 +2116,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 						     dir_key->offset,
 						     name, name_len, 0);
 		}
-		if (!log_di || (IS_ERR(log_di) && PTR_ERR(log_di) == -ENOENT)) {
+		if (!log_di || log_di ==  ERR_PTR(-ENOENT)) {
 			btrfs_dir_item_key_to_cpu(eb, di, &location);
 			btrfs_release_path(path);
 			btrfs_release_path(log_path);
@@ -5090,8 +5090,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 				 * we don't need to do more work nor fallback to
 				 * a transaction commit.
 				 */
-				if (IS_ERR(other_inode) &&
-				    PTR_ERR(other_inode) == -ENOENT) {
+				if (other_inode == ERR_PTR(-ENOENT)) {
 					goto next_key;
 				} else if (IS_ERR(other_inode)) {
 					err = PTR_ERR(other_inode);
-- 
2.11.0

