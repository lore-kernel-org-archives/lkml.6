Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZr+GRVy8jayyt5XbMT0ubl0+muynOYgwmtFlNgBvRUHPQJhoOhNAPhEU0trQdK0DePFuw01
ARC-Seal: i=1; a=rsa-sha256; t=1525780180; cv=none;
        d=google.com; s=arc-20160816;
        b=wl8xVMQOLROY+yIELeSsCIV0/pAEQ28mPCs2/FAOuIhOmloeQrOtyDJD2KQfxXhaXj
         fdqyIwVqJ5aw3Hg8cZGMs9I548V5bzBuoWbc4rGoc8paJhWzdiOpY0eqqzKGBO/rcthR
         mRZkHAslWOFZ6y4pDadQuB/WnNiYd5KAZubGQS5njTwExogXrBztp06rtc0hAlODd8LG
         NulLUC+8Rpp51hRR0GaaG+JCyLwHrtOsxkJSp+lLPT/fofKKYjvzVNaUtJ/C22QfJ6G7
         BJpSxDfZAFLHHtCifUp6Xe2WtHN/hTkcKvHtEdRGfGPZNA2Pxy+/TQ3hBpxolGAoyd4q
         p68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=y+JKOmxcjSPFoHlsMeqEKHDIday4nDdfTG1h2RG0H3w=;
        b=xW+0HdpgYHKTWT+dC4TDjR+7HylSt8kkkwgbgYveEMgR56L45S+4UM2stRi4iNJFT0
         U59su2M6IW52LuggtMoijDpEnmiFhGW7B4LlHTrbLrXfNLAxPgShtWLqvg+h8CFawflo
         lo0nVUu79F3K9qMvHLlqn2M1GWS0ZfVxLsrfLNSiyNhid/eLtng7W1ak63Nqt0mnma8h
         DIPyTg6Ks9RylyW5Cl0jjbrVP1oaujSQ5eGMur3Pe6yFZ9SuSHIr1mHYsTpb0iZr2BJq
         Hq+Lt1KQ9YoXN8Gx5HaWrfZaXiuPXAYQRpwAhUPZp/HrH2VvTBC6nLB7e8PtrDUua+5z
         91Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 08 May 2018 04:49:34 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 6/8] serial: Add Tegra Combined UART driver
Date: Tue, 8 May 2018 14:44:01 +0300
Message-ID: <20180508114403.14499-7-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896478847127946?=
X-GMAIL-MSGID: =?utf-8?q?1599896478847127946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
multiplexing multiple "virtual UARTs" into a single hardware serial
port. The TCU is the primary serial port on Tegra194 devices.

Add a TCU driver utilizing the mailbox framework, as the used mailboxes
are part of Tegra HSP blocks that are already controlled by the Tegra
HSP mailbox driver.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/tty/serial/Kconfig       |   9 ++
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/tegra-tcu.c   | 302 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 315 insertions(+)
 create mode 100644 drivers/tty/serial/tegra-tcu.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index eca55187539a..494db7afe230 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -322,6 +322,15 @@ config SERIAL_TEGRA
 	  are enabled). This driver uses the APB DMA to achieve higher baudrate
 	  and better performance.
 
+config SERIAL_TEGRA_TCU
+	tristate "NVIDIA Tegra Combined UART"
+	depends on ARCH_TEGRA && MAILBOX
+	select SERIAL_CORE
+	help
+	  Support for the mailbox-based TCU (Tegra Combined UART) serial port.
+	  TCU is a virtual serial port that allows multiplexing multiple data
+	  streams into a single hardware serial port.
+
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index daac675612df..4ad82231ff8a 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_SERIAL_LANTIQ)	+= lantiq.o
 obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
 obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
 obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
+obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
 obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
 obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
 obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
new file mode 100644
index 000000000000..8b46fe3a4b0c
--- /dev/null
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/console.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+static struct uart_driver tegra_tcu_uart_driver;
+static struct uart_port tegra_tcu_uart_port;
+
+struct tegra_tcu {
+	struct mbox_client tx_client, rx_client;
+	struct mbox_chan *tx, *rx;
+};
+
+static unsigned int tegra_tcu_uart_tx_empty(struct uart_port *port)
+{
+	return TIOCSER_TEMT;
+}
+
+static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	(void)port;
+	(void)mctrl;
+}
+
+static unsigned int tegra_tcu_uart_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void tegra_tcu_uart_stop_tx(struct uart_port *port)
+{
+	(void)port;
+}
+
+static void tegra_tcu_write(const char *s, unsigned int count)
+{
+	struct tegra_tcu *tcu = tegra_tcu_uart_port.private_data;
+	unsigned int written = 0, i = 0;
+	bool insert_nl = false;
+	uint32_t value = 0;
+
+	while (i < count) {
+		if (insert_nl) {
+			value |= '\n' << (written++ * 8);
+			insert_nl = false;
+			i++;
+		} else if (s[i] == '\n') {
+			value |= '\r' << (written++ * 8);
+			insert_nl = true;
+		} else {
+			value |= s[i++] << (written++ * 8);
+		}
+
+		if (written == 3) {
+			value |= 3 << 24;
+			value |= BIT(26);
+			mbox_send_message(tcu->tx, &value);
+			value = 0;
+			written = 0;
+		}
+	}
+
+	if (written) {
+		value |= written << 24;
+		value |= BIT(26);
+		mbox_send_message(tcu->tx, &value);
+	}
+}
+
+static void tegra_tcu_uart_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long count;
+
+	for (;;) {
+		count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+		if (!count)
+			break;
+
+		tegra_tcu_write(&xmit->buf[xmit->tail], count);
+		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
+	}
+
+	uart_write_wakeup(port);
+}
+
+static void tegra_tcu_uart_stop_rx(struct uart_port *port)
+{
+	(void)port;
+}
+
+static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
+{
+	(void)port;
+	(void)ctl;
+}
+
+static int tegra_tcu_uart_startup(struct uart_port *port)
+{
+	(void)port;
+
+	return 0;
+}
+
+static void tegra_tcu_uart_shutdown(struct uart_port *port)
+{
+	(void)port;
+}
+
+static void tegra_tcu_uart_set_termios(struct uart_port *port,
+				       struct ktermios *new,
+				       struct ktermios *old)
+{
+	(void)port;
+	(void)new;
+	(void)old;
+}
+
+static const struct uart_ops tegra_tcu_uart_ops = {
+	.tx_empty = tegra_tcu_uart_tx_empty,
+	.set_mctrl = tegra_tcu_uart_set_mctrl,
+	.get_mctrl = tegra_tcu_uart_get_mctrl,
+	.stop_tx = tegra_tcu_uart_stop_tx,
+	.start_tx = tegra_tcu_uart_start_tx,
+	.stop_rx = tegra_tcu_uart_stop_rx,
+	.break_ctl = tegra_tcu_uart_break_ctl,
+	.startup = tegra_tcu_uart_startup,
+	.shutdown = tegra_tcu_uart_shutdown,
+	.set_termios = tegra_tcu_uart_set_termios,
+};
+
+static void tegra_tcu_console_write(struct console *cons, const char *s,
+				    unsigned int count)
+{
+	(void)cons;
+
+	tegra_tcu_write(s, count);
+}
+
+static int tegra_tcu_console_setup(struct console *cons, char *options)
+{
+	(void)options;
+
+	if (!tegra_tcu_uart_port.private_data)
+		return -ENODEV;
+
+	return uart_set_options(&tegra_tcu_uart_port, cons,
+				115200, 'n', 8, 'n');
+}
+
+static struct console tegra_tcu_console = {
+	.name = "ttyTCU",
+	.device = uart_console_device,
+	.flags = CON_PRINTBUFFER | CON_ANYTIME,
+	.index = -1,
+	.write = tegra_tcu_console_write,
+	.setup = tegra_tcu_console_setup,
+	.data = &tegra_tcu_uart_driver,
+};
+
+static struct uart_driver tegra_tcu_uart_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "tegra-tcu",
+	.dev_name = "ttyTCU",
+	.cons = &tegra_tcu_console,
+	.nr = 1,
+};
+
+static void tegra_tcu_receive(struct mbox_client *client, void *msg_p)
+{
+	struct tty_port *port = &tegra_tcu_uart_port.state->port;
+	uint32_t msg = *(uint32_t *)msg_p;
+	unsigned int num_bytes;
+	int i;
+
+	num_bytes = (msg >> 24) & 0x3;
+	for (i = 0; i < num_bytes; i++)
+		tty_insert_flip_char(port, (msg >> (i*8)) & 0xff, TTY_NORMAL);
+
+	tty_flip_buffer_push(port);
+}
+
+static int tegra_tcu_probe(struct platform_device *pdev)
+{
+	struct uart_port *port = &tegra_tcu_uart_port;
+	struct tegra_tcu *tcu;
+	int err;
+
+	tcu = devm_kzalloc(&pdev->dev, sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	tcu->tx_client.dev = &pdev->dev;
+	tcu->rx_client.dev = &pdev->dev;
+	tcu->rx_client.rx_callback = tegra_tcu_receive;
+
+	tcu->tx = mbox_request_channel_byname(&tcu->tx_client, "tx");
+	if (IS_ERR(tcu->tx)) {
+		err = PTR_ERR(tcu->tx);
+		dev_err(&pdev->dev, "failed to get tx mailbox: %d\n", err);
+		return err;
+	}
+
+	tcu->rx = mbox_request_channel_byname(&tcu->rx_client, "rx");
+	if (IS_ERR(tcu->rx)) {
+		err = PTR_ERR(tcu->rx);
+		dev_err(&pdev->dev, "failed to get rx mailbox: %d\n", err);
+		goto free_tx;
+	}
+
+	err = uart_register_driver(&tegra_tcu_uart_driver);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register UART driver: %d\n",
+			err);
+		goto free_rx;
+	}
+
+	spin_lock_init(&port->lock);
+	port->dev = &pdev->dev;
+	port->type = PORT_TEGRA_TCU;
+	port->ops = &tegra_tcu_uart_ops;
+	port->fifosize = 1;
+	port->iotype = UPIO_MEM;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->private_data = tcu;
+
+	err = uart_add_one_port(&tegra_tcu_uart_driver, port);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add UART port: %d\n", err);
+		goto unregister_uart;
+	}
+
+	return 0;
+
+unregister_uart:
+	uart_unregister_driver(&tegra_tcu_uart_driver);
+free_rx:
+	mbox_free_channel(tcu->rx);
+free_tx:
+	mbox_free_channel(tcu->tx);
+
+	return err;
+}
+
+static int tegra_tcu_remove(struct platform_device *pdev)
+{
+	uart_remove_one_port(&tegra_tcu_uart_driver, &tegra_tcu_uart_port);
+	uart_unregister_driver(&tegra_tcu_uart_driver);
+
+	return 0;
+}
+
+static const struct of_device_id tegra_tcu_match[] = {
+	{ .compatible = "nvidia,tegra194-tcu" },
+	{ }
+};
+
+static struct platform_driver tegra_tcu_driver = {
+	.driver = {
+		.name = "tegra-tcu",
+		.of_match_table = tegra_tcu_match,
+	},
+	.probe = tegra_tcu_probe,
+	.remove = tegra_tcu_remove,
+};
+
+static int __init tegra_tcu_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&tegra_tcu_driver);
+	if (err)
+		return err;
+
+	register_console(&tegra_tcu_console);
+
+	return 0;
+}
+module_init(tegra_tcu_init);
+
+static void __exit tegra_tcu_exit(void)
+{
+	unregister_console(&tegra_tcu_console);
+	platform_driver_unregister(&tegra_tcu_driver);
+}
+module_exit(tegra_tcu_exit);
+
+MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("NVIDIA Tegra Combined UART driver");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index dce5f9dae121..eaf3c303cba6 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -281,4 +281,7 @@
 /* MediaTek BTIF */
 #define PORT_MTK_BTIF	117
 
+/* NVIDIA Tegra Combined UART */
+#define PORT_TEGRA_TCU	118
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.16.1
