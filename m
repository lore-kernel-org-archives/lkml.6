Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521079497; cv=none;
        d=google.com; s=arc-20160816;
        b=IgVOL8553JTPD2QSuK328aCO3M3nTvFhowlM0ca8wK4R5qiCdOzU+/rrt2CNmiqOah
         v5UvaLysLCnbC1xzzl4+TwOIepSQYzpmXc2+l5sYMH7U5JilR3KX9i4ENXGROTM05/xR
         CGtJjbevETrpuBUUbPnHYgT5P/glxgGY1sNXhn+QPU9xrzDo3IHrZU5SVmUBxvr9LcIE
         ReFObv/jxjkkPmRtO+8gCRsJvSP23jAgPsP6/Mu9BCQpS32fE7sgd0jhW9DZi5Sw20qU
         3GJGXV6Dssup9Hwd8TOXPN1fo6hA3WvMUhJHlZUXXQnN+ygpnxbaeOYvICto1fw2frrU
         qrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=I/SalXWyRJ/dyODSLks4sLP8EjMRtHl7xxxotkgiXAE=;
        b=NgsbKQpkaljiQdubaqaBGeHQbPO92tOMTJk8Pw8rO+w5F6CWlxrXGpw86XFwo/BLn7
         H9q1f/9iKgo6Ug32klrLePLtLxAdFR+5l4J7gWC4eOVsrw1YuPHbWT+4SjL3Yj3AM7/g
         j7EtTDNORJxuKftE5rhRJA32xWy8KDbvADzEXHRpZYH2ug+fKodA+U5umh0rWmyoAlyj
         /SNtJdz8y4/dIyvJ7GwNvlgtvlnmjBWpWA+9J9tO+uPCXz/S9yoav7okxdY+JCfOAbz6
         i2nPGJE5I1SSOOtD524qml5yitEFtzCR0QcWqxavY+CNtwMY7mZj/ox3W+27sqB6SdUK
         EBOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ALE+bnc7;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ALE+bnc7;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsms5JDpMzGKw5jRy7/y6Q2G/1IGcAw7+ok/0iJ6+rre8iC+D1PxyyVcCN2+qd5ewJN25nLXw==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Jiri Slaby <jslaby@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthias Brugger <mbrugger@suse.com>,
	David Howells <dhowells@redhat.com>,
	Allen Pais <allen.lkml@gmail.com>,
	Sean Young <sean@mess.org>,
	Douglas Anderson <dianders@chromium.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v3 3/3] serial: core: Allow skipping old serial port initialization
Date: Wed, 14 Mar 2018 20:04:45 -0600
Message-Id: <20180315020445.150604-4-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315020445.150604-1-djkurtz@chromium.org>
References: <20180315020445.150604-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594871331983338334?=
X-GMAIL-MSGID: =?utf-8?q?1594967455068525896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The old_serial_port global array in 8250_core is supposed to hold an entry
for each serial port on the system that cannot be discovered via a
standard enumeration mechanism (aka ACPI/PCI/DTS).  The array is populated
at compile-time from the value specified in the SERIAL_PORT_DFNS macro.
This macro is defined in arch/serial.h.

For x86, this macro is currently unconditionally initialized to supply
four ioport UARTs (0x3F8, 0x2F8, 0x3E8, 0x2E8).

However, not all x86 CPUs have these four ioport UARTs.  For example, the
UARTs on AMD Carrizo and later are separate memory mapped Designware IP
blocks.

Fairly early in boot the console_initcall univ8250_console_init iterates
over this array and installs these old UARTs into the global array
serial8250_ports.  Further, it attempts to register them for use as
the console.  In other words, if, for example, the kernel commandline has
console=ttyS0, the console will be switched over to one of these
non-existent UARTs.  Only later, when the real UART drivers are probed
and their devices are instantiated will the console switch back over to
the proper UART.

This is noticeable when using earlycon, since part of the serial console
log will appear to disappear (when the bogus old takes over) and then
re-appear (when the real UART finally gets registered for the console).

The problem is even more noticable when *not* using earlycon, since in
this case the entire console output is missing, having been incorrectly
played back to the non-existing serial port.

Create a global variable to allow skipping old serial port initialization
and wire it up to the AMDCZ ACPI SPCR quirk and the special amdcz earlycon
setup handler.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
Changes since v1:
 * Rename variable to serial8250_skip_old_ports
 * Also set variable in acpi/spcr to support no-earlycon case.

Changes since v2:
 * Added IS_ENABLED(CONFIG_SERIAL_825) and removed the .h #ifdef as suggested
   by Kees Cook.


 drivers/acpi/spcr.c                  | 3 +++
 drivers/tty/serial/8250/8250_core.c  | 6 ++++++
 drivers/tty/serial/8250/8250_early.c | 1 +
 include/linux/serial_8250.h          | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 52d840d0e05b..d1affdf2bc37 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/console.h>
 #include <linux/kernel.h>
+#include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 
 /*
@@ -208,6 +209,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	}
 
 	if (amdcz_present(table)) {
+		if (IS_ENABLED(CONFIG_SERIAL_8250))
+			serial8250_skip_old_ports = true;
 		if (enable_earlycon)
 			uart = "amdcz";
 	}
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..a04da392a251 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -66,6 +66,9 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
 #define SERIAL_PORT_DFNS
 #endif
 
+bool serial8250_skip_old_ports;
+EXPORT_SYMBOL(serial8250_skip_old_ports);
+
 static const struct old_serial_port old_serial_port[] = {
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
@@ -537,6 +540,9 @@ static void __init serial8250_isa_init_ports(void)
 	if (share_irqs)
 		irqflag = IRQF_SHARED;
 
+	if (serial8250_skip_old_ports)
+		return;
+
 	for (i = 0, up = serial8250_ports;
 	     i < ARRAY_SIZE(old_serial_port) && i < nr_uarts;
 	     i++, up++) {
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c6bf971a6038..288d2be82990 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -202,6 +202,7 @@ static int __init early_amdcz_setup(struct earlycon_device *dev,
 {
 	struct uart_port *port = &dev->port;
 
+	serial8250_skip_old_ports = true;
 	port->uartclk = 48000000;
 
 	return early_serial8250_setup(dev, opt);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..ae739c34546f 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -136,6 +136,8 @@ struct uart_8250_port {
 	struct uart_8250_em485 *em485;
 };
 
+extern bool serial8250_skip_old_ports;
+
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
 {
 	return container_of(up, struct uart_8250_port, port);
-- 
2.16.2.804.g6dcf76e118-goog
