Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D017C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0883D205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0883D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440350AbeKXCaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:30:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37261 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388513AbeKXCaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:30:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ABAF620DB0; Fri, 23 Nov 2018 16:45:41 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53B6520712;
        Fri, 23 Nov 2018 16:45:31 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/2] serial: mvebu-uart: clarify the baud rate derivation
Date:   Fri, 23 Nov 2018 16:45:29 +0100
Message-Id: <20181123154530.8022-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current comment in ->set_baud_rate() is rather incomplete as it
fails to describe what are the actual stages for the baudrate
derivation. Replace this comment with something more explicit and
close to the functional specification. Also adapt the variable names
to it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/tty/serial/mvebu-uart.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 170e446a2f62..df6e4d8cdbd6 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -72,6 +72,7 @@
 #define  BRDV_BAUD_MASK         0x3FF
 
 #define UART_OSAMP		0x14
+#define  OSAMP_DEFAULT_DIVISOR	16
 
 #define MVEBU_NR_UARTS		2
 
@@ -444,23 +445,28 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
 	struct mvebu_uart *mvuart = to_mvuart(port);
-	unsigned int baud_rate_div;
+	unsigned int d_divisor, m_divisor;
 	u32 brdv;
 
 	if (IS_ERR(mvuart->clk))
 		return -PTR_ERR(mvuart->clk);
 
 	/*
-	 * The UART clock is divided by the value of the divisor to generate
-	 * UCLK_OUT clock, which is 16 times faster than the baudrate.
-	 * This prescaler can achieve all standard baudrates until 230400.
-	 * Higher baudrates could be achieved for the extended UART by using the
-	 * programmable oversampling stack (also called fractional divisor).
+	 * The baudrate is derived from the UART clock thanks to two divisors:
+	 *   > D ("baud generator"): can divide the clock from 2 to 2^10 - 1.
+	 *   > M ("fractional divisor"): allows a better accuracy for
+	 *     baudrates higher than 230400.
+	 *
+	 * As the derivation of M is rather complicated, the code sticks to its
+	 * default value (x16) when all the prescalers are zeroed, and only
+	 * makes use of D to configure the desired baudrate.
 	 */
-	baud_rate_div = DIV_ROUND_UP(port->uartclk, baud * 16);
+	m_divisor = OSAMP_DEFAULT_DIVISOR;
+	d_divisor = DIV_ROUND_UP(port->uartclk, baud * m_divisor);
+
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
-	brdv |= baud_rate_div;
+	brdv |= d_divisor;
 	writel(brdv, port->membase + UART_BRDV);
 
 	return 0;
-- 
2.19.1

