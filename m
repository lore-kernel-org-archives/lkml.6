Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3155208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3155208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406037AbeHATIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405941AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 839EF133D;
        Wed,  1 Aug 2018 17:12:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 003/246] RDMA/core: Avoid that ib_drain_qp() triggers an out-of-bounds stack access
Date:   Wed,  1 Aug 2018 18:48:33 +0200
Message-Id: <20180801165011.873241917@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit a1ae7d0345edd593d6725d3218434d903a0af95d upstream.

This patch fixes the following KASAN complaint:

==================================================================
BUG: KASAN: stack-out-of-bounds in rxe_post_send+0x77d/0x9b0 [rdma_rxe]
Read of size 8 at addr ffff880061aef860 by task 01/1080

CPU: 2 PID: 1080 Comm: 01 Not tainted 4.16.0-rc3-dbg+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
dump_stack+0x85/0xc7
print_address_description+0x65/0x270
kasan_report+0x231/0x350
rxe_post_send+0x77d/0x9b0 [rdma_rxe]
__ib_drain_sq+0x1ad/0x250 [ib_core]
ib_drain_qp+0x9/0x30 [ib_core]
srp_destroy_qp+0x51/0x70 [ib_srp]
srp_free_ch_ib+0xfc/0x380 [ib_srp]
srp_create_target+0x1071/0x19e0 [ib_srp]
kernfs_fop_write+0x180/0x210
__vfs_write+0xb1/0x2e0
vfs_write+0xf6/0x250
SyS_write+0x99/0x110
do_syscall_64+0xee/0x2b0
entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the page:
page:ffffea000186bbc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x4000000000000000()
raw: 4000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea000186bbe0 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff880061aef700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff880061aef780: 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00
>ffff880061aef800: f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 f2 f2 f2 f2
                                                      ^
ffff880061aef880: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 f2 f2
ffff880061aef900: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 765d67748bcf ("IB: new common API for draining queues")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Steve Wise <swise@opengridcomputing.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/verbs.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2115,10 +2115,15 @@ static void __ib_drain_sq(struct ib_qp *
 	struct ib_cq *cq = qp->send_cq;
 	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
 	struct ib_drain_cqe sdrain;
-	struct ib_send_wr swr = {}, *bad_swr;
+	struct ib_send_wr *bad_swr;
+	struct ib_rdma_wr swr = {
+		.wr = {
+			.opcode	= IB_WR_RDMA_WRITE,
+			.wr_cqe	= &sdrain.cqe,
+		},
+	};
 	int ret;
 
-	swr.wr_cqe = &sdrain.cqe;
 	sdrain.cqe.done = ib_drain_qp_done;
 	init_completion(&sdrain.done);
 
@@ -2128,7 +2133,7 @@ static void __ib_drain_sq(struct ib_qp *
 		return;
 	}
 
-	ret = ib_post_send(qp, &swr, &bad_swr);
+	ret = ib_post_send(qp, &swr.wr, &bad_swr);
 	if (ret) {
 		WARN_ONCE(ret, "failed to drain send queue: %d\n", ret);
 		return;


