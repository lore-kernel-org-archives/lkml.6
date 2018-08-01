Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A38C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB2820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB2820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405918AbeHATIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405728AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C58831340;
        Wed,  1 Aug 2018 17:12:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 005/246] IB/srpt: Fix an out-of-bounds stack access in srpt_zerolength_write()
Date:   Wed,  1 Aug 2018 18:48:35 +0200
Message-Id: <20180801165011.956055366@linuxfoundation.org>
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

commit 2a78cb4db487372152bed2055c038f9634d595e8 upstream.

Avoid triggering an out-of-bounds stack access by changing the type
of 'wr' from ib_send_wr into ib_rdma_wr.

This patch fixes the following KASAN bug report:

BUG: KASAN: stack-out-of-bounds in rxe_post_send+0x7a9/0x9a0 [rdma_rxe]
Read of size 8 at addr ffff880068197a48 by task kworker/2:1/44

Workqueue: ib_cm cm_work_handler [ib_cm]
Call Trace:
 dump_stack+0x8e/0xcd
 print_address_description+0x6f/0x280
 kasan_report+0x25a/0x380
 __asan_load8+0x54/0x90
 rxe_post_send+0x7a9/0x9a0 [rdma_rxe]
 srpt_zerolength_write+0xf0/0x180 [ib_srpt]
 srpt_cm_rtu_recv+0x68/0x110 [ib_srpt]
 srpt_rdma_cm_handler+0xbb/0x15b [ib_srpt]
 cma_ib_handler+0x1aa/0x4a0 [rdma_cm]
 cm_process_work+0x30/0x100 [ib_cm]
 cm_work_handler+0xa86/0x351b [ib_cm]
 process_one_work+0x475/0x9f0
 worker_thread+0x69/0x690
 kthread+0x1ad/0x1d0
 ret_from_fork+0x3a/0x50

Fixes: aaf45bd83eba ("IB/srpt: Detect session shutdown reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -787,13 +787,16 @@ static int srpt_post_recv(struct srpt_de
  */
 static int srpt_zerolength_write(struct srpt_rdma_ch *ch)
 {
-	struct ib_send_wr wr, *bad_wr;
+	struct ib_send_wr *bad_wr;
+	struct ib_rdma_wr wr = {
+		.wr = {
+			.opcode		= IB_WR_RDMA_WRITE,
+			.wr_cqe		= &ch->zw_cqe,
+			.send_flags	= IB_SEND_SIGNALED,
+		}
+	};
 
-	memset(&wr, 0, sizeof(wr));
-	wr.opcode = IB_WR_RDMA_WRITE;
-	wr.wr_cqe = &ch->zw_cqe;
-	wr.send_flags = IB_SEND_SIGNALED;
-	return ib_post_send(ch->qp, &wr, &bad_wr);
+	return ib_post_send(ch->qp, &wr.wr, &bad_wr);
 }
 
 static void srpt_zerolength_write_done(struct ib_cq *cq, struct ib_wc *wc)


