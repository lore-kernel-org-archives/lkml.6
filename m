Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C85C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFE020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078474;
	bh=kgTi+vBILklAivvXOwY8MUPZy8DpvwjUrwujyhYQAb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eoe+ipuuHmy/q9dsZKEZ4t9ADR+7Z7I+panzf//lD4dHLsbHEB2yxlrzIyJwdroU+
	 TghYiSmXEN1uVlyS/gIfABtrDRpCv8FEAA/m8MW50sZJj8bWkR40hpXQmATvbrM4QX
	 PmNbkGSmp7a0L97Cg1UiJhUmLLv5xG4NkiVVWeKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfAUNrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbfAUNrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5FC20870;
        Mon, 21 Jan 2019 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078470;
        bh=kgTi+vBILklAivvXOwY8MUPZy8DpvwjUrwujyhYQAb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5WMk9Jlu/8mAGeDFabEzvpvcVIUobzZ7Ddu/X52iubwkfZHxta1kAebUZMGX5Qpx
         H9mnXL3x/D9kp2cxB/qx8RGUeY5PX3NVe735KQBA6O51I8a307vGp91DfPB4IP/wkY
         bJSruPImIiTe1k+JxGlccpAH0Kl53H+A2p/CKIxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.20 042/111] btrfs: wait on ordered extents on abort cleanup
Date:   Mon, 21 Jan 2019 14:42:36 +0100
Message-Id: <20190121122500.472348151@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 74d5d229b1bf60f93bff244b2dfc0eb21ec32a07 upstream.

If we flip read-only before we initiate writeback on all dirty pages for
ordered extents we've created then we'll have ordered extents left over
on umount, which results in all sorts of bad things happening.  Fix this
by making sure we wait on ordered extents if we have to do the aborted
transaction cleanup stuff.

generic/475 can produce this warning:

 [ 8531.177332] WARNING: CPU: 2 PID: 11997 at fs/btrfs/disk-io.c:3856 btrfs_free_fs_root+0x95/0xa0 [btrfs]
 [ 8531.183282] CPU: 2 PID: 11997 Comm: umount Tainted: G        W 5.0.0-rc1-default+ #394
 [ 8531.185164] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS rel-1.11.2-0-gf9626cc-prebuilt.qemu-project.org 04/01/2014
 [ 8531.187851] RIP: 0010:btrfs_free_fs_root+0x95/0xa0 [btrfs]
 [ 8531.193082] RSP: 0018:ffffb1ab86163d98 EFLAGS: 00010286
 [ 8531.194198] RAX: ffff9f3449494d18 RBX: ffff9f34a2695000 RCX:0000000000000000
 [ 8531.195629] RDX: 0000000000000002 RSI: 0000000000000001 RDI:0000000000000000
 [ 8531.197315] RBP: ffff9f344e930000 R08: 0000000000000001 R09:0000000000000000
 [ 8531.199095] R10: 0000000000000000 R11: ffff9f34494d4ff8 R12:ffffb1ab86163dc0
 [ 8531.200870] R13: ffff9f344e9300b0 R14: ffffb1ab86163db8 R15:0000000000000000
 [ 8531.202707] FS:  00007fc68e949fc0(0000) GS:ffff9f34bd800000(0000)knlGS:0000000000000000
 [ 8531.204851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 8531.205942] CR2: 00007ffde8114dd8 CR3: 000000002dfbd000 CR4:00000000000006e0
 [ 8531.207516] Call Trace:
 [ 8531.208175]  btrfs_free_fs_roots+0xdb/0x170 [btrfs]
 [ 8531.210209]  ? wait_for_completion+0x5b/0x190
 [ 8531.211303]  close_ctree+0x157/0x350 [btrfs]
 [ 8531.212412]  generic_shutdown_super+0x64/0x100
 [ 8531.213485]  kill_anon_super+0x14/0x30
 [ 8531.214430]  btrfs_kill_super+0x12/0xa0 [btrfs]
 [ 8531.215539]  deactivate_locked_super+0x29/0x60
 [ 8531.216633]  cleanup_mnt+0x3b/0x70
 [ 8531.217497]  task_work_run+0x98/0xc0
 [ 8531.218397]  exit_to_usermode_loop+0x83/0x90
 [ 8531.219324]  do_syscall_64+0x15b/0x180
 [ 8531.220192]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 [ 8531.221286] RIP: 0033:0x7fc68e5e4d07
 [ 8531.225621] RSP: 002b:00007ffde8116608 EFLAGS: 00000246 ORIG_RAX:00000000000000a6
 [ 8531.227512] RAX: 0000000000000000 RBX: 00005580c2175970 RCX:00007fc68e5e4d07
 [ 8531.229098] RDX: 0000000000000001 RSI: 0000000000000000 RDI:00005580c2175b80
 [ 8531.230730] RBP: 0000000000000000 R08: 00005580c2175ba0 R09:00007ffde8114e80
 [ 8531.232269] R10: 0000000000000000 R11: 0000000000000246 R12:00005580c2175b80
 [ 8531.233839] R13: 00007fc68eac61c4 R14: 00005580c2175a68 R15:0000000000000000

Leaving a tree in the rb-tree:

3853 void btrfs_free_fs_root(struct btrfs_root *root)
3854 {
3855         iput(root->ino_cache_inode);
3856         WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));

CC: stable@vger.kernel.org
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ add stacktrace ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4155,6 +4155,14 @@ static void btrfs_destroy_all_ordered_ex
 		spin_lock(&fs_info->ordered_root_lock);
 	}
 	spin_unlock(&fs_info->ordered_root_lock);
+
+	/*
+	 * We need this here because if we've been flipped read-only we won't
+	 * get sync() from the umount, so we need to make sure any ordered
+	 * extents that haven't had their dirty pages IO start writeout yet
+	 * actually get run and error out properly.
+	 */
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 }
 
 static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,


