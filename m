Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F214C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5102073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5102073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeH3NLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:11:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbeH3NLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:11:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 41F4EEF2349F9;
        Thu, 30 Aug 2018 17:10:39 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Thu, 30 Aug 2018 17:10:34 +0800
From:   John Garry <john.garry@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <alexander.sverdlin@nokia.com>, <jslaby@suse.com>,
        <robh@kernel.org>, <joel@jms.id.au>, <kurt@linutronix.de>,
        <yamada.masahiro@socionext.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2] serial: 8250_of: Fix for lack of interrupt support
Date:   Thu, 30 Aug 2018 17:08:50 +0800
Message-ID: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
check was added for the UART driver being probed prior to the parent IRQ
controller.

Unfortunately this breaks certain boards which have no interrupt support,
like Huawei D03.

Indeed, the 8250 DT bindings state that interrupts should be supported -
not must.

To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
does relay whether the IRQ host controller domain is not ready, i.e.
defer probe, instead of assuming it.

Fixes: c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ")
Signed-off-by: John Garry <john.garry@huawei.com>
---

Change in v2:
- fix check on irq value

Note: I think that it would better if we could try to get the interrupt
	  before clk+pm enabling, so we don't need to disable later when
	  deferring, but this is not a fix.

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index af8beef..877fd7f 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -58,7 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	struct resource resource;
 	struct device_node *np = ofdev->dev.of_node;
 	u32 clk, spd, prop;
-	int ret;
+	int ret, irq;
 
 	memset(port, 0, sizeof *port);
 
@@ -143,21 +143,27 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (ret >= 0)
 		port->line = ret;
 
-	port->irq = irq_of_parse_and_map(np, 0);
-	if (!port->irq) {
-		ret = -EPROBE_DEFER;
-		goto err_unprepare;
+	irq = of_irq_get(np, 0);
+	if (irq < 0) {
+		if (irq == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_unprepare;
+		}
+		/* IRQ support not mandatory */
+		irq = 0;
 	}
 
+	port->irq = irq;
+
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
 		ret = PTR_ERR(info->rst);
-		goto err_dispose;
+		goto err_unprepare;
 	}
 
 	ret = reset_control_deassert(info->rst);
 	if (ret)
-		goto err_dispose;
+		goto err_unprepare;
 
 	port->type = type;
 	port->uartclk = clk;
@@ -184,8 +190,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-err_dispose:
-	irq_dispose_mapping(port->irq);
 err_unprepare:
 	clk_disable_unprepare(info->clk);
 err_pmruntime:
-- 
1.9.1

