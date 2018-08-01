Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62975208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62975208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeHATpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:45:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405922AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E9D713D1;
        Wed,  1 Aug 2018 17:16:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 085/246] btrfs: qgroup: Finish rescan when hit the last leaf of extent tree
Date:   Wed,  1 Aug 2018 18:49:55 +0200
Message-Id: <20180801165015.794432322@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit ff3d27a048d926b3920ccdb75d98788c567cae0d ]

Under the following case, qgroup rescan can double account cowed tree
blocks:

In this case, extent tree only has one tree block.

-
| transid=5 last committed=4
| btrfs_qgroup_rescan_worker()
| |- btrfs_start_transaction()
| |  transid = 5
| |- qgroup_rescan_leaf()
|    |- btrfs_search_slot_for_read() on extent tree
|       Get the only extent tree block from commit root (transid = 4).
|       Scan it, set qgroup_rescan_progress to the last
|       EXTENT/META_ITEM + 1
|       now qgroup_rescan_progress = A + 1.
|
| fs tree get CoWed, new tree block is at A + 16K
| transid 5 get committed
-
| transid=6 last committed=5
| btrfs_qgroup_rescan_worker()
| btrfs_qgroup_rescan_worker()
| |- btrfs_start_transaction()
| |  transid = 5
| |- qgroup_rescan_leaf()
|    |- btrfs_search_slot_for_read() on extent tree
|       Get the only extent tree block from commit root (transid = 5).
|       scan it using qgroup_rescan_progress (A + 1).
|       found new tree block beyong A, and it's fs tree block,
|       account it to increase qgroup numbers.
-

In above case, tree block A, and tree block A + 16K get accounted twice,
while qgroup rescan should stop when it already reach the last leaf,
other than continue using its qgroup_rescan_progress.

Such case could happen by just looping btrfs/017 and with some
possibility it can hit such double qgroup accounting problem.

Fix it by checking the path to determine if we should finish qgroup
rescan, other than relying on next loop to exit.

Reported-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/qgroup.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2500,6 +2500,21 @@ out:
 }
 
 /*
+ * Check if the leaf is the last leaf. Which means all node pointers
+ * are at their last position.
+ */
+static bool is_last_leaf(struct btrfs_path *path)
+{
+	int i;
+
+	for (i = 1; i < BTRFS_MAX_LEVEL && path->nodes[i]; i++) {
+		if (path->slots[i] != btrfs_header_nritems(path->nodes[i]) - 1)
+			return false;
+	}
+	return true;
+}
+
+/*
  * returns < 0 on error, 0 when more leafs are to be scanned.
  * returns 1 when done.
  */
@@ -2512,6 +2527,7 @@ qgroup_rescan_leaf(struct btrfs_fs_info
 	struct ulist *roots = NULL;
 	struct seq_list tree_mod_seq_elem = SEQ_LIST_INIT(tree_mod_seq_elem);
 	u64 num_bytes;
+	bool done;
 	int slot;
 	int ret;
 
@@ -2540,6 +2556,7 @@ qgroup_rescan_leaf(struct btrfs_fs_info
 		mutex_unlock(&fs_info->qgroup_rescan_lock);
 		return ret;
 	}
+	done = is_last_leaf(path);
 
 	btrfs_item_key_to_cpu(path->nodes[0], &found,
 			      btrfs_header_nritems(path->nodes[0]) - 1);
@@ -2586,6 +2603,8 @@ out:
 	}
 	btrfs_put_tree_mod_seq(fs_info, &tree_mod_seq_elem);
 
+	if (done && !ret)
+		ret = 1;
 	return ret;
 }
 


