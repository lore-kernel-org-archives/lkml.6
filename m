Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32124C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8AC21508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKyo9Ypb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8AC21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbeKLIVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389879AbeKLIVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1112243E;
        Sun, 11 Nov 2018 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975506;
        bh=qtC7Gxm4kX9dec07vnu+Niij1qSczG4tRw1s1w2MkMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKyo9YpbY+qmGrPXJfgIyAPuCVgi4kpNlAzmKkF4DUA3PqF/hLd4oR9P/oXq/V9Tn
         M0OMcC3eiwxxsIFGT3ohspJr53nfZIPQD256frV3GYYkcJS+rgwJn+VkFTywl8Ol4o
         f2dunl97jkQI31WCOxbwRRYBDluQJXUy0P8UFEyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 327/350] btrfs: wait on caching when putting the bg cache
Date:   Sun, 11 Nov 2018 14:23:11 -0800
Message-Id: <20181111221721.759111159@linuxfoundation.org>
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

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9791,6 +9791,7 @@ void btrfs_put_block_group_cache(struct
 
 		block_group = btrfs_lookup_first_block_group(info, last);
 		while (block_group) {
+			wait_block_group_cache_done(block_group);
 			spin_lock(&block_group->lock);
 			if (block_group->iref)
 				break;


