Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="mhxOyC8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 380B960764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeFFMnJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:43:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47090 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeFFMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:41:49 -0400
X-Google-Smtp-Source: ADUXVKJc/g6K/xgcCKjkfZNZeo4Wzs7AZ6Y1VpEzGzOYGcBfgij3SqDXvki9vA875+sxDnYdeKKIPQ==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 3/6] serial: uartps: Do not use static struct uart_driver out of probe()
Date: Wed,  6 Jun 2018 14:41:36 +0200
Message-Id: <e1116a36eec7307d21e88869acd3c4e0e6fe874b.1528288895.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns_uart_suspend()/resume() and remove() are using static reference
to struct uart_driver. Assign this referece to private data structure
as preparation step for dynamic struct uart_driver allocation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e24382f58dea..fe96fd950d3a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -179,6 +179,7 @@
  * @port:		Pointer to the UART port
  * @uartclk:		Reference clock
  * @pclk:		APB clock
+ * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
@@ -187,6 +188,7 @@ struct cdns_uart {
 	struct uart_port	*port;
 	struct clk		*uartclk;
 	struct clk		*pclk;
+	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
@@ -1280,6 +1282,7 @@ static int __init cdns_uart_console_setup(struct console *co, char *options)
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
+	struct cdns_uart *cdns_uart = port->private_data;
 	struct tty_struct *tty;
 	struct device *tty_dev;
 	int may_wake = 0;
@@ -1296,7 +1299,7 @@ static int cdns_uart_suspend(struct device *device)
 	 * Call the API provided in serial_core.c file which handles
 	 * the suspend.
 	 */
-	uart_suspend_port(&cdns_uart_uart_driver, port);
+	uart_suspend_port(cdns_uart->cdns_uart_driver, port);
 	if (!(console_suspend_enabled && !may_wake)) {
 		unsigned long flags = 0;
 
@@ -1324,6 +1327,7 @@ static int cdns_uart_suspend(struct device *device)
 static int cdns_uart_resume(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
+	struct cdns_uart *cdns_uart = port->private_data;
 	unsigned long flags = 0;
 	u32 ctrl_reg;
 	struct tty_struct *tty;
@@ -1339,8 +1343,6 @@ static int cdns_uart_resume(struct device *device)
 	}
 
 	if (console_suspend_enabled && !may_wake) {
-		struct cdns_uart *cdns_uart = port->private_data;
-
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
@@ -1374,7 +1376,7 @@ static int cdns_uart_resume(struct device *device)
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	return uart_resume_port(&cdns_uart_uart_driver, port);
+	return uart_resume_port(cdns_uart->cdns_uart_driver, port);
 }
 #endif /* ! CONFIG_PM_SLEEP */
 static int __maybe_unused cdns_runtime_suspend(struct device *dev)
@@ -1446,6 +1448,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		}
 	}
 
+	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
+
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
 		const struct cdns_platform_data *data = match->data;
@@ -1603,7 +1607,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
-	rc = uart_remove_one_port(&cdns_uart_uart_driver, port);
+	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
1.9.1
