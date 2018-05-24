Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966626AbeEXRak (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:30:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966512AbeEXRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:30:34 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] serial: imx: disable UCR4_OREN on shutdown
Date: Thu, 24 May 2018 19:30:24 +0200
Message-Id: <20180524173024.20936-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
References: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UCR4_OREN is (depending on the configuration) enabled in startup,
but is never disabled. Fix this by disabling it in shutdown.

Reported-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a0fc0327c8a5..31e1df8a8d29 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1422,7 +1422,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long flags;
-	u32 ucr1, ucr2;
+	u32 ucr1, ucr2, ucr4;
 
 	if (sport->dma_is_enabled) {
 		dmaengine_terminate_sync(sport->dma_chan_tx);
@@ -1452,6 +1452,10 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr2 = imx_uart_readl(sport, UCR2);
 	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
+
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 &= ~UCR4_OREN;
+	imx_uart_writel(sport, ucr4, UCR4);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	/*
-- 
2.17.0
