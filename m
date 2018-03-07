Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520465060; cv=none;
        d=google.com; s=arc-20160816;
        b=zZxAaU3c1jW50sr/kMVPXof4mJS+6+ib580oR8Oh4G/3IGBLyJQpX0J+QJmh6Y8TO/
         Ykql/DG1h6Z7rmIDr+mbcYZBGwxBbYo7gVpdW6UjvDnTySBAhJoRYuNFRPMXzHTdKLJ0
         bNNBT1r37589+lD6mVjEJ8P/v0aAGuSMmymbY4stJkyidjNSeR7+8VZA2s2gH99vVs4r
         h2R6+b588CDsyhToFKqDe+QDrDMszMDMARZteG/KW4FfuzoSI5GEMqBnFRr7NUXrkwv1
         jmr3Hfxdhf56fWolk5i3IauwwrLd4UO9cVTerlSa4KVrn6cHvoYMjoeDLy8UOeqMGXPk
         YWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CwU4T3zFplmEHUrMapav5si7rl1oiuQ6dbjoTnxy8bw=;
        b=CruHfO+puyR1eSJP0J3cgFAfJzsVOmpeCKAjPDObtAiV4fhSd1u0mai5aOuFn76v53
         ZLyyAyTl4IIF7E3mkIij1NPwdXVtFkEQKJufQW0AUM5sExQ6qrztgd0/GYSvoq2/DQQ8
         PGbocEbr93CLCpgAM9i+oOpgUCzBEOGqFCjvxmsb0asbBW6dP78lwxoNYkgMm2UgmN2S
         lg1iAuktqGhj0yKR41mJvXBqTHYQeGht2q7Mbq5KvDUSkbNcmXqdGXKLUG85HW4cMaOF
         2eqoGdxxIGpg0a1EMudGNAzPo36zSK76+eVwDIjbggMEuw8BZ3L5eedG/3LA+A+bUswg
         Bc8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=faZ4i5Gg;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=faZ4i5Gg;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELujmMGZFLIRPjTjXPVal0QrlXki92Rl6yd2XvTNpR4ltg8UIfpBsxbWTvTN277ESBz7ia8J5Q==
From: Daniel Kurtz <djkurtz@chromium.org>
To: 
Cc: adurbin@chromium.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 2/2] x86/Kconfig: Add config to allow not defining old serial ports
Date: Wed,  7 Mar 2018 16:24:10 -0700
Message-Id: <20180307232410.248434-3-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180307232410.248434-1-djkurtz@chromium.org>
References: <20180307232410.248434-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594323171219342758?=
X-GMAIL-MSGID: =?utf-8?q?1594323171219342758?=
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
serial8250_ports.  Further, it attemptes to register them for use as
the console.  In other words, if, for example, the kernel commandline has
console=ttyS0, the console will be switched over to one of these
non-existent UARTs.  Only later, when the real UART drivers are probed
and their devices are instantiated will the console switch back over to
the proper UART.

This is most noticeable when using earlycon, since part of the serial
console log will appear to disappear (when the bogus old takes over) and
then re-appear (when the real UART finally gets registered for the
console).

Add a Kconfig option to allow overriding this default hard coded value
for arch/x86 devices that do not have such serial ports.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/x86/Kconfig              | 11 +++++++++++
 arch/x86/include/asm/serial.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0a258bb30159..7501cd776cfc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -463,6 +463,17 @@ config X86_SERIAL_BASE_BAUD
 	  default, but may need to be changed to get earlycon to work on
 	  some hardware, such as those that use AMD Carrizo or later SoCs.
 
+config X86_SERIAL_DEFINE_OLD_SERIAL_PORTS
+	bool "Define un-enumerable serial ports"
+	default y
+	help
+	  Say Y here if you want the kernel to assume the precense of built-in
+	  serial ports that do not have a standard enumeration mechanism.
+	  Platforms that can find all serial ports via mechanisms like ACPI or
+	  PCI can set this to N.
+
+	  If unsure, say Y.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
index c28151090b51..e86304c2bfae 100644
--- a/arch/x86/include/asm/serial.h
+++ b/arch/x86/include/asm/serial.h
@@ -24,11 +24,15 @@
 # define STD_COM4_FLAGS	(UPF_BOOT_AUTOCONF |	0		| 0		)
 #endif
 
+#ifdef CONFIG_X86_SERIAL_DEFINE_OLD_SERIAL_PORTS
 #define SERIAL_PORT_DFNS								\
 	/* UART		CLK		PORT	IRQ	FLAGS			    */	\
 	{ .uart = 0,	BASE_BAUD,	0x3F8,	4,	STD_COMX_FLAGS	}, /* ttyS0 */	\
 	{ .uart = 0,	BASE_BAUD,	0x2F8,	3,	STD_COMX_FLAGS	}, /* ttyS1 */	\
 	{ .uart = 0,	BASE_BAUD,	0x3E8,	4,	STD_COMX_FLAGS	}, /* ttyS2 */	\
 	{ .uart = 0,	BASE_BAUD,	0x2E8,	3,	STD_COM4_FLAGS	}, /* ttyS3 */
+#else
+#define SERIAL_PORT_DFNS
+#endif
 
 #endif /* _ASM_X86_SERIAL_H */
-- 
2.16.2.395.g2e18187dfd-goog
