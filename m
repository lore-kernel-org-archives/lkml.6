Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F6FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4062082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lw3qleMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4062082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeLFD4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:56:51 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:59210 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbeLFD4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:56:48 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB63trS7007398;
        Thu, 6 Dec 2018 12:55:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS7007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544068555;
        bh=i2ojI7R92ngd4Xq06C6mSR5SZWE8QuYiZ8bI+8Q1qyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lw3qleMFLx7MX5hI2QHV+N1op9V3rzX2NxKj4ltz9br1n2EUdhJgOO8Yy6UW3yGC6
         40hSFYWCpcX+5XzSj4zpC9S1lSqy2tpPL+yx+5+YfpARAVQn/DmH8bAKL99Fekh1g/
         eRsyOBwGoeREpuLOF1KfwqmezRX7VYC9lPVrLobqkEdJbkvaIED8WKo0yw4WkD9MST
         HcggJZHWRxMtXgutDem94exOe41dzM3hmorTTUeQx8Of5tOMB1G70fSBB/KitdNQAj
         HEtQ8boE90NnN9IBzcXYSCW+Cbgxn90D06lZqVC6tDaBs8l69PTBmE1YMcbPH76eRX
         kaQh/KGg0/wqg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
Date:   Thu,  6 Dec 2018 12:55:26 +0900
Message-Id: <1544068528-27657-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - For a repeated START condition, this controller starts data transfer
   immediately after the slave address is written to the TX-FIFO.

 - Once the TX-FIFO empty interrupt is asserted, the controller makes
   a pause even if additional data are written to the TX-FIFO.

Given those circumstances, the data after a repeated START may not be
transferred if the interrupt is asserted while the TX-FIFO is being
filled up. A more reliable way is to append TX data only in the
interrupt handler.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index fad2b00..d8a5db14 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -269,7 +269,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
+static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr,
+				  bool repeat)
 {
 	priv->enabled_irqs |= UNIPHIER_FI2C_INT_TE;
 	uniphier_fi2c_set_irqs(priv);
@@ -279,8 +280,12 @@ static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
 	/* set slave address */
 	writel(UNIPHIER_FI2C_DTTX_CMD | addr << 1,
 	       priv->membase + UNIPHIER_FI2C_DTTX);
-	/* first chunk of data */
-	uniphier_fi2c_fill_txfifo(priv, true);
+	/*
+	 * First chunk of data. For a repeated START condition, do not write
+	 * data to the TX fifo here to avoid the timing issue.
+	 */
+	if (!repeat)
+		uniphier_fi2c_fill_txfifo(priv, true);
 }
 
 static void uniphier_fi2c_rx_init(struct uniphier_fi2c_priv *priv, u16 addr)
@@ -361,7 +366,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	if (is_read)
 		uniphier_fi2c_rx_init(priv, msg->addr);
 	else
-		uniphier_fi2c_tx_init(priv, msg->addr);
+		uniphier_fi2c_tx_init(priv, msg->addr, repeat);
 
 	dev_dbg(&adap->dev, "start condition\n");
 	/*
-- 
2.7.4

