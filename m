Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66674ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231DE208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231DE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeIXRjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:39:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXRi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2A9081060;
        Mon, 24 Sep 2018 11:37:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 025/105] btrfs: Dont remove block group that still has pinned down bytes
Date:   Mon, 24 Sep 2018 13:33:11 +0200
Message-Id: <20180924113116.229255608@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 43794446548730ac8461be30bbe47d5d027d1d16 ]

[BUG]
Under certain KVM load and LTP tests, it is possible to hit the
following calltrace if quota is enabled:

BTRFS critical (device vda2): unable to find logical 8820195328 length 4096
BTRFS critical (device vda2): unable to find logical 8820195328 length 4096

WARNING: CPU: 0 PID: 49 at ../block/blk-core.c:172 blk_status_to_errno+0x1a/0x30
CPU: 0 PID: 49 Comm: kworker/u2:1 Not tainted 4.12.14-15-default #1 SLE15 (unreleased)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
task: ffff9f827b340bc0 task.stack: ffffb4f8c0304000
RIP: 0010:blk_status_to_errno+0x1a/0x30
Call Trace:
 submit_extent_page+0x191/0x270 [btrfs]
 ? btrfs_create_repair_bio+0x130/0x130 [btrfs]
 __do_readpage+0x2d2/0x810 [btrfs]
 ? btrfs_create_repair_bio+0x130/0x130 [btrfs]
 ? run_one_async_done+0xc0/0xc0 [btrfs]
 __extent_read_full_page+0xe7/0x100 [btrfs]
 ? run_one_async_done+0xc0/0xc0 [btrfs]
 read_extent_buffer_pages+0x1ab/0x2d0 [btrfs]
 ? run_one_async_done+0xc0/0xc0 [btrfs]
 btree_read_extent_buffer_pages+0x94/0xf0 [btrfs]
 read_tree_block+0x31/0x60 [btrfs]
 read_block_for_search.isra.35+0xf0/0x2e0 [btrfs]
 btrfs_search_slot+0x46b/0xa00 [btrfs]
 ? kmem_cache_alloc+0x1a8/0x510
 ? btrfs_get_token_32+0x5b/0x120 [btrfs]
 find_parent_nodes+0x11d/0xeb0 [btrfs]
 ? leaf_space_used+0xb8/0xd0 [btrfs]
 ? btrfs_leaf_free_space+0x49/0x90 [btrfs]
 ? btrfs_find_all_roots_safe+0x93/0x100 [btrfs]
 btrfs_find_all_roots_safe+0x93/0x100 [btrfs]
 btrfs_find_all_roots+0x45/0x60 [btrfs]
 btrfs_qgroup_trace_extent_post+0x20/0x40 [btrfs]
 btrfs_add_delayed_data_ref+0x1a3/0x1d0 [btrfs]
 btrfs_alloc_reserved_file_extent+0x38/0x40 [btrfs]
 insert_reserved_file_extent.constprop.71+0x289/0x2e0 [btrfs]
 btrfs_finish_ordered_io+0x2f4/0x7f0 [btrfs]
 ? pick_next_task_fair+0x2cd/0x530
 ? __switch_to+0x92/0x4b0
 btrfs_worker_helper+0x81/0x300 [btrfs]
 process_one_work+0x1da/0x3f0
 worker_thread+0x2b/0x3f0
 ? process_one_work+0x3f0/0x3f0
 kthread+0x11a/0x130
 ? kthread_create_on_node+0x40/0x40
 ret_from_fork+0x35/0x40

BTRFS critical (device vda2): unable to find logical 8820195328 length 16384
BTRFS: error (device vda2) in btrfs_finish_ordered_io:3023: errno=-5 IO failure
BTRFS info (device vda2): forced readonly
BTRFS error (device vda2): pending csums is 2887680

[CAUSE]
It's caused by race with block group auto removal:

- There is a meta block group X, which has only one tree block
  The tree block belongs to fs tree 257.
- In current transaction, some operation modified fs tree 257
  The tree block gets COWed, so the block group X is empty, and marked
  as unused, queued to be deleted.
- Some workload (like fsync) wakes up cleaner_kthread()
  Which will call btrfs_delete_unused_bgs() to remove unused block
  groups.
  So block group X along its chunk map get removed.
- Some delalloc work finished for fs tree 257
  Quota needs to get the original reference of the extent, which will
  read tree blocks of commit root of 257.
  Then since the chunk map gets removed, the above warning gets
  triggered.

[FIX]
Just let btrfs_delete_unused_bgs() skip block group which still has
pinned bytes.

However there is a minor side effect: currently we only queue empty
blocks at update_block_group(), and such empty block group with pinned
bytes won't go through update_block_group() again, such block group
won't be removed, until it gets new extent allocated and removed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9487,7 +9487,7 @@ void btrfs_delete_unused_bgs(struct btrf
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 		spin_lock(&block_group->lock);
-		if (block_group->reserved ||
+		if (block_group->reserved || block_group->pinned ||
 		    btrfs_block_group_used(&block_group->item) ||
 		    block_group->ro) {
 			/*


