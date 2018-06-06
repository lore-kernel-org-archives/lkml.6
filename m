Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="lS8sIbFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39BF760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeFFJuc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:50:32 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55658 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932441AbeFFJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:50:10 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] serial: core: Mask mctrl with TIOCM_RTS too if rs485 on and RTS_AFTER_SEND set.
Date: Wed,  6 Jun 2018 11:49:39 +0200
Message-Id: <20180606094942.71190-3-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rs485 is enabled and RTS_AFTER_SEND is set on startup need to keep
TIOCM_RTS asserted to keep rs485 transceiver in RX when idle.

Check if rs485 is on and RTS_AFTER_SEND is set and mask port->mctrl with
TIOCM_RTS too and not only TIOCM_DTR.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/serial_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0466f9f08a91..06d9441f6d20 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2288,6 +2288,16 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 	if (port->type != PORT_UNKNOWN) {
 		unsigned long flags;
+		int rs485_on = port->rs485_config &&
+			(port->rs485.flags & SER_RS485_ENABLED);
+		int RTS_after_send = !!(port->rs485.flags &
+				SER_RS485_RTS_AFTER_SEND);
+		int mctrl;
+
+		if (rs485_on && RTS_after_send)
+			mctrl = port->mctrl & (TIOCM_DTR | TIOCM_RTS);
+		else
+			mctrl = port->mctrl & TIOCM_DTR;
 
 		uart_report_port(drv, port);
 
@@ -2300,7 +2310,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * We probably don't need a spinlock around this, but
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
+		port->ops->set_mctrl(port, mctrl);
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		/*
-- 
2.17.1
