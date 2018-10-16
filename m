Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC1C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADDB2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wFAcg1yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADDB2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJPKvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:51:09 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45922 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJPKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:50:43 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9G31q7F017707;
        Tue, 16 Oct 2018 12:01:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9G31q7F017707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539658914;
        bh=0jExx5vDSGpy/qM7ZAif6aEaMMZKi5fc6yONUDddKPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFAcg1yhovR2BD7Pa1BaDM4Iwz5LBV8e8+Scpc+tokw5T1tsVE+y0f4GF3PfuaFYW
         ALMTN4QAsCTmGD548ePzCImxsg7YQ89yWEEHheqmeByeO9wrq4DPAXBuKFYFCnlyWK
         7ezAJf4tV1ttEVMsvIi+vYxuqCDHzBRfK8MrpuLGAtc15d1MNdC1sXPAoqMCw6WZu8
         VIyrMhOCHqo0yvFRZqoN1koxjhwQbSOL/5EbbMx41qaQzUxoqGxqT5M396Ly4FGiUU
         3mpUrT63Xx7lwxnKKvZJ5o55eFL3gXtPQcefyuhsV7EwbuMQk6KUPDlRJwN6Lovt8E
         DA/jlMzPRkUyA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] i2c: uniphier-f: fix occasional timeout error
Date:   Tue, 16 Oct 2018 12:01:48 +0900
Message-Id: <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a timeout error could happen at a repeated START condition.

For a (non-repeated) START condition, the controller starts sending
data when the UNIPHIER_FI2C_CR_STA bit is set. However, for a repeated
START condition, the hardware starts running when the slave address is
written to the TX FIFO - the write to the UNIPHIER_FI2C_CR register is
actually unneeded.

Because the hardware is already running before the IRQ is enabled for
a repeated START, the driver may miss the IRQ event. In most cases,
this problem does not show up since modern CPUs are much faster than
the I2C transfer. However, it is still possible that a context switch
happens after the controller starts, but before the IRQ register is
set up.

To fix this,

 - Do not write UNIPHIER_FI2C_CR for repeated START conditions.

 - Enable IRQ *before* writing the slave address to the TX FIFO.

 - Disable IRQ for the current CPU while queuing up the TX FIFO;
   If the CPU is interrupted by some task, the interrupt handler
   might be invoked due to the empty TX FIFO before completing the
   setup.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 200dfd1..0677153 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -260,6 +260,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 static void uniphier_fi2c_tx_init(struct uniphier_fi2c_priv *priv, u16 addr)
 {
 	priv->enabled_irqs |= UNIPHIER_FI2C_INT_TE;
+	uniphier_fi2c_set_irqs(priv);
+
 	/* do not use TX byte counter */
 	writel(0, priv->membase + UNIPHIER_FI2C_TBC);
 	/* set slave address */
@@ -292,6 +294,8 @@ static void uniphier_fi2c_rx_init(struct uniphier_fi2c_priv *priv, u16 addr)
 		priv->enabled_irqs |= UNIPHIER_FI2C_INT_RF;
 	}
 
+	uniphier_fi2c_set_irqs(priv);
+
 	/* set slave address with RD bit */
 	writel(UNIPHIER_FI2C_DTTX_CMD | UNIPHIER_FI2C_DTTX_RD | addr << 1,
 	       priv->membase + UNIPHIER_FI2C_DTTX);
@@ -315,14 +319,16 @@ static void uniphier_fi2c_recover(struct uniphier_fi2c_priv *priv)
 }
 
 static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
-					 struct i2c_msg *msg, bool stop)
+					 struct i2c_msg *msg, bool repeat,
+					 bool stop)
 {
 	struct uniphier_fi2c_priv *priv = i2c_get_adapdata(adap);
 	bool is_read = msg->flags & I2C_M_RD;
 	unsigned long time_left, flags;
 
-	dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, stop=%d\n",
-		is_read ? "receive" : "transmit", msg->addr, msg->len, stop);
+	dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, repeat=%d, stop=%d\n",
+		is_read ? "receive" : "transmit", msg->addr, msg->len,
+		repeat, stop);
 
 	priv->len = msg->len;
 	priv->buf = msg->buf;
@@ -338,16 +344,24 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	writel(UNIPHIER_FI2C_RST_TBRST | UNIPHIER_FI2C_RST_RBRST,
 	       priv->membase + UNIPHIER_FI2C_RST);	/* reset TX/RX FIFO */
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	if (is_read)
 		uniphier_fi2c_rx_init(priv, msg->addr);
 	else
 		uniphier_fi2c_tx_init(priv, msg->addr);
 
-	uniphier_fi2c_set_irqs(priv);
-
 	dev_dbg(&adap->dev, "start condition\n");
-	writel(UNIPHIER_FI2C_CR_MST | UNIPHIER_FI2C_CR_STA,
-	       priv->membase + UNIPHIER_FI2C_CR);
+	/*
+	 * For a repeated START condition, writing a slave address to the FIFO
+	 * kicks the controller. So, the UNIPHIER_FI2C_CR register should be
+	 * written only for a non-repeated START condition.
+	 */
+	if (!repeat)
+		writel(UNIPHIER_FI2C_CR_MST | UNIPHIER_FI2C_CR_STA,
+		       priv->membase + UNIPHIER_FI2C_CR);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	time_left = wait_for_completion_timeout(&priv->comp, adap->timeout);
 
@@ -408,6 +422,7 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapter *adap,
 				     struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *msg, *emsg = msgs + num;
+	bool repeat = false;
 	int ret;
 
 	ret = uniphier_fi2c_check_bus_busy(adap);
@@ -418,9 +433,11 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapter *adap,
 		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
 		bool stop = (msg + 1 == emsg) || (msg->flags & I2C_M_STOP);
 
-		ret = uniphier_fi2c_master_xfer_one(adap, msg, stop);
+		ret = uniphier_fi2c_master_xfer_one(adap, msg, repeat, stop);
 		if (ret)
 			return ret;
+
+		repeat = !stop;
 	}
 
 	return num;
-- 
2.7.4

