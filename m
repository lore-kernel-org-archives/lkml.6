Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51728217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBVRP98Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfBSHcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:32:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41015 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfBSHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:32:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so1470323pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OH4/R/+Sw0xSAT1PY7Jcu+TD5xcCuEZT5i9WHOVRd/E=;
        b=mBVRP98YrgXxSycI+IEpurKiIyLWSygxELFbpBiYNuhcEegSpkm8ZYEkBKgHbHaOXl
         8p22pkX0L8RdjuZay61ImSfuY+W2gLqUR64kM6GcN2YHly9w/hZKA9FoCBEWLbCJt7be
         T+OHTKD+0tD4AnNTzMIBJrOlpm84cd5HoSEMj/SjPMM1WOmDgQ1w4mOY5KyUChN+sXG4
         /Z+aryL/8ty5KWOYxQ/JesGZZ79S62Wtz4qqY/yOu+oraDQBJ3LsEotuWCoeQsalXPXo
         FxH7b6KPXrhlby6qbdISBaSfi/an3m2z18Lpi38RWDjGwunSaoRKZX46867Bst+BrpHy
         jnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OH4/R/+Sw0xSAT1PY7Jcu+TD5xcCuEZT5i9WHOVRd/E=;
        b=Y7cn8AbCm9q7o5HS5HpXEal38N+2HsuUYnQioiPjD/sz1CanP1D0Wv3RjG7t1Xjn//
         sYlSz11uvfeKiKSkFsSMFsJn92SSYYWhWqMXK/Nk/5KZZ6RHvqKqlEQLoN0cFH6xucAW
         9+sZZKxI/sUft221K6En1UkCMNejPPIZQVFLrstHiaCT2MHwwpvZfZVpB5IrfKAl8qfZ
         GgCo9HWemK9OivkviSySqbRsSXecvYr5TTdz0rrWr0f6yWgo4EOKosPYAK8kS7TmMOp+
         ngCRfhleEkcFQmtZ3Ujv+R0zFkF1DnBWMEvh/4TEmNj+DXbzHZmouFSAlhQvPqjI83jC
         OCtg==
X-Gm-Message-State: AHQUAubMAZNQbSSx6mFl3rX6lEl4WTXPrUP3YSzJV6vHrzuGNfpIz9TW
        7yBOgYJH8Pn/aEhGPZTl5S1VFg==
X-Google-Smtp-Source: AHgI3IaYV+Z0u6vu2iSnRUvbIWIjREnK4q0xLxz8adm1PsN6poR3bQtaDUtBgpDO4lx6jjylbodEsg==
X-Received: by 2002:a63:ae0e:: with SMTP id q14mr26926027pgf.151.1550561519923;
        Mon, 18 Feb 2019 23:31:59 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id n27sm31556569pfb.8.2019.02.18.23.31.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 23:31:59 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5] serial: sprd: Add power management for the Spreadtrum serial controller
Date:   Tue, 19 Feb 2019 15:31:13 +0800
Message-Id: <cb94ee643102cc2fd35af5ee517e46a20d5c00d9.1550560916.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550560916.git.baolin.wang@linaro.org>
References: <cover.1550560916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds power management for the Spreadtrum serial controller.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |   61 +++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1891a45..8f45b66 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -100,10 +100,12 @@
 #define SPRD_IMSR_TX_FIFO_EMPTY	BIT(1)
 #define SPRD_IMSR_BREAK_DETECT	BIT(7)
 #define SPRD_IMSR_TIMEOUT	BIT(13)
+#define SPRD_DEFAULT_SOURCE_CLK	26000000
 
 struct sprd_uart_port {
 	struct uart_port port;
 	char name[16];
+	struct clk *clk;
 };
 
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
@@ -491,6 +493,22 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
+static void sprd_pm(struct uart_port *port, unsigned int state,
+		unsigned int oldstate)
+{
+	struct sprd_uart_port *sup =
+		container_of(port, struct sprd_uart_port, port);
+
+	switch (state) {
+	case UART_PM_STATE_ON:
+		clk_prepare_enable(sup->clk);
+		break;
+	case UART_PM_STATE_OFF:
+		clk_disable_unprepare(sup->clk);
+		break;
+	}
+}
+
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
 	.get_mctrl = sprd_get_mctrl,
@@ -507,6 +525,7 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	.request_port = sprd_request_port,
 	.config_port = sprd_config_port,
 	.verify_port = sprd_verify_port,
+	.pm = sprd_pm,
 };
 
 #ifdef CONFIG_SERIAL_SPRD_CONSOLE
@@ -671,11 +690,45 @@ static int sprd_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sprd_clk_init(struct uart_port *uport)
+{
+	struct clk *clk_uart, *clk_parent;
+	struct sprd_uart_port *u = sprd_port[uport->line];
+
+	clk_uart = devm_clk_get(uport->dev, "uart");
+	if (IS_ERR(clk_uart)) {
+		dev_warn(uport->dev, "uart%d can't get uart clock\n",
+			 uport->line);
+		clk_uart = NULL;
+	}
+
+	clk_parent = devm_clk_get(uport->dev, "source");
+	if (IS_ERR(clk_parent)) {
+		dev_warn(uport->dev, "uart%d can't get source clock\n",
+			 uport->line);
+		clk_parent = NULL;
+	}
+
+	if (!clk_uart || clk_set_parent(clk_uart, clk_parent))
+		uport->uartclk = SPRD_DEFAULT_SOURCE_CLK;
+	else
+		uport->uartclk = clk_get_rate(clk_uart);
+
+	u->clk = devm_clk_get(uport->dev, "enable");
+	if (IS_ERR(u->clk)) {
+		if (PTR_ERR(u->clk) != -EPROBE_DEFER)
+			dev_err(uport->dev, "uart%d can't get enable clock\n",
+				uport->line);
+		return PTR_ERR(u->clk);
+	}
+
+	return 0;
+}
+
 static int sprd_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct uart_port *up;
-	struct clk *clk;
 	int irq;
 	int index;
 	int ret;
@@ -704,9 +757,9 @@ static int sprd_probe(struct platform_device *pdev)
 	up->ops = &serial_sprd_ops;
 	up->flags = UPF_BOOT_AUTOCONF;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR_OR_NULL(clk))
-		up->uartclk = clk_get_rate(clk);
+	ret = sprd_clk_init(up);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
1.7.9.5

