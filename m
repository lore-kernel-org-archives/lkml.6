Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+cqMg3D/cL1hxvXUB7UnqdizvoriQRHPJO5Ufm7OXcEPkgKJIIuUaNzDD1QVXCcRdKAX+F
ARC-Seal: i=1; a=rsa-sha256; t=1523022147; cv=none;
        d=google.com; s=arc-20160816;
        b=wBMUwQZDxUrst+zJHHwQAQuQrLj/giKQpiurBiDf0A1+mCeP1jdKnpTCTclrK8qv+W
         7AZO3ubQnDHo34cKS4KoE30W+RgsvGJpw7QyvOOMLJt7A9CI5oub+lzGYzcTfWUwAoeI
         gQlb3za18PXFwp55g0DAu628u/B7kacqLS9Xk5wQqaL/ATiU+dTEhwJVfFb7xv+SHx5N
         u7fKCjUyTqQs1upRAsPYnwtcH5mjrwk3qM1A6DeqQ+b1P94Gih4ZCnaVI+3ElQWbtxBm
         swQx8ht2QCL7hww6xUFnS0I3bE46qB3fSV5BXiC+DvHGfEUKmYyqYYYVkyV55rhbExdw
         3law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TVdagh882/SN098eMX6PlZkzjKFDqZ6gpPOlRMO5i1s=;
        b=UTV7mqBzFQMt8R8ecV0To1jUbaGWXf6nzmveaxxSoB7sDF50wJYZWv5snYToFyGqFk
         AvaCrfk5bCdn7n5Tb2PKjOg0pICHNwiM7Y3OasgQkuaQl/kB3XgaJB7K5it8gA3mXSDd
         zR2wQP1VzEoF7Gd2eS95B8jcuUjC5dDBTVoLbplvMt56WfQYbW7Y9011UhEI1n3NBig8
         mNA8s8upwx0B4k9RMxA1Mbhx2Rcvjz6AVwhC2hFRGyvP8edMYvx/Jolq3FGNBp+B37We
         4dtksQNTQo8qX4/JMf7AVBrNAmVIDgoRaJM6NPBai2x8HXBgeGsENKlYyjwLfWBOvP0M
         CwLQ==
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
Subject: [PATCH 4.15 44/72] serial: 8250: Add Nuvoton NPCM UART
Date: Fri,  6 Apr 2018 15:24:19 +0200
Message-Id: <20180406084352.689597197@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004355640744843?=
X-GMAIL-MSGID: =?utf-8?q?1597004471498264239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -316,6 +316,7 @@ static const struct of_device_id of_plat
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
+	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -47,6 +47,10 @@
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
+/* Nuvoton NPCM timeout register */
+#define UART_NPCM_TOR          7
+#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
+
 /*
  * Debugging.
  */
@@ -293,6 +297,15 @@ static const struct serial8250_config ua
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
@@ -2161,6 +2174,15 @@ int serial8250_do_startup(struct uart_po
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
@@ -2483,6 +2505,15 @@ static unsigned int xr17v35x_get_divisor
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
@@ -2503,6 +2534,8 @@ static unsigned int serial8250_get_divis
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
