Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mbmKJ31MGVvJYQAAmS7hNA
	; Thu, 07 Jun 2018 15:18:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9BF466089E; Thu,  7 Jun 2018 15:18:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0669606DD;
	Thu,  7 Jun 2018 15:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0669606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936013AbeFGPSg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:18:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41287 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935691AbeFGO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:31 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbI-0005hJ-Kp; Thu, 07 Jun 2018 15:09:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003KN-Kw; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jason Gunthorpe" <jgg@mellanox.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "" <syzbot+7b62c837c2516f8f38c8@syzkaller.appspotmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.701712358@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 407/410] RDMA/ucma: Check that device is connected
 prior to access it
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 4b658d1bbc16605330694bb3ef2570c465ef383d upstream.

Add missing check that device is connected prior to access it.

[   55.358652] BUG: KASAN: null-ptr-deref in rdma_init_qp_attr+0x4a/0x2c0
[   55.359389] Read of size 8 at addr 00000000000000b0 by task qp/618
[   55.360255]
[   55.360432] CPU: 1 PID: 618 Comm: qp Not tainted 4.16.0-rc1-00071-gcaf61b1b8b88 #91
[   55.361693] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[   55.363264] Call Trace:
[   55.363833]  dump_stack+0x5c/0x77
[   55.364215]  kasan_report+0x163/0x380
[   55.364610]  ? rdma_init_qp_attr+0x4a/0x2c0
[   55.365238]  rdma_init_qp_attr+0x4a/0x2c0
[   55.366410]  ucma_init_qp_attr+0x111/0x200
[   55.366846]  ? ucma_notify+0xf0/0xf0
[   55.367405]  ? _get_random_bytes+0xea/0x1b0
[   55.367846]  ? urandom_read+0x2f0/0x2f0
[   55.368436]  ? kmem_cache_alloc_trace+0xd2/0x1e0
[   55.369104]  ? refcount_inc_not_zero+0x9/0x60
[   55.369583]  ? refcount_inc+0x5/0x30
[   55.370155]  ? rdma_create_id+0x215/0x240
[   55.370937]  ? _copy_to_user+0x4f/0x60
[   55.371620]  ? mem_cgroup_commit_charge+0x1f5/0x290
[   55.372127]  ? _copy_from_user+0x5e/0x90
[   55.372720]  ucma_write+0x174/0x1f0
[   55.373090]  ? ucma_close_id+0x40/0x40
[   55.373805]  ? __lru_cache_add+0xa8/0xd0
[   55.374403]  __vfs_write+0xc4/0x350
[   55.374774]  ? kernel_read+0xa0/0xa0
[   55.375173]  ? fsnotify+0x899/0x8f0
[   55.375544]  ? fsnotify_unmount_inodes+0x170/0x170
[   55.376689]  ? __fsnotify_update_child_dentry_flags+0x30/0x30
[   55.377522]  ? handle_mm_fault+0x174/0x320
[   55.378169]  vfs_write+0xf7/0x280
[   55.378864]  SyS_write+0xa1/0x120
[   55.379270]  ? SyS_read+0x120/0x120
[   55.379643]  ? mm_fault_error+0x180/0x180
[   55.380071]  ? task_work_run+0x7d/0xd0
[   55.380910]  ? __task_pid_nr_ns+0x120/0x140
[   55.381366]  ? SyS_read+0x120/0x120
[   55.381739]  do_syscall_64+0xeb/0x250
[   55.382143]  entry_SYSCALL_64_after_hwframe+0x21/0x86
[   55.382841] RIP: 0033:0x7fc2ef803e99
[   55.383227] RSP: 002b:00007fffcc5f3be8 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
[   55.384173] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc2ef803e99
[   55.386145] RDX: 0000000000000057 RSI: 0000000020000080 RDI: 0000000000000003
[   55.388418] RBP: 00007fffcc5f3c00 R08: 0000000000000000 R09: 0000000000000000
[   55.390542] R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000400480
[   55.392916] R13: 00007fffcc5f3cf0 R14: 0000000000000000 R15: 0000000000000000
[   55.521088] Code: e5 4d 1e ff 48 89 df 44 0f b6 b3 b8 01 00 00 e8 65 50 1e ff 4c 8b 2b 49
8d bd b0 00 00 00 e8 56 50 1e ff 41 0f b6 c6 48 c1 e0 04 <49> 03 85 b0 00 00 00 48 8d 78 08
48 89 04 24 e8 3a 4f 1e ff 48
[   55.525980] RIP: rdma_init_qp_attr+0x52/0x2c0 RSP: ffff8801e2c2f9d8
[   55.532648] CR2: 00000000000000b0
[   55.534396] ---[ end trace 70cee64090251c0b ]---

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Fixes: d541e45500bd ("IB/core: Convert ah_attr from OPA to IB when copying to user")
Reported-by: <syzbot+7b62c837c2516f8f38c8@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1067,6 +1067,11 @@ static ssize_t ucma_init_qp_attr(struct
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (!ctx->cm_id->device) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	resp.qp_attr_mask = 0;
 	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.qp_state = cmd.qp_state;
