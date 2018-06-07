Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U/GdBItGGVtTOAAAmS7hNA
	; Thu, 07 Jun 2018 14:51:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D6151608BF; Thu,  7 Jun 2018 14:51:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49629607E7;
	Thu,  7 Jun 2018 14:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49629607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935115AbeFGOv4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:51:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40760 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934148AbeFGOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:46:15 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbj-0005Zp-9L; Thu, 07 Jun 2018 15:09:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002yQ-8E; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Josef Bacik" <jbacik@fb.com>, "Liu Bo" <bo.li.liu@oracle.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.129921335@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 187/410] Btrfs: fix crash due to not cleaning up tree
 log block's dirty bits
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

commit 1846430c24d66e85cc58286b3319c82cd54debb2 upstream.

In cases that the whole fs flips into readonly status due to failures in
critical sections, then log tree's blocks are still dirty, and this leads
to a crash during umount time, the crash is about use-after-free,

umount
 -> close_ctree
    -> stop workers
    -> iput(btree_inode)
       -> iput_final
          -> write_inode_now
	     -> ...
	       -> queue job on stop'd workers

Fixes: 681ae50917df ("Btrfs: cleanup reserved space when freeing tree log on error")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/tree-log.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2197,6 +2197,9 @@ static noinline int walk_down_log_tree(s
 					clean_tree_block(trans, root, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner !=
@@ -2275,6 +2278,9 @@ static noinline int walk_up_log_tree(str
 					clean_tree_block(trans, root, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
@@ -2351,6 +2357,9 @@ static int walk_log_tree(struct btrfs_tr
 				clean_tree_block(trans, log, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+			} else {
+				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+					clear_extent_buffer_dirty(next);
 			}
 
 			WARN_ON(log->root_key.objectid !=
