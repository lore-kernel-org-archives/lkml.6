Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7DDC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7CF20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxvoiQps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7CF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeJ3C6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41272 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbeJ3C6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so1394614pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CSaQp289WlwooI6biqRK70zJEg/8W1x/ZX+9kCIc7Ts=;
        b=mxvoiQpswweCkHANP3Cexu88qUDHEHcm1IUx/gx6U9O+2agCOQbySNl981YrQPO/NE
         ZINFMOGENJEp2Aht7gk4zKayGjMO6w8n2HAseulpfg1OphhcjUqBwzvJ/cbdumj+QMlg
         uZMhsBdcbNKonkRq7C2sIofM1Jw1d0iaZAIQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CSaQp289WlwooI6biqRK70zJEg/8W1x/ZX+9kCIc7Ts=;
        b=XFiwZsy99CxI3K3n+D1K9n/qc2Q5gWr2v+ojn/iB9xL+Dx1LL6/2GLHdhZmRUJniXR
         jElBzZIdv+BLmjgLaLkvucKh/1LohgkcINaMTN5iGEypVNv6bcRhCRSECnOerZS5CzTQ
         +H6XMNq7yCiGBVgUczHFziJwQwCloILI/xPraVkxJobauVqia5frEnubPziAwV3rRHR1
         OezEr79EMoXvKp+IPwQ5HMmSHwWI7K5dl+MCNPMtgOxi0JFVaWwT8VJJUnkvp3RdiQgF
         6PR8GL0bFI2PXcYYtS0QXCvNYvBzylALHWWg4SWSBfUFpiU0k6cCKwaYovhIYdS/npPD
         xrhQ==
X-Gm-Message-State: AGRZ1gK9A1CCFgvq083qi8NUp+185zvGU2JAqOOepKNqVdHeeBCHh2GC
        UVAiOamtN5g6MY3hzm6pivrpEA==
X-Google-Smtp-Source: AJdET5d/8hGlxDxAlpCXY3ZegXVIPGXLSUdUXAvdHRmyPp8wrYLT7hr04+3LnVhCwvDG/Kn1hLlsVw==
X-Received: by 2002:a62:425b:: with SMTP id p88-v6mr16258227pfa.96.1540836512254;
        Mon, 29 Oct 2018 11:08:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>, nm@ti.com,
        marex@denx.de, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org,
        jk@ozlabs.org, andrew@aj.id.au, rolf.evers.fischer@aptiv.com,
        linux-kernel@vger.kernel.org, tony@atomide.com,
        Jisheng.Zhang@synaptics.com, joel@jms.id.au,
        linux-serial@vger.kernel.org, jslaby@suse.com, asierra@xes-inc.com,
        andriy.shevchenko@linux.intel.com, dan.carpenter@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] serial: 8250: Process sysrq at port unlock time
Date:   Mon, 29 Oct 2018 11:07:05 -0700
Message-Id: <20181029180707.207546-6-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's take advantage of the new ("serial: core: Allow processing sysrq
at port unlock time") to handle sysrqs more cleanly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have a great way to test all 8250 variants, but I've at least
tested rk3288 / rk3399 and they seem to work.  Hopefully I got the
aspeed_vuart / fsl / omap variants right (I only compile tested
those).

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++++-
 drivers/tty/serial/8250/8250_fsl.c          | 6 +++++-
 drivers/tty/serial/8250/8250_omap.c         | 6 +++++-
 drivers/tty/serial/8250/8250_port.c         | 8 +++-----
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 435bec40dee6..0438d9a905ce 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -5,6 +5,10 @@
  *    Copyright (C) 2016 Jeremy Kerr <jk@ozlabs.org>, IBM Corp.
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -293,7 +297,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 	if (lsr & UART_LSR_THRE)
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_unlock_and_check_sysrq(port, flags);
 
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 6640a4c7ddd1..ff3dcaea5d93 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 
@@ -54,7 +58,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 		serial8250_tx_chars(up);
 
 	up->lsr_saved_flags = orig_lsr;
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_unlock_and_check_sysrq(&up->port, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a019286f8bb6..ad7ba7d0f28d 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -8,6 +8,10 @@
  *
  */
 
+#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -1085,7 +1089,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		}
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_unlock_and_check_sysrq(port, flags);
 	serial8250_rpm_put(up);
 	return 1;
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f776b3eafb96..c39482b96111 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1755,7 +1755,7 @@ void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 		else if (lsr & UART_LSR_FE)
 			flag = TTY_FRAME;
 	}
-	if (uart_handle_sysrq_char(port, ch))
+	if (uart_prepare_sysrq_char(port, ch))
 		return;
 
 	uart_insert_char(port, lsr, UART_LSR_OE, ch, flag);
@@ -1897,7 +1897,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_unlock_and_check_sysrq(port, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
@@ -3258,9 +3258,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	serial8250_rpm_get(up);
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.19.1.568.g152ad8e336-goog

