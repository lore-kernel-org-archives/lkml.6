Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqZLGmfR+KppEULEJ31d13bJtvdEn9VCZEtFTkeH8pAPy2tXIZQqH/gbnil6/GxnaE5dTqM
ARC-Seal: i=1; a=rsa-sha256; t=1526937567; cv=none;
        d=google.com; s=arc-20160816;
        b=etPP+G3e/r0pOPA57IJSmNRYuI3/RMhWW7qp3Nj6rfegvaOKcZW9NS7WJQB+RCNt/L
         gnPkbKm0pDMa8yRNXRFjMffElQSzaHEaL2kJ6g2fTLX5S3Y5GstztbJIroDZLWgOt3xy
         VcdLz9LWQRbzw+ElN2P81jGZUL4mKGCtRKMdhv+yMzFMk2/ITge3PIQwRsfnJn21e5ch
         J6gWy0THQwoWH8TZ3PC2WLb+2TJ6xSpkHPGEtE1ZEGXOam8F33YEpez4nK6dLGZrVPyh
         5vWQI7FFL+TzC8LCPDwlso+TA7TZW1KSLa3JnzsnHkn+c8vUZ8SGcnQ0s7i/qAj++DFK
         4qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SmhG9yVRqxg8sy66/tT1nwdVUOhKW9oZRUK19it91z0=;
        b=PFWn8ZlnU9VJY6cGzNRubbqIyWwbpAAGV1niq6Mr2nyQCL2hvW2fz7OGZfrDo6XeeT
         HbM/dklqiaZWFq99CaohKx0IAwvkmk9SLFsA+UWFp7GXrwmgUJZHcIm3Fw6a+naMvFP4
         nLNg7imNMr4n9YhbRZrOwvplcjppuiVxFcCNK12dYJFKvcFayolGXH06qtsERy9qHa7s
         lLvi05ZHfBS5rCtVwblkyQzi/n+yetYHP2U8MaSujf4GT18kYn8HqxBWDArk6ShlsUNN
         XbY4i0Bks32GK9q6kUMgW5eDxoINQUam8voDcEAUnWLuVV9/O/S6ON1m27WNfa/u5QdK
         OOWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cme/q8Up;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cme/q8Up;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 42/95] Btrfs: send, fix invalid access to commit roots due to concurrent snapshotting
Date: Mon, 21 May 2018 23:11:32 +0200
Message-Id: <20180521210456.634748797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110087056186967?=
X-GMAIL-MSGID: =?utf-8?q?1601110087056186967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robbie Ko <robbieko@synology.com>

commit 6f2f0b394b54e2b159ef969a0b5274e9bbf82ff2 upstream.

[BUG]
btrfs incremental send BUG happens when creating a snapshot of snapshot
that is being used by send.

[REASON]
The problem can happen if while we are doing a send one of the snapshots
used (parent or send) is snapshotted, because snapshoting implies COWing
the root of the source subvolume/snapshot.

1. When doing an incremental send, the send process will get the commit
   roots from the parent and send snapshots, and add references to them
   through extent_buffer_get().

2. When a snapshot/subvolume is snapshotted, its root node is COWed
   (transaction.c:create_pending_snapshot()).

3. COWing releases the space used by the node immediately, through:

   __btrfs_cow_block()
   --btrfs_free_tree_block()
   ----btrfs_add_free_space(bytenr of node)

4. Because send doesn't hold a transaction open, it's possible that
   the transaction used to create the snapshot commits, switches the
   commit root and the old space used by the previous root node gets
   assigned to some other node allocation. Allocation of a new node will
   use the existing extent buffer found in memory, which we previously
   got a reference through extent_buffer_get(), and allow the extent
   buffer's content (pages) to be modified:

   btrfs_alloc_tree_block
   --btrfs_reserve_extent
   ----find_free_extent (get bytenr of old node)
   --btrfs_init_new_buffer (use bytenr of old node)
   ----btrfs_find_create_tree_block
   ------alloc_extent_buffer
   --------find_extent_buffer (get old node)

5. So send can access invalid memory content and have unpredictable
   behaviour.

[FIX]
So we fix the problem by copying the commit roots of the send and
parent snapshots and use those copies.

CallTrace looks like this:
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.c:1861!
 invalid opcode: 0000 [#1] SMP
 CPU: 6 PID: 24235 Comm: btrfs Tainted: P           O 3.10.105 #23721
 ffff88046652d680 ti: ffff88041b720000 task.ti: ffff88041b720000
 RIP: 0010:[<ffffffffa08dd0e8>] read_node_slot+0x108/0x110 [btrfs]
 RSP: 0018:ffff88041b723b68  EFLAGS: 00010246
 RAX: ffff88043ca6b000 RBX: ffff88041b723c50 RCX: ffff880000000000
 RDX: 000000000000004c RSI: ffff880314b133f8 RDI: ffff880458b24000
 RBP: 0000000000000000 R08: 0000000000000001 R09: ffff88041b723c66
 R10: 0000000000000001 R11: 0000000000001000 R12: ffff8803f3e48890
 R13: ffff8803f3e48880 R14: ffff880466351800 R15: 0000000000000001
 FS:  00007f8c321dc8c0(0000) GS:ffff88047fcc0000(0000)
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 R2: 00007efd1006d000 CR3: 0000000213a24000 CR4: 00000000003407e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Stack:
 ffff88041b723c50 ffff8803f3e48880 ffff8803f3e48890 ffff8803f3e48880
 ffff880466351800 0000000000000001 ffffffffa08dd9d7 ffff88041b723c50
 ffff8803f3e48880 ffff88041b723c66 ffffffffa08dde85 a9ff88042d2c4400
 Call Trace:
 [<ffffffffa08dd9d7>] ? tree_move_down.isra.33+0x27/0x50 [btrfs]
 [<ffffffffa08dde85>] ? tree_advance+0xb5/0xc0 [btrfs]
 [<ffffffffa08e83d4>] ? btrfs_compare_trees+0x2d4/0x760 [btrfs]
 [<ffffffffa0982050>] ? finish_inode_if_needed+0x870/0x870 [btrfs]
 [<ffffffffa09841ea>] ? btrfs_ioctl_send+0xeda/0x1050 [btrfs]
 [<ffffffffa094bd3d>] ? btrfs_ioctl+0x1e3d/0x33f0 [btrfs]
 [<ffffffff81111133>] ? handle_pte_fault+0x373/0x990
 [<ffffffff8153a096>] ? atomic_notifier_call_chain+0x16/0x20
 [<ffffffff81063256>] ? set_task_cpu+0xb6/0x1d0
 [<ffffffff811122c3>] ? handle_mm_fault+0x143/0x2a0
 [<ffffffff81539cc0>] ? __do_page_fault+0x1d0/0x500
 [<ffffffff81062f07>] ? check_preempt_curr+0x57/0x90
 [<ffffffff8115075a>] ? do_vfs_ioctl+0x4aa/0x990
 [<ffffffff81034f83>] ? do_fork+0x113/0x3b0
 [<ffffffff812dd7d7>] ? trace_hardirqs_off_thunk+0x3a/0x6c
 [<ffffffff81150cc8>] ? SyS_ioctl+0x88/0xa0
 [<ffffffff8153e422>] ? system_call_fastpath+0x16/0x1b
 ---[ end trace 29576629ee80b2e1 ]---

Fixes: 7069830a9e38 ("Btrfs: add btrfs_compare_trees function")
CC: stable@vger.kernel.org # 3.6+
Signed-off-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5454,12 +5454,24 @@ int btrfs_compare_trees(struct btrfs_roo
 	down_read(&fs_info->commit_root_sem);
 	left_level = btrfs_header_level(left_root->commit_root);
 	left_root_level = left_level;
-	left_path->nodes[left_level] = left_root->commit_root;
+	left_path->nodes[left_level] =
+			btrfs_clone_extent_buffer(left_root->commit_root);
+	if (!left_path->nodes[left_level]) {
+		up_read(&fs_info->commit_root_sem);
+		ret = -ENOMEM;
+		goto out;
+	}
 	extent_buffer_get(left_path->nodes[left_level]);
 
 	right_level = btrfs_header_level(right_root->commit_root);
 	right_root_level = right_level;
-	right_path->nodes[right_level] = right_root->commit_root;
+	right_path->nodes[right_level] =
+			btrfs_clone_extent_buffer(right_root->commit_root);
+	if (!right_path->nodes[right_level]) {
+		up_read(&fs_info->commit_root_sem);
+		ret = -ENOMEM;
+		goto out;
+	}
 	extent_buffer_get(right_path->nodes[right_level]);
 	up_read(&fs_info->commit_root_sem);
 
