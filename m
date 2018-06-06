Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="RwZg/WS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38BF160263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeFFJuL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:50:11 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55582 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbeFFJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:50:07 -0400
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
        Aaron Sierra <asierra@xes-inc.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Rafael Gago <rafael.gago@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] serial: 8250: Make em485_rts_after_send() set mctrl according to rts state.
Date: Wed,  6 Jun 2018 11:49:38 +0200
Message-Id: <20180606094942.71190-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rs485 enabled and RTS_AFTER_SEND set on startup, need to preserve
mctrl status, because later functions will call set_mctrl passing
port->mctrl=0 overriding rts status, resulting in rts pin in
transmission when idle.

Make mctrl reflect rts pin state.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 95833cbc4338..c8c10b5ec6d6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -562,10 +562,13 @@ static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
 		mcr |= UART_MCR_RTS;
-	else
+		p->port.mctrl |= TIOCM_RTS;
+	} else {
 		mcr &= ~UART_MCR_RTS;
+		p->port.mctrl &= ~TIOCM_RTS;
+	}
 	serial8250_out_MCR(p, mcr);
 }
 
-- 
2.17.1
