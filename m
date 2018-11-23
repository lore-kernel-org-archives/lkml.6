Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F235C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE67F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE67F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440363AbeKXCa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:30:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37270 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390874AbeKXCaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:30:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9803B20D92; Fri, 23 Nov 2018 16:45:42 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3FD0F20742;
        Fri, 23 Nov 2018 16:45:32 +0100 (CET)
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
Subject: [PATCH 2/2] serial: mvebu-uart: initialize over sampling stack register
Date:   Fri, 23 Nov 2018 16:45:30 +0100
Message-Id: <20181123154530.8022-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123154530.8022-1-miquel.raynal@bootlin.com>
References: <20181123154530.8022-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The baudrate derivation relies on the state of the programmable over
sampling stack (OSAMP register) being empty, while never initializing
it.

Set all the fields of this register to 0 (except reserved areas) to
ensure a x16 divisor, as assumed by the driver.

The suspend/resume callbacks are untouched because they already
save/restore correctly this register.

Suggested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/tty/serial/mvebu-uart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index df6e4d8cdbd6..231f751d1ef4 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -73,6 +73,7 @@
 
 #define UART_OSAMP		0x14
 #define  OSAMP_DEFAULT_DIVISOR	16
+#define  OSAMP_DIVISORS_MASK	0x3F3F3F3F
 
 #define MVEBU_NR_UARTS		2
 
@@ -446,7 +447,7 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
 	struct mvebu_uart *mvuart = to_mvuart(port);
 	unsigned int d_divisor, m_divisor;
-	u32 brdv;
+	u32 brdv, osamp;
 
 	if (IS_ERR(mvuart->clk))
 		return -PTR_ERR(mvuart->clk);
@@ -469,6 +470,10 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 	brdv |= d_divisor;
 	writel(brdv, port->membase + UART_BRDV);
 
+	osamp = readl(port->membase + UART_OSAMP);
+	osamp &= ~OSAMP_DIVISORS_MASK;
+	writel(osamp, port->membase + UART_OSAMP);
+
 	return 0;
 }
 
-- 
2.19.1

