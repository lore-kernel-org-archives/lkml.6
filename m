Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521063894; cv=none;
        d=google.com; s=arc-20160816;
        b=tgvS/QAHikkbj5I5TMmo2D8wN2Zp9xsxnzbHviSVplLmqfZLHhlwGTS4SwGCrtdS4Q
         5CEetzOTzCkIoEp+yLjqKo2czAz+8Cb/pOxWHu0Lbfq5zCUTm2zTeNAWNbBX3r1hCeNR
         73Q2XQC5VAYJtAO39pQ5y4F4oCct+bWVlKQBcspomcluCFcOT7XJeniTm86YNL/rO6VV
         69e1+G87Ocq0M7nK/wJISFtr6o1aqv2Z6TA/5TnQS/WgycWfSY4JgpFp0AiE927D2Qgv
         EfaUnRloJOjiqhY5kG2PV0s6a6YmFjOULwc1ntFWgpSvtZpOPO6GvYCopd9aEyV71dCG
         VS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=xn3xab9TZitVtgpX2B6oBTQHFMNCHW2aw3FmWgVGJ0w=;
        b=y54zNMv7zOWO0NJZqD3s+yxRcqxqqFeLuAjxP8qvx1D6fXz75HUNnjKLqPE0WZTY0s
         /feTnRTaCD6nzNeRDOT3RD9/7UPPuIBQ9NUmMX4wmiUHmplLInfY/vZzqYmzawXa5cJr
         nfm3AbUCy1a2nX4UZtxzW/KIxKWu105YT+DjIxQr0KRbzjxIt4IX6xhxLCshoF4LreQ/
         k6m/iq31pMKp7iXz0+eioxGTGxLsAh4D/MKYC1QDw71EuePIsm8iDRwimRd6aGDg7gCj
         hmUckkYUpboTjzk/wjByuv9x/lJ7oEfKyAbI08v315v+um0wBxqQ08SyHtov+942whp4
         OVBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ctV7GMFb;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=ctV7GMFb;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvIVUihkDjm8N6fxCavTERw6QdTUteAALdmeSNr5+AXdENwhSHgsukM+988qr7TU/MakcNvtg==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Jiri Slaby <jslaby@suse.com>,
	Douglas Anderson <dianders@chromium.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v2 1/3] serial: 8250_early: Add earlycon support for AMD Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 15:44:36 -0600
Message-Id: <20180314214439.27806-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180314214439.27806-1-djkurtz@chromium.org>
References: <20180314214439.27806-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951094165282567?=
X-GMAIL-MSGID: =?utf-8?q?1594951094165282567?=
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
