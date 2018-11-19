Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4241FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB3208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzFiVWgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAB3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeKTC6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbeKTC6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74F32089F;
        Mon, 19 Nov 2018 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645267;
        bh=WTO9ZRcuQlc4XEam7Z50CQC/adgNeartxlFpDYeqmsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzFiVWgCkg6EuAGQrMHvtE8QMHvlJfbdQcp3HcSZ9VqSF4mM7pi6Bxc9UkSeUz6m9
         YCqxU3ExG7/DhvMAkJZt6qjBfdIBfZQnnZtTUR/UKCn8KcNuRKcRbZZVDimMQrtp6Y
         wM56xX8Z550KRhn3LlJQSAB55qclNg/hYiafKMSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 098/205] SCSI: fix queue cleanup race before queue initialization is done
Date:   Mon, 19 Nov 2018 17:26:45 +0100
Message-Id: <20181119162633.027739711@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a upstream.

c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
already fixed this race, however the implied synchronize_rcu()
in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
performance regression.

Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
tried to quiesce queue for avoiding unnecessary synchronize_rcu()
only when queue initialization is done, because it is usual to see
lots of inexistent LUNs which need to be probed.

However, turns out it isn't safe to quiesce queue only when queue
initialization is done. Because when one SCSI command is completed,
the user of sending command can be waken up immediately, then the
scsi device may be removed, meantime the run queue in scsi_end_request()
is still in-progress, so kernel panic can be caused.

In Red Hat QE lab, there are several reports about this kind of kernel
panic triggered during kernel booting.

This patch tries to address the issue by grabing one queue usage
counter during freeing one request and the following run queue.

Fixes: 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
Cc: Andrew Jones <drjones@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: stable <stable@vger.kernel.org>
Cc: jianchao.wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c        |    5 ++---
 drivers/scsi/scsi_lib.c |    8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -793,9 +793,8 @@ void blk_cleanup_queue(struct request_qu
 	 * dispatch may still be in-progress since we dispatch requests
 	 * from more than one contexts.
 	 *
-	 * No need to quiesce queue if it isn't initialized yet since
-	 * blk_freeze_queue() should be enough for cases of passthrough
-	 * request.
+	 * We rely on driver to deal with the race in case that queue
+	 * initialization isn't done.
 	 */
 	if (q->mq_ops && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -697,6 +697,12 @@ static bool scsi_end_request(struct requ
 		 */
 		scsi_mq_uninit_cmd(cmd);
 
+		/*
+		 * queue is still alive, so grab the ref for preventing it
+		 * from being cleaned up during running queue.
+		 */
+		percpu_ref_get(&q->q_usage_counter);
+
 		__blk_mq_end_request(req, error);
 
 		if (scsi_target(sdev)->single_lun ||
@@ -704,6 +710,8 @@ static bool scsi_end_request(struct requ
 			kblockd_schedule_work(&sdev->requeue_work);
 		else
 			blk_mq_run_hw_queues(q, true);
+
+		percpu_ref_put(&q->q_usage_counter);
 	} else {
 		unsigned long flags;
 


