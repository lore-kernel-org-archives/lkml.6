Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F256DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B550820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B550820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbeGWNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:32:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbeGWNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:32:41 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B75C6C21;
        Mon, 23 Jul 2018 12:31:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 28/28] block: do not use interruptible wait anywhere
Date:   Mon, 23 Jul 2018 14:25:28 +0200
Message-Id: <20180723122427.132810156@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122425.241418073@linuxfoundation.org>
References: <20180723122425.241418073@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Jenkins <alan.christopher.jenkins@gmail.com>

commit 1dc3039bc87ae7d19a990c3ee71cfd8a9068f428 upstream.

When blk_queue_enter() waits for a queue to unfreeze, or unset the
PREEMPT_ONLY flag, do not allow it to be interrupted by a signal.

The PREEMPT_ONLY flag was introduced later in commit 3a0a529971ec
("block, scsi: Make SCSI quiesce and resume work reliably").  Note the SCSI
device is resumed asynchronously, i.e. after un-freezing userspace tasks.

So that commit exposed the bug as a regression in v4.15.  A mysterious
SIGBUS (or -EIO) sometimes happened during the time the device was being
resumed.  Most frequently, there was no kernel log message, and we saw Xorg
or Xwayland killed by SIGBUS.[1]

[1] E.g. https://bugzilla.redhat.com/show_bug.cgi?id=1553979

Without this fix, I get an IO error in this test:

# dd if=/dev/sda of=/dev/null iflag=direct & \
  while killall -SIGUSR1 dd; do sleep 0.1; done & \
  echo mem > /sys/power/state ; \
  sleep 5; killall dd  # stop after 5 seconds

The interruptible wait was added to blk_queue_enter in
commit 3ef28e83ab15 ("block: generic request_queue reference counting").
Before then, the interruptible wait was only in blk-mq, but I don't think
it could ever have been correct.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -652,7 +652,6 @@ EXPORT_SYMBOL(blk_alloc_queue);
 int blk_queue_enter(struct request_queue *q, bool nowait)
 {
 	while (true) {
-		int ret;
 
 		if (percpu_ref_tryget_live(&q->q_usage_counter))
 			return 0;
@@ -660,13 +659,11 @@ int blk_queue_enter(struct request_queue
 		if (nowait)
 			return -EBUSY;
 
-		ret = wait_event_interruptible(q->mq_freeze_wq,
-				!atomic_read(&q->mq_freeze_depth) ||
-				blk_queue_dying(q));
+		wait_event(q->mq_freeze_wq,
+			   !atomic_read(&q->mq_freeze_depth) ||
+			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
-		if (ret)
-			return ret;
 	}
 }
 


