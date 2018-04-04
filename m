Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1522837250; cv=none;
        d=google.com; s=arc-20160816;
        b=NXgH41WtCdNOi/MhfYGnZzHz0CWuf1zjtqe7rpVYwOZ94HooAnG2hR5ZrTL5T4JBjA
         4iH1RRWsFUuvk8nh3SAs6+XkOlklAGqFqFTynVebzvnQ+yU7/qXC3Q+6dEYcoIRG6lit
         GKA1ULW/26OWwF5JhQOo+osnf+kUeXRwgQoRb8X7dDgLq8+8TtgFYbrICD8vVheyuxFG
         Z8FREAZcggc13hk4hZzyMgLfDmNA0oR/NXF7w879h7jrErxqwutA9CamfOiWnfIpzgg6
         hRwQobx2tBNDYree8/iTSr3Pe4yIcmDvQJOly1QnfdlWE++/i0tT34QZl6I19eNWZNtm
         4K+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=SjTHGmte3K/texYYpsRe+3VfjRtkvh+yXS6DkFWEWDQ=;
        b=h9+VP63xZikCIfwY8eIm04xHsK4Ic3VczCpG0goBA8m4y6rFiN+6+nh7qTnYuePZUg
         rQC9l+/dfP87fhKufFEslbCJMEPPSSJZc+n+1RwKY2AAoPbIrHPmD3pIV566x/QfgCiS
         DvQ4u775HB+Deeqc4pRGTbB1uD/Lb+IxHpe897COZZnn1HQNWdSQzEi2EmtoHAZ6DHjn
         Fh1MYN5U7rxnyS/6ftjd9DhaEhG7w7Db59YwH7uTLWqe7VOta2aWA4AwP+ipIhTgabI8
         LmkwXRpeEJDm+weIsG2CH2imzYU7KarTLbom3D9SE34kzC+ljvu4+1E955DNelwssL2w
         u4mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=Xxit5vLe;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=Xxit5vLe;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AIpwx4/YQHFoAA/IEvT3pY4SwoWqiLOasfA8XW3Qimwp+ydFJfUPsmJgwDWUfNzbEQilOf2NzBc/bg==
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu,
	agraf@suse.de
Cc: Nava kishore Manne <nava.manne@xilinx.com>,
	Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: xuartps: Fix the early_console junk character issue
Date: Wed,  4 Apr 2018 12:20:47 +0200
Message-Id: <6698032e594f5f921f25c4a7e235e0cee5521087.1522837245.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596810592943872606?=
X-GMAIL-MSGID: =?utf-8?q?1596810592943872606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nava kishore Manne <nava.manne@xilinx.com>

In the early_console_setup is trying to access the unregister clock value,
so we are receiving some garbage clk value because of this wrong clk value
the early_console_setup is fail to set the required console baud rate.

This path fix this issue.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 19d370779767..4176c3a0b4e8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1130,34 +1130,9 @@ static void cdns_early_write(struct console *con, const char *s,
 static int __init cdns_early_console_setup(struct earlycon_device *device,
 					   const char *opt)
 {
-	struct uart_port *port = &device->port;
-
-	if (!port->membase)
+	if (!device->port.membase)
 		return -ENODEV;
 
-	/* initialise control register */
-	writel(CDNS_UART_CR_TX_EN|CDNS_UART_CR_TXRST|CDNS_UART_CR_RXRST,
-	       port->membase + CDNS_UART_CR);
-
-	/* only set baud if specified on command line - otherwise
-	 * assume it has been initialized by a boot loader.
-	 */
-	if (device->baud) {
-		u32 cd = 0, bdiv = 0;
-		u32 mr;
-		int div8;
-
-		cdns_uart_calc_baud_divs(port->uartclk, device->baud,
-					 &bdiv, &cd, &div8);
-		mr = CDNS_UART_MR_PARITY_NONE;
-		if (div8)
-			mr |= CDNS_UART_MR_CLKSEL;
-
-		writel(mr,   port->membase + CDNS_UART_MR);
-		writel(cd,   port->membase + CDNS_UART_BAUDGEN);
-		writel(bdiv, port->membase + CDNS_UART_BAUDDIV);
-	}
-
 	device->con->write = cdns_early_write;
 
 	return 0;
-- 
1.9.1
