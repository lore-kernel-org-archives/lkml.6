Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeCOMfo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:35:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeCOMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:38 -0400
Message-Id: <20180315123202.577145977@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 05/11] sched/wait,btrfs: Replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-5.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

Cc: Chris Mason <clm@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/btrfs/extent-tree.c |   14 ++++++--------
 fs/btrfs/ioctl.c       |    2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3990,7 +3990,7 @@ void btrfs_dec_nocow_writers(struct btrf
 	bg = btrfs_lookup_block_group(fs_info, bytenr);
 	ASSERT(bg);
 	if (atomic_dec_and_test(&bg->nocow_writers))
-		wake_up_atomic_t(&bg->nocow_writers);
+		wake_up_var(&bg->nocow_writers);
 	/*
 	 * Once for our lookup and once for the lookup done by a previous call
 	 * to btrfs_inc_nocow_writers()
@@ -4001,8 +4001,7 @@ void btrfs_dec_nocow_writers(struct btrf
 
 void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg)
 {
-	wait_on_atomic_t(&bg->nocow_writers, atomic_t_wait,
-			 TASK_UNINTERRUPTIBLE);
+	wait_var_event(&bg->nocow_writers, !atomic_read(&bg->nocow_writers));
 }
 
 static const char *alloc_name(u64 flags)
@@ -6526,7 +6525,7 @@ void btrfs_dec_block_group_reservations(
 	bg = btrfs_lookup_block_group(fs_info, start);
 	ASSERT(bg);
 	if (atomic_dec_and_test(&bg->reservations))
-		wake_up_atomic_t(&bg->reservations);
+		wake_up_var(&bg->reservations);
 	btrfs_put_block_group(bg);
 }
 
@@ -6552,8 +6551,7 @@ void btrfs_wait_block_group_reservations
 	down_write(&space_info->groups_sem);
 	up_write(&space_info->groups_sem);
 
-	wait_on_atomic_t(&bg->reservations, atomic_t_wait,
-			 TASK_UNINTERRUPTIBLE);
+	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
 }
 
 /**
@@ -11061,7 +11059,7 @@ void btrfs_wait_for_snapshot_creation(st
 		ret = btrfs_start_write_no_snapshotting(root);
 		if (ret)
 			break;
-		wait_on_atomic_t(&root->will_be_snapshotted, atomic_t_wait,
-				 TASK_UNINTERRUPTIBLE);
+		wait_var_event(&root->will_be_snapshotted,
+			       !atomic_read(&root->will_be_snapshotted));
 	}
 }
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -723,7 +723,7 @@ static int create_snapshot(struct btrfs_
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
 	if (atomic_dec_and_test(&root->will_be_snapshotted))
-		wake_up_atomic_t(&root->will_be_snapshotted);
+		wake_up_var(&root->will_be_snapshotted);
 free_pending:
 	kfree(pending_snapshot->root_item);
 	btrfs_free_path(pending_snapshot->path);
