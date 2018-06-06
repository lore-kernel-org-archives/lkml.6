Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="dLTPKiqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC71460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeFFJwI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:52:08 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55944 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeFFJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:52:03 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Ed Blake <ed.blake@sondrel.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] serial: 8250_dw: allow enable rs485 at boot time
Date: Wed,  6 Jun 2018 11:51:51 +0200
Message-Id: <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "linux,rs485-enabled-at-boot-time" is specified need to setup 485
in probe function.

Call uart_get_rs485_mode() to get rs485 configuration, then call
rs485_config() callback directly to setup port as rs485.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 45366e6e5411..0f8b4da03d4e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -582,8 +582,11 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
 
-	if (!data->skip_autocfg)
+	if (!data->skip_autocfg) {
 		dw8250_setup_port(p);
+		uart_get_rs485_mode(dev, &p->rs485);
+		dw8250_rs485_config(p, &p->rs485);
+	}
 
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
-- 
2.17.1
