Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2374BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6D3213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1LxJAwU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6D3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbeK3BbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbeK3BbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA4721104;
        Thu, 29 Nov 2018 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501547;
        bh=nPGeBt17VuCWQ8jd9ctbNa+G+Fq2W/FMhEmpbefUAtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LxJAwU7u4s9ck2zTpjK/nDHlo89AHP+M/ZAy839nkf5qTAo23uf+QpdOl88j7USL
         jBccD1NeXJlWUoFw1sWpKuXLlpUDF4K54scriqolBSBFraCRwQH+h0NCW094yBb9WL
         WuKWxih5duoNzUE43o0lbYwQJqgeOzOGfVuuXKRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 041/100] can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_offload_queue_tail()
Date:   Thu, 29 Nov 2018 15:12:11 +0100
Message-Id: <20181129140102.284955336@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit 4530ec36bb1e0d24f41c33229694adacda3d5d89 upstream.

This function has nothing todo with error.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c      |    4 ++--
 drivers/net/can/rx-offload.c   |    5 +++--
 include/linux/can/rx-offload.h |    3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -599,7 +599,7 @@ static void flexcan_irq_bus_err(struct n
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
+	can_rx_offload_queue_tail(&priv->offload, skb);
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
@@ -639,7 +639,7 @@ static void flexcan_irq_state(struct net
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
+	can_rx_offload_queue_tail(&priv->offload, skb);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -255,7 +255,8 @@ unsigned int can_rx_offload_get_echo_skb
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb);
 
-int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb)
+int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+			      struct sk_buff *skb)
 {
 	if (skb_queue_len(&offload->skb_queue) >
 	    offload->skb_queue_len_max)
@@ -266,7 +267,7 @@ int can_rx_offload_irq_queue_err_skb(str
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(can_rx_offload_irq_queue_err_skb);
+EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
 static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
 {
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -45,7 +45,8 @@ int can_rx_offload_queue_sorted(struct c
 				struct sk_buff *skb, u32 timestamp);
 unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 					 unsigned int idx, u32 timestamp);
-int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb);
+int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+			      struct sk_buff *skb);
 void can_rx_offload_reset(struct can_rx_offload *offload);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);


