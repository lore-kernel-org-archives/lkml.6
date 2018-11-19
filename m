Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73767C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0202089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+oxwboP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0202089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbeKTCzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbeKTCza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC77B20870;
        Mon, 19 Nov 2018 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645083;
        bh=Drhxn7nZtRioL17ea7l2qG6z1FOxamIySG7rrBr+SI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+oxwboPZqK+krBElbXQ07mjoJBfrdiwUZ/ty5RzGedPIxQYuDKDXq0TbbvTdPicB
         QvF9qlTFo1wwPacFg6GZknBRiqICqfE2jNCYWuNgKvHXv9qUx1oBfH3/zWIZmTv+Rf
         W3jMlCj2a9jIpjkXWygSwH0q1Z7Kad786S4fQHvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/205] serial: 8250_of: Fix for lack of interrupt support
Date:   Mon, 19 Nov 2018 17:25:37 +0100
Message-Id: <20181119162622.955653931@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_of.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -58,7 +58,7 @@ static int of_platform_serial_setup(stru
 	struct resource resource;
 	struct device_node *np = ofdev->dev.of_node;
 	u32 clk, spd, prop;
-	int ret;
+	int ret, irq;
 
 	memset(port, 0, sizeof *port);
 
@@ -143,21 +143,27 @@ static int of_platform_serial_setup(stru
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
@@ -184,8 +190,6 @@ static int of_platform_serial_setup(stru
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-err_dispose:
-	irq_dispose_mapping(port->irq);
 err_unprepare:
 	clk_disable_unprepare(info->clk);
 err_pmruntime:


