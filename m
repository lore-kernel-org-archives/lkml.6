Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A5BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51A021908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luf+qgoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBGOjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:39:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfBGOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:39:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so28098pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1nID1jHED5BSd1qcUkdTr+9IBVI3RJS3sh8T3acwUiw=;
        b=luf+qgoi8YBKrX404aBVy40RJzqDYYR8YisErFlZg5540Eke5ssJSCZhq+jcbrs7C4
         ANANNv3Nfx76y9jAguYvt6En9CNWgnHjZEf5q1DObRw4iU/ccNaVe4IJ9gy25JewoIF/
         Nup3zIrrpXx+QssAY/NnwYKDNQGDk00ioO7VC1+YiMliqtdone+PV3s7W3l0Yar5nhzt
         9D5rEUEg1lzBrvBE3tcf1ySTW76PoZpxJ4okAhwebfKM1kUA3QPdumpqj20HZ3TWuDmr
         RBkB1sK6fVtCk6diaQ2VFarsUEcN0UuqlQ1600xqSe/RlEbyLUOXQ9yh5PN0c9BggaRz
         UaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=1nID1jHED5BSd1qcUkdTr+9IBVI3RJS3sh8T3acwUiw=;
        b=OFq6341qPw+awBzCnMk12QKWWVk7xPxDrrqMYaRfS2v7FXJQ7MYWAnHxSvWMOAGEvN
         svzz+mI1E4yUecsQC/T7xBDNwgzuf01/hT9UefjmqctTXHe8Lf07mDVdxmfsrg1N1QeS
         lg5/+T5grUBFAmr1IFP4A8U8CAg18z1EEdaGXrQVSnw3YanpoGjXGFiz9fMEjtgUrZhN
         hNs4zZDeVgUKkjiVWZNEUumWKITLD+Sd6RKqN/jFVvW37aHGnU9c0IT0mc2N4l8I74c0
         xvU/L1XPW4eZBbcinj5wNXKLtCo0gxydEEd+marVA6JHv758R1tMkGOJnge7iFwEqHzB
         edww==
X-Gm-Message-State: AHQUAuYiup8PqvLURaes/Jskyd/JCkmyb1J5EFKJxytrrbXZB+ohu38v
        BbKlF1LWUE5StemLsBDTW6lspDVj
X-Google-Smtp-Source: AHgI3IYBBtn0IAc5EpO4cOWlj09W3juGbUObY8JRxaGh3t0gHX9Aw/OibflcGmLS82KF7hps01HH8g==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr10415315pgb.249.1549550357765;
        Thu, 07 Feb 2019 06:39:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5sm43345732pge.49.2019.02.07.06.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:39:17 -0800 (PST)
Date:   Thu, 7 Feb 2019 06:39:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add Tegra Combined UART driver
Message-ID: <20190207143916.GA11121@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:28:19AM +0100, Thierry Reding wrote:
> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> multiplexing multiple "virtual UARTs" into a single hardware serial
> port. The TCU is the primary serial port on Tegra194 devices.
> 
> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> are part of Tegra HSP blocks that are already controlled by the Tegra
> HSP mailbox driver.
> 
> Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

In case 0day hasn't reported it:

arm64:allmodconfig:

ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!

mbox_flush() isn't exported.

Guenter

> ---
>  drivers/tty/serial/Kconfig       |  22 +++
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/tegra-tcu.c   | 298 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 324 insertions(+)
>  create mode 100644 drivers/tty/serial/tegra-tcu.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 089a6f285d5e..72966bc0ac76 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -335,6 +335,28 @@ config SERIAL_TEGRA
>  	  are enabled). This driver uses the APB DMA to achieve higher baudrate
>  	  and better performance.
>  
> +config SERIAL_TEGRA_TCU
> +	tristate "NVIDIA Tegra Combined UART"
> +	depends on ARCH_TEGRA && TEGRA_HSP_MBOX
> +	select SERIAL_CORE
> +	help
> +	  Support for the mailbox-based TCU (Tegra Combined UART) serial port.
> +	  TCU is a virtual serial port that allows multiplexing multiple data
> +	  streams into a single hardware serial port.
> +
> +config SERIAL_TEGRA_TCU_CONSOLE
> +	bool "Support for console on a Tegra TCU serial port"
> +	depends on SERIAL_TEGRA_TCU=y
> +	select SERIAL_CORE_CONSOLE
> +	default y
> +	---help---
> +	  If you say Y here, it will be possible to use a the Tegra TCU as the
> +	  system console (the system console is the device which receives all
> +	  kernel messages and warnings and which allows logins in single user
> +	  mode).
> +
> +	  If unsure, say Y.
> +
>  config SERIAL_MAX3100
>  	tristate "MAX3100 support"
>  	depends on SPI
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 1511e8a9f856..40b702aaa85e 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_SERIAL_LANTIQ)	+= lantiq.o
>  obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
>  obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
>  obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
> +obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
>  obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
>  obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
>  obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
> diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
> new file mode 100644
> index 000000000000..aaf8748a6147
> --- /dev/null
> +++ b/drivers/tty/serial/tegra-tcu.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <linux/console.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +
> +#define TCU_MBOX_BYTE(i, x)			((x) << (i * 8))
> +#define TCU_MBOX_BYTE_V(x, i)			(((x) >> (i * 8)) & 0xff)
> +#define TCU_MBOX_NUM_BYTES(x)			((x) << 24)
> +#define TCU_MBOX_NUM_BYTES_V(x)			(((x) >> 24) & 0x3)
> +
> +struct tegra_tcu {
> +	struct uart_driver driver;
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
> +	struct console console;
> +#endif
> +	struct uart_port port;
> +
> +	struct mbox_client tx_client, rx_client;
> +	struct mbox_chan *tx, *rx;
> +};
> +
> +static unsigned int tegra_tcu_uart_tx_empty(struct uart_port *port)
> +{
> +	return TIOCSER_TEMT;
> +}
> +
> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +}
> +
> +static unsigned int tegra_tcu_uart_get_mctrl(struct uart_port *port)
> +{
> +	return 0;
> +}
> +
> +static void tegra_tcu_uart_stop_tx(struct uart_port *port)
> +{
> +}
> +
> +static void tegra_tcu_write_one(struct tegra_tcu *tcu, u32 value,
> +				unsigned int count)
> +{
> +	void *msg;
> +
> +	value |= TCU_MBOX_NUM_BYTES(count);
> +	msg = (void *)(unsigned long)value;
> +	mbox_send_message(tcu->tx, msg);
> +	mbox_flush(tcu->tx, 1000);
> +}
> +
> +static void tegra_tcu_write(struct tegra_tcu *tcu, const char *s,
> +			    unsigned int count)
> +{
> +	unsigned int written = 0, i = 0;
> +	bool insert_nl = false;
> +	u32 value = 0;
> +
> +	while (i < count) {
> +		if (insert_nl) {
> +			value |= TCU_MBOX_BYTE(written++, '\n');
> +			insert_nl = false;
> +			i++;
> +		} else if (s[i] == '\n') {
> +			value |= TCU_MBOX_BYTE(written++, '\r');
> +			insert_nl = true;
> +		} else {
> +			value |= TCU_MBOX_BYTE(written++, s[i++]);
> +		}
> +
> +		if (written == 3) {
> +			tegra_tcu_write_one(tcu, value, 3);
> +			value = written = 0;
> +		}
> +	}
> +
> +	if (written)
> +		tegra_tcu_write_one(tcu, value, written);
> +}
> +
> +static void tegra_tcu_uart_start_tx(struct uart_port *port)
> +{
> +	struct tegra_tcu *tcu = port->private_data;
> +	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned long count;
> +
> +	for (;;) {
> +		count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +		if (!count)
> +			break;
> +
> +		tegra_tcu_write(tcu, &xmit->buf[xmit->tail], count);
> +		xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
> +	}
> +
> +	uart_write_wakeup(port);
> +}
> +
> +static void tegra_tcu_uart_stop_rx(struct uart_port *port)
> +{
> +}
> +
> +static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
> +{
> +}
> +
> +static int tegra_tcu_uart_startup(struct uart_port *port)
> +{
> +	return 0;
> +}
> +
> +static void tegra_tcu_uart_shutdown(struct uart_port *port)
> +{
> +}
> +
> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
> +				       struct ktermios *new,
> +				       struct ktermios *old)
> +{
> +}
> +
> +static const struct uart_ops tegra_tcu_uart_ops = {
> +	.tx_empty = tegra_tcu_uart_tx_empty,
> +	.set_mctrl = tegra_tcu_uart_set_mctrl,
> +	.get_mctrl = tegra_tcu_uart_get_mctrl,
> +	.stop_tx = tegra_tcu_uart_stop_tx,
> +	.start_tx = tegra_tcu_uart_start_tx,
> +	.stop_rx = tegra_tcu_uart_stop_rx,
> +	.break_ctl = tegra_tcu_uart_break_ctl,
> +	.startup = tegra_tcu_uart_startup,
> +	.shutdown = tegra_tcu_uart_shutdown,
> +	.set_termios = tegra_tcu_uart_set_termios,
> +};
> +
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
> +static void tegra_tcu_console_write(struct console *cons, const char *s,
> +				    unsigned int count)
> +{
> +	struct tegra_tcu *tcu = container_of(cons, struct tegra_tcu, console);
> +
> +	tegra_tcu_write(tcu, s, count);
> +}
> +
> +static int tegra_tcu_console_setup(struct console *cons, char *options)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static void tegra_tcu_receive(struct mbox_client *cl, void *msg)
> +{
> +	struct tegra_tcu *tcu = container_of(cl, struct tegra_tcu, rx_client);
> +	struct tty_port *port = &tcu->port.state->port;
> +	u32 value = (u32)(unsigned long)msg;
> +	unsigned int num_bytes, i;
> +
> +	num_bytes = TCU_MBOX_NUM_BYTES_V(value);
> +
> +	for (i = 0; i < num_bytes; i++)
> +		tty_insert_flip_char(port, TCU_MBOX_BYTE_V(value, i),
> +				     TTY_NORMAL);
> +
> +	tty_flip_buffer_push(port);
> +}
> +
> +static int tegra_tcu_probe(struct platform_device *pdev)
> +{
> +	struct uart_port *port;
> +	struct tegra_tcu *tcu;
> +	int err;
> +
> +	tcu = devm_kzalloc(&pdev->dev, sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	tcu->tx_client.dev = &pdev->dev;
> +	tcu->rx_client.dev = &pdev->dev;
> +	tcu->rx_client.rx_callback = tegra_tcu_receive;
> +
> +	tcu->tx = mbox_request_channel_byname(&tcu->tx_client, "tx");
> +	if (IS_ERR(tcu->tx)) {
> +		err = PTR_ERR(tcu->tx);
> +		dev_err(&pdev->dev, "failed to get tx mailbox: %d\n", err);
> +		return err;
> +	}
> +
> +	tcu->rx = mbox_request_channel_byname(&tcu->rx_client, "rx");
> +	if (IS_ERR(tcu->rx)) {
> +		err = PTR_ERR(tcu->rx);
> +		dev_err(&pdev->dev, "failed to get rx mailbox: %d\n", err);
> +		goto free_tx;
> +	}
> +
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
> +	/* setup the console */
> +	strcpy(tcu->console.name, "ttyTCU");
> +	tcu->console.device = uart_console_device;
> +	tcu->console.flags = CON_PRINTBUFFER | CON_ANYTIME;
> +	tcu->console.index = -1;
> +	tcu->console.write = tegra_tcu_console_write;
> +	tcu->console.setup = tegra_tcu_console_setup;
> +	tcu->console.data = &tcu->driver;
> +#endif
> +
> +	/* setup the driver */
> +	tcu->driver.owner = THIS_MODULE;
> +	tcu->driver.driver_name = "tegra-tcu";
> +	tcu->driver.dev_name = "ttyTCU";
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
> +	tcu->driver.cons = &tcu->console;
> +#endif
> +	tcu->driver.nr = 1;
> +
> +	err = uart_register_driver(&tcu->driver);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to register UART driver: %d\n",
> +			err);
> +		goto free_rx;
> +	}
> +
> +	/* setup the port */
> +	port = &tcu->port;
> +	spin_lock_init(&port->lock);
> +	port->dev = &pdev->dev;
> +	port->type = PORT_TEGRA_TCU;
> +	port->ops = &tegra_tcu_uart_ops;
> +	port->fifosize = 1;
> +	port->iotype = UPIO_MEM;
> +	port->flags = UPF_BOOT_AUTOCONF;
> +	port->private_data = tcu;
> +
> +	err = uart_add_one_port(&tcu->driver, port);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to add UART port: %d\n", err);
> +		goto unregister_uart;
> +	}
> +
> +	platform_set_drvdata(pdev, tcu);
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
> +	register_console(&tcu->console);
> +#endif
> +
> +	return 0;
> +
> +unregister_uart:
> +	uart_unregister_driver(&tcu->driver);
> +free_rx:
> +	mbox_free_channel(tcu->rx);
> +free_tx:
> +	mbox_free_channel(tcu->tx);
> +
> +	return err;
> +}
> +
> +static int tegra_tcu_remove(struct platform_device *pdev)
> +{
> +	struct tegra_tcu *tcu = platform_get_drvdata(pdev);
> +
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA_TCU_CONSOLE)
> +	unregister_console(&tcu->console);
> +#endif
> +	uart_remove_one_port(&tcu->driver, &tcu->port);
> +	uart_unregister_driver(&tcu->driver);
> +	mbox_free_channel(tcu->rx);
> +	mbox_free_channel(tcu->tx);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tegra_tcu_match[] = {
> +	{ .compatible = "nvidia,tegra194-tcu" },
> +	{ }
> +};
> +
> +static struct platform_driver tegra_tcu_driver = {
> +	.driver = {
> +		.name = "tegra-tcu",
> +		.of_match_table = tegra_tcu_match,
> +	},
> +	.probe = tegra_tcu_probe,
> +	.remove = tegra_tcu_remove,
> +};
> +module_platform_driver(tegra_tcu_driver);
> +
> +MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("NVIDIA Tegra Combined UART driver");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index df4a7534e239..6009ee2c2e99 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -79,6 +79,9 @@
>  /* Nuvoton UART */
>  #define PORT_NPCM	40
>  
> +/* NVIDIA Tegra Combined UART */
> +#define PORT_TEGRA_TCU	41
> +
>  /* Intel EG20 */
>  #define PORT_PCH_8LINE	44
>  #define PORT_PCH_2LINE	45
> -- 
> 2.7.4
