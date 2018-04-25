Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MnU+f8paRcOKLR5+qJCTJKuNiAU25ujqp7Ay9VzbQtfyoYPKEpBSdL6ugyc5ohbeFpxUe
ARC-Seal: i=1; a=rsa-sha256; t=1524652840; cv=none;
        d=google.com; s=arc-20160816;
        b=ZMX/EroqDYV2tncsH8lytlNrE1LrAjoc6VG5Erw1WB4SLCyydGN2ccvk8QprdCJKlL
         yCCAJEfoWwqHqKEAOx0A0ty93NuQuaRRrHSOgeytXL4aMl3T5I0QoXE9OCxKhdcp6Ya6
         zI1rs1YaWbgj5y0yLnPG+f8f/bodnHt+OaF4XENAPUGYlq5sXYuqLPGNH6X5IqV8uHv5
         Kyr/ukW9P6dXnmVEaC2aT4H4ny9wK8ZLRVbDJ9/00woyGbIVnaB+v4lEu6GnTPD1hfZU
         iytA7h+8xUvU3z7iNF7f3vXho+8VsW/+X1Xqg5qHUOJQ+sYvNYQTDHgA4zPsrJ1NR/7/
         FtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cveIaINDqN6nv0DmOt63kZKawg06Z/Ew4yJnYMrr0CQ=;
        b=uGuXdg/WR2Vto0SerfFoUwfEW7cr2gE0rj5aAOtWp/Py+GMcw8QQmCtycbSKcmaTWN
         rGuPxDXkx+FC+BbQfKyRnh1h6s0WsuUN5f9vsemibcpoynPbSyXZfG3g4TfwTgJF4PPj
         Q4eK7JqJLAiytbczme6Mjow2OHNdoexVpsEKLvQhDS6GDFpcZjPzkYHr2ZPngQ217U04
         sinlFOM0VlVLn6MdxjofV50U/zYmPuBsMd5/451C3HX1/LFdQqeb5Cw1G+2OXzX0ie0y
         wT6TzU6Ks4dleqoPgolT8dGP6brnzbkVLkmoXAFvnrXmfo6GfUAkI6pQv51IN7JLvi9V
         SIMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matt Schulte <matts@commtech-fastcom.com>,
	Aaron Sierra <asierra@xes-inc.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 088/183] tty: serial: exar: Relocate sleep wake-up handling
Date: Wed, 25 Apr 2018 12:35:08 +0200
Message-Id: <20180425103246.029612025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714376689786689?=
X-GMAIL-MSGID: =?utf-8?q?1598714376689786689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Sierra <asierra@xes-inc.com>


[ Upstream commit c7e1b4059075c9e8eed101d7cc5da43e95eb5e18 ]

Exar sleep wake-up handling has been done on a per-channel basis by
virtue of INT0 being accessible from each channel's address space. I
believe this was initially done out of necessity, but now that Exar
devices have their own driver, we can do things more efficiently by
registering a dedicated INT0 handler at the PCI device level.

I see this change providing the following benefits:

    1. If more than one port is active, eliminates the redundant bus
       cycles for reading INT0 on every interrupt.
    2. This note associated with hooking in the per-channel handler in
       8250_port.c is resolved:
        /* Fixme: probably not the best place for this */

Cc: Matt Schulte <matts@commtech-fastcom.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c |   34 ++++++++++++++++++++++++++++++----
 drivers/tty/serial/8250/8250_port.c |   26 --------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -37,6 +37,7 @@
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
 
+#define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
 
 #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
@@ -124,6 +125,7 @@ struct exar8250_board {
 struct exar8250 {
 	unsigned int		nr;
 	struct exar8250_board	*board;
+	void __iomem		*virt;
 	int			line[0];
 };
 
@@ -134,12 +136,9 @@ static int default_setup(struct exar8250
 	const struct exar8250_board *board = priv->board;
 	unsigned int bar = 0;
 
-	if (!pcim_iomap_table(pcidev)[bar] && !pcim_iomap(pcidev, bar, 0))
-		return -ENOMEM;
-
 	port->port.iotype = UPIO_MEM;
 	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
-	port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
+	port->port.membase = priv->virt + offset;
 	port->port.regshift = board->reg_shift;
 
 	return 0;
@@ -423,6 +422,25 @@ static void pci_xr17v35x_exit(struct pci
 	port->port.private_data = NULL;
 }
 
+/*
+ * These Exar UARTs have an extra interrupt indicator that could fire for a
+ * few interrupts that are not presented/cleared through IIR.  One of which is
+ * a wakeup interrupt when coming out of sleep.  These interrupts are only
+ * cleared by reading global INT0 or INT1 registers as interrupts are
+ * associated with channel 0. The INT[3:0] registers _are_ accessible from each
+ * channel's address space, but for the sake of bus efficiency we register a
+ * dedicated handler at the PCI device level to handle them.
+ */
+static irqreturn_t exar_misc_handler(int irq, void *data)
+{
+	struct exar8250 *priv = data;
+
+	/* Clear all PCI interrupts by reading INT0. No effect on IIR */
+	ioread8(priv->virt + UART_EXAR_INT0);
+
+	return IRQ_HANDLED;
+}
+
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -451,6 +469,9 @@ exar_pci_probe(struct pci_dev *pcidev, c
 		return -ENOMEM;
 
 	priv->board = board;
+	priv->virt = pcim_iomap(pcidev, bar, 0);
+	if (!priv->virt)
+		return -ENOMEM;
 
 	pci_set_master(pcidev);
 
@@ -464,6 +485,11 @@ exar_pci_probe(struct pci_dev *pcidev, c
 	uart.port.irq = pci_irq_vector(pcidev, 0);
 	uart.port.dev = &pcidev->dev;
 
+	rc = devm_request_irq(&pcidev->dev, uart.port.irq, exar_misc_handler,
+			 IRQF_SHARED, "exar_uart", priv);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -458,7 +458,6 @@ static void io_serial_out(struct uart_po
 }
 
 static int serial8250_default_handle_irq(struct uart_port *port);
-static int exar_handle_irq(struct uart_port *port);
 
 static void set_io_from_upio(struct uart_port *p)
 {
@@ -1904,26 +1903,6 @@ static int serial8250_default_handle_irq
 }
 
 /*
- * These Exar UARTs have an extra interrupt indicator that could
- * fire for a few unimplemented interrupts.  One of which is a
- * wakeup event when coming out of sleep.  Put this here just
- * to be on the safe side that these interrupts don't go unhandled.
- */
-static int exar_handle_irq(struct uart_port *port)
-{
-	unsigned int iir = serial_port_in(port, UART_IIR);
-	int ret = 0;
-
-	if (((port->type == PORT_XR17V35X) || (port->type == PORT_XR17D15X)) &&
-	    serial_port_in(port, UART_EXAR_INT0) != 0)
-		ret = 1;
-
-	ret |= serial8250_handle_irq(port, iir);
-
-	return ret;
-}
-
-/*
  * Newer 16550 compatible parts such as the SC16C650 & Altera 16550 Soft IP
  * have a programmable TX threshold that triggers the THRE interrupt in
  * the IIR register. In this case, the THRE interrupt indicates the FIFO
@@ -3107,11 +3086,6 @@ static void serial8250_config_port(struc
 	if (port->type == PORT_UNKNOWN)
 		serial8250_release_std_resource(up);
 
-	/* Fixme: probably not the best place for this */
-	if ((port->type == PORT_XR17V35X) ||
-	   (port->type == PORT_XR17D15X))
-		port->handle_irq = exar_handle_irq;
-
 	register_dev_spec_attr_grp(up);
 	up->fcr = uart_config[up->port.type].fcr;
 }
