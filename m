Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1311C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44192146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zpGyDgDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44192146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbeK3BgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbeK3BgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1157B2146D;
        Thu, 29 Nov 2018 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501839;
        bh=9YuLFtH4iJ5jvMI1LylK1xbOIh5NUDK9xjc5blcQeyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpGyDgDR4yd62sN5SAc86ZAbGC5uJN1KbF66THvh1XOV/DZ/wQ2lysPrxzn7HIhjV
         jHunSnbwNr0OFczGVT7bNG0Xmbk4M5ltCfyjs7YGxM7pZygINlfFhSCMbE0VB0JE8Q
         0RdFLe2tmYEGKW37/3rzVAjGh5M65IhNu8rE1DE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 055/110] can: flexcan: use can_rx_offload_queue_sorted() for flexcan_irq_bus_*()
Date:   Thu, 29 Nov 2018 15:12:26 +0100
Message-Id: <20181129135923.487469738@linuxfoundation.org>
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

commit d788905f68fd4714c82936f6f7f1d3644d7ae7ef upstream.

Currently, in case of bus error, driver will generate error message and put
in the tail of the message queue. To avoid confusions, this change should
place the bus related messages in proper order.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -563,9 +563,13 @@ static netdev_tx_t flexcan_start_xmit(st
 static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	bool rx_errors = false, tx_errors = false;
+	u32 timestamp;
+
+	timestamp = priv->read(&regs->timer) << 16;
 
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
@@ -612,17 +616,21 @@ static void flexcan_irq_bus_err(struct n
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_queue_tail(&priv->offload, skb);
+	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	enum can_state new_state, rx_state, tx_state;
 	int flt;
 	struct can_berr_counter bec;
+	u32 timestamp;
+
+	timestamp = priv->read(&regs->timer) << 16;
 
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
@@ -652,7 +660,7 @@ static void flexcan_irq_state(struct net
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	can_rx_offload_queue_tail(&priv->offload, skb);
+	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)


