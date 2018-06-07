Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cGGsIvBBGVsldwAAmS7hNA
	; Thu, 07 Jun 2018 14:34:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 35C0F608FB; Thu,  7 Jun 2018 14:34:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A50B608C8;
	Thu,  7 Jun 2018 14:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A50B608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933951AbeFGOeF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:34:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40330 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933936AbeFGOeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:34:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005Zn-SB; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003Hb-0x; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "" <syzbot+36712f50b0552615bf59@syzkaller.appspotmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.409989054@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 383/410] RDMA/ucma: Ensure that CM_ID exists prior to
 access it
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

commit e8980d67d6017c8eee8f9c35f782c4bd68e004c9 upstream.

Prior to access UCMA commands, the context should be initialized
and connected to CM_ID with ucma_create_id(). In case user skips
this step, he can provide non-valid ctx without CM_ID and cause
to multiple NULL dereferences.

Also there are situations where the create_id can be raced with
other user access, ensure that the context is only shared to
other threads once it is fully initialized to avoid the races.

[  109.088108] BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
[  109.090315] IP: ucma_connect+0x138/0x1d0
[  109.092595] PGD 80000001dc02d067 P4D 80000001dc02d067 PUD 1da9ef067 PMD 0
[  109.095384] Oops: 0000 [#1] SMP KASAN PTI
[  109.097834] CPU: 0 PID: 663 Comm: uclose Tainted: G    B 4.16.0-rc1-00062-g2975d5de6428 #45
[  109.100816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[  109.105943] RIP: 0010:ucma_connect+0x138/0x1d0
[  109.108850] RSP: 0018:ffff8801c8567a80 EFLAGS: 00010246
[  109.111484] RAX: 0000000000000000 RBX: 1ffff100390acf50 RCX: ffffffff9d7812e2
[  109.114496] RDX: 1ffffffff3f507a5 RSI: 0000000000000297 RDI: 0000000000000297
[  109.117490] RBP: ffff8801daa15600 R08: 0000000000000000 R09: ffffed00390aceeb
[  109.120429] R10: 0000000000000001 R11: ffffed00390aceea R12: 0000000000000000
[  109.123318] R13: 0000000000000120 R14: ffff8801de6459c0 R15: 0000000000000118
[  109.126221] FS:  00007fabb68d6700(0000) GS:ffff8801e5c00000(0000) knlGS:0000000000000000
[  109.129468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  109.132523] CR2: 0000000000000020 CR3: 00000001d45d8003 CR4: 00000000003606b0
[  109.135573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  109.138716] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  109.142057] Call Trace:
[  109.144160]  ? ucma_listen+0x110/0x110
[  109.146386]  ? wake_up_q+0x59/0x90
[  109.148853]  ? futex_wake+0x10b/0x2a0
[  109.151297]  ? save_stack+0x89/0xb0
[  109.153489]  ? _copy_from_user+0x5e/0x90
[  109.155500]  ucma_write+0x174/0x1f0
[  109.157933]  ? ucma_resolve_route+0xf0/0xf0
[  109.160389]  ? __mod_node_page_state+0x1d/0x80
[  109.162706]  __vfs_write+0xc4/0x350
[  109.164911]  ? kernel_read+0xa0/0xa0
[  109.167121]  ? path_openat+0x1b10/0x1b10
[  109.169355]  ? fsnotify+0x899/0x8f0
[  109.171567]  ? fsnotify_unmount_inodes+0x170/0x170
[  109.174145]  ? __fget+0xa8/0xf0
[  109.177110]  vfs_write+0xf7/0x280
[  109.179532]  SyS_write+0xa1/0x120
[  109.181885]  ? SyS_read+0x120/0x120
[  109.184482]  ? compat_start_thread+0x60/0x60
[  109.187124]  ? SyS_read+0x120/0x120
[  109.189548]  do_syscall_64+0xeb/0x250
[  109.192178]  entry_SYSCALL_64_after_hwframe+0x21/0x86
[  109.194725] RIP: 0033:0x7fabb61ebe99
[  109.197040] RSP: 002b:00007fabb68d5e98 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  109.200294] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fabb61ebe99
[  109.203399] RDX: 0000000000000120 RSI: 00000000200001c0 RDI: 0000000000000004
[  109.206548] RBP: 00007fabb68d5ec0 R08: 0000000000000000 R09: 0000000000000000
[  109.209902] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fabb68d5fc0
[  109.213327] R13: 0000000000000000 R14: 00007fff40ab2430 R15: 00007fabb68d69c0
[  109.216613] Code: 88 44 24 2c 0f b6 84 24 6e 01 00 00 88 44 24 2d 0f
b6 84 24 69 01 00 00 88 44 24 2e 8b 44 24 60 89 44 24 30 e8 da f6 06 ff
31 c0 <66> 41 83 7c 24 20 1b 75 04 8b 44 24 64 48 8d 74 24 20 4c 89 e7
[  109.223602] RIP: ucma_connect+0x138/0x1d0 RSP: ffff8801c8567a80
[  109.226256] CR2: 0000000000000020

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Reported-by: <syzbot+36712f50b0552615bf59@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -121,7 +121,7 @@ static inline struct ucma_context *_ucma
 	ctx = idr_find(&ctx_idr, id);
 	if (!ctx)
 		ctx = ERR_PTR(-ENOENT);
-	else if (ctx->file != file)
+	else if (ctx->file != file || !ctx->cm_id)
 		ctx = ERR_PTR(-EINVAL);
 	return ctx;
 }
@@ -371,6 +371,7 @@ static ssize_t ucma_create_id(struct ucm
 	struct rdma_ucm_create_id cmd;
 	struct rdma_ucm_create_id_resp resp;
 	struct ucma_context *ctx;
+	struct rdma_cm_id *cm_id;
 	enum ib_qp_type qp_type;
 	int ret;
 
@@ -391,9 +392,9 @@ static ssize_t ucma_create_id(struct ucm
 		return -ENOMEM;
 
 	ctx->uid = cmd.uid;
-	ctx->cm_id = rdma_create_id(ucma_event_handler, ctx, cmd.ps, qp_type);
-	if (IS_ERR(ctx->cm_id)) {
-		ret = PTR_ERR(ctx->cm_id);
+	cm_id = rdma_create_id(ucma_event_handler, ctx, cmd.ps, qp_type);
+	if (IS_ERR(cm_id)) {
+		ret = PTR_ERR(cm_id);
 		goto err1;
 	}
 
@@ -403,10 +404,12 @@ static ssize_t ucma_create_id(struct ucm
 		ret = -EFAULT;
 		goto err2;
 	}
+
+	ctx->cm_id = cm_id;
 	return 0;
 
 err2:
-	rdma_destroy_id(ctx->cm_id);
+	rdma_destroy_id(cm_id);
 err1:
 	mutex_lock(&mut);
 	idr_remove(&ctx_idr, ctx->id);
