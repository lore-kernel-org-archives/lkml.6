Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeBMTKN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:10:13 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37006 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753260AbeBMTKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:10:10 -0500
X-Google-Smtp-Source: AH8x2258SXHCEliAAjjnoUM43AJwK9m/q+jgQh2VwEQlH0lGdjSUdAFaoWkMM7WV3mR+RdnhYmYHCQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: glink: Use spinlock in tx path
Date: Tue, 13 Feb 2018 11:04:04 -0800
Message-Id: <20180213190404.25026-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the tx_lock to a spinlock we allow clients to use rpmsg_trysend()
from atomic context.

In order to allow clients to sleep while waiting for space in the FIFO
we release the lock temporarily around the delay; which should be
replaced by sending a READ_NOTIF and waiting for the remote to signal
us that space has been made available.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index e0f31ed096a5..6e950e9afa82 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -113,7 +113,7 @@ struct qcom_glink {
 	spinlock_t rx_lock;
 	struct list_head rx_queue;
 
-	struct mutex tx_lock;
+	spinlock_t tx_lock;
 
 	spinlock_t idr_lock;
 	struct idr lcids;
@@ -288,15 +288,14 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 			 const void *data, size_t dlen, bool wait)
 {
 	unsigned int tlen = hlen + dlen;
+	unsigned long flags;
 	int ret;
 
 	/* Reject packets that are too big */
 	if (tlen >= glink->tx_pipe->length)
 		return -EINVAL;
 
-	ret = mutex_lock_interruptible(&glink->tx_lock);
-	if (ret)
-		return ret;
+	spin_lock_irqsave(&glink->tx_lock, flags);
 
 	while (qcom_glink_tx_avail(glink) < tlen) {
 		if (!wait) {
@@ -304,7 +303,12 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 			goto out;
 		}
 
+		/* Wait without holding the tx_lock */
+		spin_unlock_irqrestore(&glink->tx_lock, flags);
+
 		usleep_range(10000, 15000);
+
+		spin_lock_irqsave(&glink->tx_lock, flags);
 	}
 
 	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
@@ -313,7 +317,7 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 	mbox_client_txdone(glink->mbox_chan, 0);
 
 out:
-	mutex_unlock(&glink->tx_lock);
+	spin_unlock_irqrestore(&glink->tx_lock, flags);
 
 	return ret;
 }
@@ -1567,7 +1571,7 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	glink->features = features;
 	glink->intentless = intentless;
 
-	mutex_init(&glink->tx_lock);
+	spin_lock_init(&glink->tx_lock);
 	spin_lock_init(&glink->rx_lock);
 	INIT_LIST_HEAD(&glink->rx_queue);
 	INIT_WORK(&glink->rx_work, qcom_glink_work);
-- 
2.15.0
