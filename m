Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeBMTKF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:10:05 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46150 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbeBMTKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:10:04 -0500
X-Google-Smtp-Source: AH8x225MoqcnU4QMesxNcipKwGmzFD+okdpTyq6Sn9zMsHqJWKE8iOywpnsX06BEe1GipiH4//iE7w==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: smd: Use spinlock in tx path
Date: Tue, 13 Feb 2018 11:04:11 -0800
Message-Id: <20180213190411.25076-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By switching the tx_lock to a spinlock we allow clients to use
rpmsg_trysend() from atomic context.

The mutex was interruptable as it was previously held for the duration
of some client waiting for available space in the FIFO, but this was
recently changed to only be held temporarily - allowing us to replace it
with a spinlock.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 92d0c6a7a837..1066ee48420f 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -205,7 +205,7 @@ struct qcom_smd_channel {
 	struct smd_channel_info_pair *info;
 	struct smd_channel_info_word_pair *info_word;
 
-	struct mutex tx_lock;
+	spinlock_t tx_lock;
 	wait_queue_head_t fblockread_event;
 
 	void *tx_fifo;
@@ -729,6 +729,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 {
 	__le32 hdr[5] = { cpu_to_le32(len), };
 	int tlen = sizeof(hdr) + len;
+	unsigned long flags;
 	int ret;
 
 	/* Word aligned channels only accept word size aligned data */
@@ -739,9 +740,11 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 	if (tlen >= channel->fifo_size)
 		return -EINVAL;
 
-	ret = mutex_lock_interruptible(&channel->tx_lock);
-	if (ret)
-		return ret;
+	/* Highlight the fact that if we enter the loop below we might sleep */
+	if (wait)
+		might_sleep();
+
+	spin_lock_irqsave(&channel->tx_lock, flags);
 
 	while (qcom_smd_get_tx_avail(channel) < tlen &&
 	       channel->state == SMD_CHANNEL_OPENED) {
@@ -753,7 +756,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 		SET_TX_CHANNEL_FLAG(channel, fBLOCKREADINTR, 0);
 
 		/* Wait without holding the tx_lock */
-		mutex_unlock(&channel->tx_lock);
+		spin_unlock_irqrestore(&channel->tx_lock, flags);
 
 		ret = wait_event_interruptible(channel->fblockread_event,
 				       qcom_smd_get_tx_avail(channel) >= tlen ||
@@ -761,9 +764,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 		if (ret)
 			return ret;
 
-		ret = mutex_lock_interruptible(&channel->tx_lock);
-		if (ret)
-			return ret;
+		spin_lock_irqsave(&channel->tx_lock, flags);
 
 		SET_TX_CHANNEL_FLAG(channel, fBLOCKREADINTR, 1);
 	}
@@ -787,7 +788,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 	qcom_smd_signal_channel(channel);
 
 out_unlock:
-	mutex_unlock(&channel->tx_lock);
+	spin_unlock_irqrestore(&channel->tx_lock, flags);
 
 	return ret;
 }
@@ -1090,7 +1091,7 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 	if (!channel->name)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_init(&channel->tx_lock);
+	spin_lock_init(&channel->tx_lock);
 	spin_lock_init(&channel->recv_lock);
 	init_waitqueue_head(&channel->fblockread_event);
 	init_waitqueue_head(&channel->state_change_event);
-- 
2.15.0
