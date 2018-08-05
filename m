Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CBAC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B29219A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B29219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeHFBdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 21:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:37766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbeHFBdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 21:33:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37D09AE62;
        Sun,  5 Aug 2018 23:27:03 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc:     linux-mips@linux-mips.org, jringle@gridpoint.com,
        allsey87@gmail.com, Jakub Kicinski <kubakici@wp.pl>,
        Xue Liu <liuxuenetmail@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
Date:   Mon,  6 Aug 2018 01:26:51 +0200
Message-Id: <20180805232651.10605-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to allow using serdev.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 243c96025053..ad7267274f65 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
+#ifdef CONFIG_OF
+		struct device_node *np;
+		struct platform_device *pdev;
+		char name[6] = "uartx";
+#endif
+
 		s->p[i].line		= i;
 		/* Initialize port data */
+#ifdef CONFIG_OF
+		name[4] = '0' + i;
+		np = of_get_child_by_name(dev->of_node, name);
+		if (IS_ERR(np)) {
+			ret = PTR_ERR(np);
+			goto out_ports;
+		}
+		pdev = of_platform_device_create(np, NULL, dev);
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			goto out_ports;
+		}
+		platform_set_drvdata(pdev, dev_get_drvdata(dev));
+		s->p[i].port.dev	= &pdev->dev;
+#else
 		s->p[i].port.dev	= dev;
+#endif
 		s->p[i].port.irq	= irq;
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
@@ -1271,6 +1293,9 @@ static int sc16is7xx_probe(struct device *dev,
 	for (i--; i >= 0; i--) {
 		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
+#ifdef CONFIG_OF
+		of_platform_device_destroy(s->p[i].port.dev, NULL);
+#endif
 	}
 
 #ifdef CONFIG_GPIOLIB
-- 
2.16.4

