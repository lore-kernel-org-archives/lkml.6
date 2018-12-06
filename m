Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8DD2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kPHi2dOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8DD2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeLFD4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:56:52 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:59213 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeLFD4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:56:50 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB63trS6007398;
        Thu, 6 Dec 2018 12:55:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS6007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544068555;
        bh=2y2cw2qzebvkA+Mtv/XDf/lXFAsgLnN70QsGjRHK68c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPHi2dOEi3qWH6h8XKwY274U9vnp6zKg7l3nNiKvf+kib3GV6+hakUNhgUnJJv/NF
         QHc/hlsIotcEtGB5VC2dt/W9jOMZqqbgx8hd5vZ3ylxiudEBtz8JnBgUwak7qri5rt
         Zpt+7C4FpNFZjl8l8IW8KZNAfoQ1ZMIV8KPl+Aiiilu2M+0j9fYu5OskyJ4UINipp7
         kdkbPwV862Vny5wy2cJZ1alQv9PL7LDEz2AIMbYuPxYGX7ZvElrn9bsnDorMCu/2CW
         oWeUxwZPvHto49Ojo8gn5cZ4aIXQT+MsT1D4wDwCF9w4GI/LiHEO9CTKWOrP9c6CJ/
         1zoDG2ayu67Zw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] i2c: uniphier-f: fix timeout error after reading 8 bytes
Date:   Thu,  6 Dec 2018 12:55:25 +0900
Message-Id: <1544068528-27657-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was totally screwed up in commit eaba68785c2d ("i2c: uniphier-f:
fix race condition when IRQ is cleared"). Since that commit, if the
number of read bytes is multiple of the FIFO size (8, 16, 24... bytes),
the STOP condition could be issued twice, depending on the timing.
If this happens, the controller will go wrong, resulting in the timeout
error.

It was more than 3 years ago when I wrote this driver, so my memory
about this hardware was vague. Please let me correct the description
in the commit log of eaba68785c2d.

Clearing the IRQ status on exiting the IRQ handler is absolutely
fine. This controller makes a pause while any IRQ status is asserted.
If the IRQ status is cleared first, the hardware may start the next
transaction before the IRQ handler finishes what it supposed to do.

This partially reverts the bad commit with clear comments so that I
will never repeat this mistake.

I also investigated what is happening at the last moment of the read
mode. The UNIPHIER_FI2C_INT_RF interrupt is asserted a bit earlier
(by half a period of the clock cycle) than UNIPHIER_FI2C_INT_RB.

I consulted a hardware engineer, and I got the following information:

UNIPHIER_FI2C_INT_RF
    asserted at the falling edge of SCL at the 8th bit.

UNIPHIER_FI2C_INT_RB
    asserted at the rising edge of SCL at the 9th (ACK) bit.

In order to avoid calling uniphier_fi2c_stop() twice, check the latter
interrupt. I also commented this because it is obscure hardware internal.

Fixes: eaba68785c2d ("i2c: uniphier-f: fix race condition when IRQ is cleared")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index dd38474..fad2b00 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -173,8 +173,6 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
 		priv->enabled_irqs, irq_status);
 
-	uniphier_fi2c_clear_irqs(priv, irq_status);
-
 	if (irq_status & UNIPHIER_FI2C_INT_STOP)
 		goto complete;
 
@@ -214,7 +212,13 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 
 	if (irq_status & (UNIPHIER_FI2C_INT_RF | UNIPHIER_FI2C_INT_RB)) {
 		uniphier_fi2c_drain_rxfifo(priv);
-		if (!priv->len)
+		/*
+		 * If the number of bytes to read is multiple of the FIFO size
+		 * (msg->len == 8, 16, 24, ...), the INT_RF bit is set a little
+		 * earlier than INT_RB. We wait for INT_RB to confirm the
+		 * completion of the current message.
+		 */
+		if (!priv->len && (irq_status & UNIPHIER_FI2C_INT_RB))
 			goto data_done;
 
 		if (unlikely(priv->flags & UNIPHIER_FI2C_MANUAL_NACK)) {
@@ -253,6 +257,13 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	}
 
 handled:
+	/*
+	 * This controller makes a pause while any bit of the IRQ status is
+	 * asserted. Clear the asserted bit to kick the controller just before
+	 * exiting the handler.
+	 */
+	uniphier_fi2c_clear_irqs(priv, irq_status);
+
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
-- 
2.7.4

