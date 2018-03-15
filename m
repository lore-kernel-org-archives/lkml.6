Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521079491; cv=none;
        d=google.com; s=arc-20160816;
        b=rFWcqkbq+uSyY7+FVrFdGX8PWioqetzvv+nQwcDNByOv5SF3UwMpcJmthrTGU9oimP
         xx6qNMbfOcxSbY6YR2hZQkz7w4VRuCSv7ZvPPPeU7A4JAZ49OfiCt7Z6J6bRUzPkmuuh
         NXSGHLVOHWxmPJAqEyX1mSB+JBNgdZppGPHeoVMugrZquOzwzfuyXLGFhHy7Hd9vz7uU
         IU5syPpTdzO7t231A855HHH0x24vixkNHBgpaXPI+fQJp+ZAz5DTxnmYB/n8KaOxbdrP
         cvuu98MWNS5vMn+oUzISbzDGpvZjgdsxJt4B2WsPoEPHQi52cntJQSpoOp+V4hySRQm7
         oDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=aKVFpScwnQ8pzQB6DZDzG4ua3jf7n8aw9buIr62C8V0=;
        b=k83rWBiIPBhMAAro1sw7Nf6apIiXpK/gbPq05xuRUT5KVDohkVPOQveAgPX9u2zftU
         TtNEFfy+I5gJAXfZvEP/l2eaVjMEatUsMKngTbAjvyYzxoLXv2G91iKNTaAgg8ics+Wg
         CcgrVwhnzU5gtaGmlODM0LUuqvxVdDQJXOlHTK40YlSYAwRz8e4XdQmWHRXEqaPQMUqj
         J09YpyWE54cBfS96IjoU7iOK1Zc6O/sGOh+/uAhTnQC8sMonb7IP4iSV/wRw+GxLNoqA
         nvijvTdH1ySXPUZeIkeblBzqR+1w1wJiLf+1L7qBXxmUrkgjakYfBlGMa1MG2cPcWg4r
         EfFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=L6k8k0e8;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=L6k8k0e8;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvxIS0S+QoRFbeInJEGi4pj6iXDZrlRv33pMf6YyhTGAFbm6e814vhN7NZHl133NCoWQWPDPQ==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Jiri Slaby <jslaby@suse.com>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Douglas Anderson <dianders@chromium.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v3 1/3] serial: 8250_early: Add earlycon support for AMD Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 20:04:43 -0600
Message-Id: <20180315020445.150604-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315020445.150604-1-djkurtz@chromium.org>
References: <20180315020445.150604-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951094165282567?=
X-GMAIL-MSGID: =?utf-8?q?1594967448639992816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
input clock.

Allow these platforms to set up this clock by specifying a kernel command
line like:
earlycon=amdcz,mmio32,0xfedc6000,115200

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes since v1:
 * added Reviewed-by & Suggested-by

 drivers/tty/serial/8250/8250_early.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index ae6a256524d8..c6bf971a6038 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -195,3 +195,18 @@ static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
 OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
 
 #endif
+
+#ifdef CONFIG_SERIAL_8250_DW
+static int __init early_amdcz_setup(struct earlycon_device *dev,
+				    const char *opt)
+{
+	struct uart_port *port = &dev->port;
+
+	port->uartclk = 48000000;
+
+	return early_serial8250_setup(dev, opt);
+}
+
+EARLYCON_DECLARE(amdcz, early_amdcz_setup);
+
+#endif
-- 
2.16.2.804.g6dcf76e118-goog
