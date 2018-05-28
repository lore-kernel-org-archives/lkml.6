Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938429AbeE1L5g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423533AbeE1LII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Justin Maggard <jmaggard@netgear.com>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 093/272] btrfs: qgroup: Fix root item corruption when multiple same source snapshots are created with quota enabled
Date: Mon, 28 May 2018 12:02:06 +0200
Message-Id: <20180528100248.964280991@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 4d31778aa2fa342f5f92ca4025b293a1729161d1 ]

When multiple pending snapshots referring to the same source subvolume
are executed, enabled quota will cause root item corruption, where root
items are using old bytenr (no backref in extent tree).

This can be triggered by fstests btrfs/152.

The cause is when source subvolume is still dirty, extra commit
(simplied transaction commit) of qgroup_account_snapshot() can skip
dirty roots not recorded in current transaction, making root item of
source subvolume not updated.

Fix it by forcing recording source subvolume in current transaction
before qgroup sub-transaction commit.

Reported-by: Justin Maggard <jmaggard@netgear.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/transaction.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -319,7 +319,7 @@ static int record_root_in_trans(struct b
 	if ((test_bit(BTRFS_ROOT_REF_COWS, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
 		WARN_ON(root == fs_info->extent_root);
-		WARN_ON(root->commit_root != root->node);
+		WARN_ON(!force && root->commit_root != root->node);
 
 		/*
 		 * see below for IN_TRANS_SETUP usage rules
@@ -1366,6 +1366,14 @@ static int qgroup_account_snapshot(struc
 		return 0;
 
 	/*
+	 * Ensure dirty @src will be commited.  Or, after comming
+	 * commit_fs_roots() and switch_commit_roots(), any dirty but not
+	 * recorded root will never be updated again, causing an outdated root
+	 * item.
+	 */
+	record_root_in_trans(trans, src, 1);
+
+	/*
 	 * We are going to commit transaction, see btrfs_commit_transaction()
 	 * comment for reason locking tree_log_mutex
 	 */
