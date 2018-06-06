Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="MhDWO1ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C29360764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFFMmb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:42:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39658 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeFFMlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:41:53 -0400
X-Google-Smtp-Source: ADUXVKKpynFPHVgJE6vr1FeEcGsPUyMRllm31fkESD78bmohbqtpypAYQAxec+qVXTKf1ejkyyORhw==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 6/6] serial: uartps: Remove CDNS_UART_NR_PORTS macro
Date: Wed,  6 Jun 2018 14:41:39 +0200
Message-Id: <8e2c1a052ab678274c49990bdbfb595208e2cc6d.1528288895.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is removing CDNS_UART_NR_PORTS macro which limits number of
ports which can be used. Every instance is registering own struct
uart_driver with minor number which corresponds to alias ID (or 0 now).
and with 1 uart port. The same alias ID is saved to
tty_driver->name_base which is key field for creating ttyPSX name.

Because name_base and minor number are setup already there is no need to
setup any port->line number because 0 is the right value.

~# find /proc/tty/ -name "*uartps*"
/proc/tty/driver/xuartps0
/proc/tty/driver/xuartps100

Unfortunately this driver is setting up major number to 0 for using
dynamic assignment and kernel is allocating different major numbers for
every instance instead of using the same major and different minor
number.

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jan  1 03:36 /dev/ttyPS0
crw--w----    1 root     root      253,   1 Jan  1 00:00 /dev/ttyPS1

When major number is not 0. For example 252 then major/minor
combinations are in expected form

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jan  1 04:04 /dev/ttyPS0
crw--w----    1 root     root      252,   1 Jan  1 00:00 /dev/ttyPS1

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Register one uart_driver with unique minor at probe time

This patch not done because id is not unique. This needs to be solved
before this patch can be applied. In v1 I have created
of_alias_check_id() for that. https://lkml.org/lkml/2018/4/26/551

Also we need to run more testing on this to make sure that everything is
working properly.

---
 drivers/tty/serial/xilinx_uartps.c | 78 +++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d76efe8cb3df..82cc17ec7b5d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -30,8 +30,6 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
-#define CDNS_UART_MINOR		0	/* works best with devtmpfs */
-#define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
@@ -1247,8 +1245,6 @@ static int __init cdns_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver cdns_uart_uart_driver;
-
 static struct console cdns_uart_console = {
 	.name	= CDNS_UART_TTY_NAME,
 	.write	= cdns_uart_console_write,
@@ -1256,7 +1252,6 @@ static int __init cdns_uart_console_setup(struct console *co, char *options)
 	.setup	= cdns_uart_console_setup,
 	.flags	= CON_PRINTBUFFER,
 	.index	= -1, /* Specified on the cmdline (e.g. console=ttyPS ) */
-	.data	= &cdns_uart_uart_driver,
 };
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
@@ -1419,6 +1414,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
 	const struct of_device_id *match;
+	struct uart_driver *cdns_uart_uart_driver;
+	char *driver_name;
 
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
 			GFP_KERNEL);
@@ -1431,32 +1428,49 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	/* Look for a serialN alias */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (id < 0)
+		/*
+		 * FIXME this is not enough because if there the next instance
+		 * without alias it will get also id = 0 which is wrong
+		 */
 		id = 0;
 
-	if (id >= CDNS_UART_NR_PORTS) {
-		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
-		return -ENODEV;
-	}
+	cdns_uart_uart_driver = devm_kzalloc(&pdev->dev,
+					     sizeof(*cdns_uart_uart_driver),
+					     GFP_KERNEL);
+	if (!cdns_uart_uart_driver)
+		return -ENOMEM;
+
+	/* There is a need to use unique driver name */
+	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
+				     CDNS_UART_NAME, id);
+	if (!driver_name)
+		return -ENOMEM;
 
-	if (!cdns_uart_uart_driver.state) {
-		cdns_uart_uart_driver.owner = THIS_MODULE,
-		cdns_uart_uart_driver.driver_name = CDNS_UART_NAME,
-		cdns_uart_uart_driver.dev_name = CDNS_UART_TTY_NAME,
-		cdns_uart_uart_driver.major = CDNS_UART_MAJOR,
-		cdns_uart_uart_driver.minor = CDNS_UART_MINOR,
-		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS,
+	cdns_uart_uart_driver->owner = THIS_MODULE;
+	cdns_uart_uart_driver->driver_name = driver_name;
+	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
+	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
+	cdns_uart_uart_driver->minor = id;
+	cdns_uart_uart_driver->nr = 1;
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-		cdns_uart_uart_driver.cons = &cdns_uart_console,
+	cdns_uart_uart_driver->cons = &cdns_uart_console;
+	cdns_uart_console.data = cdns_uart_uart_driver;
 #endif
 
-		rc = uart_register_driver(&cdns_uart_uart_driver);
-		if (rc < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			return rc;
-		}
+	rc = uart_register_driver(cdns_uart_uart_driver);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Failed to register driver\n");
+		return rc;
 	}
 
-	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
+	/*
+	 * Setting up proper name_base needs to be done after uart
+	 * registration because tty_driver structure is not filled.
+	 * name_base is 0 by default.
+	 */
+	cdns_uart_uart_driver->tty_driver->name_base = id;
+
+	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
@@ -1473,7 +1487,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
-		return PTR_ERR(cdns_uart_data->pclk);
+		rc = PTR_ERR(cdns_uart_data->pclk);
+		goto err_out_unregister_driver;
 	}
 
 	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
@@ -1484,13 +1499,14 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 	if (IS_ERR(cdns_uart_data->uartclk)) {
 		dev_err(&pdev->dev, "uart_clk clock not found.\n");
-		return PTR_ERR(cdns_uart_data->uartclk);
+		rc = PTR_ERR(cdns_uart_data->uartclk);
+		goto err_out_unregister_driver;
 	}
 
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to enable pclk clock.\n");
-		return rc;
+		goto err_out_unregister_driver;
 	}
 	rc = clk_prepare_enable(cdns_uart_data->uartclk);
 	if (rc) {
@@ -1525,7 +1541,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
-	port->line	= id;
 
 	/*
 	 * Register the port.
@@ -1552,11 +1567,11 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (cdns_uart_uart_driver.cons->index == -1)
+	if (cdns_uart_uart_driver->cons->index == -1)
 		console_port = port;
 #endif
 
-	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
+	rc = uart_add_one_port(cdns_uart_uart_driver, port);
 	if (rc) {
 		dev_err(&pdev->dev,
 			"uart_add_one_port() failed; err=%i\n", rc);
@@ -1565,7 +1580,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
-	if (cdns_uart_uart_driver.cons->index == -1)
+	if (cdns_uart_uart_driver->cons->index == -1)
 		console_port = NULL;
 #endif
 
@@ -1583,6 +1598,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 err_out_clk_dis_pclk:
 	clk_disable_unprepare(cdns_uart_data->pclk);
+err_out_unregister_driver:
+	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 
 	return rc;
 }
@@ -1611,6 +1628,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
-- 
1.9.1
