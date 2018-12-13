Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7634C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFC620849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676362;
	bh=66bIVOUhszalWq34bmkerV14UFkvSHRPxHOyFzoG0Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PcIvX5OwdP1OVbsUZUxSGyMuwuft8BaDXq9e8T6UWlr08Z8eYyAPxLLnAKHdz21q2
	 rt+qoW5aT7yYj13scBgAb8qB6/U+CJoxbmVsHIEHk1oTL593cZ4RF1X6KzaWo22gsz
	 S3TvZ1o9H7LG7d5xN8nCIZsXaA3jOQI3TiGSJYDk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFC620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeLMEqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbeLMEat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED0820989;
        Thu, 13 Dec 2018 04:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675448;
        bh=66bIVOUhszalWq34bmkerV14UFkvSHRPxHOyFzoG0Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IawTy8P1U1l3pVoDP6OOqVGQSKDds8Ps9RLc85Ung+5YvCv30LKTSbQJRQB0wYrZa
         7IGSo6Va3yzTn5swkiN6U+DR0czBYmTI9x/U8Buzs+cB1U02/+7atln9LbAkO86jYy
         XZT/ynDdvm+igAGORxlNfC4rxugLowXFqeAy+7lo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 70/73] nvme: validate controller state before rescheduling keep alive
Date:   Wed, 12 Dec 2018 23:28:35 -0500
Message-Id: <20181213042838.75160-70-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

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
index 0ba301f7e8b4..05bd7f49d6e0 100644
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

