Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3329EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8723216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XR3d8tCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8723216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeI1I1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:27:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:52928 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeI1I1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:27:52 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8S25FOi028340;
        Fri, 28 Sep 2018 11:05:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8S25FOi028340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538100318;
        bh=EqRd+5cNk7+zWbyynhC051ZQ8Ujg1qu2ddHKUFsjyCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XR3d8tChezqibpT4U9CJDIOLWdsJu1U9Ln9/lSMWkywsG332w807gZURAEEABpKak
         aQIkKD5QAtQ6cYydan6wUR+UY8JDsQj6VtQGT/exQAWOFv+45ixXl0Ru06sUtNRqj9
         M7t5jtRWjN+/GAfppNRtNnsF1w+k3C81nn1EhMNNgwvCWqVP5s4F4o6Lvgeo8mvbFF
         3NwdIOR8JiiQOgwypsfZRXIJaGX7b2oP+qWHmQtSoM+p5R37+KqYSVgLFvajagWoWs
         5lojyAofueRj9Qwobz/AJ7F8Uu9JmczT7e+AtLCcGEMJTs9B0FychgtVc5eHg7rduZ
         4FiKDMe8GTEHg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] serial: 8250_uniphier: flatten probe function
Date:   Fri, 28 Sep 2018 11:05:08 +0900
Message-Id: <1538100309-24323-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v2: None

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

