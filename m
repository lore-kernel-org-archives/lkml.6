Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB8E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896760;
	bh=nPBNA9FPaEtYY8sYxOE+8Yv5GRhWQQ4QUcJmpEHGt/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AMgprWUcCx8Nl5/6CI+53+2RX62ldIaq/mC07rvB8oAK2aIXpSwQLDFizQJF131Dg
	 t1oyDZ2c7Sh8oDpL47kjS+digWorfd7RRs+4jHwFlOYcAN6q7Qvnvg0iXLeRb8Soe+
	 9YdvdJYnnccZ7Ra8kTFLk3snFdNNwWHiq7o6WK70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbfBKOwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388444AbfBKOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6442214DA;
        Mon, 11 Feb 2019 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896755;
        bh=nPBNA9FPaEtYY8sYxOE+8Yv5GRhWQQ4QUcJmpEHGt/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0A3edfbwRvv/lrJm4XAYh1pJk7t6G/FlqzNVp+FygnpenfWVHI3OQuXKavP+oM32A
         06JG4dLyBpU0TKDrNLimv2cwO70qRVjvCoAiQzPHGzzC1y1uu6CziVw8hmv8yHQoOI
         qkjVROhuts70SERinqpTZCCQfWh1vPzURqiPObLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 249/313] xfs: cancel COW blocks before swapext
Date:   Mon, 11 Feb 2019 15:18:49 +0100
Message-Id: <20190211141909.974927750@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 96987eea537d6ccd98704a71958f9ba02da80843 upstream.

We need to make sure we have no outstanding COW blocks before we swap
extents, as there is nothing preventing us from having preallocated COW
delalloc on either inode that swapext is called on.  That case can
easily be reproduced by running generic/324 in always_cow mode:

[  620.760572] XFS: Assertion failed: tip->i_delayed_blks == 0, file: fs/xfs/xfs_bmap_util.c, line: 1669
[  620.761608] ------------[ cut here ]------------
[  620.762171] kernel BUG at fs/xfs/xfs_message.c:102!
[  620.762732] invalid opcode: 0000 [#1] SMP PTI
[  620.763272] CPU: 0 PID: 24153 Comm: xfs_fsr Tainted: G        W         4.19.0-rc1+ #4182
[  620.764203] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[  620.765202] RIP: 0010:assfail+0x20/0x28
[  620.765646] Code: 31 ff e8 83 fc ff ff 0f 0b c3 48 89 f1 41 89 d0 48 c7 c6 48 ca 8d 82 48 89 fa 38
[  620.767758] RSP: 0018:ffffc9000898bc10 EFLAGS: 00010202
[  620.768359] RAX: 0000000000000000 RBX: ffff88012f14ba40 RCX: 0000000000000000
[  620.769174] RDX: 00000000ffffffc0 RSI: 000000000000000a RDI: ffffffff828560d9
[  620.769982] RBP: ffff88012f14b300 R08: 0000000000000000 R09: 0000000000000000
[  620.770788] R10: 000000000000000a R11: f000000000000000 R12: ffffc9000898bc98
[  620.771638] R13: ffffc9000898bc9c R14: ffff880130b5e2b8 R15: ffff88012a1fa2a8
[  620.772504] FS:  00007fdc36e0fbc0(0000) GS:ffff88013ba00000(0000) knlGS:0000000000000000
[  620.773475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  620.774168] CR2: 00007fdc3604d000 CR3: 0000000132afc000 CR4: 00000000000006f0
[  620.774978] Call Trace:
[  620.775274]  xfs_swap_extent_forks+0x2a0/0x2e0
[  620.775792]  xfs_swap_extents+0x38b/0xab0
[  620.776256]  xfs_ioc_swapext+0x121/0x140
[  620.776709]  xfs_file_ioctl+0x328/0xc90
[  620.777154]  ? rcu_read_lock_sched_held+0x50/0x60
[  620.777694]  ? xfs_iunlock+0x233/0x260
[  620.778127]  ? xfs_setattr_nonsize+0x3be/0x6a0
[  620.778647]  do_vfs_ioctl+0x9d/0x680
[  620.779071]  ? ksys_fchown+0x47/0x80
[  620.779552]  ksys_ioctl+0x35/0x70
[  620.780040]  __x64_sys_ioctl+0x11/0x20
[  620.780530]  do_syscall_64+0x4b/0x190
[  620.780927]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  620.781467] RIP: 0033:0x7fdc364d0f07
[  620.781900] Code: b3 66 90 48 8b 05 81 5f 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 28
[  620.784044] RSP: 002b:00007ffe2a766038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  620.784896] RAX: ffffffffffffffda RBX: 0000000000000025 RCX: 00007fdc364d0f07
[  620.785667] RDX: 0000560296ca2fc0 RSI: 00000000c0c0586d RDI: 0000000000000005
[  620.786398] RBP: 0000000000000025 R08: 0000000000001200 R09: 0000000000000000
[  620.787283] R10: 0000000000000432 R11: 0000000000000246 R12: 0000000000000005
[  620.788051] R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000006
[  620.788927] Modules linked in:
[  620.789340] ---[ end trace 9503b7417ffdbdb0 ]---
[  620.790065] RIP: 0010:assfail+0x20/0x28
[  620.790642] Code: 31 ff e8 83 fc ff ff 0f 0b c3 48 89 f1 41 89 d0 48 c7 c6 48 ca 8d 82 48 89 fa 38
[  620.793038] RSP: 0018:ffffc9000898bc10 EFLAGS: 00010202
[  620.793609] RAX: 0000000000000000 RBX: ffff88012f14ba40 RCX: 0000000000000000
[  620.794317] RDX: 00000000ffffffc0 RSI: 000000000000000a RDI: ffffffff828560d9
[  620.795025] RBP: ffff88012f14b300 R08: 0000000000000000 R09: 0000000000000000
[  620.795778] R10: 000000000000000a R11: f000000000000000 R12: ffffc9000898bc98
[  620.796675] R13: ffffc9000898bc9c R14: ffff880130b5e2b8 R15: ffff88012a1fa2a8
[  620.797782] FS:  00007fdc36e0fbc0(0000) GS:ffff88013ba00000(0000) knlGS:0000000000000000
[  620.798908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  620.799594] CR2: 00007fdc3604d000 CR3: 0000000132afc000 CR4: 00000000000006f0
[  620.800424] Kernel panic - not syncing: Fatal exception
[  620.801191] Kernel Offset: disabled
[  620.801597] ---[ end Kernel panic - not syncing: Fatal exception ]---

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 6de8d90041ff..9d1e5c3a661e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1824,6 +1824,12 @@ xfs_swap_extents(
 	if (error)
 		goto out_unlock;
 
+	if (xfs_inode_has_cow_data(tip)) {
+		error = xfs_reflink_cancel_cow_range(tip, 0, NULLFILEOFF, true);
+		if (error)
+			return error;
+	}
+
 	/*
 	 * Extent "swapping" with rmap requires a permanent reservation and
 	 * a block reservation because it's really just a remap operation
-- 
2.19.1



