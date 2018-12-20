Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A675C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299F320989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298319;
	bh=WbUD8HTcfVkF3MUWgrTDUBrQAOmqVEPghTASzYwCdy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCmLmNuMCZpI3/9eP65Qzdhp+l0e7AQK9JHfrPlvzl+Jm4VHGqlkFZyAgtzrso2Ds
	 XACiOp3KafNZ81uxkcJfQfzlRD3oh0Eu0svMuYw3nfFrjnw8qGlFuSPhM+R1ZuOCK3
	 3lVFH++rfjOQPILPfdwXxhJXU7mBVbsWMCgEh2/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbeLTJbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733160AbeLTJbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:31:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAABD21741;
        Thu, 20 Dec 2018 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298296;
        bh=WbUD8HTcfVkF3MUWgrTDUBrQAOmqVEPghTASzYwCdy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqBpzLEjYE8m2ruoW2an0EH3+jNs6rJu4ZMgA4bNoLprhWUka6axT6gqDA5lkA3yW
         IIy7h13qG/h4YdftvEhNls+QIB6YBzgeR0vYxN6127n7d/ray9GO1foXBctmfET6zk
         WGrR8YC2kIRBSW1eeVpLf8/2wU8a4ELAdZPPNsko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 65/67] nvme: validate controller state before rescheduling keep alive
Date:   Thu, 20 Dec 2018 10:19:17 +0100
Message-Id: <20181220085906.107772719@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit 86880d646122240596d6719b642fee3213239994 ]

Delete operations are seeing NULL pointer references in call_timer_fn.
Tracking these back, the timer appears to be the keep alive timer.

nvme_keep_alive_work() which is tied to the timer that is cancelled
by nvme_stop_keep_alive(), simply starts the keep alive io but doesn't
wait for it's completion. So nvme_stop_keep_alive() only stops a timer
when it's pending. When a keep alive is in flight, there is no timer
running and the nvme_stop_keep_alive() will have no affect on the keep
alive io. Thus, if the io completes successfully, the keep alive timer
will be rescheduled.   In the failure case, delete is called, the
controller state is changed, the nvme_stop_keep_alive() is called while
the io is outstanding, and the delete path continues on. The keep
alive happens to successfully complete before the delete paths mark it
as aborted as part of the queue termination, so the timer is restarted.
The delete paths then tear down the controller, and later on the timer
code fires and the timer entry is now corrupt.

Fix by validating the controller state before rescheduling the keep
alive. Testing with the fix has confirmed the condition above was hit.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7b2659e02fa..e5bddae16ed4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -831,6 +831,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
+	unsigned long flags;
+	bool startka = false;
 
 	blk_mq_free_request(rq);
 
@@ -841,7 +843,13 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		return;
 	}
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE ||
+	    ctrl->state == NVME_CTRL_CONNECTING)
+		startka = true;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (startka)
+		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.19.1



