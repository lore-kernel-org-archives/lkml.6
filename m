Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424902146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGx0vxVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424902146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeK3Bfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbeK3Bfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7FA42145D;
        Thu, 29 Nov 2018 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501820;
        bh=RheXuBgCQoLV5PH1S2X4k5fRz9tjIWgnwrIrdB+lRkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGx0vxVSnrZbVbc2pc92yBQ1gDq4r1/3mVxJIJ6gO+AHfxyAKDDayG6jgtOY0M8pO
         ox+sjJYvwnKXULXZZBLxqtoIiNIELOmtsXdJbV8ljYrU+xzsSj0D/YXCZVjlVT6jEO
         Y7E9UhB1iwVRLmd68pR9puW2vbNS/DBfLRaRwHuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 053/110] can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_offload_queue_sorted() functions
Date:   Thu, 29 Nov 2018 15:12:24 +0100
Message-Id: <20181129135923.412164060@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit 55059f2b7f868cd43b3ad30e28e18347e1b46ace upstream.

Current CAN framework can't guarantee proper/chronological order
of RX and TX-ECHO messages. To make this possible, drivers should use
this functions instead of can_get_echo_skb().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/rx-offload.c   |   46 +++++++++++++++++++++++++++++++++++++++++
 include/linux/can/rx-offload.h |    4 +++
 2 files changed, 50 insertions(+)

--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -209,6 +209,52 @@ int can_rx_offload_irq_offload_fifo(stru
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
 
+int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
+				struct sk_buff *skb, u32 timestamp)
+{
+	struct can_rx_offload_cb *cb;
+	unsigned long flags;
+
+	if (skb_queue_len(&offload->skb_queue) >
+	    offload->skb_queue_len_max)
+		return -ENOMEM;
+
+	cb = can_rx_offload_get_cb(skb);
+	cb->timestamp = timestamp;
+
+	spin_lock_irqsave(&offload->skb_queue.lock, flags);
+	__skb_queue_add_sort(&offload->skb_queue, skb, can_rx_offload_compare);
+	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+
+	can_rx_offload_schedule(offload);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_queue_sorted);
+
+unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
+					 unsigned int idx, u32 timestamp)
+{
+	struct net_device *dev = offload->dev;
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	u8 len;
+	int err;
+
+	skb = __can_get_echo_skb(dev, idx, &len);
+	if (!skb)
+		return 0;
+
+	err = can_rx_offload_queue_sorted(offload, skb, timestamp);
+	if (err) {
+		stats->rx_errors++;
+		stats->tx_fifo_errors++;
+	}
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb);
+
 int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb)
 {
 	if (skb_queue_len(&offload->skb_queue) >
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -41,6 +41,10 @@ int can_rx_offload_add_timestamp(struct
 int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight);
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 reg);
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
+int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
+				struct sk_buff *skb, u32 timestamp);
+unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
+					 unsigned int idx, u32 timestamp);
 int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb);
 void can_rx_offload_reset(struct can_rx_offload *offload);
 void can_rx_offload_del(struct can_rx_offload *offload);


