Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeFERHD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753784AbeFERHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:07:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Christopher Covington <cov@codeaurora.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.9 61/61] serial: pl011: add console matching function
Date: Tue,  5 Jun 2018 19:02:22 +0200
Message-Id: <20180605170121.492754231@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksey Makarov <aleksey.makarov@linaro.org>

commit 10879ae5f12e9cab3c4e8e9504c1aaa8a033bde7 upstream.

This patch adds function pl011_console_match() that implements
method match of struct console.  It allows to match consoles against
data specified in a string, for example taken from command line or
compiled by ACPI SPCR table handler.

This patch was merged to tty-next but then reverted because of
conflict with

commit 46e36683f433 ("serial: earlycon: Extend earlycon command line option to support 64-bit addresses")

Now it is fixed.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/amba-pl011.c |   55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2320,12 +2320,67 @@ static int __init pl011_console_setup(st
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
 
+/**
+ *	pl011_console_match - non-standard console matching
+ *	@co:	  registering console
+ *	@name:	  name from console command line
+ *	@idx:	  index from console command line
+ *	@options: ptr to option string from console command line
+ *
+ *	Only attempts to match console command lines of the form:
+ *	    console=pl011,mmio|mmio32,<addr>[,<options>]
+ *	    console=pl011,0x<addr>[,<options>]
+ *	This form is used to register an initial earlycon boot console and
+ *	replace it with the amba_console at pl011 driver init.
+ *
+ *	Performs console setup for a match (as required by interface)
+ *	If no <options> are specified, then assume the h/w is already setup.
+ *
+ *	Returns 0 if console matches; otherwise non-zero to use default matching
+ */
+static int __init pl011_console_match(struct console *co, char *name, int idx,
+				      char *options)
+{
+	unsigned char iotype;
+	resource_size_t addr;
+	int i;
+
+	if (strcmp(name, "pl011") != 0)
+		return -ENODEV;
+
+	if (uart_parse_earlycon(options, &iotype, &addr, &options))
+		return -ENODEV;
+
+	if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
+		return -ENODEV;
+
+	/* try to match the port specified on the command line */
+	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
+		struct uart_port *port;
+
+		if (!amba_ports[i])
+			continue;
+
+		port = &amba_ports[i]->port;
+
+		if (port->mapbase != addr)
+			continue;
+
+		co->index = i;
+		port->cons = co;
+		return pl011_console_setup(co, options);
+	}
+
+	return -ENODEV;
+}
+
 static struct uart_driver amba_reg;
 static struct console amba_console = {
 	.name		= "ttyAMA",
 	.write		= pl011_console_write,
 	.device		= uart_console_device,
 	.setup		= pl011_console_setup,
+	.match		= pl011_console_match,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.data		= &amba_reg,
