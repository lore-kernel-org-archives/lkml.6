Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360DE21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360DE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbeIXS0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbeIXS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AFC031094;
        Mon, 24 Sep 2018 12:24:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 155/173] blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()
Date:   Mon, 24 Sep 2018 13:53:09 +0200
Message-Id: <20180924113126.670088676@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 1311326cf4755c7ffefd20f576144ecf46d9906b ]

SCSI probing may synchronously create and destroy a lot of request_queues
for non-existent devices. Any synchronize_rcu() in queue creation or
destroy path may introduce long latency during booting, see detailed
description in comment of blk_register_queue().

This patch removes one synchronize_rcu() inside blk_cleanup_queue()
for this case, commit c2856ae2f315d75(blk-mq: quiesce queue before freeing queue)
needs synchronize_rcu() for implementing blk_mq_quiesce_queue(), but
when queue isn't initialized, it isn't necessary to do that since
only pass-through requests are involved, no original issue in
scsi_execute() at all.

Without this patch and previous one, it may take more 20+ seconds for
virtio-scsi to complete disk probe. With the two patches, the time becomes
less than 100ms.

Fixes: c2856ae2f315d75 ("blk-mq: quiesce queue before freeing queue")
Reported-by: Andrew Jones <drjones@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -669,9 +669,13 @@ void blk_cleanup_queue(struct request_qu
 	 * make sure all in-progress dispatch are completed because
 	 * blk_freeze_queue() can only complete all requests, and
 	 * dispatch may still be in-progress since we dispatch requests
-	 * from more than one contexts
+	 * from more than one contexts.
+	 *
+	 * No need to quiesce queue if it isn't initialized yet since
+	 * blk_freeze_queue() should be enough for cases of passthrough
+	 * request.
 	 */
-	if (q->mq_ops)
+	if (q->mq_ops && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
 
 	/* for synchronous bio-based driver finish in-flight integrity i/o */


