Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520465057; cv=none;
        d=google.com; s=arc-20160816;
        b=HRLOrETINBvDEFMNeBNkH1MvBgnhSmz/x3Ol3Nv/3sY/XLGOGmb4rx4y8aJ4utnYOp
         4P9G90kib2JE2nb7lAsyWHCFvFYy4fhXCSg9ri4OpgucVLuoGrOb0cMzjUsmmb6b//2F
         SeELZQwdrdSNhMTbhEnc8JHaROsnRWoQaie9Pxofis+1nWEGUEkDt0DpUg3b/77W4h+b
         Gwk/WO5Je6vctO2rdZG+G3Yrk6PhcPEIYX0PQXbMDQvoBBRsVbygONJzeZXALYI4RNQn
         P70B5z3gAWrjppliDn/zhYxNzd3P/wGYzVBX+tmOAgtfgvaLDXzuOXmqvPLpLEKQ2kaI
         Liug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=V4jhfRjAq669UzzZjW1EncMUKEE934aU2Qy9E0+S6xw=;
        b=SDEChoLNcEkRRtNKH1KWV4bZ79zoKFTKZx0ctxB8rIOyLSydjz+/FHYTwU8rQmNytJ
         9MOW3JP9/DczTkOgYxkDFmQyv55XQ9uh5yevwPb12KNnKatffyva6YWx3OOc1J4IeWBA
         175PIzAHaewx47pA/zJ5ou9K6MRtpjW/pwg29nzDx4rSnrMK+UeR30t08m931yz15Ar5
         9JhoW5WSMbem9VbR8UhsSbH+G9dAZmpBYYeG4x/+URUt9JO/tdm+Rm1ArlxvQKhSSDOc
         19FHfO1AsSuELKo6MO6MzKMd8TVKiODTSYxopO45qVZZ7fbaEXv2jREJjbdP/AoK6z1h
         jlxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZEEUEelX;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZEEUEelX;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtp/5aM1yDvY07tvkxKuaNuKIWVn+lbQZX89d6fzcnhXSvBhdHGSA6EKPE89H+l9Ty7P5Ud1w==
From: Daniel Kurtz <djkurtz@chromium.org>
To: 
Cc: adurbin@chromium.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 1/2] x86/Kconfig: Add config for specifying BASE_BAUD
Date: Wed,  7 Mar 2018 16:24:09 -0700
Message-Id: <20180307232410.248434-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180307232410.248434-1-djkurtz@chromium.org>
References: <20180307232410.248434-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594323168937167564?=
X-GMAIL-MSGID: =?utf-8?q?1594323168937167564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Not all x86 CPUs have UARTs that use a baud reference clock (BASE_BAUD) of
115200 = 1843200 / 16.  For example, the UARTs on AMD Carrizo and later
use a fixed input clock of 48000000, and hence require BASE_BAUD=3000000.

The BASE_BAUD value is used by the generic earlycon driver to compute the
UART clock used early in boot before the real serial drivers have a
chance to load and read their input clock configuration from ACPI.

Add a Kconfig option to override this default hard coded value.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/x86/Kconfig              | 9 +++++++++
 arch/x86/include/asm/serial.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eb7f43f23521..0a258bb30159 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -454,6 +454,15 @@ config INTEL_RDT
 
 	  Say N if unsure.
 
+config X86_SERIAL_BASE_BAUD
+	int "UART input clock for platform 8250/16550 serial ports"
+	default "115200"
+	help
+	  This specifies the default frequency for the reference clock of the
+	  serial ports.  For many systems this is 1843200 / 16, which is the
+	  default, but may need to be changed to get earlycon to work on
+	  some hardware, such as those that use AMD Carrizo or later SoCs.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
index ece8299d2695..c28151090b51 100644
--- a/arch/x86/include/asm/serial.h
+++ b/arch/x86/include/asm/serial.h
@@ -9,7 +9,11 @@
  * clock, since the 16550A is capable of handling a top speed of 1.5
  * megabits/second; but this requires a faster clock.
  */
+#ifdef CONFIG_X86_SERIAL_BASE_BAUD
+#define BASE_BAUD CONFIG_X86_SERIAL_BASE_BAUD
+#else
 #define BASE_BAUD (1843200/16)
+#endif
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
-- 
2.16.2.395.g2e18187dfd-goog
