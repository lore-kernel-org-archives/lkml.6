Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B92ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A6F2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cs8vYqFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A6F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbeISLFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:05:51 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:61299 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbeISLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:05:50 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8J5Sefb016652;
        Wed, 19 Sep 2018 14:28:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8J5Sefb016652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537334922;
        bh=yiszHmXZYmVw9rgfzdxM58x4hbs7T2QUqJBQH2oKjMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cs8vYqFTnu5xeHf3JbeXhJvWb0UmibOlhXJE+h3HqDfoNiBjFC/QpYhAaEYaA63sn
         wwzJQl64LQpdROp/pYERKeD3Z+0BxjPzi6zAD5UFRBxumuSlmpSJ2iqIIQDft0SgQ6
         DgDQ4XpIMakZquc3UicPMWahXnkU52QIWaeevFz8cKmt1fhrdtgpHAO2g3xS64Aawv
         F4fNaNVetN4NQu2NBksF1bg6e7EgHcQaopLciCDLscMvB+qtPMZRnLKW03Iv9RQxim
         XLtxAixHGtHcOjs/2DQt0TygH1J8mpoqIGlklTE357zyEYBKxWq1nY1DB6fitzrWp1
         HQ5qjeKYlqnvg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] serial: 8250_uniphier: flatten probe function
Date:   Wed, 19 Sep 2018 14:28:12 +0900
Message-Id: <1537334893-26079-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DT-related settings are split out to
uniphier_of_serial_setup(), but it turned out to be not nice.
The next commit will add a DT property, but it will not fit in
the helper.  Merge the helper into the probe function.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 49 ++++++++++++---------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index d292654..1028c02 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -155,36 +155,6 @@ static void uniphier_serial_dl_write(struct uart_8250_port *up, int value)
 	writel(value, up->port.membase + UNIPHIER_UART_DLR);
 }
 
-static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
-				    struct uniphier8250_priv *priv)
-{
-	int ret;
-	u32 prop;
-	struct device_node *np = dev->of_node;
-
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		dev_err(dev, "failed to get alias id\n");
-		return ret;
-	}
-	port->line = ret;
-
-	/* Get clk rate through clk driver */
-	priv->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clock\n");
-		return PTR_ERR(priv->clk);
-	}
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret < 0)
-		return ret;
-
-	port->uartclk = clk_get_rate(priv->clk);
-
-	return 0;
-}
-
 static int uniphier_uart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -217,9 +187,24 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	memset(&up, 0, sizeof(up));
 
-	ret = uniphier_of_serial_setup(dev, &up.port, priv);
-	if (ret < 0)
+	ret = of_alias_get_id(dev->of_node, "serial");
+	if (ret < 0) {
+		dev_err(dev, "failed to get alias id\n");
 		return ret;
+	}
+	up.port.line = ret;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	up.port.uartclk = clk_get_rate(priv->clk);
 
 	spin_lock_init(&priv->atomic_write_lock);
 
-- 
2.7.4

