Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE27C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E37020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfAORSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:18:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60753 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbfAORSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:18:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D104F20750; Tue, 15 Jan 2019 18:18:27 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr [109.213.145.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id 951AA206A6;
        Tue, 15 Jan 2019 18:18:17 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Roland Stigge <stigge@antcom.de>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] tty: serial: lpc32xx_hs: fix missing console boot messages
Date:   Tue, 15 Jan 2019 18:18:14 +0100
Message-Id: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probing the HSUART, it is put in loopback mode in order to prevent a
potential issue that may happen on RX (Errata HSUART.1).

serial_lpc32xx_startup() moves it out of loopback mode but this is too late
to get the kernel boot messages before userspace opens the device.

Also get out of loopback mode in lpc32xx_hsuart_console_setup().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/tty/serial/lpc32xx_hs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index d1d73261575b..f4e27d0ad947 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -151,6 +151,8 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
+static void lpc32xx_loopback_set(resource_size_t mapbase, int state);
+
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
 					       char *options)
 {
@@ -170,6 +172,8 @@ static int __init lpc32xx_hsuart_console_setup(struct console *co,
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	lpc32xx_loopback_set(port->mapbase, 0); /* get out of loopback mode */
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-- 
2.20.1

