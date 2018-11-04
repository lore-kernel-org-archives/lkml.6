Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B18CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353D92085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y2ufjeVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353D92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeKDXHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730390AbeKDXHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879062085B;
        Sun,  4 Nov 2018 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339548;
        bh=A5jCYSplBYoOFQ8zRetf6AmvXC5z+rSE1tCGxdnEW/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2ufjeVKYsxoG3vwdc5rzHegI1OqXsAQajPc59YR2IJuRgoezKOhLpbU29kqPlD6t
         cWJpTaol5vH7tXlWHAUkmRMDWfk6golCr+r9A55yPGHLTl56BIs0zwCe3QNCPgwnwx
         IvQ2YxqEXCnNIZ8gYAPsArDlrlsVEadvPlk4NE/Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 43/57] serial: 8250_of: Fix for lack of interrupt support
Date:   Sun,  4 Nov 2018 08:51:30 -0500
Message-Id: <20181104135144.88324-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit a27d938251ef40c43db81af16fc26b2cec181d4d ]

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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_of.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index af8beefe9b5c..877fd7f8a8ed 100644
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
2.17.1

