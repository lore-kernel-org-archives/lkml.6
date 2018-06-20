Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2C120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeFTMVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:21:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12657 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeFTMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2a46a40000>; Wed, 20 Jun 2018 05:20:52 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 05:21:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Jun 2018 05:21:14 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:13 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:13 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 20 Jun 2018 12:21:13 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b2a46b60003>; Wed, 20 Jun 2018 05:21:12 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 3/8] mailbox: Add transmit done by blocking option
Date:   Wed, 20 Jun 2018 15:20:37 +0300
Message-ID: <20180620122042.10950-4-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
send_data function of the mailbox driver is expected to block until
the message has been sent. The new option is used with the Tegra
Combined UART driver to minimize unnecessary overhead when transmitting
data.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
 drivers/mailbox/mailbox.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..5c76b70e673c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -53,6 +53,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	return idx;
 }
 
+static void tx_tick(struct mbox_chan *chan, int r, bool submit_next);
+
 static void msg_submit(struct mbox_chan *chan)
 {
 	unsigned count, idx;
@@ -60,10 +62,13 @@ static void msg_submit(struct mbox_chan *chan)
 	void *data;
 	int err = -EBUSY;
 
+next:
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
-		goto exit;
+	if (!chan->msg_count || chan->active_req) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return;
+	}
 
 	count = chan->msg_count;
 	idx = chan->msg_free;
@@ -82,15 +87,21 @@ static void msg_submit(struct mbox_chan *chan)
 		chan->active_req = data;
 		chan->msg_count--;
 	}
-exit:
+
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
 		/* kick start the timer immediately to avoid delays */
 		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+
+	if (chan->txdone_method & TXDONE_BY_BLOCK) {
+		tx_tick(chan, err, false);
+		if (!err)
+			goto next;
+	}
 }
 
-static void tx_tick(struct mbox_chan *chan, int r)
+static void tx_tick(struct mbox_chan *chan, int r, bool submit_next)
 {
 	unsigned long flags;
 	void *mssg;
@@ -101,7 +112,8 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Submit next message */
-	msg_submit(chan);
+	if (submit_next)
+		msg_submit(chan);
 
 	if (!mssg)
 		return;
@@ -127,7 +139,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 		if (chan->active_req && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
-				tx_tick(chan, 0);
+				tx_tick(chan, 0, true);
 			else
 				resched = true;
 		}
@@ -176,7 +188,7 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, true);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 
@@ -196,7 +208,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, true);
 }
 EXPORT_SYMBOL_GPL(mbox_client_txdone);
 
@@ -275,7 +287,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		ret = wait_for_completion_timeout(&chan->tx_complete, wait);
 		if (ret == 0) {
 			t = -ETIME;
-			tx_tick(chan, t);
+			tx_tick(chan, t, true);
 		}
 	}
 
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 456ba68513bb..ec68e2e28cd6 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -10,5 +10,6 @@
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+#define TXDONE_BY_BLOCK	BIT(3) /* mailbox driver send_data blocks until done */
 
 #endif /* __MAILBOX_H */
-- 
2.16.1

