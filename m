Return-Path: <kurt@linutronix.de>
X-Google-Smtp-Source: AG47ELs1BYDF9RIKeNTeIEoIP4pVrY3cg2LTHswHjsECDb0ds01o7Ibp5TP9ApQKGQpdBYWvoF9w
ARC-Seal: i=1; a=rsa-sha256; t=1521199846; cv=none;
        d=google.com; s=arc-20160816;
        b=UdrV6bGUILpsoHGEin75ZnW6QUtBr14yRiBzUATtpAJtY/pdZV3dvPVSFD64Z07Esv
         r17qqF/o6Bojdn60VQoPbe5IMtNpO6ruPje6tCHavQ7xCtRK99U+47bT/JNi6iM7Rm8t
         vgENdnuhS0E4OO73mdUAvhgN3MeDbqGaCqmK3vEcuQV5YP2+l10biWCMoJVctTlxigPp
         tit+2eazV2bnKbBrHDVMuikOKJEmzWueg6i325pzdmDepvG723D3z/rIlJ7IO2d1basi
         3uIE5QHB41Kqruy21/90y/ADFZq7hwsz6aPmSGnxNQDgbouiAFfgU8BxtBpimjCjQ0X7
         pwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=9slBi4wXOzc2hu8Yr5JDprYlXpfsPbA0Jg0wNWGtxKo=;
        b=nFc1W+usPVRa+UWbggnX4LnmxKMckUQ+zs6HQwRcqVINLurn5xrEkWd14eZnEmbtq+
         LrOtM3+jTY0ExT5OOHbUgWN1au6z1WdrCI08zmpy+IWSqkg53o8Sb4rAtjir+TUuwY6G
         YEOxPuijaAB2YGoX10bVZwfL93H2ePQOJpopgpLdd2+pyDmXmRCx8m4qpk5STRXe83Kz
         M73lr6Pa64PNYS1WrJhQ8sdFh/tBNPfP3EGgbyv922QY7rEzMX7vSIT0JFjTx8lJu9Lb
         dpsxBsUuHaWQnNiLTC3xsFsBQWb3FDT6Rfnclgw1e9L6XO2hvik7OLMqNA0QLokTf34S
         T/gQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of kurt@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=kurt@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of kurt@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=kurt@linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
To: gregkh@linuxfoundation.org
Cc: kurt@linutronix.de,
	tglx@linutronix.de,
	jslaby@suse.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: 8250: pass IRQ shared flag to UART ports
Date: Fri, 16 Mar 2018 12:31:58 +0100
Message-Id: <20180316113158.10298-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595093650314463976?=
X-GMAIL-MSGID: =?utf-8?q?1595093650314463976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some systems IRQ lines between multiple UARTs might be shared. If so, the
irqflags have to be configured accordingly. The reason is: The 8250 port startup
code performs IRQ tests *before* the IRQ handler for that particular port is
registered. This is performed in serial8250_do_startup(). This function checks
whether IRQF_SHARED is configured and only then disables the IRQ line while
testing.

This test is performed upon each open() of the UART device. Imagine two UARTs
share the same IRQ line: On is already opened and the IRQ is active. When the
second UART is opened, the IRQ line has to be disabled while performing IRQ
tests. Otherwise an IRQ might handler might be invoked, but the the IRQ itself
cannot be handled, because the corresponding handler isn't registered,
yet. That's because the 8250 code uses a chain-handler and invokes the
corresponding port's IRQ handling rountines himself.

Unfortunately this IRQF_SHARED flag isn't configured for UARTs probed via device
tree even if the IRQs are shared. This way, the actual and shared IRQ line isn't
disabled while performing tests and the kernel correctly detects a spurious
IRQ. So, adding this flag to the DT probe solves the issue.

Note: The UPF_SHARE_IRQ flag is configured unconditionally. Therefore, the
IRQF_SHARED flag can be set unconditionally as well.

Example stacktrace by performing echo 1 > /dev/ttyS2 on a non-patched system:

|irq 85: nobody cared (try booting with the "irqpoll" option)
| [...]
|handlers:
|[<ffff0000080fc628>] irq_default_primary_handler threaded [<ffff00000855fbb8>] serial8250_interrupt
|Disabling IRQ #85

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/tty/serial/8250/8250_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 160b8906d9b9..575f91e04770 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -149,6 +149,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	port->uartclk = clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	port->irqflags |= IRQF_SHARED;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
 		port->flags |= UPF_SKIP_TEST;
-- 
2.11.0
