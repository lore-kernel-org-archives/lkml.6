Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC17EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03042146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtBJHaZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03042146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbeK3Bgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbeK3Bgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650A22146D;
        Thu, 29 Nov 2018 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501866;
        bh=XsEEmIaSmt+nFPTIVxSyy8N/T0XpCLnjuJStxPf50JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtBJHaZBm2RLaCPTKHUG6EvJHqn4HLtX0XGSBjiVQ6N8mAJue22+85FZ+ozoLJRNH
         VyhnyICRGly9w5s/Trsa4ElH6iS7bAKTJjIaEj7Lqyr/qPxy8ZlK3hlEbInz1H065p
         fppqCjYgkNI4xiuN5DdAMSPYithDwEi0+W1nsMN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 056/110] can: flexcan: handle tx-complete CAN frames via rx-offload infrastructure
Date:   Thu, 29 Nov 2018 15:12:27 +0100
Message-Id: <20181129135923.526445258@linuxfoundation.org>
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

commit ed72bc8bcb9277061e753faf300b20f97323761c upstream.

Current flexcan driver will put TX-ECHO in regular unsorted way, in
this case TX-ECHO can come after the response to the same TXed message.
In some cases, for example for J1939 stack, things will break.
This patch is using new rx-offload API to put the messages just in the
right place.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -794,8 +794,11 @@ static irqreturn_t flexcan_irq(int irq,
 
 	/* transmission complete interrupt */
 	if (reg_iflag1 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
+		u32 reg_ctrl = priv->read(&regs->mb[FLEXCAN_TX_MB].can_ctrl);
+
 		handled = IRQ_HANDLED;
-		stats->tx_bytes += can_get_echo_skb(dev, 0);
+		stats->tx_bytes += can_rx_offload_get_echo_skb(&priv->offload,
+							       0, reg_ctrl << 16);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
 


