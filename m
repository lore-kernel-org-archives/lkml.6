Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L+EzI3dNGVvdcQAAmS7hNA
	; Thu, 07 Jun 2018 15:21:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D36B607E7; Thu,  7 Jun 2018 15:21:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 671EB606DD;
	Thu,  7 Jun 2018 15:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 671EB606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935746AbeFGPVz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:21:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41243 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935599AbeFGO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zn-2z; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Fj-UY; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "" <syzbot+2287ac532caa81900a4e@syzkaller.appspotmail.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Sean Hefty" <sean.hefty@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.52029454@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 360/410] RDMA/ucma: Don't allow join attempts for
 unsupported AF family
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

commit 0c81ffc60d5280991773d17e84bda605387148b1 upstream.

Users can provide garbage while calling to ucma_join_ip_multicast(),
it will indirectly cause to rdma_addr_size() return 0, making the
call to ucma_process_join(), which had the right checks, but it is
better to check the input as early as possible.

The following crash from syzkaller revealed it.

kernel BUG at lib/string.c:1052!
invalid opcode: 0000 [#1] SMP KASAN Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4113 Comm: syz-executor0 Not tainted 4.16.0-rc5+ #261
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fortify_panic+0x13/0x20 lib/string.c:1051
RSP: 0018:ffff8801ca81f8f0 EFLAGS: 00010286
RAX: 0000000000000022 RBX: 1ffff10039503f23 RCX: 0000000000000000
RDX: 0000000000000022 RSI: 1ffff10039503ed3 RDI: ffffed0039503f12
RBP: ffff8801ca81f8f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff8801ca81f998
R13: ffff8801ca81f938 R14: ffff8801ca81fa58 R15: 000000000000fa00
FS:  0000000000000000(0000) GS:ffff8801db200000(0063) knlGS:000000000a12a900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000008138024 CR3: 00000001cbb58004 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy include/linux/string.h:344 [inline]
 ucma_join_ip_multicast+0x36b/0x3b0 drivers/infiniband/core/ucma.c:1421
 ucma_write+0x2d6/0x3d0 drivers/infiniband/core/ucma.c:1633
 __vfs_write+0xef/0x970 fs/read_write.c:480
 vfs_write+0x189/0x510 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xef/0x220 fs/read_write.c:581
 do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
 do_fast_syscall_32+0x3ec/0xf9f arch/x86/entry/common.c:392
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f9ec99
RSP: 002b:00000000ff8172cc EFLAGS: 00000282 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000100
RDX: 0000000000000063 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Code: 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 48 89 df e8 42 2c e3 fb eb de
55 48 89 fe 48 c7 c7 80 75 98 86 48 89 e5 e8 85 95 94 fb <0f> 0b 90 90 90 90
90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56
RIP: fortify_panic+0x13/0x20 lib/string.c:1051 RSP: ffff8801ca81f8f0

Fixes: 5bc2b7b397b0 ("RDMA/ucma: Allow user space to specify AF_IB when joining multicast")
Reported-by: <syzbot+2287ac532caa81900a4e@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1241,7 +1241,7 @@ static ssize_t ucma_process_join(struct
 		return -ENOSPC;
 
 	addr = (struct sockaddr *) &cmd->addr;
-	if (cmd->reserved || !cmd->addr_size || (cmd->addr_size != rdma_addr_size(addr)))
+	if (cmd->reserved || cmd->addr_size != rdma_addr_size(addr))
 		return -EINVAL;
 
 	ctx = ucma_get_ctx(file, cmd->id);
@@ -1301,6 +1301,9 @@ static ssize_t ucma_join_ip_multicast(st
 	join_cmd.uid = cmd.uid;
 	join_cmd.id = cmd.id;
 	join_cmd.addr_size = rdma_addr_size((struct sockaddr *) &cmd.addr);
+	if (!join_cmd.addr_size)
+		return -EINVAL;
+
 	join_cmd.reserved = 0;
 	memcpy(&join_cmd.addr, &cmd.addr, join_cmd.addr_size);
 
@@ -1316,6 +1319,9 @@ static ssize_t ucma_join_multicast(struc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+		return -EINVAL;
+
 	return ucma_process_join(file, &cmd, out_len);
 }
 
