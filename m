Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeEOSe5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:34:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:38110 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752668AbeEOSeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:34:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="56156496"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] serial: 8250_port: Don't use power management for kernel console
Date: Tue, 15 May 2018 21:34:08 +0300
Message-Id: <20180515183409.78046-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing any kind of power management for kernel console is really bad idea.

First of all, it runs in poll and atomic mode. This fact attaches a limitation
on the functions that might be called. For example, pm_runtime_get_sync() might
sleep and thus can't be used. On the other hand pm_runtime_get() doesn't
guarantee that device becomes powered on (fast enough). On ACPI enabled
platforms it might even call firmware for a job.

Besides that, imagine the case when console is about to print a kernel oops and
it's powered off. In such an emergency case calling the complex functions is
not the best what we can do, taking into consideration that user wants to see
at least something of the last kernel word before it passes away.

Here we modify the 8250 console code to prevent runtime power management.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c |  9 +++++++++
 drivers/tty/serial/8250/8250_port.c | 22 ++++++++++++++++++----
 include/linux/serial_8250.h         |  1 +
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..cdafee307482 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -612,6 +612,14 @@ static int univ8250_console_setup(struct console *co, char *options)
 	return retval;
 }
 
+static void univ8250_console_exit(struct console *co)
+{
+	struct uart_port *port;
+
+	port = &serial8250_ports[co->index].port;
+	serial8250_console_exit(port);
+}
+
 /**
  *	univ8250_console_match - non-standard console matching
  *	@co:	  registering console
@@ -670,6 +678,7 @@ static struct console univ8250_console = {
 	.write		= univ8250_console_write,
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
+	.exit		= univ8250_console_exit,
 	.match		= univ8250_console_match,
 	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
 	.index		= -1,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2ca7df29dc11..db97222a1bf4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3207,6 +3207,9 @@ static void serial8250_console_restore(struct uart_8250_port *up)
  *	any possible real use of the port...
  *
  *	The console_lock must be held when we get here.
+ *
+ *	Doing runtime PM is a really bad idea for the kernel console.
+ *	Thus we assume that the function called when device is powered on.
  */
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count)
@@ -3218,8 +3221,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	touch_nmi_watchdog();
 
-	serial8250_rpm_get(up);
-
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
@@ -3264,7 +3265,6 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
-	serial8250_rpm_put(up);
 }
 
 static unsigned int probe_baud(struct uart_port *port)
@@ -3288,6 +3288,7 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
@@ -3297,7 +3298,20 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	else if (probe)
 		baud = probe_baud(port);
 
-	return uart_set_options(port, port->cons, baud, parity, bits, flow);
+	ret = uart_set_options(port, port->cons, baud, parity, bits, flow);
+	if (ret)
+		return ret;
+
+	if (port->dev)
+		pm_runtime_get_noresume(port->dev);
+
+	return 0;
+}
+
+void serial8250_console_exit(struct uart_port *port)
+{
+	if (port->dev)
+		pm_runtime_put_noidle(port->dev);
 }
 
 #endif /* CONFIG_SERIAL_8250_CONSOLE */
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..f83309328b66 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -171,6 +171,7 @@ void serial8250_set_defaults(struct uart_8250_port *up);
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
+void serial8250_console_exit(struct uart_port *port);
 
 extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
-- 
2.17.0
