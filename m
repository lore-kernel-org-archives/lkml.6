Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeFAMmy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:42:54 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:38760 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeFAMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:40:37 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 2/8] serial: 8250_dw: allow enable rs485 at boot time
Date: Fri,  1 Jun 2018 14:40:15 +0200
Message-Id: <20180601124021.102970-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
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
2.17.0
