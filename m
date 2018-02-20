Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AH8x227c1xEDk5avFUACgLqiXQTs1F07p9RIGU/sqWNOu95W0neh/tHDP8I/7vPmhqJRDS8MeQ/Y
ARC-Seal: i=1; a=rsa-sha256; t=1519120644; cv=none;
        d=google.com; s=arc-20160816;
        b=KlsIVQV4NcAvstgb9Yzi7Ri4IA1LNELERfkUbMlobYgF3Nv43V5VG40hZZ4RIPonTs
         r6W2mrwCXOgeSY7CeQG4aMA0i9H98ToEuNZTZhCGVzw6eMvJNixdBTdrWONWSCs7wW5n
         9mTA5jXW/BCjt1MMl3bPsZumI1qN/CUBBBTUXRDs4oIvulbuet4aDOKzB6ClQWp4rdLu
         LbE0rS9myOcUjcFyNzZAN/9kCz7AN5v/bjVhocb9E9BVQ4C6USoqLhm8WN+RYWYKAjmr
         X2YjKK6bZ/kApWUTXnKuTboq9zoryRQLzx/E+MDYKEfzN270745a2Dla68pmhsWSpDvF
         m8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JmSIYhb49Tl8mCH2ki3HBJZ5qB3E13FTgpZbL7OKuZE=;
        b=YStyiFuSeH9xV6FS+WgdAlqPXKEGr8bi99W9I5fSQy7qdbf+nACy++lTB6d3UTBxE4
         kmBRCW3qzqH/RhcErKeceQptaY37iyz9w5b/ehhgRcYimmmhMFVO+kKcXGGx10qlfdST
         9iWVaLj/P8XhKv58+8B0LXRn6UHgA4arA0rdNSt3CkMcIB+zlFK0S9REbZBSTPrpCOod
         oCgMODMBkIg34tn0UEJHVfNIQEAFqGgxFr5vOJGRXyNPP4we7+LNdav5HKiNM3sPOiEv
         TZcKWxWYL7G39j0u7b/sdMT2dAlywpt8xMFRPjnEfuqdA6bFlcpdGtlLklbI8Anxn059
         E1pA==
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
Subject: [PATCH 6/9] serial: samsung: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:21 +0100
Message-Id: <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592913448940605769?=
X-GMAIL-MSGID: =?utf-8?q?1592913448940605769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: 3ac337e76a1c637b ("serial: samsung: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f9fecc5ed0cee826..9ea42197ceefabba 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1818,6 +1818,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= CONFIG_SERIAL_SAMSUNG_UARTS) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
-- 
2.7.4
