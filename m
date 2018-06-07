Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AHcZKSVLGVtbWgAAmS7hNA
	; Thu, 07 Jun 2018 15:11:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 890766074D; Thu,  7 Jun 2018 15:11:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0590601B4;
	Thu,  7 Jun 2018 15:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0590601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935939AbeFGPLa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:11:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41473 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964998AbeFGPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005Zv-6z; Thu, 07 Jun 2018 15:09:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003DM-BB; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "syzkaller" <syzkaller@googlegroups.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Yishai Hadas" <yishaih@mellanox.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Noa Osherovich" <noaos@mellanox.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.900291711@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 341/410] RDMA/mlx5: Fix integer overflow while
 resizing CQ
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

commit 28e9091e3119933c38933cb8fc48d5618eb784c8 upstream.

The user can provide very large cqe_size which will cause to integer
overflow as it can be seen in the following UBSAN warning:

=======================================================================
UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx5/cq.c:1192:53
signed integer overflow:
64870 * 65536 cannot be represented in type 'int'
CPU: 0 PID: 267 Comm: syzkaller605279 Not tainted 4.15.0+ #90 Hardware
name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0xde/0x164
 ? dma_virt_map_sg+0x22c/0x22c
 ubsan_epilogue+0xe/0x81
 handle_overflow+0x1f3/0x251
 ? __ubsan_handle_negate_overflow+0x19b/0x19b
 ? lock_acquire+0x440/0x440
 mlx5_ib_resize_cq+0x17e7/0x1e40
 ? cyc2ns_read_end+0x10/0x10
 ? native_read_msr_safe+0x6c/0x9b
 ? cyc2ns_read_end+0x10/0x10
 ? mlx5_ib_modify_cq+0x220/0x220
 ? sched_clock_cpu+0x18/0x200
 ? lookup_get_idr_uobject+0x200/0x200
 ? rdma_lookup_get_uobject+0x145/0x2f0
 ib_uverbs_resize_cq+0x207/0x3e0
 ? ib_uverbs_ex_create_cq+0x250/0x250
 ib_uverbs_write+0x7f9/0xef0
 ? cyc2ns_read_end+0x10/0x10
 ? print_irqtrace_events+0x280/0x280
 ? ib_uverbs_ex_create_cq+0x250/0x250
 ? uverbs_devnode+0x110/0x110
 ? sched_clock_cpu+0x18/0x200
 ? do_raw_spin_trylock+0x100/0x100
 ? __lru_cache_add+0x16e/0x290
 __vfs_write+0x10d/0x700
 ? uverbs_devnode+0x110/0x110
 ? kernel_read+0x170/0x170
 ? sched_clock_cpu+0x18/0x200
 ? security_file_permission+0x93/0x260
 vfs_write+0x1b0/0x550
 SyS_write+0xc7/0x1a0
 ? SyS_read+0x1a0/0x1a0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 entry_SYSCALL_64_fastpath+0x1e/0x8b
RIP: 0033:0x433549
RSP: 002b:00007ffe63bd1ea8 EFLAGS: 00000217
=======================================================================

Cc: syzkaller <syzkaller@googlegroups.com>
Fixes: bde51583f49b ("IB/mlx5: Add support for resize CQ")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/cq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -956,7 +956,12 @@ static int resize_user(struct mlx5_ib_de
 	if (ucmd.reserved0 || ucmd.reserved1)
 		return -EINVAL;
 
-	umem = ib_umem_get(context, ucmd.buf_addr, entries * ucmd.cqe_size,
+	/* check multiplication overflow */
+	if (ucmd.cqe_size && SIZE_MAX / ucmd.cqe_size <= entries - 1)
+		return -EINVAL;
+
+	umem = ib_umem_get(context, ucmd.buf_addr,
+			   (size_t)ucmd.cqe_size * entries,
 			   IB_ACCESS_LOCAL_WRITE, 1);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
