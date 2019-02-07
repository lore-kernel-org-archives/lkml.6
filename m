Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5ACC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B4921902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lpGa0Grw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGL1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:27:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38276 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:27:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so8690596ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:references:reply-to:message-id:mime-version;
        bh=obC/o0x/Of+oiYvDNo+3FmUgPGJAQl+NE5x85eXAQHI=;
        b=lpGa0Grw3h/abtMaXn8NhnwSyAc4gkosLOJN3rQecVmu/PUkG6561GanDZRktd8Nca
         SmSdGAm7PK7OLr+TV0dpGPi2QnPfRciLmalt04YeQub95QaqfKMzO5nMopKi6EA51LaA
         HHqzvMmE6uovrowLcZJf0bK4COmQu/hZ+bfPRRyVE9vJ8tJkjSc/LYeRHaFXueQ5Pfov
         MMFTeIH4v1IvyDhmAIWOIqikUDlDabQZvovVAWtgJ8/qAynFQH1PCB6a7bbSIrfjKWVf
         7v2rQY2Z66S9UFvsAue90atnXEAbwYSrw/JY08p1V/2cCbKHOUWq4l0DVZqZdXHKM66c
         gKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:reply-to
         :message-id:mime-version;
        bh=obC/o0x/Of+oiYvDNo+3FmUgPGJAQl+NE5x85eXAQHI=;
        b=D48qxjOhtRGtWKKwR/Obf6UXb6CxHz6MHxk2KHHsLu47HnqMNSFwkJVOKd7VbkVRCh
         B5DZQ1lAEaq3OL6D00cPhgLQ0tZfLqFH2QfwIAzAcoHrZPVoA9t/50VDklKTCbgcD0Hi
         LAA50BCF9T8tEe71hDFEB4wh6i8zfazbQsnDUWYPqeo5jMLCwUPJMQnCO/CnlMyJlim8
         XE+jQcTJuk+soNwn5opZ+LIK/spCSOQ7lJ0CTn3eMsHRbRvol56zFwONuHw+njuFRwTK
         UN9wX+8PcgUNJjSNb52Nmg6KGmVKwa7VFzbqBRK0JaCnYfIWl1iJdxREtX3ScXBskX2b
         z8eg==
X-Gm-Message-State: AHQUAuYHi3lFmWg+MXoVEnQ6u6oJkGcJDXoYmJEApgzcvpgu7Nf3feoE
        FczdamTHtUmw8GX41j30P9h+ww==
X-Google-Smtp-Source: AHgI3IaacZRmJNMHtyYLIrXWsYmX+kBY4nCl0BEnTm3g+kmpaGvMP3TR483tFqfu5leYPUmmyCMgkg==
X-Received: by 2002:aa7:c0c8:: with SMTP id j8mr4962862edp.94.1549538818755;
        Thu, 07 Feb 2019 03:26:58 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:a0f9])
        by smtp.gmail.com with ESMTPSA id e26sm3239012eja.9.2019.02.07.03.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 03:26:58 -0800 (PST)
From:   Julien Masson <jmasson@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        Julien Masson <jmasson@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: meson_uart: Add support for kernel debugger
Date:   Thu,  7 Feb 2019 12:26:16 +0100
References: <86h8dfx2jv.fsf@gmail.com>
Reply-To: <86h8dfx2jv.fsf@gmail.com>
Message-ID: <86ftszx2im.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kgdb invokes the poll_put_char and poll_get_char when communicating
with the host. This patch implement the serial polling hooks for the
meson_uart to be used for KGDB debugging over serial line.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 8a84259..49b20da 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context (i.e. kgdb).
+ */
+
+static int meson_uart_poll_get_char(struct uart_port *port)
+{
+	u32 c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
+		c = NO_POLL_CHAR;
+	else
+		c = readl(port->membase + AML_UART_RFIFO);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return c;
+}
+
+static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	writel(c, port->membase + AML_UART_WFIFO);
+
+	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+		cpu_relax();
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
@@ -441,6 +483,10 @@ static const struct uart_ops meson_uart_ops = {
 	.request_port	= meson_uart_request_port,
 	.release_port	= meson_uart_release_port,
 	.verify_port	= meson_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= meson_uart_poll_get_char,
+	.poll_put_char	= meson_uart_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
-- 
2.7.4

