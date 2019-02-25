Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D87C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C30D21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129521;
	bh=HPzk/xHzcT7opeaUeZ625OA6YRYFprTfMT6EKPnQYh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5mDK5n0pcj5IlAjELIIBcd/3Lh8rVboScdGL+0fUEtaLtop0CrQmpr2qQ6U0TVex
	 WySqewsEXr6kPYrx1L8WI2fXMInhDj945wkdWbGaXzJe0KHwOM1V+MNZxVW300Epwv
	 NXdRlAGyU9mbGYlvzdQNmL/WHa3YpMtjHYSYleQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfBYVSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbfBYVSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EFB2173C;
        Mon, 25 Feb 2019 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129514;
        bh=HPzk/xHzcT7opeaUeZ625OA6YRYFprTfMT6EKPnQYh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqmWfr4I7pqlA3dkzFYWQ9BeVUHVWBREuDPgULzTJ3ebPq1ZiyjPj7WZ+wmwAWkeG
         DmlDf0VQVBJ1y87XewrcR35HZ8oad7EbachPbfIsVgM95zjcZ8xJDc9xqo/J87JfAr
         xh70kuQyP/HekqwLT0LMXUUNpWLo32GGLUVcrxIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 55/71] RDMA/srp: Rework SCSI device reset handling
Date:   Mon, 25 Feb 2019 22:11:57 +0100
Message-Id: <20190225195038.778191261@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 48396e80fb6526ea5ed267bd84f028bae56d2f9e upstream.

Since .scsi_done() must only be called after scsi_queue_rq() has
finished, make sure that the SRP initiator driver does not call
.scsi_done() while scsi_queue_rq() is in progress. Although
invoking sg_reset -d while I/O is in progress works fine with kernel
v4.20 and before, that is not the case with kernel v5.0-rc1. This
patch avoids that the following crash is triggered with kernel
v5.0-rc1:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000138
CPU: 0 PID: 360 Comm: kworker/0:1H Tainted: G    B             5.0.0-rc1-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:blk_mq_dispatch_rq_list+0x116/0xb10
Call Trace:
 blk_mq_sched_dispatch_requests+0x2f7/0x300
 __blk_mq_run_hw_queue+0xd6/0x180
 blk_mq_run_work_fn+0x27/0x30
 process_one_work+0x4f1/0xa20
 worker_thread+0x67/0x5b0
 kthread+0x1cf/0x1f0
 ret_from_fork+0x24/0x30

Cc: <stable@vger.kernel.org>
Fixes: 94a9174c630c ("IB/srp: reduce lock coverage of command completion")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srp/ib_srp.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2669,7 +2669,6 @@ static int srp_reset_device(struct scsi_
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
 	struct srp_rdma_ch *ch;
-	int i, j;
 	u8 status;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP reset_device called\n");
@@ -2681,15 +2680,6 @@ static int srp_reset_device(struct scsi_
 	if (status)
 		return FAILED;
 
-	for (i = 0; i < target->ch_count; i++) {
-		ch = &target->ch[i];
-		for (j = 0; j < target->req_ring_size; ++j) {
-			struct srp_request *req = &ch->req_ring[j];
-
-			srp_finish_req(ch, req, scmnd->device, DID_RESET << 16);
-		}
-	}
-
 	return SUCCESS;
 }
 


