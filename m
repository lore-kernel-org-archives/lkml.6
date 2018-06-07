Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rhswIP5IGVuGTAAAmS7hNA
	; Thu, 07 Jun 2018 15:04:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB55B608BF; Thu,  7 Jun 2018 15:04:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F2DF601C3;
	Thu,  7 Jun 2018 15:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F2DF601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936014AbeFGPD7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:03:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41545 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935962AbeFGPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:53 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zj-97; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002ya-BS; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Josef Bacik" <jbacik@fb.com>,
        "Liu Bo" <bo.li.liu@oracle.com>, "David Sterba" <dsterba@suse.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.97244826@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 189/410] Btrfs: fix use-after-free on root->orphan_block_rsv
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 1a932ef4e47984dee227834667b5ff5a334e4805 upstream.

I got these from running generic/475,

WARNING: CPU: 0 PID: 26384 at fs/btrfs/inode.c:3326 btrfs_orphan_commit_root+0x1ac/0x2b0 [btrfs]
BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
IP: btrfs_block_rsv_release+0x1c/0x70 [btrfs]
Call Trace:
  btrfs_orphan_release_metadata+0x9f/0x200 [btrfs]
  btrfs_orphan_del+0x10d/0x170 [btrfs]
  btrfs_setattr+0x500/0x640 [btrfs]
  notify_change+0x7ae/0x870
  do_truncate+0xca/0x130
  vfs_truncate+0x2ee/0x3d0
  do_sys_truncate+0xaf/0xf0
  SyS_truncate+0xe/0x10
  entry_SYSCALL_64_fastpath+0x1f/0x96

The race is between btrfs_orphan_commit_root and btrfs_orphan_del,
        t1                                        t2
btrfs_orphan_commit_root                     btrfs_orphan_del
   spin_lock
   check (&root->orphan_inodes)
   root->orphan_block_rsv = NULL;
   spin_unlock
                                             atomic_dec(&root->orphan_inodes);
                                             access root->orphan_block_rsv

Accessing root->orphan_block_rsv must be done before decreasing
root->orphan_inodes.

Fixes: 703c88e03524 ("Btrfs: fix tracking of orphan inode count")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: Drop the added comment in a path that's
 unreachable here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3082,12 +3082,17 @@ int btrfs_orphan_add(struct btrfs_trans_
 	if (insert >= 1) {
 		ret = btrfs_insert_orphan_item(trans, root, btrfs_ino(inode));
 		if (ret) {
-			atomic_dec(&root->orphan_inodes);
 			if (reserve) {
 				clear_bit(BTRFS_INODE_ORPHAN_META_RESERVED,
 					  &BTRFS_I(inode)->runtime_flags);
 				btrfs_orphan_release_metadata(inode);
 			}
+			/*
+			 * btrfs_orphan_commit_root may race with us and set
+			 * ->orphan_block_rsv to zero, in order to avoid that,
+			 * decrease ->orphan_inodes after everything is done.
+			 */
+			atomic_dec(&root->orphan_inodes);
 			if (ret != -EEXIST) {
 				clear_bit(BTRFS_INODE_HAS_ORPHAN_ITEM,
 					  &BTRFS_I(inode)->runtime_flags);
@@ -3119,28 +3124,26 @@ static int btrfs_orphan_del(struct btrfs
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int delete_item = 0;
-	int release_rsv = 0;
 	int ret = 0;
 
-	spin_lock(&root->orphan_lock);
 	if (test_and_clear_bit(BTRFS_INODE_HAS_ORPHAN_ITEM,
 			       &BTRFS_I(inode)->runtime_flags))
 		delete_item = 1;
 
+	if (delete_item && trans)
+		ret = btrfs_del_orphan_item(trans, root, btrfs_ino(inode));
+
 	if (test_and_clear_bit(BTRFS_INODE_ORPHAN_META_RESERVED,
 			       &BTRFS_I(inode)->runtime_flags))
-		release_rsv = 1;
-	spin_unlock(&root->orphan_lock);
+		btrfs_orphan_release_metadata(inode);
 
-	if (delete_item) {
+	/*
+	 * btrfs_orphan_commit_root may race with us and set ->orphan_block_rsv
+	 * to zero, in order to avoid that, decrease ->orphan_inodes after
+	 * everything is done.
+	 */
+	if (delete_item)
 		atomic_dec(&root->orphan_inodes);
-		if (trans)
-			ret = btrfs_del_orphan_item(trans, root,
-						    btrfs_ino(inode));
-	}
-
-	if (release_rsv)
-		btrfs_orphan_release_metadata(inode);
 
 	return ret;
 }
