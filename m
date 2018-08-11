Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F24C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2FD22436
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1q4Q8kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2FD22436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeHKEHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:07:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39193 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeHKEHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:07:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id a11-v6so5130254pgw.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WS73hgKCe7tsfUIogpxbjOL5bwPxakTmgNQf6YebHkM=;
        b=F1q4Q8kRQbiKeV+51mx6Ttf3MQkBrrl3Z4hYw+ukzjG1Ul12iiHG5MgydSNuW4N841
         CvG0RFDals/ULGQlX5hser/Qov6yMMY92gf3Q1FLTOfRInL2pW4qbfdBTOqHZxAtiay0
         xP0GCVacakhPsBJWPm8wRcFOlGyjUWf9Jw7fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WS73hgKCe7tsfUIogpxbjOL5bwPxakTmgNQf6YebHkM=;
        b=htCpvHcS75JemQ70OLMhnXhCEvazkvqqwqYuKp45R6D0wwgH2KY4nAj4xH3sCbJ6hm
         CAgQ/x8DFpgwXqtb8ficfE0exWiNb177HYYlNml2ossLrcxe9V9NpnT3MXmXF3ULV7j+
         194b+O0zUVEXagcCQBaeC8O2bvR+/KZ7M50TJ6g+O5kCWn7gBnqi/2WJ/cKX3FX+Zoso
         yBZXux/3eWF3hOTtmL8vbb+hD5Thc9Ptphue6MjvOSKrJj9BCVfGn8u8Bf/6LUcymOmK
         J3yONA3bCfFbYQCosOOJPGVOwGzctnwFziDndyx7/F8sgMizfPhYZWSFSJRJqojJMylO
         +DPQ==
X-Gm-Message-State: AOUpUlGW7XK8r0vp7S8HM8Dln5M1Ma3yZTVZ61htcSmS7XqvZ0oyyVT3
        t2tMBlOUf1Tc2cKmXzJZn4zR4w==
X-Google-Smtp-Source: AA+uWPw8B62pJEq+IvKAI0ac6Ozhs4ZF2AnwWJpxU0FYMOIUcAXyc0433E94LrsWqbW7DjP4tq5nnw==
X-Received: by 2002:a63:ee56:: with SMTP id n22-v6mr8166569pgk.402.1533951326176;
        Fri, 10 Aug 2018 18:35:26 -0700 (PDT)
Received: from ubuntu.localdomain ([45.56.155.48])
        by smtp.gmail.com with ESMTPSA id d22-v6sm21722373pfk.69.2018.08.10.18.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 18:35:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] serial: sprd: Fix the indentation issue
Date:   Fri, 10 Aug 2018 18:34:27 -0700
Message-Id: <5952d0e2189677a247a8efabf356347e1e087187.1533950271.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the macros' definition and code have the same correct indentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 46 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 8d5c9cd..4287ca3 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -68,24 +68,24 @@
 #define SPRD_LCR_DATA_LEN6	0x4
 #define SPRD_LCR_DATA_LEN7	0x8
 #define SPRD_LCR_DATA_LEN8	0xc
-#define SPRD_LCR_PARITY	(BIT(0) | BIT(1))
+#define SPRD_LCR_PARITY		(BIT(0) | BIT(1))
 #define SPRD_LCR_PARITY_EN	0x2
 #define SPRD_LCR_EVEN_PAR	0x0
 #define SPRD_LCR_ODD_PAR	0x1
 
 /* control register 1 */
-#define SPRD_CTL1			0x001C
+#define SPRD_CTL1		0x001C
 #define RX_HW_FLOW_CTL_THLD	BIT(6)
 #define RX_HW_FLOW_CTL_EN	BIT(7)
 #define TX_HW_FLOW_CTL_EN	BIT(8)
 #define RX_TOUT_THLD_DEF	0x3E00
-#define RX_HFC_THLD_DEF	0x40
+#define RX_HFC_THLD_DEF		0x40
 
 /* fifo threshold register */
 #define SPRD_CTL2		0x0020
-#define THLD_TX_EMPTY	0x40
+#define THLD_TX_EMPTY		0x40
 #define THLD_TX_EMPTY_SHIFT	8
-#define THLD_RX_FULL	0x40
+#define THLD_RX_FULL		0x40
 
 /* config baud rate register */
 #define SPRD_CLKD0		0x0024
@@ -95,11 +95,11 @@
 #define SPRD_CLKD1_SHIFT	16
 
 /* interrupt mask status register */
-#define SPRD_IMSR			0x002C
-#define SPRD_IMSR_RX_FIFO_FULL		BIT(0)
+#define SPRD_IMSR		0x002C
+#define SPRD_IMSR_RX_FIFO_FULL	BIT(0)
 #define SPRD_IMSR_TX_FIFO_EMPTY	BIT(1)
-#define SPRD_IMSR_BREAK_DETECT		BIT(7)
-#define SPRD_IMSR_TIMEOUT		BIT(13)
+#define SPRD_IMSR_BREAK_DETECT	BIT(7)
+#define SPRD_IMSR_TIMEOUT	BIT(13)
 
 struct sprd_uart_port {
 	struct uart_port port;
@@ -229,7 +229,7 @@ static inline void sprd_rx(struct uart_port *port)
 		port->icount.rx++;
 
 		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
-			SPRD_LSR_FE | SPRD_LSR_OE))
+			   SPRD_LSR_FE | SPRD_LSR_OE))
 			if (handle_lsr_errors(port, &lsr, &flag))
 				continue;
 		if (uart_handle_sysrq_char(port, ch))
@@ -292,8 +292,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 	if (ims & SPRD_IMSR_TIMEOUT)
 		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
-	if (ims & (SPRD_IMSR_RX_FIFO_FULL |
-		SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
+	if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
+		   SPRD_IMSR_TIMEOUT))
 		sprd_rx(port);
 
 	if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
@@ -333,7 +333,7 @@ static int sprd_startup(struct uart_port *port)
 	sp = container_of(port, struct sprd_uart_port, port);
 	snprintf(sp->name, sizeof(sp->name), "sprd_serial%d", port->line);
 	ret = devm_request_irq(port->dev, port->irq, sprd_handle_irq,
-				IRQF_SHARED, sp->name, port);
+			       IRQF_SHARED, sp->name, port);
 	if (ret) {
 		dev_err(port->dev, "fail to request serial irq %d, ret=%d\n",
 			port->irq, ret);
@@ -361,8 +361,8 @@ static void sprd_shutdown(struct uart_port *port)
 }
 
 static void sprd_set_termios(struct uart_port *port,
-				    struct ktermios *termios,
-				    struct ktermios *old)
+			     struct ktermios *termios,
+			     struct ktermios *old)
 {
 	unsigned int baud, quot;
 	unsigned int lcr = 0, fc;
@@ -480,8 +480,7 @@ static void sprd_config_port(struct uart_port *port, int flags)
 		port->type = PORT_SPRD;
 }
 
-static int sprd_verify_port(struct uart_port *port,
-				   struct serial_struct *ser)
+static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	if (ser->type != PORT_SPRD)
 		return -EINVAL;
@@ -531,7 +530,7 @@ static void sprd_console_putchar(struct uart_port *port, int ch)
 }
 
 static void sprd_console_write(struct console *co, const char *s,
-				      unsigned int count)
+			       unsigned int count)
 {
 	struct uart_port *port = &sprd_port[co->index]->port;
 	int locked = 1;
@@ -594,7 +593,7 @@ static void sprd_putc(struct uart_port *port, int c)
 	unsigned int timeout = SPRD_TIMEOUT;
 
 	while (timeout-- &&
-		   !(readl(port->membase + SPRD_LSR) & SPRD_LSR_TX_OVER))
+	       !(readl(port->membase + SPRD_LSR) & SPRD_LSR_TX_OVER))
 		cpu_relax();
 
 	writeb(c, port->membase + SPRD_TXD);
@@ -607,9 +606,8 @@ static void sprd_early_write(struct console *con, const char *s, unsigned int n)
 	uart_console_write(&dev->port, s, n, sprd_putc);
 }
 
-static int __init sprd_early_console_setup(
-				struct earlycon_device *device,
-				const char *opt)
+static int __init sprd_early_console_setup(struct earlycon_device *device,
+					   const char *opt)
 {
 	if (!device->port.membase)
 		return -ENODEV;
@@ -691,8 +689,8 @@ static int sprd_probe(struct platform_device *pdev)
 
 	index = sprd_probe_dt_alias(index, &pdev->dev);
 
-	sprd_port[index] = devm_kzalloc(&pdev->dev,
-		sizeof(*sprd_port[index]), GFP_KERNEL);
+	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
+					GFP_KERNEL);
 	if (!sprd_port[index])
 		return -ENOMEM;
 
-- 
1.9.1

