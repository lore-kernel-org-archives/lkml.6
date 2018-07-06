Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFCA208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFCA208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934563AbeGFFwX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933713AbeGFFwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:20 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 560DEB14;
        Fri,  6 Jul 2018 05:52:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 48/61] s390/dasd: use blk_mq_rq_from_pdu for per request data
Date:   Fri,  6 Jul 2018 07:47:12 +0200
Message-Id: <20180706054714.184058642@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
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

From: Sebastian Ott <sebott@linux.ibm.com>

[ Upstream commit f0f59a2fab8e52b9d582b39da39f22230ca80aee ]

Dasd uses completion_data from struct request to store per request
private data - this is problematic since this member is part of a
union which is also used by IO schedulers.
Let the block layer maintain space for per request data behind each
struct request.

Fixes crashes on block layer timeouts like this one:

Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000000000000000 TEID: 0000000000000483
Fault in home space mode while using kernel ASCE.
AS:0000000001308007 R3:00000000fffc8007 S:00000000fffcc000 P:000000000000013d
Oops: 0004 ilc:2 [#1] PREEMPT SMP
Modules linked in: [...]
CPU: 0 PID: 1480 Comm: kworker/0:2H Not tainted 4.17.0-rc4-00046-gaa3bcd43b5af #203
Hardware name: IBM 3906 M02 702 (LPAR)
Workqueue: kblockd blk_mq_timeout_work
Krnl PSW : 0000000067ac406b 00000000b6960308 (do_raw_spin_trylock+0x30/0x78)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000c00 0000000000000000 0000000000000000 0000000000000001
           0000000000b9d3c8 0000000000000000 0000000000000001 00000000cf9639d8
           0000000000000000 0700000000000000 0000000000000000 000000000099f09e
           0000000000000000 000000000076e9d0 000000006247bb08 000000006247bae0
Krnl Code: 00000000001c159c: b90400c2           lgr     %r12,%r2
           00000000001c15a0: a7180000           lhi     %r1,0
          #00000000001c15a4: 583003a4           l       %r3,932
          >00000000001c15a8: ba132000           cs      %r1,%r3,0(%r2)
           00000000001c15ac: a7180001           lhi     %r1,1
           00000000001c15b0: a784000b           brc     8,1c15c6
           00000000001c15b4: c0e5004e72aa       brasl   %r14,b8fb08
           00000000001c15ba: 1812               lr      %r1,%r2
Call Trace:
([<0700000000000000>] 0x700000000000000)
 [<0000000000b9d3d2>] _raw_spin_lock_irqsave+0x7a/0xb8
 [<000000000099f09e>] dasd_times_out+0x46/0x278
 [<000000000076ea6e>] blk_mq_terminate_expired+0x9e/0x108
 [<000000000077497a>] bt_for_each+0x102/0x130
 [<0000000000774e54>] blk_mq_queue_tag_busy_iter+0x74/0xd8
 [<000000000076fea0>] blk_mq_timeout_work+0x260/0x320
 [<0000000000169dd4>] process_one_work+0x3bc/0x708
 [<000000000016a382>] worker_thread+0x262/0x408
 [<00000000001723a8>] kthread+0x160/0x178
 [<0000000000b9e73a>] kernel_thread_starter+0x6/0xc
 [<0000000000b9e734>] kernel_thread_starter+0x0/0xc
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<0000000000b9d3cc>] _raw_spin_lock_irqsave+0x74/0xb8

Kernel panic - not syncing: Fatal exception: panic_on_oops

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3049,7 +3049,8 @@ static blk_status_t do_dasd_request(stru
 	cqr->callback_data = req;
 	cqr->status = DASD_CQR_FILLED;
 	cqr->dq = dq;
-	req->completion_data = cqr;
+	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
+
 	blk_mq_start_request(req);
 	spin_lock(&block->queue_lock);
 	list_add_tail(&cqr->blocklist, &block->ccw_queue);
@@ -3073,12 +3074,13 @@ out:
  */
 enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 {
-	struct dasd_ccw_req *cqr = req->completion_data;
 	struct dasd_block *block = req->q->queuedata;
 	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
 	unsigned long flags;
 	int rc = 0;
 
+	cqr = *((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req));
 	if (!cqr)
 		return BLK_EH_NOT_HANDLED;
 
@@ -3184,6 +3186,7 @@ static int dasd_alloc_queue(struct dasd_
 	int rc;
 
 	block->tag_set.ops = &dasd_mq_ops;
+	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req *);
 	block->tag_set.nr_hw_queues = DASD_NR_HW_QUEUES;
 	block->tag_set.queue_depth = DASD_MAX_LCU_DEV * DASD_REQ_PER_DEV;
 	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;


