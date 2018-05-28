Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeE1QNi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965325AbeE1KNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:13:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 167/185] serial: xuartps: Fix out-of-bounds access through DT alias
Date: Mon, 28 May 2018 12:03:28 +0200
Message-Id: <20180528100112.974627197@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit e7d75e18d0fc3f7193b65282b651f980c778d935 ]

The cdns_uart_port[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1001,7 +1001,7 @@ static struct uart_port *cdns_uart_get_p
 	struct uart_port *port;
 
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
 		/* Find the next unused port */
 		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase == 0)
