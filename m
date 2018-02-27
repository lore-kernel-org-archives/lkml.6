Return-Path: <mmoese@suse.de>
X-Google-Smtp-Source: AH8x225oooX6k8AhaYKjIWomG/Qkmpz5T8/pzaN6ZlTRKZ+n87Yax3NAxnygmlVMwn0xoVLRrc6o
ARC-Seal: i=1; a=rsa-sha256; t=1519745488; cv=none;
        d=google.com; s=arc-20160816;
        b=IPEEDVlpti+ZL6y4vbN7qg9X6CX0+DlmW5TlRKN5i25myFyoZcct9ySl5gap0Qr1Vz
         gVc2rbnaoN5nAJFzRlkU3NV2/fv2Ont6XN7ndyplJxx7eEF0vbSLUt/NZqfrwJweEAHJ
         qgloh6DcPh/3sZc2kKtvByLBXUg6EIHF7FDJ0FhV/EREh+MVfP4lMl4utwAl0m75idLW
         STXU2PrYKn6XOqhYuuEnGvqxuibh7C0UvLoGftaJZolK23pS0daPRJAKGl/cHuN4Jqti
         xgbGWFZISLKznGNZGml+Mt/0BBqd4bz9plrRWQoPKej+sUf6dWS+pShHcQ2uOdpLlxo4
         wr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=/rzYIdUwNgCQMUPGFdx4Jo4TH1w1UqNZZleh9KVIxms=;
        b=fZCbRzgrdxlAj0kY7z3dKw78MtSMnE0800RKVbomYIdOKeAprbfr7ux74/Yl4LGPmB
         vUCYc/9YWUKK/KRMgrymiz757BAHgC1eJGWYdsLI90WHU6t+yltNG1AeF/lCX3Ibgug5
         QabVzQIrlbxeRGRPEod5EOFabNErhiSVHv8HQCloDrpW0AX4VRxC5zxhNL2fsH1c9vj9
         shMJ4EhY/zws5vnhyp/4TB9h58lg0KZTJhdqifhNXv+l5sga1sQqINeIH5kdqdfS+8Sn
         6NnpYjgJoBPoqBO6O3YRdKN6kkMTNvNG5YtcC5lzVmRlWXRyP1U8u45jhYMalQOhyneJ
         GZxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mmoese@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=mmoese@suse.de
From: Michael Moese <mmoese@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Michael Moese <mmoese@suse.de>,
	Andreas Geissler <andreas.geissler@men.de>,
	Ben Turner <ben.turner@21net.com>
Subject: [PATCH] 8250-men-mcb: add support for 16z025 and 16z057
Date: Tue, 27 Feb 2018 16:31:06 +0100
Message-Id: <20180227153106.3224-1-mmoese@suse.de>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593568644699224821?=
X-GMAIL-MSGID: =?utf-8?q?1593568644699224821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for two MEN UARTs (16z025 and 16z057) to the
8250_men_mcb driver.
The 16z025 consists of up to four ports, the 16z057 has
exactly four ports. Apart from that, all of them share the
Port settings.

Signed-off-by: Michael Moese <mmoese@suse.de>
Reported-by: Ben Turner <ben.turner@21net.com>
Tested-by: Ben Turner <ben.turner@21net.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 132 ++++++++++++++++++++++++---------
 drivers/tty/serial/8250/Kconfig        |   5 +-
 2 files changed, 100 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 308977807994..47abcb8d834f 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -7,6 +7,12 @@
 #include <linux/serial_8250.h>
 #include <uapi/linux/serial_core.h>
 
+#define MEN_UART_ID_Z025 0x19
+#define MEN_UART_ID_Z057 0x39
+#define MEN_UART_ID_Z125 0x7d
+
+#define MEN_UART_MEM_SIZE 0x10
+
 struct serial_8250_men_mcb_data {
 	struct uart_8250_port uart;
 	int line;
@@ -18,7 +24,7 @@ struct serial_8250_men_mcb_data {
  * parameter in order to really set the correct baudrate, and
  * do so if possible without user interaction
  */
-static u32 men_z125_lookup_uartclk(struct mcb_device *mdev)
+static u32 men_lookup_uartclk(struct mcb_device *mdev)
 {
 	/* use default value if board is not available below */
 	u32 clkval = 1041666;
@@ -28,10 +34,12 @@ static u32 men_z125_lookup_uartclk(struct mcb_device *mdev)
 		mdev->bus->name);
 	if  (strncmp(mdev->bus->name, "F075", 4) == 0)
 		clkval = 1041666;
-	else if  (strncmp(mdev->bus->name, "F216", 4) == 0)
+	else if (strncmp(mdev->bus->name, "F216", 4) == 0)
 		clkval = 1843200;
 	else if (strncmp(mdev->bus->name, "G215", 4) == 0)
 		clkval = 1843200;
+	else if (strncmp(mdev->bus->name, "F210", 4) == 0)
+		clkval = 115200;
 	else
 		dev_info(&mdev->dev,
 			 "board not detected, using default uartclk\n");
@@ -46,57 +54,109 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 {
 	struct serial_8250_men_mcb_data *data;
 	struct resource *mem;
+	unsigned int num_ports;
+	unsigned int i;
+	void __iomem *membase;
+
+	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
+	if (mem == NULL)
+		return -ENXIO;
 
-	data = devm_kzalloc(&mdev->dev,
+	membase = devm_ioremap_resource(&mdev->dev, mem);
+	if (IS_ERR(membase))
+		return PTR_ERR_OR_ZERO(membase);
+
+	switch (mdev->id) {
+	case MEN_UART_ID_Z125:
+		num_ports = 1U;
+		break;
+	case MEN_UART_ID_Z025:
+		num_ports = readb(membase) >> 4;
+		break;
+	case MEN_UART_ID_Z057:
+		num_ports = 4U;
+		break;
+	default:
+		dev_err(&mdev->dev, "no supported device!\n");
+		return -ENODEV;
+	}
+	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
+		mdev->id, num_ports);
+
+	if (num_ports == 0 || num_ports > 4) {
+		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
+			num_ports);
+		return -ENODEV;
+	}
+
+	data = devm_kcalloc(&mdev->dev, num_ports,
 			    sizeof(struct serial_8250_men_mcb_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	mcb_set_drvdata(mdev, data);
-	data->uart.port.dev = mdev->dma_dev;
-	spin_lock_init(&data->uart.port.lock);
-
-	data->uart.port.type = PORT_16550;
-	data->uart.port.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-	data->uart.port.iotype = UPIO_MEM;
-	data->uart.port.uartclk = men_z125_lookup_uartclk(mdev);
-	data->uart.port.regshift = 0;
-	data->uart.port.fifosize = 60;
-
-	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
-	if (mem == NULL)
-		return -ENXIO;
-
-	data->uart.port.irq = mcb_get_irq(mdev);
 
-	data->uart.port.membase = devm_ioremap_resource(&mdev->dev, mem);
-	if (IS_ERR(data->uart.port.membase))
-		return PTR_ERR_OR_ZERO(data->uart.port.membase);
-
-	data->uart.port.mapbase = (unsigned long) mem->start;
-	data->uart.port.iobase = data->uart.port.mapbase;
-
-	/* ok, register the port */
-	data->line = serial8250_register_8250_port(&data->uart);
-	if (data->line < 0)
-		return data->line;
-
-	dev_info(&mdev->dev, "found 16Z125 UART: ttyS%d\n", data->line);
+	for (i = 0; i < num_ports; i++) {
+		data[i].uart.port.dev = mdev->dma_dev;
+		spin_lock_init(&data[i].uart.port.lock);
+
+		data[i].uart.port.type = PORT_16550;
+		data[i].uart.port.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ
+					  | UPF_FIXED_TYPE;
+		data[i].uart.port.iotype = UPIO_MEM;
+		data[i].uart.port.uartclk = men_lookup_uartclk(mdev);
+		data[i].uart.port.regshift = 0;
+		data[i].uart.port.irq = mcb_get_irq(mdev);
+		data[i].uart.port.membase = membase;
+		data[i].uart.port.fifosize = 60;
+		data[i].uart.port.mapbase = (unsigned long) mem->start
+					    + (i * MEN_UART_MEM_SIZE);
+		data[i].uart.port.iobase = data[i].uart.port.mapbase;
+
+		/* ok, register the port */
+		data[i].line = serial8250_register_8250_port(&data[i].uart);
+		if (data[i].line < 0) {
+			dev_err(&mdev->dev, "unable to register UART port\n");
+			return data[i].line;
+		}
+		dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data[i].line);
+	}
 
 	return 0;
 }
 
 static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
 {
+	unsigned int num_ports, i;
 	struct serial_8250_men_mcb_data *data = mcb_get_drvdata(mdev);
 
-	if (data)
-		serial8250_unregister_port(data->line);
+	if (!data)
+		return;
+
+	switch (mdev->id) {
+	case MEN_UART_ID_Z125:
+		num_ports = 1U;
+		break;
+	case MEN_UART_ID_Z025:
+		num_ports = readb(data[0].uart.port.membase) >> 4;
+		break;
+	case MEN_UART_ID_Z057:
+		num_ports = 4U;
+		break;
+	default:
+		dev_err(&mdev->dev, "no supported device!\n");
+		return;
+	}
+
+	for (i = 0; i < num_ports; i++)
+		serial8250_unregister_port(data[i].line);
 }
 
 static const struct mcb_device_id serial_8250_men_mcb_ids[] = {
-	{ .device = 0x7d },
+	{ .device = MEN_UART_ID_Z025 },
+	{ .device = MEN_UART_ID_Z057 },
+	{ .device = MEN_UART_ID_Z125 },
 	{ }
 };
 MODULE_DEVICE_TABLE(mcb, serial_8250_men_mcb_ids);
@@ -113,6 +173,8 @@ static struct mcb_driver mcb_driver = {
 module_mcb_driver(mcb_driver);
 
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("MEN 16z125 8250 UART driver");
+MODULE_DESCRIPTION("MEN 8250 UART driver");
 MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
 MODULE_ALIAS("mcb:16z125");
+MODULE_ALIAS("mcb:16z025");
+MODULE_ALIAS("mcb:16z057");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 16b1496e6105..f005eaf8bc57 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -157,11 +157,12 @@ config SERIAL_8250_CS
 	  If unsure, say N.
 
 config SERIAL_8250_MEN_MCB
-	tristate "MEN Z125 UART device support"
+	tristate "MEN MCB UART device support"
 	depends on MCB && SERIAL_8250
 	help
 	  This enables support for FPGA based UARTs found on many MEN
-	  boards. This driver enables support for the Z125 UARTs.
+	  boards. This driver enables support for the 16z025, 16z057
+	  and 16z125 UARTs.
 
 	  To compile this driver as a module, chose M here: the
 	  module will be called 8250_men_mcb.
-- 
2.13.6
