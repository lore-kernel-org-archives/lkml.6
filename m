Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0573BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18C6223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="t9W1z9Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18C6223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbeKODx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:53:58 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:50452 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeKODx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:53:57 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B3CB95C1776;
        Wed, 14 Nov 2018 18:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542217785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLKkszEWOPlBFuW2wcbYnhdMhnLa9QG3D33fjz0lQpw=;
        b=t9W1z9ExdUtXJDW+Vbuqb0sh4I7pt349j5coJFsS554VrAMeGjsSDUcwZfLik4ZTb+kHG1
        58TFaCePKL/rxz5PKweGtjS0Q+jREUFwiNz0i2p6+GQ6nTNl8+gwnebXnTeYojv5hIgfrP
        piB4Y5rlQEgTSDNrHfTlaojPrLVNUk0=
From:   Stefan Agner <stefan@agner.ch>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     fabio.estevam@nxp.com, u.kleine-koenig@pengutronix.de,
        s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] serial: imx: unprepare console clocks on remove
Date:   Wed, 14 Nov 2018 18:49:39 +0100
Message-Id: <20181114174940.7865-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114174940.7865-1-stefan@agner.ch>
References: <20181114174940.7865-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently imx_uart_console_setup() prepares clocks which do not
get unprepared anywhere. Check whether the console has been used
by testing if index is set and unprepare clocks in this case.

This makes sure that clocks are properly unprepared after the
console device has been unbound.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 313c3b1900a8..757c91e5105a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2085,7 +2085,7 @@ static struct console imx_uart_console = {
 	.data		= &imx_uart_uart_driver,
 };
 
-#define IMX_CONSOLE	&imx_uart_console
+#define IMX_CONSOLE	(&imx_uart_console)
 
 #ifdef CONFIG_OF
 static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
@@ -2378,8 +2378,17 @@ static int imx_uart_probe(struct platform_device *pdev)
 static int imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+
+	if (IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE) && IMX_CONSOLE->index >= 0) {
+		clk_unprepare(sport->clk_ipg);
+		clk_unprepare(sport->clk_per);
+		IMX_CONSOLE->index = -1;
+	}
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	return ret;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.19.1

