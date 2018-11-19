Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36022C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC204214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQktVONz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC204214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbeKTDHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbeKTDHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A34214D9;
        Mon, 19 Nov 2018 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645817;
        bh=wtbERkHEmfXQLGY1zfrx5/DDkwbxqHwABxmybw8NBvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQktVONzSxpx61NzgCK3pizVLc9TWgwmHlMprHTFlf2gQjRrozMDBzMu1JooFF11S
         wsbwrfA4rHUJ0xXwBcoTPAbY+7XBqWk5aVHfwTNfSOA4Wyew1COBTS1QTTDnutg5z/
         c/HTODw0sg2XHUZZN+B/4ACrwJoH/hEnHWG3j3ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 100/171] btrfs: fix pinned underflow after transaction aborted
Date:   Mon, 19 Nov 2018 17:28:16 +0100
Message-Id: <20181119162634.867613556@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

commit fcd5e74288f7d36991b1f0fb96b8c57079645e38 upstream.

When running generic/475, we may get the following warning in dmesg:

[ 6902.102154] WARNING: CPU: 3 PID: 18013 at fs/btrfs/extent-tree.c:9776 btrfs_free_block_groups+0x2af/0x3b0 [btrfs]
[ 6902.109160] CPU: 3 PID: 18013 Comm: umount Tainted: G        W  O      4.19.0-rc8+ #8
[ 6902.110971] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[ 6902.112857] RIP: 0010:btrfs_free_block_groups+0x2af/0x3b0 [btrfs]
[ 6902.118921] RSP: 0018:ffffc9000459bdb0 EFLAGS: 00010286
[ 6902.120315] RAX: ffff880175050bb0 RBX: ffff8801124a8000 RCX: 0000000000170007
[ 6902.121969] RDX: 0000000000000002 RSI: 0000000000170007 RDI: ffffffff8125fb74
[ 6902.123716] RBP: ffff880175055d10 R08: 0000000000000000 R09: 0000000000000000
[ 6902.125417] R10: 0000000000000000 R11: 0000000000000000 R12: ffff880175055d88
[ 6902.127129] R13: ffff880175050bb0 R14: 0000000000000000 R15: dead000000000100
[ 6902.129060] FS:  00007f4507223780(0000) GS:ffff88017ba00000(0000) knlGS:0000000000000000
[ 6902.130996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6902.132558] CR2: 00005623599cac78 CR3: 000000014b700001 CR4: 00000000003606e0
[ 6902.134270] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6902.135981] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6902.137836] Call Trace:
[ 6902.138939]  close_ctree+0x171/0x330 [btrfs]
[ 6902.140181]  ? kthread_stop+0x146/0x1f0
[ 6902.141277]  generic_shutdown_super+0x6c/0x100
[ 6902.142517]  kill_anon_super+0x14/0x30
[ 6902.143554]  btrfs_kill_super+0x13/0x100 [btrfs]
[ 6902.144790]  deactivate_locked_super+0x2f/0x70
[ 6902.146014]  cleanup_mnt+0x3b/0x70
[ 6902.147020]  task_work_run+0x9e/0xd0
[ 6902.148036]  do_syscall_64+0x470/0x600
[ 6902.149142]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 6902.150375]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 6902.151640] RIP: 0033:0x7f45077a6a7b
[ 6902.157324] RSP: 002b:00007ffd589f3e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[ 6902.159187] RAX: 0000000000000000 RBX: 000055e8eec732b0 RCX: 00007f45077a6a7b
[ 6902.160834] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055e8eec73490
[ 6902.162526] RBP: 0000000000000000 R08: 000055e8eec734b0 R09: 00007ffd589f26c0
[ 6902.164141] R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8eec73490
[ 6902.165815] R13: 00007f4507ac61a4 R14: 0000000000000000 R15: 00007ffd589f40d8
[ 6902.167553] irq event stamp: 0
[ 6902.168998] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
[ 6902.170731] hardirqs last disabled at (0): [<ffffffff810cd810>] copy_process.part.55+0x3b0/0x1f00
[ 6902.172773] softirqs last  enabled at (0): [<ffffffff810cd810>] copy_process.part.55+0x3b0/0x1f00
[ 6902.174671] softirqs last disabled at (0): [<0000000000000000>]           (null)
[ 6902.176407] ---[ end trace 463138c2986b275c ]---
[ 6902.177636] BTRFS info (device dm-3): space_info 4 has 273465344 free, is not full
[ 6902.179453] BTRFS info (device dm-3): space_info total=276824064, used=4685824, pinned=18446744073708158976, reserved=0, may_use=0, readonly=65536

In the above line there's "pinned=18446744073708158976" which is an
unsigned u64 value of -1392640, an obvious underflow.

When transaction_kthread is running cleanup_transaction(), another
fsstress is running btrfs_commit_transaction(). The
btrfs_finish_extent_commit() may get the same range as
btrfs_destroy_pinned_extent() got, which causes the pinned underflow.

Fixes: d4b450cd4b33 ("Btrfs: fix race between transaction commit and empty block group removal")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4404,13 +4404,23 @@ static int btrfs_destroy_pinned_extent(s
 	unpin = pinned_extents;
 again:
 	while (1) {
+		/*
+		 * The btrfs_finish_extent_commit() may get the same range as
+		 * ours between find_first_extent_bit and clear_extent_dirty.
+		 * Hence, hold the unused_bg_unpin_mutex to avoid double unpin
+		 * the same extent range.
+		 */
+		mutex_lock(&fs_info->unused_bg_unpin_mutex);
 		ret = find_first_extent_bit(unpin, 0, &start, &end,
 					    EXTENT_DIRTY, NULL);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
+		}
 
 		clear_extent_dirty(unpin, start, end);
 		btrfs_error_unpin_extent_range(fs_info, start, end);
+		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		cond_resched();
 	}
 


