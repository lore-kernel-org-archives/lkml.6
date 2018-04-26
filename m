Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1524751708; cv=none;
        d=google.com; s=arc-20160816;
        b=Kn6+OiJseoA3WutXjtQRxdhU7qVQ/iwcE/4/E87uoTfDaFbYcLXeN8O8A0t5ttxqfI
         v29fWL/Yh/O+NUaIDe5Fr0/f8toSX2SEwB49WSZGezKo3VAxaz9iwzhVxKO0Fl9mNhoh
         Okter72DzYkVSU4y7mMTXWDEXYjzAw1wdV92ZDLUIkUdinrFXrrF9FskP0zoDN1xpPhM
         R6KYX2OmXjePrNEa9kX7/8r5jI61lPu4Sk+tQzs0ObvQwv6+uSFVGdqpuKS9ewD8Qs3v
         nwdQwLs++l825eBu9k29SPyYdNpzdEYiNnWVSaQXQOqTgl0ZI4AoV6lSxQ2B/UcizDQN
         XXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:sender:dkim-signature:arc-authentication-results;
        bh=FAOFcpp/B6D2Q8Bu4CRlqm5bO2dL8QbsLNrCJB37dUY=;
        b=CUMWSdSKMGutVXfyLYWVCoYNpXLZSm09JoDxnfIroT+SdYuJW+q2qi7lEUWEEZqOpi
         0ob2EsCOS3er5PbzujwKeLbHJVq0qERHN+JoVXqhsse7m9H/tM+2hY0BnbgbcQi72Wlu
         fsgX70IzVJk7v+MlUbCyXAkEpAb7Bpue3w/hQf/Y/0llCjDeV/jYubnpVk76YFLS1bop
         RK0r3Ws3qXFOz12o5bO6wKrUJI0vzBqy4WJ/MNRpU70/3+9aDoJDUofXlR9att751PrC
         72SlKuNAEuQ7y1zkjRz23QyFCuS4fgAD48TX5qcgsdoA1lccvgeR5abA3eM4PGOy9xDP
         xJZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=zhqRMjjO;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=zhqRMjjO;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AIpwx48OVMAhrCpZRRIKzbcbPojmnomd8oS5PMQNHxNISnh4rbxzCuNGOPJaTp6auOxO+d7jGzX+xw==
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu,
	gnomes@lxorguk.ukuu.org.uk,
	Alexander Graf <agraf@suse.de>
Cc: Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/3] serial: uartps: Move register to probe based on run time detection
Date: Thu, 26 Apr 2018 16:08:18 +0200
Message-Id: <7dc0d444ddfae465a80e509af6ceb6be5b42881a.1524751696.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598818047135604383?=
X-GMAIL-MSGID: =?utf-8?q?1598818047135604383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Find out the highest serial alias and allocate that amount of
structures/minor numbers to be able to handle all of them.
Origin setting that there are two prealocated CDNS_UART_NR_PORTS is kept
there.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Discussed here: https://patchwork.kernel.org/patch/9738445/

The same solution is done in pl011 driver.
---
 drivers/tty/serial/xilinx_uartps.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0fc9de20843c..ffb5b66a05b5 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1432,6 +1432,22 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	struct cdns_uart *cdns_uart_data;
 	const struct of_device_id *match;
 
+	if (!cdns_uart_uart_driver.state) {
+		rc = of_alias_get_highest_id("serial");
+		if (rc >= CDNS_UART_NR_PORTS) {
+			/* serial2 means 3 ports that's why rc(2) + 1 here */
+			rc += 1;
+			/* Rewrite default setup which is using 2 ports */
+			cdns_uart_uart_driver.nr = rc;
+		}
+
+		rc = uart_register_driver(&cdns_uart_uart_driver);
+		if (rc < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return rc;
+		}
+	}
+
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
 			GFP_KERNEL);
 	if (!cdns_uart_data)
@@ -1622,28 +1638,14 @@ static struct platform_driver cdns_uart_platform_driver = {
 
 static int __init cdns_uart_init(void)
 {
-	int retval = 0;
-
-	/* Register the cdns_uart driver with the serial core */
-	retval = uart_register_driver(&cdns_uart_uart_driver);
-	if (retval)
-		return retval;
-
 	/* Register the platform driver */
-	retval = platform_driver_register(&cdns_uart_platform_driver);
-	if (retval)
-		uart_unregister_driver(&cdns_uart_uart_driver);
-
-	return retval;
+	return platform_driver_register(&cdns_uart_platform_driver);
 }
 
 static void __exit cdns_uart_exit(void)
 {
 	/* Unregister the platform driver */
 	platform_driver_unregister(&cdns_uart_platform_driver);
-
-	/* Unregister the cdns_uart driver */
-	uart_unregister_driver(&cdns_uart_uart_driver);
 }
 
 arch_initcall(cdns_uart_init);
-- 
2.17.0
