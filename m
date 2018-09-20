Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0469ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9216921529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9216921529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbeITRyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:54:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38237 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeITRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:54:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1g2xno-0006Pu-QZ; Thu, 20 Sep 2018 14:11:24 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1g2xnm-0001Jp-Vw; Thu, 20 Sep 2018 14:11:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>
Subject: [PATCH] serial: imx: restore handshaking irq for imx1
Date:   Thu, 20 Sep 2018 14:11:17 +0200
Message-Id: <20180920121117.19041-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920071957.xnwni4lqb5kgncfc@pengutronix.de>
References: <20180920071957.xnwni4lqb5kgncfc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2015 when irda was dropped from the driver imx1 was broken. This
change reintroduces the support for the third interrupt of the UART.

Fixes: afe9cbb1a6ad ("serial: imx: drop support for IRDA")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4e853570ea80..554a69db1bca 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2350,6 +2350,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 				ret);
 			return ret;
 		}
+
+		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
+				       dev_name(&pdev->dev), sport);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
+				ret);
+			return ret;
+		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);
-- 
2.18.0

