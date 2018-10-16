Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC3F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O/pPABwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC3F2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJPKun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:50:43 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45901 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeJPKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:50:42 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9G31q7G017707;
        Tue, 16 Oct 2018 12:01:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9G31q7G017707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539658914;
        bh=ZxktTlt0uvBW/TQJyZzElfrrpdv27cPqcb9+fDo0GgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/pPABwgfSvRnjkopXRsQUdWzrIAHkbAUdbQNhHlVgefn9NPMp14lL7gsML0hd6Dh
         ogp+Z4+ChZpj4yBhaPslRuHowITUNaSHhADxeV5d2e4djxo6xteMNDBkqmF8SDRukf
         wi2PqaWt0gL/aTDm150hvr8UU2fgSx6dfCo7f1GmkHnB1/6PICv+gX4aPUsS3XHUmt
         Wra/UA89rU4WEC4e1E76jzhe6jSAzX8DZQj7JqW0TMk5iNl55TUatoR/7bGCQpCV7l
         sy8fbgvRQ6Wzi5NJthgzngpEVLA5mC2LEaz5Vqymm9qVx79ZE26EmXD+8W0CbHR50r
         zn2Xt7bpNy2Vg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] i2c: uniphier-f: fix race condition when IRQ is cleared
Date:   Tue, 16 Oct 2018 12:01:49 +0900
Message-Id: <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current IRQ handler clears all the IRQ status bits when it bails
out. This is dangerous because it might clear away the status bits
that have just been set while processing the current handler. If this
happens, the IRQ event for the latest transfer is lost forever.

The IRQ status bits must be cleared *before* the next transfer is
kicked.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 0677153..dd38474 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -143,9 +143,10 @@ static void uniphier_fi2c_set_irqs(struct uniphier_fi2c_priv *priv)
 	writel(priv->enabled_irqs, priv->membase + UNIPHIER_FI2C_IE);
 }
 
-static void uniphier_fi2c_clear_irqs(struct uniphier_fi2c_priv *priv)
+static void uniphier_fi2c_clear_irqs(struct uniphier_fi2c_priv *priv,
+				     u32 mask)
 {
-	writel(-1, priv->membase + UNIPHIER_FI2C_IC);
+	writel(mask, priv->membase + UNIPHIER_FI2C_IC);
 }
 
 static void uniphier_fi2c_stop(struct uniphier_fi2c_priv *priv)
@@ -172,6 +173,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
 		priv->enabled_irqs, irq_status);
 
+	uniphier_fi2c_clear_irqs(priv, irq_status);
+
 	if (irq_status & UNIPHIER_FI2C_INT_STOP)
 		goto complete;
 
@@ -250,8 +253,6 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	}
 
 handled:
-	uniphier_fi2c_clear_irqs(priv);
-
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
@@ -340,7 +341,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 		priv->flags |= UNIPHIER_FI2C_STOP;
 
 	reinit_completion(&priv->comp);
-	uniphier_fi2c_clear_irqs(priv);
+	uniphier_fi2c_clear_irqs(priv, U32_MAX);
 	writel(UNIPHIER_FI2C_RST_TBRST | UNIPHIER_FI2C_RST_RBRST,
 	       priv->membase + UNIPHIER_FI2C_RST);	/* reset TX/RX FIFO */
 
-- 
2.7.4

