Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Fo0FEdOxbd5SekoPiG4gpdEMt4XhIJ6TA6/OfXplarM7OC7UfE5uA4yb4j/9DEIUnROt7
ARC-Seal: i=1; a=rsa-sha256; t=1523022037; cv=none;
        d=google.com; s=arc-20160816;
        b=PhdKQzsjIlG/rDfsoEDFko1QdVC7HRKzRVezmWFILD8f+AsAJ2zgdpohhQulGK9lDe
         FNAEg2V71VmasUy3YuRFyHGgMSu6I/zLTc2AZInI8Q4UgAaNGNHDcvUfYLqb4VsnIF80
         nKsqlAE6RkG6g/VtzIMOcJkF0SKEBuL8afTpphQTpQWD9+8HMaET45QahFFqjhy56pEm
         w2oqYhyrLFzJDxDlfb7X8H7w6MvH+T3VtuKiSg2BkGT2aJH9HpnCJJ7Z6z2CW1epEUFW
         +BmUA+EYy6ffBHSyolW2jfpl0JeQFIWcw19naTijhj1CGLx5G2h4e0wfqYyZffYmwJ4T
         BGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f55zHVDhrm4PsDJak5irGZDj8NJxJiaSwYkCKOhZmUs=;
        b=CWf5nZSjr1ezfYtHH8eNBhNjMXr3gW8ueORH6+ru3JykIB5H+UTWvblAAkjB171KI6
         axrVBhPK3esyQoMeCW5DHEhM1JxklAbzsUh/Vs0bc9UKd/m7V7Cj3Jll9n57RFKlWZHk
         5pTREqnp2/mJO/HaOsX9vQLSe3bVEBbIVryCquw+OoK5C/O2rKL99DHQPI7BlIFmA9sV
         J6R2g2T0YPDUEQruLRGIVs1QCP3PrWyVEHN3qnLHiuo9QQ9h/YI2tSGLB8mS4Hi1WPsn
         nAx8fbNk48LuwpaxiCN9M9LYRbl97n8QnDjYO7MlVYJbAgRIqj/q9pP9Y9iqqhX3GHCa
         5RQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 4.14 41/67] serial: 8250: Add Nuvoton NPCM UART
Date: Fri,  6 Apr 2018 15:24:11 +0200
Message-Id: <20180406084346.988322037@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004355640744843?=
X-GMAIL-MSGID: =?utf-8?q?1597004355640744843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit f597fbce38d230af95384f4a04e0a13a1d0ad45d upstream.

The Nuvoton UART is almost compatible with the 8250 driver when probed
via the 8250_of driver, however it requires some extra configuration
at startup.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/serial/8250.txt |    1 
 drivers/tty/serial/8250/8250_of.c                 |    1 
 drivers/tty/serial/8250/8250_port.c               |   33 ++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |    3 ++
 4 files changed, 38 insertions(+)

--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -24,6 +24,7 @@ Required properties:
 	- "ti,da830-uart"
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
+	- "nuvoton,npcm750-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -321,6 +321,7 @@ static const struct of_device_id of_plat
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
+	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -51,6 +51,10 @@
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
+/* Nuvoton NPCM timeout register */
+#define UART_NPCM_TOR          7
+#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
+
 /*
  * Debugging.
  */
@@ -297,6 +301,15 @@ static const struct serial8250_config ua
 				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_NPCM] = {
+		.name		= "Nuvoton 16550",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
+				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
@@ -2168,6 +2181,15 @@ int serial8250_do_startup(struct uart_po
 				UART_DA830_PWREMU_MGMT_FREE);
 	}
 
+	if (port->type == PORT_NPCM) {
+		/*
+		 * Nuvoton calls the scratch register 'UART_TOR' (timeout
+		 * register). Enable it, and set TIOC (timeout interrupt
+		 * comparator) to be 0x20 for correct operation.
+		 */
+		serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
+	}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
@@ -2490,6 +2512,15 @@ static unsigned int xr17v35x_get_divisor
 	return quot_16 >> 4;
 }
 
+/* Nuvoton NPCM UARTs have a custom divisor calculation */
+static unsigned int npcm_get_divisor(struct uart_8250_port *up,
+		unsigned int baud)
+{
+	struct uart_port *port = &up->port;
+
+	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
+}
+
 static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 					   unsigned int baud,
 					   unsigned int *frac)
@@ -2510,6 +2541,8 @@ static unsigned int serial8250_get_divis
 		quot = 0x8002;
 	else if (up->port.type == PORT_XR17V35X)
 		quot = xr17v35x_get_divisor(up, baud, frac);
+	else if (up->port.type == PORT_NPCM)
+		quot = npcm_get_divisor(up, baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -76,6 +76,9 @@
 #define PORT_SUNZILOG	38
 #define PORT_SUNSAB	39
 
+/* Nuvoton UART */
+#define PORT_NPCM	40
+
 /* Intel EG20 */
 #define PORT_PCH_8LINE	44
 #define PORT_PCH_2LINE	45
