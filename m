Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167CDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE56420815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfBCOBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:01:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53228 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbfBCNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:49 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-0003tv-6R; Sun, 03 Feb 2019 13:49:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006vI-2b; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Sterba" <dsterba@suse.com>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Omar Sandoval" <osandov@fb.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.766938046@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 083/305] btrfs: wait on caching when putting the bg cache
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 3aa7c7a31c26321696b92841d5103461c6f3f517 upstream.

While testing my backport I noticed there was a panic if I ran
generic/416 generic/417 generic/418 all in a row.  This just happened to
uncover a race where we had outstanding IO after we destroy all of our
workqueues, and then we'd go to queue the endio work on those free'd
workqueues.

This is because we aren't waiting for the caching threads to be done
before freeing everything up, so to fix this make sure we wait on any
outstanding caching that's being done before we free up the block group,
so we're sure to be done with all IO by the time we get to
btrfs_stop_all_workers().  This fixes the panic I was seeing
consistently in testing.

------------[ cut here ]------------
kernel BUG at fs/btrfs/volumes.c:6112!
SMP PTI
Modules linked in:
CPU: 1 PID: 27165 Comm: kworker/u4:7 Not tainted 4.16.0-02155-g3553e54a578d-dirty #875
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Workqueue: btrfs-cache btrfs_cache_helper
RIP: 0010:btrfs_map_bio+0x346/0x370
RSP: 0000:ffffc900061e79d0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff880071542e00 RCX: 0000000000533000
RDX: ffff88006bb74380 RSI: 0000000000000008 RDI: ffff880078160000
RBP: 0000000000000001 R08: ffff8800781cd200 R09: 0000000000503000
R10: ffff88006cd21200 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8800781cd200 R15: ffff880071542e00
FS:  0000000000000000(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000817ffc4 CR3: 0000000078314000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 btree_submit_bio_hook+0x8a/0xd0
 submit_one_bio+0x5d/0x80
 read_extent_buffer_pages+0x18a/0x320
 btree_read_extent_buffer_pages+0xbc/0x200
 ? alloc_extent_buffer+0x359/0x3e0
 read_tree_block+0x3d/0x60
 read_block_for_search.isra.30+0x1a5/0x360
 btrfs_search_slot+0x41b/0xa10
 btrfs_next_old_leaf+0x212/0x470
 caching_thread+0x323/0x490
 normal_work_helper+0xc5/0x310
 process_one_work+0x141/0x340
 worker_thread+0x44/0x3c0
 kthread+0xf8/0x130
 ? process_one_work+0x340/0x340
 ? kthread_bind+0x10/0x10
 ret_from_fork+0x35/0x40
RIP: btrfs_map_bio+0x346/0x370 RSP: ffffc900061e79d0
---[ end trace 827eb13e50846033 ]---
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8590,6 +8590,7 @@ void btrfs_put_block_group_cache(struct
 
 		block_group = btrfs_lookup_first_block_group(info, last);
 		while (block_group) {
+			wait_block_group_cache_done(block_group);
 			spin_lock(&block_group->lock);
 			if (block_group->iref)
 				break;

