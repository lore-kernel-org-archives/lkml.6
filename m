Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA99ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322B92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322B92146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeIREhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:59 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E9E96C49;
        Mon, 17 Sep 2018 23:07:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 019/158] btrfs: fix qgroup_free wrong num_bytes in btrfs_subvolume_reserve_metadata
Date:   Tue, 18 Sep 2018 00:40:49 +0200
Message-Id: <20180917211711.708123020@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

commit a5b7f4295eeae8b05ca91f6d145cd8773b08de9e upstream.

After btrfs_qgroup_reserve_meta_prealloc(), num_bytes will be assigned
again by btrfs_calc_trans_metadata_size(). Once block_rsv fails, we
can't properly free the num_bytes of the previous qgroup_reserve. Use a
separate variable to store the num_bytes of the qgroup_reserve.

Delete the comment for the qgroup_reserved that does not exist and add a
comment about use_global_rsv.

Fixes: c4c129db5da8 ("btrfs: drop unused parameter qgroup_reserved")
CC: stable@vger.kernel.org # 4.18+
Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5935,7 +5935,7 @@ void btrfs_trans_release_chunk_metadata(
  * root: the root of the parent directory
  * rsv: block reservation
  * items: the number of items that we need do reservation
- * qgroup_reserved: used to return the reserved size in qgroup
+ * use_global_rsv: allow fallback to the global block reservation
  *
  * This function is used to reserve the space for snapshot/subvolume
  * creation and deletion. Those operations are different with the
@@ -5945,10 +5945,10 @@ void btrfs_trans_release_chunk_metadata(
  * the space reservation mechanism in start_transaction().
  */
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
-				     struct btrfs_block_rsv *rsv,
-				     int items,
+				     struct btrfs_block_rsv *rsv, int items,
 				     bool use_global_rsv)
 {
+	u64 qgroup_num_bytes = 0;
 	u64 num_bytes;
 	int ret;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -5956,12 +5956,11 @@ int btrfs_subvolume_reserve_metadata(str
 
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
 		/* One for parent inode, two for dir entries */
-		num_bytes = 3 * fs_info->nodesize;
-		ret = btrfs_qgroup_reserve_meta_prealloc(root, num_bytes, true);
+		qgroup_num_bytes = 3 * fs_info->nodesize;
+		ret = btrfs_qgroup_reserve_meta_prealloc(root,
+				qgroup_num_bytes, true);
 		if (ret)
 			return ret;
-	} else {
-		num_bytes = 0;
 	}
 
 	num_bytes = btrfs_calc_trans_metadata_size(fs_info, items);
@@ -5973,8 +5972,8 @@ int btrfs_subvolume_reserve_metadata(str
 	if (ret == -ENOSPC && use_global_rsv)
 		ret = btrfs_block_rsv_migrate(global_rsv, rsv, num_bytes, 1);
 
-	if (ret && num_bytes)
-		btrfs_qgroup_free_meta_prealloc(root, num_bytes);
+	if (ret && qgroup_num_bytes)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_num_bytes);
 
 	return ret;
 }


