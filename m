Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="UyvtqKOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 534796070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbeFFJwg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:52:36 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:56118 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932641AbeFFJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:52:17 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Ed Blake <ed.blake@sondrel.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] serial: 8250_dw: treat rpm suspend with -EBUSY if RS485 ON and RTS_AFTER_SEND
Date: Wed,  6 Jun 2018 11:51:53 +0200
Message-Id: <20180606095156.72628-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rs485 is on and RTS_AFTER_SEND it means that in idle state rts pin
must be asserted, othwerwise rs485 transceiver will enter tx state.
dw8250 when clocks are stopped keeps rts line de-asserted(high),
resulting in keeping rs485 transceiver in tx state when port is idle.

Check if rs485 is on with RTS_AFTER_SEND set, if so return -EBUSY in
rpm_suspend,

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 888280ff5451..6b0ee6dc8ad0 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -668,6 +668,11 @@ static int dw8250_resume(struct device *dev)
 static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(data->line);
+	struct uart_port *p = &up->port;
+
+	if (p->rs485.flags & (SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND))
+		return -EBUSY;
 
 	if (!IS_ERR(data->clk))
 		clk_disable_unprepare(data->clk);
-- 
2.17.1
