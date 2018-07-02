Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A22425D0D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A22425D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030737AbeGBLnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:43:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11159 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeGBLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:41:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3a0f810000>; Mon, 02 Jul 2018 04:41:53 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 04:41:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Jul 2018 04:41:52 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 11:41:52 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 11:41:52 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Mon, 2 Jul 2018 11:41:52 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b3a0f7d0001>; Mon, 02 Jul 2018 04:41:51 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
Date:   Mon, 2 Jul 2018 14:40:31 +0300
Message-ID: <20180702114033.15654-7-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
multiplexing multiple "virtual UARTs" into a single hardware serial
port. The TCU is the primary serial port on Tegra194 devices.

Add a TCU driver utilizing the mailbox framework, as the used mailboxes
are part of Tegra HSP blocks that are already controlled by the Tegra
HSP mailbox driver.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---

Notes:
    v2:
    - Removed (void) casts for unused variables.
    - Changed the uart_set_options() call to be on one line, even if its
      over 80 characters.
    - Added defines for magic numbers.
    - Style fixes.
    - Changed Kconfig entry to depend on the Tegra HSP driver instead of
      just the mailbox framework.
    
    v3:
    - Removed FLUSH bit, as it's unnecessary and slows down printing
    - Removed call to uart_set_options
    - Added mbox_free_channel calls to remove()

 drivers/tty/serial/Kconfig       |   9 ++
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/tegra-tcu.c   | 291 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 304 insertions(+)
 create mode 100644 drivers/tty/serial/tegra-tcu.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index df8bd0c7b97d..5fdd336e8937 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -322,6 +322,15 @@ config SERIAL_TEGRA
 	  are enabled). This driver uses the APB DMA to achieve higher baudrate
 	  and better performance.
 
+config SERIAL_TEGRA_TCU
+	tristate "NVIDIA Tegra Combined UART"
+	depends on ARCH_TEGRA && TEGRA_HSP_MBOX
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
index 000000000000..de58815bb215
--- /dev/null
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -0,0 +1,291 @@
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
+#define TCU_MBOX_BYTE(i, x)			((x) << (i*8))
+#define TCU_MBOX_BYTE_V(x, i)			(((x) >> (i*8)) & 0xff)
+#define TCU_MBOX_NUM_BYTES(x)			((x) << 24)
+#define TCU_MBOX_NUM_BYTES_V(x)			(((x) >> 24) & 0x3)
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
+}
+
+static unsigned int tegra_tcu_uart_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void tegra_tcu_uart_stop_tx(struct uart_port *port)
+{
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
+			value |= TCU_MBOX_BYTE(written++, '\n');
+			insert_nl = false;
+			i++;
+		} else if (s[i] == '\n') {
+			value |= TCU_MBOX_BYTE(written++, '\r');
+			insert_nl = true;
+		} else {
+			value |= TCU_MBOX_BYTE(written++, s[i++]);
+		}
+
+		if (written == 3) {
+			value |= TCU_MBOX_NUM_BYTES(3);
+			mbox_send_message(tcu->tx, &value);
+			value = 0;
+			written = 0;
+		}
+	}
+
+	if (written) {
+		value |= TCU_MBOX_NUM_BYTES(written);
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
+}
+
+static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
+{
+}
+
+static int tegra_tcu_uart_startup(struct uart_port *port)
+{
+	return 0;
+}
+
+static void tegra_tcu_uart_shutdown(struct uart_port *port)
+{
+}
+
+static void tegra_tcu_uart_set_termios(struct uart_port *port,
+				       struct ktermios *new,
+				       struct ktermios *old)
+{
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
+	tegra_tcu_write(s, count);
+}
+
+static int tegra_tcu_console_setup(struct console *cons, char *options)
+{
+	return 0;
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
+	num_bytes = TCU_MBOX_NUM_BYTES_V(msg);
+	for (i = 0; i < num_bytes; i++)
+		tty_insert_flip_char(port, TCU_MBOX_BYTE_V(msg, i), TTY_NORMAL);
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
+	platform_set_drvdata(pdev, tcu);
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
+	struct tegra_tcu *tcu = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&tegra_tcu_uart_driver, &tegra_tcu_uart_port);
+	uart_unregister_driver(&tegra_tcu_uart_driver);
+	mbox_free_channel(tcu->rx);
+	mbox_free_channel(tcu->tx);
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
index dce5f9dae121..69883c32cb98 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -79,6 +79,9 @@
 /* Nuvoton UART */
 #define PORT_NPCM	40
 
+/* NVIDIA Tegra Combined UART */
+#define PORT_TEGRA_TCU	41
+
 /* Intel EG20 */
 #define PORT_PCH_8LINE	44
 #define PORT_PCH_2LINE	45
-- 
2.16.1

