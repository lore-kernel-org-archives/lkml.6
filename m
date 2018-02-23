Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x227ofdREhN1cv8jjg/lz6XBXnG2gySn5pRFJXD1Kadk/6Sw6J/R6xs0ANrJb1HGqyBW/PzxN
ARC-Seal: i=1; a=rsa-sha256; t=1519393121; cv=none;
        d=google.com; s=arc-20160816;
        b=Vu0p+WKDU5X+PNK4MpiC0ly8P8njpVqi7RwZVHlTQV/nsadYIyzG6r3tbrGgDX/K7C
         ztanah4phKBpmxl6T+RkgpvP3iwBzIJ2J9l573k6oqzkLd79aVARYKfspZ51vc7YmLDa
         2lV7fdAIOuLG3ElUcrWOt0KT1kVC0EBsrJliysawwQ395Dcg/EWNN+JtQ2f/l2Ayy2VW
         rTpFqpSmZy8FpIx8Sk0wgBLW+bPU7Fb+s4QmOTKxju0bo+7SDsos7TSIgxYFCj7xHsMI
         sRqSr4IwUaUO1P+h7C3nZQM2PR3gZnJMbaT4uIImXEINrXkeILnXf0rouadJMaqsVGu+
         OhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=p+8Erp74Y5A8QtRN1zSPWIJyXyg3djaMD6DOAOj8wnE=;
        b=Xcoqiyu78X64UuC27/x219mSAepHPjTc2Q1HVK3851U1MNlCjd/7HAytEF3kdKUSc1
         0Incc3ggT63Dz+vQGcfUQ61g+rc9Y0Fcdq0tnJ30SoMB5MBAq58BnbZabwYpdjxXSPPh
         PasM5yUTn53AfHZSy6BC/BdOdIfaDtczlKeZnd3/dsJZWxfU/FVYFDvoZD8WCm4sa+8u
         fe2JlVIi9CDjj0LZ+g+tCq6CHKZ+4WFVeNStNNWgtDy+I0gr4jhuLDwdMi/nCOgmXX+u
         VMKjPOLaBqOQm0zuk7VW6bVmDRsWsbPchIekhvD5+V5k2e34rOA9uA1KWVc7eDO4tBpI
         i61w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry Song <baohua@kernel.org>,
	Vineet Gupta <vgupta@synopsys.com>,
	Jiri Slaby <jslaby@suse.com>,
	Michal Simek <michal.simek@xilinx.com>,
	linux-serial@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 5/9] serial: pxa: Fix out-of-bounds access through serial port index
Date: Fri, 23 Feb 2018 14:38:33 +0100
Message-Id: <1519393117-31998-6-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593199161757958629?=
X-GMAIL-MSGID: =?utf-8?q?1593199161757958629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The serial_pxa_ports[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: 699c20f3e6310aa2 ("serial: pxa: add OF support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Fix off-by-one error (use ">="),
  - Update patch description for platform data.
---
 drivers/tty/serial/pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index baf552944d5686e8..eda3c7710d6a745f 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -885,6 +885,10 @@ static int serial_pxa_probe(struct platform_device *dev)
 		sport->port.line = dev->id;
 	else if (ret < 0)
 		goto err_clk;
+	if (sport->port.line >= ARRAY_SIZE(serial_pxa_ports)) {
+		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
+		return -EINVAL;
+	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
 	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
-- 
2.7.4
