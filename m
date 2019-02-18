Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2225BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E644420449
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498013;
	bh=5dtjvQcmvI8RJLw81c2/eSohufywToOB8UszzZDa78Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2k/W8URmAeFhAYu5b0Rplccc2LkjBFeliV+kTs3RIdrmv4cBduBhX3XoCHI6V8ReL
	 dhJ5clM5MVw7Ec9dmlb2uleqQMxhD1iOxaOijFi2FISUixLR6NOm6nLxCiETbi8nb5
	 314jjOewKszIawVWQGv+GATOlV5ni7qhA9aKt5DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbfBRNxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732552AbfBRNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 222C820842;
        Mon, 18 Feb 2019 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498007;
        bh=5dtjvQcmvI8RJLw81c2/eSohufywToOB8UszzZDa78Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oviih1v+Ro76bHOMpYVKjNDwfhFUqYapq1FU+p/fKfrtTKJ/cn3qBpYXq/LiQITnS
         ae1U4x1ARouKexIsi0rV7vcekllFg3/7F2nsPlswSNHSaThsax76OJ0ArVSemCPM41
         cy/IY7lQuOEZz2dUfhyJsLAlqQLGCKvP0gGS4btE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zachary Hays <zhays@lexmark.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 64/85] mmc: block: handle complete_work on separate workqueue
Date:   Mon, 18 Feb 2019 14:43:30 +0100
Message-Id: <20190218133506.140415853@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zachary Hays <zhays@lexmark.com>

commit dcf6e2e38a1c7ccbc535de5e1d9b14998847499d upstream.

The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
This generates a rescuer thread for that queue that will trigger when
the CPU is under heavy load and collect the uncompleted work.

In the case of mmc, this creates the possibility of a deadlock when
there are multiple partitions on the device as other blk-mq work is
also run on the same queue. For example:

- worker 0 claims the mmc host to work on partition 1
- worker 1 attempts to claim the host for partition 2 but has to wait
  for worker 0 to finish
- worker 0 schedules complete_work to release the host
- rescuer thread is triggered after time-out and collects the dangling
  work
- rescuer thread attempts to complete the work in order starting with
  claim host
- the task to release host is now blocked by a task to claim it and
  will never be called

The above results in multiple hung tasks that lead to failures to
mount partitions.

Handling complete_work on a separate workqueue avoids this by keeping
the work completion tasks separate from the other blk-mq work. This
allows the host to be released without getting blocked by other tasks
attempting to claim the host.

Signed-off-by: Zachary Hays <zhays@lexmark.com>
Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |   10 +++++++++-
 include/linux/mmc/card.h |    1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2114,7 +2114,7 @@ static void mmc_blk_mq_req_done(struct m
 		if (waiting)
 			wake_up(&mq->wait);
 		else
-			kblockd_schedule_work(&mq->complete_work);
+			queue_work(mq->card->complete_wq, &mq->complete_work);
 
 		return;
 	}
@@ -2928,6 +2928,13 @@ static int mmc_blk_probe(struct mmc_card
 
 	mmc_fixup_device(card, mmc_blk_fixups);
 
+	card->complete_wq = alloc_workqueue("mmc_complete",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (unlikely(!card->complete_wq)) {
+		pr_err("Failed to create mmc completion workqueue");
+		return -ENOMEM;
+	}
+
 	md = mmc_blk_alloc(card);
 	if (IS_ERR(md))
 		return PTR_ERR(md);
@@ -2991,6 +2998,7 @@ static void mmc_blk_remove(struct mmc_ca
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
 	dev_set_drvdata(&card->dev, NULL);
+	destroy_workqueue(card->complete_wq);
 }
 
 static int _mmc_blk_suspend(struct mmc_card *card)
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -308,6 +308,7 @@ struct mmc_card {
 	unsigned int    nr_parts;
 
 	unsigned int		bouncesz;	/* Bounce buffer size */
+	struct workqueue_struct *complete_wq;	/* Private workqueue */
 };
 
 static inline bool mmc_large_sector(struct mmc_card *card)


