Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1786F20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7+PTjhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1786F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbeKLIVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389835AbeKLIVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:40 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77405224B3;
        Sun, 11 Nov 2018 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975503;
        bh=iK9BWGYwtqke/MPc+zbixiaG++v0UvK7luZd8XYCJus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7+PTjhMr6kdWGCY2ElkCMODb/XPgklWnJeQ+dsUgNOY5F1pmIEBHmKz+ys7C0hCu
         aBVC8jk9ewruNHgRZHljfuvaZXdXS6ublyI5k/j5xmPJNXyr+vnrzH2WVinldo5EGc
         49VK5CSxgE3FBqqOhY1WYTtrjGVe8dG1ojcy4I5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 320/350] btrfs: fix error handling in free_log_tree
Date:   Sun, 11 Nov 2018 14:23:04 -0800
Message-Id: <20181111221721.453378857@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Jeff Mahoney <jeffm@suse.com>

commit 374b0e2d6ba5da7fd1cadb3247731ff27d011f6f upstream.

When we hit an I/O error in free_log_tree->walk_log_tree during file system
shutdown we can crash due to there not being a valid transaction handle.

Use btrfs_handle_fs_error when there's no transaction handle to use.

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000060
  IP: free_log_tree+0xd2/0x140 [btrfs]
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
  Modules linked in: <modules>
  CPU: 2 PID: 23544 Comm: umount Tainted: G        W        4.12.14-kvmsmall #9 SLE15 (unreleased)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
  task: ffff96bfd3478880 task.stack: ffffa7cf40d78000
  RIP: 0010:free_log_tree+0xd2/0x140 [btrfs]
  RSP: 0018:ffffa7cf40d7bd10 EFLAGS: 00010282
  RAX: 00000000fffffffb RBX: 00000000fffffffb RCX: 0000000000000002
  RDX: 0000000000000000 RSI: ffff96c02f07d4c8 RDI: 0000000000000282
  RBP: ffff96c013cf1000 R08: ffff96c02f07d4c8 R09: ffff96c02f07d4d0
  R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
  R13: ffff96c005e800c0 R14: ffffa7cf40d7bdb8 R15: 0000000000000000
  FS:  00007f17856bcfc0(0000) GS:ffff96c03f600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000060 CR3: 0000000045ed6002 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   ? wait_for_writer+0xb0/0xb0 [btrfs]
   btrfs_free_log+0x17/0x30 [btrfs]
   btrfs_drop_and_free_fs_root+0x9a/0xe0 [btrfs]
   btrfs_free_fs_roots+0xc0/0x130 [btrfs]
   ? wait_for_completion+0xf2/0x100
   close_ctree+0xea/0x2e0 [btrfs]
   ? kthread_stop+0x161/0x260
   generic_shutdown_super+0x6c/0x120
   kill_anon_super+0xe/0x20
   btrfs_kill_super+0x13/0x100 [btrfs]
   deactivate_locked_super+0x3f/0x70
   cleanup_mnt+0x3b/0x70
   task_work_run+0x78/0x90
   exit_to_usermode_loop+0x77/0xa6
   do_syscall_64+0x1c5/0x1e0
   entry_SYSCALL_64_after_hwframe+0x42/0xb7
  RIP: 0033:0x7f1784f90827
  RSP: 002b:00007ffdeeb03118 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
  RAX: 0000000000000000 RBX: 0000556a60c62970 RCX: 00007f1784f90827
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000556a60c62b50
  RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000ffffffff
  R10: 0000556a60c63900 R11: 0000000000000246 R12: 0000556a60c62b50
  R13: 00007f17854a81c4 R14: 0000000000000000 R15: 0000000000000000
  RIP: free_log_tree+0xd2/0x140 [btrfs] RSP: ffffa7cf40d7bd10
  CR2: 0000000000000060

Fixes: 681ae50917df9 ("Btrfs: cleanup reserved space when freeing tree log on error")
CC: <stable@vger.kernel.org> # v3.13
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3209,9 +3209,12 @@ static void free_log_tree(struct btrfs_t
 	};
 
 	ret = walk_log_tree(trans, log, &wc);
-	/* I don't think this can happen but just in case */
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
+	if (ret) {
+		if (trans)
+			btrfs_abort_transaction(trans, ret);
+		else
+			btrfs_handle_fs_error(log->fs_info, ret, NULL);
+	}
 
 	while (1) {
 		ret = find_first_extent_bit(&log->dirty_log_pages,


