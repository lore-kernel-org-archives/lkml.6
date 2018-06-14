Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A6978C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0A020693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr5XHPNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0A020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965767AbeFNOfa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965107AbeFNOKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:10:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D27208DE;
        Thu, 14 Jun 2018 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985413;
        bh=rDZSFQqD5Oryo8Gf3Qn7KjFpBWPgsccNcdWKGK3Puno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lr5XHPNu6lnRdm9YdTK1vpCx83qfecm9445hwdFYCvt9e8KgwcnEINL/n64TQmmxy
         vi5wV9YKwpTges3GrgwutkTxcZEa0NRBBLi2pDZaYuU+ZpL6ZKHnGF4Y1PA1vj7mOb
         G5D9OgHEmn+hAooF0DtPSnMHEWxZ6VFf92BJ47yE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4.14 19/36] tty/serial: atmel: use port->name as name in request_irq()
Date:   Thu, 14 Jun 2018 16:04:42 +0200
Message-Id: <20180614132158.127782200@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 9594b5be7ec110ed11acec58fa94f3f293668c85 upstream.

I was puzzled while looking at /proc/interrupts and random things showed
up between reboots. This occurred more often but I realised it later. The
"correct" output should be:
|38:      11861  atmel-aic5   2 Level     ttyS0

but I saw sometimes
|38:       6426  atmel-aic5   2 Level     tty1

and accounted it wrongly as correct. This is use after free and the
former example randomly got the "old" pointer which pointed to the same
content. With SLAB_FREELIST_RANDOM and HARDENED I even got
|38:       7067  atmel-aic5   2 Level     E=Started User Manager for UID 0

or other nonsense.
As it turns out the tty, pointer that is accessed in atmel_startup(), is
freed() before atmel_shutdown(). It seems to happen quite often that the
tty for ttyS0 is allocated and freed while ->shutdown is not invoked. I
don't do anything special - just a systemd boot :)

Use dev_name(&pdev->dev) as the IRQ name for request_irq(). This exists
as long as the driver is loaded so no use-after-free here.

Cc: stable@vger.kernel.org
Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Acked-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/atmel_serial.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1786,7 +1786,6 @@ static int atmel_startup(struct uart_por
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	struct tty_struct *tty = port->state->port.tty;
 	int retval;
 
 	/*
@@ -1801,8 +1800,8 @@ static int atmel_startup(struct uart_por
 	 * Allocate the IRQ
 	 */
 	retval = request_irq(port->irq, atmel_interrupt,
-			IRQF_SHARED | IRQF_COND_SUSPEND,
-			tty ? tty->name : "atmel_serial", port);
+			     IRQF_SHARED | IRQF_COND_SUSPEND,
+			     dev_name(&pdev->dev), port);
 	if (retval) {
 		dev_err(port->dev, "atmel_startup - Can't get irq\n");
 		return retval;


