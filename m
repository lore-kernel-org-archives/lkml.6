Return-Path: <mmoese@suse.de>
X-Google-Smtp-Source: AG47ELvaGL8e50TR+EWp5Araoj9UzBZHEyk8YMKEzmEKfIFGMykGOWBloLOxGDVToWCY0wdb/nU/
ARC-Seal: i=1; a=rsa-sha256; t=1520238160; cv=none;
        d=google.com; s=arc-20160816;
        b=qvKLliZ4e2JATRJDVqj0Ykj4jQPC6giUi47XqaWhFRB6PGihpJ9uGgTFyFRcugiS62
         bm9spID5JsdlCpmtr1YPgVeDhIYo9Ov3pElI9RjscH3i/7OYlrfQVfZxOeXBlNyPECPQ
         /sXbXJkmUlOdhAY+oEH0QGkg+kFqKEZeoRknkfa3SnzfqbsNwpg4W5vVCmBYvKnRByiw
         WOQ+nd5yBucbDnAkQqkvU3tOex36RphBw6Jjuzd4MrJmf754VYZQj/Z86gmTGYrkG5F/
         /WYCrRn47lzf9JeNNeWg4N9EpAvCLtRSOp5nz9BgtUkhNXEi1ZAQ3QI6epJmcdcawvcF
         FCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=hk+5roH9MWnMoES2yFRHte3TazN63ZIKYKE/k5ymOXc=;
        b=BVRqDpSwSFASRurgC/vZUFJFByogAO8sq2kL56XOSYquu5unqPX36YjT9+6uUaDKiG
         h65fTaPHI7IkZYyeyseyPiJqs19cMuONS9oIjvVghQ67SsVBatyvjYtdufBnx0AiKZJ4
         2wTVu8LL5xc7ZxcbYuQ72vHjEQHgFksbAqlKToyqoWi3ok9mkyPjhr8eg2FsQUbMJm4n
         +WWILpBkPwdFoFBfbx1a6wxs0xEGNGvvICJ6adKZFz1OSIO3mrutt3902roC8cwFuala
         dbKIutUGvY/RAke3ELY3zciRJ4WvPV7n6Qt92LcPdGqW+p/BEtgI0hvOygo6+C4ljCGD
         ah4w==
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
	Ben Turner <ben.turner@21net.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] 8250-men-mcb: add support for 16z025 and 16z057
Date: Mon,  5 Mar 2018 09:22:35 +0100
Message-Id: <20180305082235.12777-1-mmoese@suse.de>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594085248786012954?=
X-GMAIL-MSGID: =?utf-8?q?1594085248786012954?=
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
Changes to v2:
Added include of linux/io.h due to finding of kbuild robot.

Changes to v1:
Deduplicated the two switch() blocks into a function returning
the number of ports.
Minor style corrections.
---
 drivers/tty/serial/8250/8250_men_mcb.c | 124 ++++++++++++++++++++++++---------
 drivers/tty/serial/8250/Kconfig        |   5 +-
 2 files changed, 93 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 308977807994..98b6b919bca6 100644
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
@@ -41,62 +49,108 @@ static u32 men_z125_lookup_uartclk(struct mcb_device *mdev)
 	return clkval;
 }
 
+static unsigned int get_num_ports(struct mcb_device *mdev,
+				  void __iomem *membase)
+{
+	switch (mdev->id) {
+	case MEN_UART_ID_Z125:
+		return 1U;
+	case MEN_UART_ID_Z025:
+		return readb(membase) >> 4;
+	case MEN_UART_ID_Z057:
+		return 4U;
+	default:
+		dev_err(&mdev->dev, "no supported device!\n");
+		return -ENODEV;
+	}
+}
+
 static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 				     const struct mcb_device_id *id)
 {
 	struct serial_8250_men_mcb_data *data;
 	struct resource *mem;
-
-	data = devm_kzalloc(&mdev->dev,
-			    sizeof(struct serial_8250_men_mcb_data),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	mcb_set_drvdata(mdev, data);
-	data->uart.port.dev = mdev->dma_dev;
-	spin_lock_init(&data->uart.port.lock);
-
-	data->uart.port.type = PORT_16550;
-	data->uart.port.flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
-	data->uart.port.iotype = UPIO_MEM;
-	data->uart.port.uartclk = men_z125_lookup_uartclk(mdev);
-	data->uart.port.regshift = 0;
-	data->uart.port.fifosize = 60;
+	unsigned int num_ports;
+	unsigned int i;
+	void __iomem *membase;
 
 	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
 	if (mem == NULL)
 		return -ENXIO;
+	membase = devm_ioremap_resource(&mdev->dev, mem);
+	if (IS_ERR(membase))
+		return PTR_ERR_OR_ZERO(membase);
 
-	data->uart.port.irq = mcb_get_irq(mdev);
+	num_ports = get_num_ports(mdev, membase);
 
-	data->uart.port.membase = devm_ioremap_resource(&mdev->dev, mem);
-	if (IS_ERR(data->uart.port.membase))
-		return PTR_ERR_OR_ZERO(data->uart.port.membase);
+	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
+		mdev->id, num_ports);
 
-	data->uart.port.mapbase = (unsigned long) mem->start;
-	data->uart.port.iobase = data->uart.port.mapbase;
+	if (num_ports == 0 || num_ports > 4) {
+		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
+			num_ports);
+		return -ENODEV;
+	}
 
-	/* ok, register the port */
-	data->line = serial8250_register_8250_port(&data->uart);
-	if (data->line < 0)
-		return data->line;
+	data = devm_kcalloc(&mdev->dev, num_ports,
+			    sizeof(struct serial_8250_men_mcb_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	dev_info(&mdev->dev, "found 16Z125 UART: ttyS%d\n", data->line);
+	mcb_set_drvdata(mdev, data);
+
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
+					    + i * MEN_UART_MEM_SIZE;
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
+	num_ports = get_num_ports(mdev, data[0].uart.port.membase);
+	if (num_ports < 0 || num_ports > 4) {
+		dev_err(&mdev->dev, "error retrieving number of ports!\n");
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
@@ -113,6 +167,8 @@ static struct mcb_driver mcb_driver = {
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
