Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1524751710; cv=none;
        d=google.com; s=arc-20160816;
        b=S5Hx8KoIlZIvU3yGDrytEqg+9yPD4kNnLaY/wSS813AVEk0Jc1NU7HTu5ZGrIIFLGm
         glUBrynd35yfZMjunV7kAgFSoiFxPc32DT75OId5Xr8dh1poNMwdPXlzq43ACtUY3zB1
         obW3U7j2kw6bx5jcrUJTO/xyFDv5KsVskzRyRwu/YuyaDsfoogrU87SHHfInOwP8RTVY
         131yOndKq2etihwHloESmLL0dp8BCQD9W03Z2ZteyHe+0RGVpOkkUW/NkICkxAclO8qP
         KVE8Jy+rNOsvkC/c+fuDyZBJaKHSTeM4tjXJ7L/X4nPBaEi/pNE0RrS0MkTKkTOUBD2P
         6FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:sender:dkim-signature:arc-authentication-results;
        bh=lXiRgNIlbs2ZhrTnuwv/Pzzy/qNw0VwwFxMvzSF1djc=;
        b=N8A92hFOB+FEqiP5oGGiWLqHGR7pwqR7/MXT+uAW3GoWd/RrBMyt7WwNWRSghnA8Ui
         kZde4PH5yivzemV00Wt0wqN2znz8zDk4pKCZlIQzfCnZnsTN1mGoJNRTafzqV7kS569q
         /qAe8TkT+bgBolFW6bwnhPHkCdFGSEOwgeylkuuA78OXkrtQiOZxWOZ7m2lQ3x8aoRdS
         4Rjetm6y5PJteCAZYv7Qc5ba+/md29AshhWA75lpuknrbtXtQJs6ZaYoW1cunjNQZDY3
         m49Mm/8F3E3ie0Ym8NjA1AOrHyWuo0d/bqe1zwraziHgRtxo8e3BS8DF+VQ7VWNsKXpS
         XiLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=tsJqkxYm;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=tsJqkxYm;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AIpwx480BV/ztfitKnHUxarWHs2qHaTlgihptGsFL+362KU99m8E8/tWyyQ27N1bSmJOQC1mnQVvmQ==
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
Subject: [RFC PATCH 3/3] serial: uartps: Change uart ports allocation
Date: Thu, 26 Apr 2018 16:08:19 +0200
Message-Id: <782bf2c500578db1a8ee327cc48ed905d3e50497.1524751696.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598818049279373202?=
X-GMAIL-MSGID: =?utf-8?q?1598818049279373202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For ips which have alias algorightm all the tim using that alias and
minor number. It means serial20 alias ends up as ttyPS20.

If aliases are not setup for enabled core the first unused position is
used but that's need to be checked if it is really empty because another
instance doesn't need to be probed. of_alias_check_id() does that test.
If alias pointing to different not compatible IP, it is free to use.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 96 ++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ffb5b66a05b5..7c616b48c117 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -45,6 +45,9 @@ static int rx_timeout = 10;
 module_param(rx_timeout, uint, S_IRUGO);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
+/* The inuse bitfield is recording which IDs are free/used by the driver. */
+static unsigned long *inuse;
+
 /* Register offsets for the UART. */
 #define CDNS_UART_CR		0x00  /* Control Register */
 #define CDNS_UART_MR		0x04  /* Mode Register */
@@ -1418,6 +1421,75 @@ static const struct of_device_id cdns_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
+static int cdns_get_id(struct platform_device *pdev)
+{
+	int id;
+
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&pdev->dev,
+			 "No serial alias passed. Using the first free id\n");
+
+		/*
+		 * Start with id 0 and check if there is no serial0 alias
+		 * which points to device which is compatible with this driver.
+		 * If alias exists then try next free position.
+		 */
+		id = 0;
+
+		for (;;) {
+			dev_dbg(&pdev->dev, "Validate id %d\n", id);
+			id = find_next_zero_bit(inuse, id,
+						cdns_uart_uart_driver.nr);
+
+			dev_dbg(&pdev->dev, "The empty id is %d\n", id);
+			/* Check if ID is empty */
+
+			if (of_alias_check_id(cdns_uart_of_match,
+					      "serial", id)) {
+				dev_dbg(&pdev->dev,
+					"ID %d already taken - skipped\n", id);
+				/* Try next one */
+				id++;
+				continue;
+			}
+
+			/* It shouldn't happen anytime */
+			if (id >= cdns_uart_uart_driver.nr) {
+				dev_dbg(&pdev->dev,
+					"ID %d is greater than NR of ports\n",
+					cdns_uart_uart_driver.nr);
+				return -ENXIO;
+			}
+
+			/* Break the loop if bit is taken */
+			if (!test_and_set_bit(id, inuse)) {
+				dev_dbg(&pdev->dev,
+					"Selected ID %d allocation passed\n",
+					id);
+				break;
+			}
+			dev_dbg(&pdev->dev,
+				"Selected ID %d allocation failed\n", id);
+			/* if taking bit fails then try next one */
+			id++;
+		}
+	} else {
+		/*
+		 * If alias was found there is no reason to check
+		 * anything else
+		 */
+		if (test_and_set_bit(id, inuse)) {
+			dev_dbg(&pdev->dev,
+				 "ID %d allocation failed\n", id);
+			return -EAGAIN;
+		}
+	}
+
+	return id;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1446,6 +1518,13 @@ static int cdns_uart_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Failed to register driver\n");
 			return rc;
 		}
+
+		/* Create bitfield to record which ids are free */
+		inuse = devm_kcalloc(&pdev->dev,
+				     BITS_TO_LONGS(cdns_uart_uart_driver.nr),
+				     sizeof(unsigned long), GFP_KERNEL);
+		if (!inuse)
+			return -ENOMEM;
 	}
 
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
@@ -1463,6 +1542,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		cdns_uart_data->quirks = data->quirks;
 	}
 
+	id = cdns_get_id(pdev);
+	if (id < 0)
+		return id;
+
 	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
@@ -1515,16 +1598,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 				&cdns_uart_data->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
 #endif
-	/* Look for a serialN alias */
-	id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (id < 0)
-		id = 0;
-
-	if (id >= CDNS_UART_NR_PORTS) {
-		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
-		rc = -ENODEV;
-		goto err_out_notif_unreg;
-	}
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
@@ -1583,10 +1656,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	return 0;
 
 err_out_pm_disable:
+	clear_bit(port->line, inuse);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-err_out_notif_unreg:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
@@ -1618,6 +1691,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 #endif
 	rc = uart_remove_one_port(&cdns_uart_uart_driver, port);
 	port->mapbase = 0;
+	clear_bit(port->line, inuse);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
 	pm_runtime_disable(&pdev->dev);
-- 
2.17.0
