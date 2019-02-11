Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F47E2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895712;
	bh=NNKqMCN/k/TP/RBnw5dfn5dUfgdbZAup/EisBFeg91U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKtBpVnlpe3n41YjnjmvzFX7Y6GBAGr9svWvhMnyPiJbNuP82yhWpOJyc7fk8PbHR
	 N4zXyfYW5s3WrbJea7g2kTu+fAXamWS72gtJ9a4koY+ULrj4J2TU9TQL/Kz3Ez0nak
	 yGxKWt2eCA/ykB1gFgIrbBTBfr12V3JUYYVZEzjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfBKOfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbfBKOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426EB20700;
        Mon, 11 Feb 2019 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895705;
        bh=NNKqMCN/k/TP/RBnw5dfn5dUfgdbZAup/EisBFeg91U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0lDgxRXiORaNR0+xtReML9fR6qaYn9eKUK59suxtYh+eYyfZvn1TsFmL24LwYo/L
         RyHL40BwiAalF5f5ZNmL8NjUMkMT6sZWLsQuv8cv5NxDQtq8sjmBwZOEAoOF/xldLX
         HrCPyDgOdopTqKoQzUX2ZjKHx22fBEPMWPJvFAeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 295/352] net: dp83640: expire old TX-skb
Date:   Mon, 11 Feb 2019 15:18:42 +0100
Message-Id: <20190211141905.662732944@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 53bc8d2af08654659abfadfd3e98eb9922ff787c ]

During sendmsg() a cloned skb is saved via dp83640_txtstamp() in
->tx_queue. After the NIC sends this packet, the PHY will reply with a
timestamp for that TX packet. If the cable is pulled at the right time I
don't see that packet. It might gets flushed as part of queue shutdown
on NIC's side.
Once the link is up again then after the next sendmsg() we enqueue
another skb in dp83640_txtstamp() and have two on the list. Then the PHY
will send a reply and decode_txts() attaches it to the first skb on the
list.
No crash occurs since refcounting works but we are one packet behind.
linuxptp/ptp4l usually closes the socket and opens a new one (in such a
timeout case) so those "stale" replies never get there. However it does
not resume normal operation anymore.

Purge old skbs in decode_txts().

Fixes: cb646e2b02b2 ("ptp: Added a clock driver for the National Semiconductor PHYTER.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83640.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -898,14 +898,14 @@ static void decode_txts(struct dp83640_p
 			struct phy_txts *phy_txts)
 {
 	struct skb_shared_hwtstamps shhwtstamps;
+	struct dp83640_skb_info *skb_info;
 	struct sk_buff *skb;
-	u64 ns;
 	u8 overflow;
+	u64 ns;
 
 	/* We must already have the skb that triggered this. */
-
+again:
 	skb = skb_dequeue(&dp83640->tx_queue);
-
 	if (!skb) {
 		pr_debug("have timestamp but tx_queue empty\n");
 		return;
@@ -920,6 +920,11 @@ static void decode_txts(struct dp83640_p
 		}
 		return;
 	}
+	skb_info = (struct dp83640_skb_info *)skb->cb;
+	if (time_after(jiffies, skb_info->tmo)) {
+		kfree_skb(skb);
+		goto again;
+	}
 
 	ns = phy2txts(phy_txts);
 	memset(&shhwtstamps, 0, sizeof(shhwtstamps));
@@ -1472,6 +1477,7 @@ static bool dp83640_rxtstamp(struct phy_
 static void dp83640_txtstamp(struct phy_device *phydev,
 			     struct sk_buff *skb, int type)
 {
+	struct dp83640_skb_info *skb_info = (struct dp83640_skb_info *)skb->cb;
 	struct dp83640_private *dp83640 = phydev->priv;
 
 	switch (dp83640->hwts_tx_en) {
@@ -1484,6 +1490,7 @@ static void dp83640_txtstamp(struct phy_
 		/* fall through */
 	case HWTSTAMP_TX_ON:
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		skb_info->tmo = jiffies + SKB_TIMESTAMP_TIMEOUT;
 		skb_queue_tail(&dp83640->tx_queue, skb);
 		break;
 


