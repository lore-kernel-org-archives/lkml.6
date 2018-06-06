Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="QmwlYPkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9553460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeFFMms (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:42:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54209 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFFMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:41:52 -0400
X-Google-Smtp-Source: ADUXVKIcpfehs87UdYvTklG3+X+UGgs0JakPt6KFO95LgO42rq0/v+sIO2klzWMoANiTZ/wIXy4k5Q==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 5/6] serial: uartps: Fill struct uart_driver in probe()
Date: Wed,  6 Jun 2018 14:41:38 +0200
Message-Id: <b035a7b7014c4aa2b9192a945cf75c9c7143b16f.1528288895.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation step for dynamic port allocation without
CDNS_UART_NR_PORTS macro. Fill the structure only once at probe.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b47d7ccbc38d..d76efe8cb3df 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1260,18 +1260,6 @@ static int __init cdns_uart_console_setup(struct console *co, char *options)
 };
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
-static struct uart_driver cdns_uart_uart_driver = {
-	.owner		= THIS_MODULE,
-	.driver_name	= CDNS_UART_NAME,
-	.dev_name	= CDNS_UART_TTY_NAME,
-	.major		= CDNS_UART_MAJOR,
-	.minor		= CDNS_UART_MINOR,
-	.nr		= CDNS_UART_NR_PORTS,
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	.cons		= &cdns_uart_console,
-#endif
-};
-
 #ifdef CONFIG_PM_SLEEP
 /**
  * cdns_uart_suspend - suspend event
@@ -1451,6 +1439,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	if (!cdns_uart_uart_driver.state) {
+		cdns_uart_uart_driver.owner = THIS_MODULE,
+		cdns_uart_uart_driver.driver_name = CDNS_UART_NAME,
+		cdns_uart_uart_driver.dev_name = CDNS_UART_TTY_NAME,
+		cdns_uart_uart_driver.major = CDNS_UART_MAJOR,
+		cdns_uart_uart_driver.minor = CDNS_UART_MINOR,
+		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS,
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+		cdns_uart_uart_driver.cons = &cdns_uart_console,
+#endif
+
 		rc = uart_register_driver(&cdns_uart_uart_driver);
 		if (rc < 0) {
 			dev_err(&pdev->dev, "Failed to register driver\n");
-- 
1.9.1
