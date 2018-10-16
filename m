Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F545C04EBE
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D222089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LTjHPHS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D222089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJPKuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:50:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45986 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeJPKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:50:46 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9G31q7E017707;
        Tue, 16 Oct 2018 12:01:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9G31q7E017707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539658913;
        bh=8mve5wKKHLT57E+Sp7ZGGe3P0Plrd/MS1fwKPvtPSt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTjHPHS2jUAIvbnoEx2x8kABx7XncEYbGUAOSlKcjGjbxYlC7+hSSbuPsGYZAVFaj
         dsCEglEGxJ5JhAErLe8S1GE0CrKGgUX30kcfs9Nfp/6K3YNVltTBomCJ9Rvwn028rd
         X8hnZ/WiKodJSUjrT4aCFl/RlcRrr1obzFTQ9nseYFcdQr3CeGLgvZBNQPwX6Cu7XM
         xM4VTN4vmwtOW5tNy8F0ksR21EMIm6HiNZMaZyjYL1uWCHEekrhr1AQcHXdqS3Mavs
         nXFG6iq1BgETiRjB2/XKpmfJ2WEvfDmjRT8v2QQQ7E6BYJheMBB8hzWqBGokk0HxDJ
         orLyuaR2T1YAA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] i2c: uniphier-f: make driver robust against concurrency
Date:   Tue, 16 Oct 2018 12:01:47 +0900
Message-Id: <1539658909-26691-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unlikely to happen, but it is possible for a CPU to enter
the interrupt handler just after wait_for_completion_timeout() has
expired. If this happens, the hardware is accessed from multiple
contexts concurrently.

Disable the IRQ after wait_for_completion_timeout(), and do nothing
from the handler when the IRQ is disabled.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index a403e85..200dfd1 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -98,6 +98,7 @@ struct uniphier_fi2c_priv {
 	unsigned int flags;
 	unsigned int busy_cnt;
 	unsigned int clk_cycle;
+	spinlock_t lock;	/* IRQ synchronization */
 };
 
 static void uniphier_fi2c_fill_txfifo(struct uniphier_fi2c_priv *priv,
@@ -162,7 +163,10 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	struct uniphier_fi2c_priv *priv = dev_id;
 	u32 irq_status;
 
+	spin_lock(&priv->lock);
+
 	irq_status = readl(priv->membase + UNIPHIER_FI2C_INT);
+	irq_status &= priv->enabled_irqs;
 
 	dev_dbg(&priv->adap.dev,
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
@@ -230,6 +234,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		goto handled;
 	}
 
+	spin_unlock(&priv->lock);
+
 	return IRQ_NONE;
 
 data_done:
@@ -246,6 +252,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 handled:
 	uniphier_fi2c_clear_irqs(priv);
 
+	spin_unlock(&priv->lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -311,7 +319,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 {
 	struct uniphier_fi2c_priv *priv = i2c_get_adapdata(adap);
 	bool is_read = msg->flags & I2C_M_RD;
-	unsigned long time_left;
+	unsigned long time_left, flags;
 
 	dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, stop=%d\n",
 		is_read ? "receive" : "transmit", msg->addr, msg->len, stop);
@@ -342,6 +350,12 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 	       priv->membase + UNIPHIER_FI2C_CR);
 
 	time_left = wait_for_completion_timeout(&priv->comp, adap->timeout);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->enabled_irqs = 0;
+	uniphier_fi2c_set_irqs(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	if (!time_left) {
 		dev_err(&adap->dev, "transaction timeout.\n");
 		uniphier_fi2c_recover(priv);
@@ -529,6 +543,7 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 
 	priv->clk_cycle = clk_rate / bus_speed;
 	init_completion(&priv->comp);
+	spin_lock_init(&priv->lock);
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &uniphier_fi2c_algo;
 	priv->adap.dev.parent = dev;
-- 
2.7.4

