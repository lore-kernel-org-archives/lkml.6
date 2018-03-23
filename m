Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806695-2-9195318474462941570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806694; b=PyHQyzb8zzUeyuyEx5cLsOY5z+lRRqdvBICDQ+zgsfF469c
    Y6X1YiGnklI7cPXqEgtADFowDfj98uDgrPLHakXGDYtWwzyHzk1cFUoT9vVHKjeH
    VnxG7dZ4XKQDQqfkqtalysOp5ovRvVfZYbPhSlM6nmeZn8v5vjWkUPIbE1zZCsg7
    xCdhs7/pgfFe8FNkmNLmTgP7Wv9mk/8+SYdiKU3fTfVztxBYQvRCTLF6wFjeB3+N
    Lgy7ssQtcQe/P48Xc4s4DiSsjh1tvyQNrrQOcW7XG3nNzLZQnGbgYa8gAc4nVJHZ
    KKUPZxYnBpbWZ3tQ+S3/dHP7rKkhMjWMEwRhCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806694; bh=0mQdsdLqew3y7Gp2uwbgOicJVx
    RHH8UUOnwmEKxjxgA=; b=BbM7Rs2ra53Fv6Jx/FDWfpuKMXe1/YbnDRu+0vtYqX
    tTTQgTKXdPLN6tOYRGzgiH7byaZmSH9xSuBtduHCw2mAF97L/wMie2q+gwjKPV21
    LXwGlTlAu9f/RYjkaCdI+efe885r+zn+u/Lu0D4UMut9nT2luOwzFZs5x3H0XaX5
    DBAP26Eo8Qun1vIR6wJ0ueP1VuhfCbfnOHKo0anHf8xLefbxF8jaVaSPZgETz5cl
    HBqTulVc8yiLoLFYwMCnQpC2yjdAeCaRzRLvcMrEct0r0rYHEL4dkBnxxtqG4eon
    1mp1yv8RjEPbke0bJtGabFPZkL/z1eSEBibzq+H7dxNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeCWJ72 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbeCWJ7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.15 78/84] IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
Date: Fri, 23 Mar 2018 10:54:32 +0100
Message-Id: <20180323095423.686408598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Pismenny <borisp@mellanox.com>

commit 2c292dbb398ee46fc1343daf6c3cf9715a75688e upstream.

Add a check for the length of the qpin structure to prevent out-of-bounds reads

BUG: KASAN: slab-out-of-bounds in create_raw_packet_qp+0x114c/0x15e2
Read of size 8192 at addr ffff880066b99290 by task syz-executor3/549

CPU: 3 PID: 549 Comm: syz-executor3 Not tainted 4.15.0-rc2+ #27 Hardware
name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0x8d/0xd4
 print_address_description+0x73/0x290
 kasan_report+0x25c/0x370
 ? create_raw_packet_qp+0x114c/0x15e2
 memcpy+0x1f/0x50
 create_raw_packet_qp+0x114c/0x15e2
 ? create_raw_packet_qp_tis.isra.28+0x13d/0x13d
 ? lock_acquire+0x370/0x370
 create_qp_common+0x2245/0x3b50
 ? destroy_qp_user.isra.47+0x100/0x100
 ? kasan_kmalloc+0x13d/0x170
 ? sched_clock_cpu+0x18/0x180
 ? fs_reclaim_acquire.part.15+0x5/0x30
 ? __lock_acquire+0xa11/0x1da0
 ? sched_clock_cpu+0x18/0x180
 ? kmem_cache_alloc_trace+0x17e/0x310
 ? mlx5_ib_create_qp+0x30e/0x17b0
 mlx5_ib_create_qp+0x33d/0x17b0
 ? sched_clock_cpu+0x18/0x180
 ? create_qp_common+0x3b50/0x3b50
 ? lock_acquire+0x370/0x370
 ? __radix_tree_lookup+0x180/0x220
 ? uverbs_try_lock_object+0x68/0xc0
 ? rdma_lookup_get_uobject+0x114/0x240
 create_qp.isra.5+0xce4/0x1e20
 ? ib_uverbs_ex_create_cq_cb+0xa0/0xa0
 ? copy_ah_attr_from_uverbs.isra.2+0xa00/0xa00
 ? ib_uverbs_cq_event_handler+0x160/0x160
 ? __might_fault+0x17c/0x1c0
 ib_uverbs_create_qp+0x21b/0x2a0
 ? ib_uverbs_destroy_cq+0x2e0/0x2e0
 ib_uverbs_write+0x55a/0xad0
 ? ib_uverbs_destroy_cq+0x2e0/0x2e0
 ? ib_uverbs_destroy_cq+0x2e0/0x2e0
 ? ib_uverbs_open+0x760/0x760
 ? futex_wake+0x147/0x410
 ? check_prev_add+0x1680/0x1680
 ? do_futex+0x3d3/0xa60
 ? sched_clock_cpu+0x18/0x180
 __vfs_write+0xf7/0x5c0
 ? ib_uverbs_open+0x760/0x760
 ? kernel_read+0x110/0x110
 ? lock_acquire+0x370/0x370
 ? __fget+0x264/0x3b0
 vfs_write+0x18a/0x460
 SyS_write+0xc7/0x1a0
 ? SyS_read+0x1a0/0x1a0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 entry_SYSCALL_64_fastpath+0x18/0x85
RIP: 0033:0x4477b9
RSP: 002b:00007f1822cadc18 EFLAGS: 00000292 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004477b9
RDX: 0000000000000070 RSI: 000000002000a000 RDI: 0000000000000005
RBP: 0000000000708000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 00000000ffffffff
R13: 0000000000005d70 R14: 00000000006e6e30 R15: 0000000020010ff0

Allocated by task 549:
 __kmalloc+0x15e/0x340
 kvmalloc_node+0xa1/0xd0
 create_user_qp.isra.46+0xd42/0x1610
 create_qp_common+0x2e63/0x3b50
 mlx5_ib_create_qp+0x33d/0x17b0
 create_qp.isra.5+0xce4/0x1e20
 ib_uverbs_create_qp+0x21b/0x2a0
 ib_uverbs_write+0x55a/0xad0
 __vfs_write+0xf7/0x5c0
 vfs_write+0x18a/0x460
 SyS_write+0xc7/0x1a0
 entry_SYSCALL_64_fastpath+0x18/0x85

Freed by task 368:
 kfree+0xeb/0x2f0
 kernfs_fop_release+0x140/0x180
 __fput+0x266/0x700
 task_work_run+0x104/0x180
 exit_to_usermode_loop+0xf7/0x110
 syscall_return_slowpath+0x298/0x370
 entry_SYSCALL_64_fastpath+0x83/0x85

The buggy address belongs to the object at ffff880066b99180  which
belongs to the cache kmalloc-512 of size 512 The buggy address is
located 272 bytes inside of  512-byte region [ffff880066b99180,
ffff880066b99380) The buggy address belongs to the page:
page:000000006040eedd count:1 mapcount:0 mapping:          (null)
index:0x0 compound_mapcount: 0
flags: 0x4000000000008100(slab|head)
raw: 4000000000008100 0000000000000000 0000000000000000 0000000180190019
raw: ffffea00019a7500 0000000b0000000b ffff88006c403080 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880066b99180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff880066b99200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff880066b99280: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff880066b99300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff880066b99380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Cc: syzkaller <syzkaller@googlegroups.com>
Fixes: 0fb2ed66a14c ("IB/mlx5: Add create and destroy functionality for Raw Packet QP")
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1130,7 +1130,7 @@ static void destroy_raw_packet_qp_sq(str
 	ib_umem_release(sq->ubuffer.umem);
 }
 
-static int get_rq_pas_size(void *qpc)
+static size_t get_rq_pas_size(void *qpc)
 {
 	u32 log_page_size = MLX5_GET(qpc, qpc, log_page_size) + 12;
 	u32 log_rq_stride = MLX5_GET(qpc, qpc, log_rq_stride);
@@ -1146,7 +1146,8 @@ static int get_rq_pas_size(void *qpc)
 }
 
 static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
-				   struct mlx5_ib_rq *rq, void *qpin)
+				   struct mlx5_ib_rq *rq, void *qpin,
+				   size_t qpinlen)
 {
 	struct mlx5_ib_qp *mqp = rq->base.container_mibqp;
 	__be64 *pas;
@@ -1155,9 +1156,12 @@ static int create_raw_packet_qp_rq(struc
 	void *rqc;
 	void *wq;
 	void *qpc = MLX5_ADDR_OF(create_qp_in, qpin, qpc);
-	int inlen;
+	size_t rq_pas_size = get_rq_pas_size(qpc);
+	size_t inlen;
 	int err;
-	u32 rq_pas_size = get_rq_pas_size(qpc);
+
+	if (qpinlen < rq_pas_size + MLX5_BYTE_OFF(create_qp_in, pas))
+		return -EINVAL;
 
 	inlen = MLX5_ST_SZ_BYTES(create_rq_in) + rq_pas_size;
 	in = kvzalloc(inlen, GFP_KERNEL);
@@ -1246,7 +1250,7 @@ static void destroy_raw_packet_qp_tir(st
 }
 
 static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-				u32 *in,
+				u32 *in, size_t inlen,
 				struct ib_pd *pd)
 {
 	struct mlx5_ib_raw_packet_qp *raw_packet_qp = &qp->raw_packet_qp;
@@ -1278,7 +1282,7 @@ static int create_raw_packet_qp(struct m
 			rq->flags |= MLX5_IB_RQ_CVLAN_STRIPPING;
 		if (qp->flags & MLX5_IB_QP_PCI_WRITE_END_PADDING)
 			rq->flags |= MLX5_IB_RQ_PCI_WRITE_END_PADDING;
-		err = create_raw_packet_qp_rq(dev, rq, in);
+		err = create_raw_packet_qp_rq(dev, rq, in, inlen);
 		if (err)
 			goto err_destroy_sq;
 
@@ -1836,11 +1840,16 @@ static int create_qp_common(struct mlx5_
 		}
 	}
 
+	if (inlen < 0) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (init_attr->qp_type == IB_QPT_RAW_PACKET ||
 	    qp->flags & MLX5_IB_QP_UNDERLAY) {
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd.sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
-		err = create_raw_packet_qp(dev, qp, in, pd);
+		err = create_raw_packet_qp(dev, qp, in, inlen, pd);
 	} else {
 		err = mlx5_core_create_qp(dev->mdev, &base->mqp, in, inlen);
 	}
