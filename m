Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeFAOMV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:12:21 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:44088 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeFAOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:12:11 -0400
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
Subject: [PATCH 2/2] serial: 8250: Add SERIAL_MCTRL_GPIO support to 8250.
Date: Fri,  1 Jun 2018 16:11:58 +0200
Message-Id: <20180601141158.93817-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
References: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes mctrl signals can be connected to pins different from HW ones.

User serial_mctrl_gpio helpers to align HW signals(RTS, CTS, etc.) with
gpios-rts, gpios-cts etc.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_core.c |  6 ++++++
 drivers/tty/serial/8250/8250_port.c | 18 +++++++++++++++---
 include/linux/serial_8250.h         |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..c2bc906ffdf4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -41,6 +41,8 @@
 
 #include "8250.h"
 
+#include "../serial_mctrl_gpio.h"
+
 /*
  * Configuration:
  *   share_irqs - whether we pass IRQF_SHARED to request_irq().  This option
@@ -1036,6 +1038,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->dl_write)
 			uart->dl_write = up->dl_write;
 
+		uart->gpios = mctrl_gpio_init(&up->port, 0);
+		if (IS_ERR(uart->gpios))
+			return PTR_ERR(uart->gpios);
+
 		if (uart->port.type != PORT_8250_CIR) {
 			if (serial8250_isa_config != NULL)
 				serial8250_isa_config(0, &uart->port,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 95833cbc4338..3004aa3ef4e5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -40,6 +40,8 @@
 
 #include "8250.h"
 
+#include "../serial_mctrl_gpio.h"
+
 /*
  * These are definitions for the Exar XR17V35X and XR17(C|D)15X
  */
@@ -567,6 +569,8 @@ static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
 	else
 		mcr &= ~UART_MCR_RTS;
 	serial8250_out_MCR(p, mcr);
+
+	mctrl_gpio_set(p->gpios, p->port.mctrl);
 }
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
@@ -1591,12 +1595,17 @@ static inline void start_tx_rs485(struct uart_port *port)
 	mcr = serial8250_in_MCR(up);
 	if (!!(up->port.rs485.flags & SER_RS485_RTS_ON_SEND) !=
 	    !!(mcr & UART_MCR_RTS)) {
-		if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND)
+		if (up->port.rs485.flags & SER_RS485_RTS_ON_SEND) {
 			mcr |= UART_MCR_RTS;
-		else
+			up->port.mctrl |= TIOCM_RTS;
+		} else {
 			mcr &= ~UART_MCR_RTS;
+			up->port.mctrl &= ~TIOCM_RTS;
+		}
 		serial8250_out_MCR(up, mcr);
 
+		mctrl_gpio_set(up->gpios, up->port.mctrl);
+
 		if (up->port.rs485.delay_rts_before_send > 0) {
 			em485->active_timer = &em485->start_tx_timer;
 			start_hrtimer_ms(&em485->start_tx_timer,
@@ -1957,7 +1966,8 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
 		ret |= TIOCM_DSR;
 	if (status & UART_MSR_CTS)
 		ret |= TIOCM_CTS;
-	return ret;
+
+	return mctrl_gpio_get(up->gpios, &ret);
 }
 EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
 
@@ -1987,6 +1997,8 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
 
 	serial8250_out_MCR(up, mcr);
+
+	mctrl_gpio_set(up->gpios, mctrl);
 }
 EXPORT_SYMBOL_GPL(serial8250_do_set_mctrl);
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..7872f11d4b04 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -134,6 +134,8 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *, int);
 
 	struct uart_8250_em485 *em485;
+
+	struct mctrl_gpios *gpios;
 };
 
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
-- 
2.17.0
