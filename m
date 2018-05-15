Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeEOSeS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:34:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:1943 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752304AbeEOSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:34:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="228823542"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] serial: 8250_port: Disable DMA operations for kernel console
Date: Tue, 15 May 2018 21:34:09 +0300
Message-Id: <20180515183409.78046-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be too tricky and error prone to allow DMA operations on kernel
console.

Disable any kind of DMA operations in such case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index db97222a1bf4..9a4696ea728b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2371,7 +2371,10 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Request DMA channels for both RX and TX.
 	 */
 	if (up->dma) {
-		retval = serial8250_request_dma(up);
+		if (uart_console(port))
+			retval = -ENXIO;
+		else
+			retval = serial8250_request_dma(up);
 		if (retval)
 			pr_warn_ratelimited("ttyS%d - failed to request DMA\n",
 					    serial_index(port));
-- 
2.17.0
